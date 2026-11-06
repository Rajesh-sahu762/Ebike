using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.SessionState;
using System.Configuration;

namespace EBIke.Security
{
    /// <summary>Opaque, rotating, server-validated remember-me tokens.</summary>
    public static class RememberMeSecurity
    {
        private const string CookieName = "EBikesUser";
        private const int TokenBytes = 32;
        private const int LifetimeDays = 30;

        public static void Issue(HttpContext context, int userId)
        {
            string token = CreateToken();
            byte[] tokenHash = HashToken(token);
            DateTime expiresUtc = DateTime.UtcNow.AddDays(LifetimeDays);

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString))
            using (SqlCommand cmd = new SqlCommand(@"
INSERT INTO dbo.RememberMeTokens (UserID, TokenHash, ExpiresAtUtc)
VALUES (@UserID, @TokenHash, @ExpiresAtUtc);", con))
            {
                cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                cmd.Parameters.Add("@TokenHash", SqlDbType.VarBinary, 32).Value = tokenHash;
                cmd.Parameters.Add("@ExpiresAtUtc", SqlDbType.DateTime2).Value = expiresUtc;
                con.Open();
                cmd.ExecuteNonQuery();
            }

            WriteCookie(context, token, expiresUtc);
        }

        public static bool TryRestore(HttpContext context)
        {
            HttpCookie cookie = context.Request.Cookies[CookieName];
            if (cookie == null || String.IsNullOrEmpty(cookie.Value))
                return false;

            string token = cookie.Value;
            if (!IsTokenFormatValid(token))
            {
                ExpireCookie(context);
                return false;
            }

            byte[] tokenHash = HashToken(token);
            string rotatedToken = CreateToken();
            byte[] rotatedHash = HashToken(rotatedToken);
            DateTime expiresUtc = DateTime.UtcNow.AddDays(LifetimeDays);

            using (SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString))
            {
                con.Open();
                using (SqlTransaction tx = con.BeginTransaction(IsolationLevel.ReadCommitted))
                {
                    int userId = 0;
                    string fullName = null;

                    using (SqlCommand read = new SqlCommand(@"
SELECT TOP (1) U.UserID, U.FullName
FROM dbo.RememberMeTokens T WITH (UPDLOCK, ROWLOCK)
INNER JOIN dbo.Users U ON U.UserID=T.UserID
WHERE T.TokenHash=@TokenHash
  AND T.RevokedAtUtc IS NULL
  AND T.ExpiresAtUtc > SYSUTCDATETIME()
  AND U.Role='Customer'
  AND U.IsActive=1
  AND U.IsEmailVerified=1;", con, tx))
                    {
                        read.Parameters.Add("@TokenHash", SqlDbType.VarBinary, 32).Value = tokenHash;
                        using (SqlDataReader dr = read.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                userId = Convert.ToInt32(dr["UserID"]);
                                fullName = Convert.ToString(dr["FullName"]);
                            }
                        }
                    }

                    if (userId == 0)
                    {
                        tx.Rollback();
                        ExpireCookie(context);
                        return false;
                    }

                    using (SqlCommand revoke = new SqlCommand(@"
UPDATE dbo.RememberMeTokens
SET RevokedAtUtc=SYSUTCDATETIME()
WHERE TokenHash=@TokenHash AND RevokedAtUtc IS NULL;", con, tx))
                    {
                        revoke.Parameters.Add("@TokenHash", SqlDbType.VarBinary, 32).Value = tokenHash;
                        if (revoke.ExecuteNonQuery() != 1)
                        {
                            tx.Rollback();
                            ExpireCookie(context);
                            return false;
                        }
                    }

                    using (SqlCommand insert = new SqlCommand(@"
INSERT INTO dbo.RememberMeTokens (UserID, TokenHash, ExpiresAtUtc)
VALUES (@UserID, @TokenHash, @ExpiresAtUtc);", con, tx))
                    {
                        insert.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                        insert.Parameters.Add("@TokenHash", SqlDbType.VarBinary, 32).Value = rotatedHash;
                        insert.Parameters.Add("@ExpiresAtUtc", SqlDbType.DateTime2).Value = expiresUtc;
                        insert.ExecuteNonQuery();
                    }

                    tx.Commit();
                    context.Session["CustomerID"] = userId;
                    context.Session["CustomerName"] = fullName;
                }
            }

            WriteCookie(context, rotatedToken, expiresUtc);
            return true;
        }

        public static void RevokeCurrent(HttpContext context)
        {
            HttpCookie cookie = context.Request.Cookies[CookieName];
            if (cookie != null && IsTokenFormatValid(cookie.Value))
            {
                byte[] tokenHash = HashToken(cookie.Value);
                using (SqlConnection con = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(@"
UPDATE dbo.RememberMeTokens
SET RevokedAtUtc=SYSUTCDATETIME()
WHERE TokenHash=@TokenHash AND RevokedAtUtc IS NULL;", con))
                {
                    cmd.Parameters.Add("@TokenHash", SqlDbType.VarBinary, 32).Value = tokenHash;
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            ExpireCookie(context);
        }

        private static string CreateToken()
        {
            byte[] bytes = new byte[TokenBytes];
            using (var rng = RandomNumberGenerator.Create())
                rng.GetBytes(bytes);
            return Convert.ToBase64String(bytes).TrimEnd('=').Replace('+', '-').Replace('/', '_');
        }

        private static bool IsTokenFormatValid(string token)
        {
            if (String.IsNullOrEmpty(token) || token.Length != 43)
                return false;
            foreach (char c in token)
                if (!(c >= 'A' && c <= 'Z') && !(c >= 'a' && c <= 'z') &&
                    !(c >= '0' && c <= '9') && c != '-' && c != '_')
                    return false;
            return true;
        }

        private static byte[] HashToken(string token)
        {
            using (SHA256 sha = SHA256.Create())
                return sha.ComputeHash(Encoding.UTF8.GetBytes(token));
        }

        private static void WriteCookie(HttpContext context, string token, DateTime expiresUtc)
        {
            HttpCookie cookie = new HttpCookie(CookieName, token);
            cookie.HttpOnly = true;
            cookie.Secure = context.Request.IsSecureConnection;
            cookie.Path = "/";
            cookie.Expires = expiresUtc.ToLocalTime();
            cookie.SameSite = SameSiteMode.Lax;
            context.Response.Cookies.Add(cookie);
        }

        private static void ExpireCookie(HttpContext context)
        {
            HttpCookie cookie = new HttpCookie(CookieName, String.Empty);
            cookie.HttpOnly = true;
            cookie.Secure = context.Request.IsSecureConnection;
            cookie.Path = "/";
            cookie.Expires = DateTime.UtcNow.AddDays(-1);
            cookie.SameSite = SameSiteMode.Lax;
            context.Response.Cookies.Add(cookie);
        }
    }
}
