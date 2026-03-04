using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;

public partial class Client_ClientRegister : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (txtName.Text.Trim() == "" ||
            txtEmail.Text.Trim() == "" ||
            txtMobile.Text.Trim() == "" ||
            txtPassword.Text.Trim() == "")
        {
            lblMsg.Text = "All fields are required.";
            return;
        }

        if (txtPassword.Text != txtConfirm.Text)
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

            checkEmail.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

            if (Convert.ToInt32(checkEmail.ExecuteScalar()) > 0)
            {
                lblMsg.Text = "Email already exists.";
                return;
            }

            // Duplicate Mobile Check
            SqlCommand checkMobile = new SqlCommand(
                "SELECT COUNT(*) FROM Users WHERE Mobile=@Mobile", con);

            checkMobile.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());

            if (Convert.ToInt32(checkMobile.ExecuteScalar()) > 0)
            {
                lblMsg.Text = "Mobile already registered.";
                return;
            }

            // Insert Client (Email Not Verified Yet)
            SqlCommand cmd = new SqlCommand(
            @"INSERT INTO Users
            (FullName, Email, Mobile, PasswordHash, Role,
             IsEmailVerified,
             IsApproved, IsActive, CreatedAt)
            VALUES
            (@FullName, @Email, @Mobile, @Password, 'Customer',
             0,
             1, 1, GETDATE())", con);

            cmd.Parameters.AddWithValue("@FullName", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

            cmd.ExecuteNonQuery();

            // Generate OTP
            string otp = new Random().Next(100000, 999999).ToString();

            SqlCommand otpCmd = new SqlCommand(
                @"UPDATE Users SET
                  OTPCode=@otp,
                  OTPExpiry=DATEADD(MINUTE,10,GETDATE())
                  WHERE Email=@Email", con);

            otpCmd.Parameters.AddWithValue("@otp", otp);
            otpCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            otpCmd.ExecuteNonQuery();

            SendOTPEmail(txtEmail.Text.Trim(), txtName.Text.Trim(), otp);
        }

        // Redirect to OTP Verification Page
        Response.Redirect("ClientVerifyOTP.aspx?email=" + txtEmail.Text.Trim());
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