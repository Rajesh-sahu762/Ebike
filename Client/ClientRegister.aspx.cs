using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using EBIke.Security;

public partial class Client_ClientRegister : System.Web.UI.Page
{
    private readonly string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string name = txtName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string mobile = txtMobile.Text.Trim();
        string password = txtPassword.Text;

        if (name.Length == 0 || email.Length == 0 || mobile.Length == 0 || password.Length == 0)
        {
            lblMsg.Text = "All fields are required.";
            return;
        }
        if (password != txtConfirm.Text)
        {
            lblMsg.Text = "Passwords do not match.";
            return;
        }
        if (password.Length < 10)
        {
            lblMsg.Text = "Use a password with at least 10 characters.";
            return;
        }

        string passwordHash = PasswordSecurity.HashPassword(password);
        string otp = OtpSecurity.GenerateSixDigitOtp();

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            using (SqlTransaction tx = con.BeginTransaction())
            {
                using (SqlCommand check = new SqlCommand(
                    "SELECT COUNT(*) FROM dbo.Users WHERE Email=@Email OR Mobile=@Mobile;", con, tx))
                {
                    check.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;
                    check.Parameters.Add("@Mobile", SqlDbType.NVarChar, 30).Value = mobile;
                    if (Convert.ToInt32(check.ExecuteScalar()) > 0)
                    {
                        tx.Rollback();
                        lblMsg.Text = "Email or mobile is already registered.";
                        return;
                    }
                }

                using (SqlCommand insert = new SqlCommand(@"
INSERT INTO dbo.Users
(FullName, Email, Mobile, PasswordHash, Role, IsEmailVerified, IsApproved, IsActive, CreatedAt)
VALUES
(@FullName, @Email, @Mobile, @PasswordHash, 'Customer', 0, 1, 1, GETDATE());", con, tx))
                {
                    insert.Parameters.Add("@FullName", SqlDbType.NVarChar, 150).Value = name;
                    insert.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;
                    insert.Parameters.Add("@Mobile", SqlDbType.NVarChar, 30).Value = mobile;
                    insert.Parameters.Add("@PasswordHash", SqlDbType.NVarChar, 500).Value = passwordHash;
                    insert.ExecuteNonQuery();
                }

                using (SqlCommand updateOtp = new SqlCommand(@"
UPDATE dbo.Users
SET OTPCode=@Otp, OTPExpiry=DATEADD(MINUTE,10,GETDATE()), OTPFailedAttempts=0, OTPResendAt=GETDATE()
WHERE Email=@Email AND Role='Customer';", con, tx))
                {
                    updateOtp.Parameters.Add("@Otp", SqlDbType.NVarChar, 10).Value = otp;
                    updateOtp.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;
                    updateOtp.ExecuteNonQuery();
                }

                tx.Commit();
            }
        }

        try
        {
            SendOTPEmail(email, name, otp);
            Session["VerifyEmail"] = email;
            Response.Redirect("ClientVerifyOTP.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
        catch (SmtpException)
        {
            lblMsg.Text = "Registration was saved, but the verification email could not be sent. Use resend OTP.";
        }
    }

    private void SendOTPEmail(string toEmail, string name, string otp)
    {
        using (MailMessage mail = new MailMessage())
        {
            mail.To.Add(toEmail);
            mail.Subject = "Client Registration OTP - EBikes Duniya";
            mail.Body = "Hello " + name + ",\n\nYour registration OTP is: " + otp +
                "\nIt is valid for 10 minutes.\n\nEBikes Duniya Team";
            mail.IsBodyHtml = false;
            using (SmtpClient smtp = new SmtpClient())
                smtp.Send(mail);
        }
    }
}
