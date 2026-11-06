using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using EBIke.Security;

public partial class Client_ClientResetPassword : System.Web.UI.Page
{
    private readonly string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnReset_Click(object sender, EventArgs e)
    {
        if (Session["ResetUserID"] == null)
        {
            Response.Redirect("ClientLogin.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }

        if (txtNewPass.Text.Length < 10)
        {
            lblMsg.Text = "Use a password with at least 10 characters.";
            return;
        }

        int userId = Convert.ToInt32(Session["ResetUserID"]);
        string passwordHash = PasswordSecurity.HashPassword(txtNewPass.Text);
        bool resetSucceeded = false;
        string resultMessage = "Invalid or expired OTP.";

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            using (SqlTransaction tx = con.BeginTransaction(IsolationLevel.ReadCommitted))
            {
                string storedOtp = null;
                DateTime? expiry = null;
                int attempts = 0;

                using (SqlCommand read = new SqlCommand(@"
SELECT OTPCode, OTPExpiry, OTPFailedAttempts
FROM dbo.Users WITH (UPDLOCK, ROWLOCK)
WHERE UserID=@UserID AND Role='Customer' AND IsActive=1;", con, tx))
                {
                    read.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                    using (SqlDataReader dr = read.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            storedOtp = dr["OTPCode"] == DBNull.Value ? null : Convert.ToString(dr["OTPCode"]);
                            expiry = dr["OTPExpiry"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dr["OTPExpiry"]);
                            attempts = dr["OTPFailedAttempts"] == DBNull.Value ? 0 : Convert.ToInt32(dr["OTPFailedAttempts"]);
                        }
                    }
                }

                if (attempts >= 5)
                {
                    tx.Rollback();
                    lblMsg.Text = "Too many incorrect attempts. Request a new OTP after the cooldown.";
                    return;
                }

                if (String.IsNullOrEmpty(storedOtp) || !expiry.HasValue || expiry.Value <= DateTime.Now)
                {
                    tx.Rollback();
                    lblMsg.Text = "OTP is invalid or expired. Request a new OTP.";
                    return;
                }

                if (!String.Equals(storedOtp, txtOTP.Text.Trim(), StringComparison.Ordinal))
                {
                    using (SqlCommand fail = new SqlCommand(@"
UPDATE dbo.Users SET OTPFailedAttempts=OTPFailedAttempts+1
WHERE UserID=@UserID AND Role='Customer' AND OTPFailedAttempts<5;", con, tx))
                    {
                        fail.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                        fail.ExecuteNonQuery();
                    }
                    tx.Commit();
                    lblMsg.Text = attempts + 1 >= 5
                        ? "Too many incorrect attempts. Request a new OTP after the cooldown."
                        : "Invalid OTP.";
                    return;
                }

                using (SqlCommand update = new SqlCommand(@"
UPDATE dbo.Users
SET PasswordHash=@PasswordHash, OTPCode=NULL, OTPExpiry=NULL,
    OTPFailedAttempts=0, OTPResendAt=NULL,
    FailedLoginAttempts=0, LockoutEndTime=NULL
WHERE UserID=@UserID AND Role='Customer' AND IsActive=1;", con, tx))
                {
                    update.Parameters.Add("@PasswordHash", SqlDbType.NVarChar, 500).Value = passwordHash;
                    update.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                    resetSucceeded = update.ExecuteNonQuery() == 1;
                }

                if (!resetSucceeded)
                {
                    tx.Rollback();
                    lblMsg.Text = "Unable to reset this account. Please try again.";
                    return;
                }

                using (SqlCommand revoke = new SqlCommand(@"
UPDATE dbo.RememberMeTokens
SET RevokedAtUtc=SYSUTCDATETIME()
WHERE UserID=@UserID AND RevokedAtUtc IS NULL;", con, tx))
                {
                    revoke.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                    revoke.ExecuteNonQuery();
                }

                tx.Commit();
                resultMessage = "Password reset successful. Please login with your new password.";
            }
        }

        Session.Remove("ResetUserID");
        lblMsg.Text = resultMessage;
    }
}
