using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.SessionState;

/// <summary>
/// Authentication helper for managing secure remember-me tokens, sessions, and authorization checks.
/// </summary>
public static class AuthHelper
{
    public const string RememberCookieName = "EBikesAuthToken";
    public const string LegacyCookieName = "EBikesUser";
    public const int RememberDays = 30;

    /// <summary>
    /// Issues a cryptographically secure, server-validated Remember Me token and sets an HttpOnly cookie.
    /// </summary>
    public static void IssueRememberMeCookie(int userId, HttpResponse response, string constr)
    {
        if (response == null || string.IsNullOrEmpty(constr))
            return;

        try
        {
            string rawToken = SecurityHelper.GenerateSecureToken(32);
            string tokenHash = SecurityHelper.HashSha256(rawToken);
            DateTime expiresAt = DateTime.Now.AddDays(RememberDays);

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                // Remove existing tokens for this user to prevent accumulation
                using (SqlCommand delCmd = new SqlCommand("DELETE FROM UserAuthTokens WHERE UserID=@uid OR ExpiresAt < GETDATE()", con))
                {
                    delCmd.Parameters.AddWithValue("@uid", userId);
                    delCmd.ExecuteNonQuery();
                }

                using (SqlCommand insCmd = new SqlCommand(
                    "INSERT INTO UserAuthTokens (UserID, TokenHash, ExpiresAt, CreatedAt) VALUES (@uid, @thash, @exp, GETDATE())", con))
                {
                    insCmd.Parameters.AddWithValue("@uid", userId);
                    insCmd.Parameters.AddWithValue("@thash", tokenHash);
                    insCmd.Parameters.AddWithValue("@exp", expiresAt);
                    insCmd.ExecuteNonQuery();
                }
            }

            HttpCookie cookie = new HttpCookie(RememberCookieName, rawToken);
            cookie.HttpOnly = true;
            cookie.Path = "/";
            cookie.Expires = expiresAt;

            if (HttpContext.Current != null && HttpContext.Current.Request.IsSecureConnection)
            {
                cookie.Secure = true;
            }

            response.Cookies.Add(cookie);

            // Invalidate legacy insecure cookie if present
            HttpCookie legacy = new HttpCookie(LegacyCookieName, string.Empty);
            legacy.Expires = DateTime.Now.AddDays(-1);
            legacy.Path = "/";
            response.Cookies.Add(legacy);
        }
        catch (SqlException)
        {
            // Failsafe if UserAuthTokens table has not yet been migrated
        }
    }

    /// <summary>
    /// Validates the Remember Me cookie against server-stored hashed tokens.
    /// Reconstitutes session if valid, or removes cookie if invalid/expired.
    /// </summary>
    public static bool ValidateRememberMeCookie(HttpRequest request, HttpResponse response, HttpSessionState session, string constr)
    {
        if (session == null || request == null)
            return false;

        // Already authenticated in current session
        if (session["CustomerID"] != null)
            return true;

        HttpCookie authCookie = request.Cookies[RememberCookieName];
        if (authCookie == null || string.IsNullOrEmpty(authCookie.Value))
        {
            // If legacy insecure cookie is present, clear it immediately
            if (request.Cookies[LegacyCookieName] != null && response != null)
            {
                HttpCookie deadLegacy = new HttpCookie(LegacyCookieName, string.Empty);
                deadLegacy.Expires = DateTime.Now.AddDays(-1);
                deadLegacy.Path = "/";
                response.Cookies.Add(deadLegacy);
            }
            return false;
        }

        try
        {
            string rawToken = authCookie.Value.Trim();
            string tokenHash = SecurityHelper.HashSha256(rawToken);

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                string query = @"
                SELECT u.UserID, u.FullName, u.Role, u.IsActive, u.IsEmailVerified
                FROM UserAuthTokens t
                INNER JOIN Users u ON t.UserID = u.UserID
                WHERE t.TokenHash = @thash AND t.ExpiresAt > GETDATE()";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@thash", tokenHash);

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            bool isActive = dr["IsActive"] != DBNull.Value && Convert.ToBoolean(dr["IsActive"]);
                            bool isEmailVerified = dr["IsEmailVerified"] != DBNull.Value && Convert.ToBoolean(dr["IsEmailVerified"]);
                            string role = dr["Role"] != DBNull.Value ? dr["Role"].ToString() : string.Empty;

                            if (isActive && isEmailVerified && role == "Customer")
                            {
                                int userId = Convert.ToInt32(dr["UserID"]);
                                string fullName = dr["FullName"].ToString();

                                session["CustomerID"] = userId;
                                session["CustomerName"] = fullName;
                                session["Role"] = role;
                                return true;
                            }
                        }
                    }
                }
            }

            // If token invalid or expired, clear cookie
            RevokeRememberMeCookie(request, response, constr);
            return false;
        }
        catch (SqlException)
        {
            // Failsafe if UserAuthTokens table has not yet been migrated
            return false;
        }
    }

    /// <summary>
    /// Revokes the Remember Me token from the database and removes the cookie.
    /// </summary>
    public static void RevokeRememberMeCookie(HttpRequest request, HttpResponse response, string constr)
    {
        if (request != null && !string.IsNullOrEmpty(constr))
        {
            HttpCookie authCookie = request.Cookies[RememberCookieName];
            if (authCookie != null && !string.IsNullOrEmpty(authCookie.Value))
            {
                try
                {
                    string rawToken = authCookie.Value.Trim();
                    string tokenHash = SecurityHelper.HashSha256(rawToken);

                    using (SqlConnection con = new SqlConnection(constr))
                    {
                        con.Open();
                        using (SqlCommand cmd = new SqlCommand("DELETE FROM UserAuthTokens WHERE TokenHash=@thash", con))
                        {
                            cmd.Parameters.AddWithValue("@thash", tokenHash);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
                catch (SqlException)
                {
                    // Failsafe if table does not exist
                }
            }
        }

        if (response != null)
        {
            HttpCookie deadAuth = new HttpCookie(RememberCookieName, string.Empty);
            deadAuth.Expires = DateTime.Now.AddDays(-1);
            deadAuth.Path = "/";
            response.Cookies.Add(deadAuth);

            HttpCookie deadLegacy = new HttpCookie(LegacyCookieName, string.Empty);
            deadLegacy.Expires = DateTime.Now.AddDays(-1);
            deadLegacy.Path = "/";
            response.Cookies.Add(deadLegacy);
        }
    }
}

