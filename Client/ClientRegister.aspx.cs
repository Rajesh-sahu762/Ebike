using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;

public partial class Client_ClientRegister : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        string name = txtName.Text.Trim();
        string email = txtEmail.Text.Trim();
        string mobile = txtMobile.Text.Trim();
        string password = txtPassword.Text.Trim();
        string confirm = txtConfirm.Text.Trim();

        if (string.IsNullOrEmpty(name) ||
            string.IsNullOrEmpty(email) ||
            string.IsNullOrEmpty(mobile) ||
            string.IsNullOrEmpty(password))
        {
            lblMsg.Text = "All fields are required.";
            return;
        }

        if (password != confirm)
        {
            lblMsg.Text = "Passwords do not match.";
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
                lblMsg.Text = "Email already exists.";
                return;
            }

            // Duplicate Mobile Check
            SqlCommand checkMobile = new SqlCommand(
                "SELECT COUNT(*) FROM Users WHERE Mobile=@Mobile", con);

            checkMobile.Parameters.AddWithValue("@Mobile", mobile);

            if (Convert.ToInt32(checkMobile.ExecuteScalar()) > 0)
            {
                lblMsg.Text = "Mobile already registered.";
                return;
            }

            // Secure PBKDF2 Password Hashing
            string passwordHash = SecurityHelper.HashPassword(password);

            // Generate Cryptographically Secure 6-digit OTP
            string otp = SecurityHelper.GenerateOtp(6);

            // Insert Customer with PBKDF2 hash
            SqlCommand cmd = new SqlCommand(
            @"INSERT INTO Users
            (FullName, Email, Mobile, PasswordHash, Role,
             IsEmailVerified, IsApproved, IsActive, CreatedAt, OTPCode, OTPExpiry)
            VALUES
            (@FullName, @Email, @Mobile, @Password, 'Customer',
             0, 1, 1, GETDATE(), @otp, DATEADD(MINUTE, 10, GETDATE()))", con);

            cmd.Parameters.AddWithValue("@FullName", name);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Mobile", mobile);
            cmd.Parameters.AddWithValue("@Password", passwordHash);
            cmd.Parameters.AddWithValue("@otp", otp);

            cmd.ExecuteNonQuery();

            // Try to set optional columns if migrated
            try
            {
                using (SqlCommand optCmd = new SqlCommand("UPDATE Users SET OTPAttempts=0, OTPLastSent=GETDATE() WHERE Email=@Email", con))
                {
                    optCmd.Parameters.AddWithValue("@Email", email);
                    optCmd.ExecuteNonQuery();
                }
            }
            catch (SqlException) { }

            SendOTPEmail(email, name, otp);
        }

        // Store email in session and redirect to OTP Verification Page
        Session["VerifyEmail"] = email;
        Session["LastOTPResend"] = DateTime.Now;
        Response.Redirect("ClientVerifyOTP.aspx?email=" + Server.UrlEncode(email));
    }

    void SendOTPEmail(string toEmail, string name, string otp)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(toEmail);
            mail.Subject = "Client Registration OTP - EBikes Duniya";

            mail.Body =
            "Hello " + name + ",\n\n" +
            "Your OTP for registration is:\n\n" +
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
