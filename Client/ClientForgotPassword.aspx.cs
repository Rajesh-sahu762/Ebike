using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using EBIke.Security;

public partial class Client_ClientForgotPassword : System.Web.UI.Page
{
    private readonly string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnSendOTP_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        int userId = 0;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            using (SqlCommand check = new SqlCommand(
                "SELECT UserID FROM dbo.Users WHERE Email=@Email AND Role='Customer' AND IsActive=1 AND IsEmailVerified=1;", con))
            {
                check.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;
                object result = check.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                    userId = Convert.ToInt32(result);
            }

            if (userId != 0)
            {
                string otp = OtpSecurity.GenerateSixDigitOtp();
                int rows;
                using (SqlCommand update = new SqlCommand(@"
UPDATE dbo.Users
SET OTPCode=@Otp, OTPExpiry=DATEADD(MINUTE,5,GETDATE()),
    OTPFailedAttempts=0, OTPResendAt=GETDATE()
WHERE UserID=@UserID
  AND (OTPResendAt IS NULL OR DATEADD(SECOND,60,OTPResendAt)<=GETDATE());", con))
                {
                    update.Parameters.Add("@Otp", SqlDbType.NVarChar, 10).Value = otp;
                    update.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                    rows = update.ExecuteNonQuery();
                }

                if (rows == 1)
                {
                    try
                    {
                        using (MailMessage mail = new MailMessage())
                        {
                            mail.To.Add(email);
                            mail.Subject = "Password Reset OTP - EBikes Duniya";
                            mail.Body = "Your OTP is: " + otp + "\nValid for 5 minutes.";
                            mail.IsBodyHtml = false;
                            using (SmtpClient smtp = new SmtpClient())
                                smtp.Send(mail);
                        }
                        Session["ResetUserID"] = userId;
                    }
                    catch (SmtpException)
                    {
                        lblMsg.Text = "Unable to send the reset email. Please try again after the cooldown.";
                        return;
                    }
                }
            }
        }

        // Do not disclose whether an email exists or whether resend cooldown is active.
        lblMsg.Text = "If the account exists, a password reset OTP has been sent.";
        if (userId != 0 && Session["ResetUserID"] != null)
        {
            Response.Redirect("ClientResetPassword.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
