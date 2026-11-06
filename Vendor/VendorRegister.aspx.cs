using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendor_VendorRegister : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string fullName = txtFullName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string mobile = txtMobile.Text.Trim();
        string password = txtPassword.Text.Trim();
        string confirm = txtConfirm.Text.Trim();
        string shop = txtShop.Text.Trim();
        string city = txtCity.Text.Trim();

        if (string.IsNullOrEmpty(fullName) ||
            string.IsNullOrEmpty(email) ||
            string.IsNullOrEmpty(mobile) ||
            string.IsNullOrEmpty(password))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('All fields are required.');", true);
            return;
        }

        if (password != confirm)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Passwords do not match.');", true);
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // Duplicate Email Check
            SqlCommand checkEmail = new SqlCommand(
                "SELECT COUNT(*) FROM Users WHERE Email=@Email", con);
            checkEmail.Parameters.AddWithValue("@Email", email);

            if (Convert.ToInt32(checkEmail.ExecuteScalar()) > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Email already registered.');", true);
                return;
            }

            // Duplicate Mobile Check
            SqlCommand checkMobile = new SqlCommand(
                "SELECT COUNT(*) FROM Users WHERE Mobile=@Mobile", con);
            checkMobile.Parameters.AddWithValue("@Mobile", mobile);

            if (Convert.ToInt32(checkMobile.ExecuteScalar()) > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Mobile number already registered.');", true);
                return;
            }

            // Secure PBKDF2 Password Hashing
            string passwordHash = SecurityHelper.HashPassword(password);

            // Generate Cryptographically Secure 6-digit OTP
            string otp = SecurityHelper.GenerateOtp(6);

            // Insert Vendor with PBKDF2 hash
            SqlCommand cmd = new SqlCommand(
            @"INSERT INTO Users
            (FullName, Email, Mobile, PasswordHash, Role,
             ShopName, City,
             IsEmailVerified,
             IsApproved, IsActive, CreatedAt, OTPCode, OTPExpiry)
            VALUES
            (@FullName, @Email, @Mobile, @Password, 'Dealer',
             @ShopName, @City,
             0,
             0, 1, GETDATE(), @otp, DATEADD(MINUTE, 10, GETDATE()))", con);

            cmd.Parameters.AddWithValue("@FullName", fullName);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Mobile", mobile);
            cmd.Parameters.AddWithValue("@Password", passwordHash);
            cmd.Parameters.AddWithValue("@ShopName", shop);
            cmd.Parameters.AddWithValue("@City", city);
            cmd.Parameters.AddWithValue("@otp", otp);

            cmd.ExecuteNonQuery();

            try
            {
                using (SqlCommand optCmd = new SqlCommand("UPDATE Users SET OTPAttempts=0, OTPLastSent=GETDATE() WHERE Email=@Email", con))
                {
                    optCmd.Parameters.AddWithValue("@Email", email);
                    optCmd.ExecuteNonQuery();
                }
            }
            catch (SqlException) { }

            SendOTPEmail(email, fullName, otp);
        }

        Session["VendorVerifyEmail"] = email;
        Session["VendorLastOTPResend"] = DateTime.Now;
        Response.Redirect("VendorVerifyOTP.aspx?email=" + Server.UrlEncode(email));
    }

    void SendOTPEmail(string toEmail, string name, string otp)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(toEmail);
            mail.Subject = "Vendor Registration OTP - EBikes Duniya";

            mail.Body =
            "Hello " + name + ",\n\n" +
            "Your OTP for dealer registration is:\n\n" +
            "OTP: " + otp + "\n\n" +
            "This OTP is valid for 10 minutes.\n\n" +
            "Regards,\nEBikes Duniya Team";

            mail.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);
        }
        catch
        {
        }
    }
}
