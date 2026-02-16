using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendor_VendorForgotPassword : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnSendOTP_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand check = new SqlCommand(
                "SELECT COUNT(*) FROM Users WHERE Email=@Email AND Role='Dealer'", con);

            check.Parameters.AddWithValue("@Email", email);

            if (Convert.ToInt32(check.ExecuteScalar()) == 0)
            {
                lblMessage.Text = "Email not found.";
                return;
            }

            string otp = new Random().Next(100000, 999999).ToString();

            SqlCommand cmd = new SqlCommand(
            @"UPDATE Users SET
              OTPCode=@otp,
              OTPExpiry=DATEADD(MINUTE,10,GETDATE())
              WHERE Email=@Email", con);

            cmd.Parameters.AddWithValue("@otp", otp);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.ExecuteNonQuery();

            SendOTPEmail(email, otp);

            pnlEmail.Visible = false;
            pnlReset.Visible = true;

            lblMessage.Text = "OTP sent to your email.";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        if (txtNewPassword.Text != txtConfirmPassword.Text)
        {
            lblMessage.Text = "Passwords do not match.";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            @"UPDATE Users SET
              PasswordHash=@pass,
              OTPCode=NULL,
              OTPExpiry=NULL
              WHERE Email=@Email
              AND OTPCode=@otp
              AND OTPExpiry > GETDATE()", con);

            cmd.Parameters.AddWithValue("@pass", txtNewPassword.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@otp", txtOTP.Text.Trim());

            int rows = cmd.ExecuteNonQuery();

            if (rows > 0)
            {
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Password reset successful. Redirecting to login...";
                Response.AddHeader("REFRESH", "3;URL=VendorLogin.aspx");
            }
            else
            {
                lblMessage.Text = "Invalid or expired OTP.";
            }
        }
    }

    protected void btnResendOTP_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string otp = new Random().Next(100000, 999999).ToString();

            SqlCommand cmd = new SqlCommand(
            @"UPDATE Users SET
          OTPCode=@otp,
          OTPExpiry=DATEADD(MINUTE,10,GETDATE())
          WHERE Email=@Email", con);

            cmd.Parameters.AddWithValue("@otp", otp);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.ExecuteNonQuery();

            SendOTPEmail(email, otp);
        }

        lblMessage.ForeColor = System.Drawing.Color.Green;
        lblMessage.Text = "New OTP sent successfully.";

        // Reset timer
        ScriptManager.RegisterStartupScript(this, this.GetType(),
            "resetTimer",
            "seconds=60; resendBtn.disabled=true; document.getElementById('timerText').innerHTML='Resend available in <span id=\"countdown\">60</span> sec';",
            true);
    }


    void SendOTPEmail(string toEmail, string otp)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(toEmail);
            mail.Subject = "Password Reset OTP - EBikes Duniya";
            mail.Body = "Your OTP for password reset is: " + otp + "\nValid for 10 minutes.";
            mail.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);
        }
        catch { }
    }
}