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
    private const int ResendCooldownSeconds = 60;
    private const int MaxAttempts = 5;

    protected void btnSendOTP_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();

        if (string.IsNullOrEmpty(email))
        {
            lblMessage.Text = "Please enter your email.";
            return;
        }

        // Resend cooldown check
        if (Session["VendorResetOTP_Sent"] != null)
        {
            DateTime lastSent = (DateTime)Session["VendorResetOTP_Sent"];
            double elapsed = (DateTime.Now - lastSent).TotalSeconds;
            if (elapsed < ResendCooldownSeconds)
            {
                int remaining = ResendCooldownSeconds - (int)elapsed;
                lblMessage.Text = string.Format("Please wait {0} seconds before requesting another OTP.", remaining);
                return;
            }
        }

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

            string otp = SecurityHelper.GenerateOtp(6);

            SqlCommand cmd = new SqlCommand(
            @"UPDATE Users SET
              OTPCode=@otp,
              OTPExpiry=DATEADD(MINUTE,10,GETDATE())
              WHERE Email=@Email", con);

            cmd.Parameters.AddWithValue("@otp", otp);
            cmd.Parameters.AddWithValue("@Email", email);
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

            SendOTPEmail(email, otp);

            Session["VendorResetOTP_Sent"] = DateTime.Now;
            Session["VendorResetAttempts"] = 0;

            pnlEmail.Visible = false;
            pnlReset.Visible = true;

            lblMessage.Text = "OTP sent to your email.";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        string newPass = txtNewPassword.Text.Trim();
        string confirmPass = txtConfirmPassword.Text.Trim();
        string email = txtEmail.Text.Trim();
        string otp = txtOTP.Text.Trim();

        if (string.IsNullOrEmpty(newPass) || newPass.Length < 6)
        {
            lblMessage.Text = "Password must be at least 6 characters long.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        if (newPass != confirmPass)
        {
            lblMessage.Text = "Passwords do not match.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand checkCmd = new SqlCommand(
                "SELECT OTPCode, OTPExpiry FROM Users WHERE Email=@Email AND Role='Dealer'", con);
            checkCmd.Parameters.AddWithValue("@Email", email);

            string dbOtp = null;
            DateTime? expiry = null;
            using (SqlDataReader dr = checkCmd.ExecuteReader())
            {
                if (dr.Read())
                {
                    dbOtp = dr["OTPCode"] != DBNull.Value ? dr["OTPCode"].ToString() : null;
                    if (dr["OTPExpiry"] != DBNull.Value)
                        expiry = Convert.ToDateTime(dr["OTPExpiry"]);
                }
            }

            if (string.IsNullOrEmpty(dbOtp) || expiry == null)
            {
                lblMessage.Text = "No active OTP found. Please click Resend OTP.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (expiry.Value < DateTime.Now)
            {
                lblMessage.Text = "Invalid or expired OTP.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int attempts = Session["VendorResetAttempts"] != null ? (int)Session["VendorResetAttempts"] : 0;

            if (otp != dbOtp)
            {
                attempts++;
                Session["VendorResetAttempts"] = attempts;

                if (attempts >= MaxAttempts)
                {
                    SqlCommand invalidate = new SqlCommand(
                        "UPDATE Users SET OTPCode=NULL, OTPExpiry=NULL WHERE Email=@Email", con);
                    invalidate.Parameters.AddWithValue("@Email", email);
                    invalidate.ExecuteNonQuery();

                    Session.Remove("VendorResetAttempts");
                    lblMessage.Text = "Too many failed attempts. This OTP has been invalidated. Please request a new OTP.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    lblMessage.Text = string.Format("Invalid OTP. {0} attempt(s) remaining.", MaxAttempts - attempts);
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                return;
            }

            // Secure PBKDF2 Password Hashing
            string passwordHash = SecurityHelper.HashPassword(newPass);

            SqlCommand cmd = new SqlCommand(
            @"UPDATE Users SET
              PasswordHash=@pass,
              OTPCode=NULL,
              OTPExpiry=NULL,
              FailedLoginAttempts=0,
              LockoutEndTime=NULL
              WHERE Email=@Email", con);

            cmd.Parameters.AddWithValue("@pass", passwordHash);
            cmd.Parameters.AddWithValue("@Email", email);

            int rows = cmd.ExecuteNonQuery();

            if (rows > 0)
            {
                Session.Remove("VendorResetAttempts");
                Session.Remove("VendorResetOTP_Sent");

                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Password reset successful. Redirecting to login...";
                Response.AddHeader("REFRESH", "3;URL=VendorLogin.aspx");
            }
            else
            {
                lblMessage.Text = "Password reset failed. Please try again.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }

    protected void btnResendOTP_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();

        if (Session["VendorResetOTP_Sent"] != null)
        {
            DateTime lastSent = (DateTime)Session["VendorResetOTP_Sent"];
            double elapsed = (DateTime.Now - lastSent).TotalSeconds;
            if (elapsed < ResendCooldownSeconds)
            {
                int remaining = ResendCooldownSeconds - (int)elapsed;
                lblMessage.Text = string.Format("Please wait {0} seconds before requesting another OTP.", remaining);
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string otp = SecurityHelper.GenerateOtp(6);

            SqlCommand cmd = new SqlCommand(
            @"UPDATE Users SET
              OTPCode=@otp,
              OTPExpiry=DATEADD(MINUTE,10,GETDATE())
              WHERE Email=@Email", con);

            cmd.Parameters.AddWithValue("@otp", otp);
            cmd.Parameters.AddWithValue("@Email", email);
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

            SendOTPEmail(email, otp);
        }

        Session["VendorResetOTP_Sent"] = DateTime.Now;
        Session["VendorResetAttempts"] = 0;

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
