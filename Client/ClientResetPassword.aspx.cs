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

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            using (SqlTransaction tx = con.BeginTransaction())
            {
                bool otpValid = false;
                using (SqlCommand check = new SqlCommand(@"
SELECT OTPCode, OTPExpiry
FROM dbo.Users WITH (UPDLOCK, ROWLOCK)
WHERE UserID=@UserID AND Role='Customer';", con, tx))
                {
                    check.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                    using (SqlDataReader dr = check.ExecuteReader())
                    {
                        if (dr.Read() && dr["OTPCode"] != DBNull.Value && dr["OTPExpiry"] != DBNull.Value)
                        {
                            DateTime expiry = Convert.ToDateTime(dr["OTPExpiry"]);
                            otpValid = expiry >= DateTime.Now &&
                                String.Equals(Convert.ToString(dr["OTPCode"]), txtOTP.Text.Trim(), StringComparison.Ordinal);
                        }
                    }
                }

                if (!otpValid)
                {
                    tx.Rollback();
                    lblMsg.Text = "Invalid or expired OTP.";
                    return;
                }

                using (SqlCommand update = new SqlCommand(@"
UPDATE dbo.Users
SET PasswordHash=@PasswordHash, OTPCode=NULL, OTPExpiry=NULL,
    FailedLoginAttempts=0, LockoutEndTime=NULL
WHERE UserID=@UserID AND Role='Customer';", con, tx))
                {
                    update.Parameters.Add("@PasswordHash", SqlDbType.NVarChar, 500).Value = passwordHash;
                    update.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                    update.ExecuteNonQuery();
                }

                using (SqlCommand revoke = new SqlCommand(@"
UPDATE dbo.RememberMeTokens SET RevokedAtUtc=SYSUTCDATETIME()
WHERE UserID=@UserID AND RevokedAtUtc IS NULL;", con, tx))
                {
                    // If migration has not yet been applied, password reset must still work.
                    try
                    {
                        revoke.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                        revoke.ExecuteNonQuery();
                    }
                    catch (SqlException ex)
                    {
                        if (ex.Number != 208) throw;
                    }
                }
                tx.Commit();
            }
        }

        Session.Remove("ResetUserID");
        lblMsg.Text = "Password reset successful. Please login with your new password.";
    }
}
