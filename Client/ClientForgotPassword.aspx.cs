using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;

public partial class Client_ClientForgotPassword : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnSendOTP_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();

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

            string otp = new Random().Next(100000, 999999).ToString();
            DateTime expiry = DateTime.Now.AddMinutes(5);

            SqlCommand update = new SqlCommand(
                "UPDATE Users SET OTPCode=@o, OTPExpiry=@ex WHERE UserID=@id", con);

            update.Parameters.AddWithValue("@o", otp);
            update.Parameters.AddWithValue("@ex", expiry);
            update.Parameters.AddWithValue("@id", userId);
            update.ExecuteNonQuery();

            SendOTP(email, otp);

            Session["ResetUserID"] = userId;
            Response.Redirect("ClientResetPassword.aspx");
        }
    }

    void SendOTP(string toEmail, string otp)
    {
        MailMessage mail = new MailMessage();
        mail.To.Add(toEmail);
        mail.Subject = "Password Reset OTP";
        mail.Body = "Your OTP is: " + otp + "\nValid for 5 minutes.";

        SmtpClient smtp = new SmtpClient();
        smtp.Send(mail);
    }
}
