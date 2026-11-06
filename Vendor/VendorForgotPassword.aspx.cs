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

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            using (SqlCommand update = new SqlCommand(@"
UPDATE dbo.Users
SET OTPCode=@Otp, OTPExpiry=DATEADD(MINUTE,10,GETDATE())
WHERE Email=@Email AND Role='Dealer' AND IsActive=1;", con))
            {
                update.Parameters.Add("@Otp", SqlDbType.NVarChar, 10).Value = otp;
                update.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;
                int rows = update.ExecuteNonQuery();

                if (rows > 0)
                {
                    try { SendOTPEmail(email, otp); }
                    catch (SmtpException)
                    {
                        lblMessage.Text = "Unable to send OTP. Please try again later.";
                        return;
                    }
                    pnlEmail.Visible = false;
                    pnlReset.Visible = true;
                }
            }
        }

        lblMessage.Text = "If the vendor account exists, an OTP has been sent.";
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

        string hash = PasswordSecurity.HashPassword(txtNewPassword.Text);
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            using (SqlCommand cmd = new SqlCommand(@"
UPDATE dbo.Users
SET PasswordHash=@Hash, OTPCode=NULL, OTPExpiry=NULL,
    FailedLoginAttempts=0, LockoutEndTime=NULL
WHERE Email=@Email AND Role='Dealer'
  AND OTPCode=@Otp AND OTPExpiry > GETDATE();", con))
            {
                cmd.Parameters.Add("@Hash", SqlDbType.NVarChar, 500).Value = hash;
                cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = txtEmail.Text.Trim();
                cmd.Parameters.Add("@Otp", SqlDbType.NVarChar, 10).Value = txtOTP.Text.Trim();
                int rows = cmd.ExecuteNonQuery();
                if (rows > 0)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Password reset successful. Please login again.";
                    pnlEmail.Visible = false;
                    pnlReset.Visible = false;
                }
                else
                    lblMessage.Text = "Invalid or expired OTP.";
            }
        }
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
