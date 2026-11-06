using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.Web.UI;
using EBIke.Security;

public partial class Vendor_VendorForgotPassword : System.Web.UI.Page
{
    private readonly string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnSendOTP_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string otp = OtpSecurity.GenerateSixDigitOtp();
        int rows;

        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand update = new SqlCommand(@"
UPDATE dbo.Users
SET OTPCode=@Otp, OTPExpiry=DATEADD(MINUTE,10,GETDATE()),
    OTPFailedAttempts=0, OTPResendAt=GETDATE()
WHERE Email=@Email AND Role='Dealer' AND IsActive=1
  AND (OTPResendAt IS NULL OR DATEADD(SECOND,60,OTPResendAt)<=GETDATE());", con))
        {
            update.Parameters.Add("@Otp", SqlDbType.NVarChar, 10).Value = otp;
            update.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;
            con.Open();
            rows = update.ExecuteNonQuery();
        }

        if (rows == 1)
        {
            try
            {
                SendOTPEmail(email, otp);
                pnlEmail.Visible = false;
                pnlReset.Visible = true;
            }
            catch (SmtpException)
            {
                lblMessage.Text = "Unable to send OTP. Please try again after the cooldown.";
                return;
            }
        }

        // Do not disclose whether a vendor email exists.
        lblMessage.Text = "If the vendor account exists and resend cooldown has passed, an OTP has been sent.";
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        if (txtNewPassword.Text.Length < 10)
        {
            lblMessage.Text = "Use a password with at least 10 characters.";
            return;
        }
        if (txtNewPassword.Text != txtConfirmPassword.Text)
        {
            lblMessage.Text = "Passwords do not match.";
            return;
        }

        string email = txtEmail.Text.Trim();
        string submittedOtp = txtOTP.Text.Trim();
        string hash = PasswordSecurity.HashPassword(txtNewPassword.Text);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            using (SqlTransaction tx = con.BeginTransaction(IsolationLevel.ReadCommitted))
            {
                int userId = 0;
                string storedOtp = null;
                DateTime? expiry = null;
                int attempts = 0;

                using (SqlCommand read = new SqlCommand(@"
SELECT UserID, OTPCode, OTPExpiry, OTPFailedAttempts
FROM dbo.Users WITH (UPDLOCK, ROWLOCK)
WHERE Email=@Email AND Role='Dealer' AND IsActive=1;", con, tx))
                {
                    read.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;
                    using (SqlDataReader dr = read.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            userId = Convert.ToInt32(dr["UserID"]);
                            storedOtp = dr["OTPCode"] == DBNull.Value ? null : Convert.ToString(dr["OTPCode"]);
                            expiry = dr["OTPExpiry"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dr["OTPExpiry"]);
                            attempts = dr["OTPFailedAttempts"] == DBNull.Value ? 0 : Convert.ToInt32(dr["OTPFailedAttempts"]);
                        }
                    }
                }

                if (userId <= 0 || String.IsNullOrEmpty(storedOtp) || !expiry.HasValue ||
                    expiry.Value <= DateTime.Now)
                {
                    tx.Rollback();
                    lblMessage.Text = "Invalid or expired OTP.";
                    return;
                }

                if (attempts >= 5)
                {
                    tx.Rollback();
                    lblMessage.Text = "Too many incorrect attempts. Request a new OTP after the cooldown.";
                    return;
                }

                if (!String.Equals(storedOtp, submittedOtp, StringComparison.Ordinal))
                {
                    using (SqlCommand fail = new SqlCommand(@"
UPDATE dbo.Users SET OTPFailedAttempts=OTPFailedAttempts+1
WHERE UserID=@UserID AND Role='Dealer' AND OTPFailedAttempts<5;", con, tx))
                    {
                        fail.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                        fail.ExecuteNonQuery();
                    }
                    tx.Commit();
                    lblMessage.Text = attempts + 1 >= 5
                        ? "Too many incorrect attempts. Request a new OTP after the cooldown."
                        : "Invalid OTP.";
                    return;
                }

                using (SqlCommand update = new SqlCommand(@"
UPDATE dbo.Users
SET PasswordHash=@Hash, OTPCode=NULL, OTPExpiry=NULL, OTPFailedAttempts=0,
    OTPResendAt=NULL, FailedLoginAttempts=0, LockoutEndTime=NULL
WHERE UserID=@UserID AND Role='Dealer' AND IsActive=1;", con, tx))
                {
                    update.Parameters.Add("@Hash", SqlDbType.NVarChar, 500).Value = hash;
                    update.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                    if (update.ExecuteNonQuery() != 1)
                    {
                        tx.Rollback();
                        lblMessage.Text = "Unable to reset this vendor account.";
                        return;
                    }
                }

                try
                {
                    using (SqlCommand revoke = new SqlCommand(@"
UPDATE dbo.RememberMeTokens SET RevokedAtUtc=SYSUTCDATETIME()
WHERE UserID=@UserID AND RevokedAtUtc IS NULL;", con, tx))
                    {
                        revoke.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                        revoke.ExecuteNonQuery();
                    }
                }
                catch (SqlException ex)
                {
                    if (ex.Number != 208) throw;
                }

                tx.Commit();
            }
        }

        lblMessage.ForeColor = System.Drawing.Color.Green;
        lblMessage.Text = "Password reset successful. Please login again.";
        pnlEmail.Visible = false;
        pnlReset.Visible = false;
    }

    protected void btnResendOTP_Click(object sender, EventArgs e)
    {
        btnSendOTP_Click(sender, e);
    }

    private void SendOTPEmail(string toEmail, string otp)
    {
        using (MailMessage mail = new MailMessage())
        {
            mail.To.Add(toEmail);
            mail.Subject = "Password Reset OTP - EBikes Duniya";
            mail.Body = "Your password reset OTP is: " + otp + "\nValid for 10 minutes.";
            mail.IsBodyHtml = false;
            using (SmtpClient smtp = new SmtpClient())
                smtp.Send(mail);
        }
    }
}
