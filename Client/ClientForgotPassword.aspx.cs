using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;

public partial class Client_ClientForgotPassword : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
    private const int ResendCooldownSeconds = 60;

    protected void btnSendOTP_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();

        if (string.IsNullOrEmpty(email))
        {
            lblMsg.Text = "Please enter your email.";
            return;
        }

        // Resend cooldown check
        if (Session["LastResetOTP_Sent"] != null)
        {
            DateTime lastSent = (DateTime)Session["LastResetOTP_Sent"];
            double elapsed = (DateTime.Now - lastSent).TotalSeconds;
            if (elapsed < ResendCooldownSeconds)
            {
                int remaining = ResendCooldownSeconds - (int)elapsed;
                lblMsg.Text = string.Format("Please wait {0} seconds before requesting another OTP.", remaining);
                return;
            }
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand check = new SqlCommand(
                "SELECT UserID FROM Users WHERE Email=@e AND Role='Customer'", con);

            check.Parameters.AddWithValue("@e", email);

            object userObj = check.ExecuteScalar();

            if (userObj == null)
            {
                lblMsg.Text = "Email not found.";
                return;
            }

            int userId = Convert.ToInt32(userObj);

            // Generate cryptographically secure OTP
            string otp = SecurityHelper.GenerateOtp(6);
            DateTime expiry = DateTime.Now.AddMinutes(5);

            SqlCommand update = new SqlCommand(
                "UPDATE Users SET OTPCode=@o, OTPExpiry=@ex WHERE UserID=@id", con);

            update.Parameters.AddWithValue("@o", otp);
            update.Parameters.AddWithValue("@ex", expiry);
            update.Parameters.AddWithValue("@id", userId);
            update.ExecuteNonQuery();

            try
            {
                using (SqlCommand optCmd = new SqlCommand("UPDATE Users SET OTPAttempts=0, OTPLastSent=GETDATE() WHERE UserID=@id", con))
                {
                    optCmd.Parameters.AddWithValue("@id", userId);
                    optCmd.ExecuteNonQuery();
                }
            }
            catch (SqlException) { }

            SendOTP(email, otp);

            Session["LastResetOTP_Sent"] = DateTime.Now;
            Session["ResetOTP_Attempts"] = 0;
            Session["ResetUserID"] = userId;
            Response.Redirect("ClientResetPassword.aspx");
        }
    }

    void SendOTP(string toEmail, string otp)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(toEmail);
            mail.Subject = "Password Reset OTP - EBikes Duniya";
            mail.Body = "Your OTP is: " + otp + "\nValid for 5 minutes.";

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);
        }
        catch { }
    }
}
