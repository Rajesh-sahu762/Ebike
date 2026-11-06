using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using EBIke.Security;

public partial class Vendor_VendorRegister : System.Web.UI.Page
{
    private readonly string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string name = txtFullName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string mobile = txtMobile.Text.Trim();
        string shop = txtShop.Text.Trim();
        string city = txtCity.Text.Trim();
        string password = txtPassword.Text;

        if (name.Length == 0 || email.Length == 0 || mobile.Length == 0 || shop.Length == 0 || password.Length == 0)
        {
            lblMessage.Text = "All fields are required.";
            return;
        }
        if (password != txtConfirm.Text)
        {
            lblMessage.Text = "Passwords do not match.";
            return;
        }
        if (password.Length < 10)
        {
            lblMessage.Text = "Use a password with at least 10 characters.";
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
                        lblMessage.Text = "Email or mobile is already registered.";
                        return;
                    }
                }

                using (SqlCommand insert = new SqlCommand(@"
INSERT INTO dbo.Users
(FullName, Email, Mobile, PasswordHash, Role, ShopName, City,
 IsEmailVerified, IsApproved, IsActive, CreatedAt)
VALUES
(@FullName, @Email, @Mobile, @PasswordHash, 'Dealer', @ShopName, @City,
 0, 0, 1, GETDATE());", con, tx))
                {
                    insert.Parameters.Add("@FullName", SqlDbType.NVarChar, 150).Value = name;
                    insert.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;
                    insert.Parameters.Add("@Mobile", SqlDbType.NVarChar, 30).Value = mobile;
                    insert.Parameters.Add("@PasswordHash", SqlDbType.NVarChar, 500).Value = passwordHash;
                    insert.Parameters.Add("@ShopName", SqlDbType.NVarChar, 150).Value = shop;
                    insert.Parameters.Add("@City", SqlDbType.NVarChar, 100).Value = city;
                    insert.ExecuteNonQuery();
                }

                using (SqlCommand updateOtp = new SqlCommand(@"
UPDATE dbo.Users SET OTPCode=@Otp, OTPExpiry=DATEADD(MINUTE,10,GETDATE())
WHERE Email=@Email AND Role='Dealer';", con, tx))
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
            Response.Redirect("VendorVerifyOTP.aspx?email=" + Server.UrlEncode(email), false);
            Context.ApplicationInstance.CompleteRequest();
        }
        catch (SmtpException)
        {
            lblMessage.Text = "Registration was saved, but the verification email could not be sent. Use resend OTP.";
        }
    }

    private void SendOTPEmail(string toEmail, string name, string otp)
    {
        using (MailMessage mail = new MailMessage())
        {
            mail.To.Add(toEmail);
            mail.Subject = "Vendor Registration OTP - EBikes Duniya";
            mail.Body = "Hello " + name + ",\n\nYour vendor registration OTP is: " + otp +
                "\nIt is valid for 10 minutes.\n\nEBikes Duniya Team";
            mail.IsBodyHtml = false;
            using (SmtpClient smtp = new SmtpClient())
                smtp.Send(mail);
        }
    }
}
