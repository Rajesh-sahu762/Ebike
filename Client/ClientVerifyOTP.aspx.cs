using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;

public partial class Client_ClientVerifyOTP : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
    private const int MaxAttempts = 5;
    private const int ResendCooldownSeconds = 60;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VerifyEmail"] == null)
        {
            if (Request.QueryString["email"] != null && !string.IsNullOrEmpty(Request.QueryString["email"].Trim()))
            {
                Session["VerifyEmail"] = Request.QueryString["email"].Trim();
            }
            else
            {
                Response.Redirect("ClientRegister.aspx");
                return;
            }
        }
    }

    protected void btnVerify_Click(object sender, EventArgs e)
    {
        if (Session["VerifyEmail"] == null)
        {
            Response.Redirect("ClientRegister.aspx");
            return;
        }

        string email = Session["VerifyEmail"].ToString();
        string inputOtp = txtOTP.Text.Trim();

        if (string.IsNullOrEmpty(inputOtp))
        {
            lblMsg.Text = "Please enter the OTP.";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT OTPCode, OTPExpiry FROM Users WHERE Email=@e", con);

            cmd.Parameters.AddWithValue("@e", email);

            string dbOTP = null;
            DateTime? expiry = null;

            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                if (dr.Read())
                {
                    dbOTP = dr["OTPCode"] != DBNull.Value ? dr["OTPCode"].ToString() : null;
                    if (dr["OTPExpiry"] != DBNull.Value)
                        expiry = Convert.ToDateTime(dr["OTPExpiry"]);
                }
            }

            if (string.IsNullOrEmpty(dbOTP) || expiry == null)
            {
                lblMsg.Text = "No active OTP found. Please click Resend OTP.";
                return;
            }

            if (DateTime.Now > expiry.Value)
            {
                lblMsg.Text = "OTP has expired. Please request a new one.";
                return;
            }

            // Attempt limiting logic
            int currentAttempts = Session["VerifyOTP_Attempts"] != null ? (int)Session["VerifyOTP_Attempts"] : 0;

            if (inputOtp == dbOTP)
            {
                // One-time validation: immediately clear OTPCode and OTPExpiry
                SqlCommand update = new SqlCommand(
                    "UPDATE Users SET IsEmailVerified=1, OTPCode=NULL, OTPExpiry=NULL WHERE Email=@e", con);

                update.Parameters.AddWithValue("@e", email);
                update.ExecuteNonQuery();

                // Optional column reset
                try
                {
                    using (SqlCommand optCmd = new SqlCommand("UPDATE Users SET OTPAttempts=0 WHERE Email=@e", con))
                    {
                        optCmd.Parameters.AddWithValue("@e", email);
                        optCmd.ExecuteNonQuery();
                    }
                }
                catch (SqlException) { }

                Session.Remove("VerifyEmail");
                Session.Remove("VerifyOTP_Attempts");
                Session.Remove("LastOTPResend");

                Response.Redirect("ClientLogin.aspx");
            }
            else
            {
                currentAttempts++;
                Session["VerifyOTP_Attempts"] = currentAttempts;

                if (currentAttempts >= MaxAttempts)
                {
                    // Invalidate OTP after maximum failed attempts
                    SqlCommand invalidate = new SqlCommand(
                        "UPDATE Users SET OTPCode=NULL, OTPExpiry=NULL WHERE Email=@e", con);
                    invalidate.Parameters.AddWithValue("@e", email);
                    invalidate.ExecuteNonQuery();

                    Session.Remove("VerifyOTP_Attempts");
                    lblMsg.Text = "Too many failed attempts. This OTP has been invalidated. Please request a new OTP.";
                }
                else
                {
                    lblMsg.Text = string.Format("Invalid OTP. {0} attempt(s) remaining.", MaxAttempts - currentAttempts);
                }
            }
        }
    }

    protected void btnResend_Click(object sender, EventArgs e)
    {
        if (Session["VerifyEmail"] == null)
        {
            Response.Redirect("ClientRegister.aspx");
            return;
        }

        string email = Session["VerifyEmail"].ToString();

        // Enforce Resend Cooldown
        if (Session["LastOTPResend"] != null)
        {
            DateTime lastSent = (DateTime)Session["LastOTPResend"];
            double elapsedSeconds = (DateTime.Now - lastSent).TotalSeconds;
            if (elapsedSeconds < ResendCooldownSeconds)
            {
                int remaining = ResendCooldownSeconds - (int)elapsedSeconds;
                lblMsg.Text = string.Format("Please wait {0} seconds before requesting another OTP.", remaining);
                return;
            }
        }

        // Generate cryptographically secure OTP
        string newOTP = SecurityHelper.GenerateOtp(6);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "UPDATE Users SET OTPCode=@otp, OTPExpiry=DATEADD(MINUTE,10,GETDATE()) WHERE Email=@e", con);

            cmd.Parameters.AddWithValue("@otp", newOTP);
            cmd.Parameters.AddWithValue("@e", email);
            cmd.ExecuteNonQuery();

            try
            {
                using (SqlCommand optCmd = new SqlCommand("UPDATE Users SET OTPAttempts=0, OTPLastSent=GETDATE() WHERE Email=@e", con))
                {
                    optCmd.Parameters.AddWithValue("@e", email);
                    optCmd.ExecuteNonQuery();
                }
            }
            catch (SqlException) { }
        }

        Session["LastOTPResend"] = DateTime.Now;
        Session["VerifyOTP_Attempts"] = 0;

        try
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(email);
            mail.Subject = "Your OTP - EBikes";
            mail.Body = "Your new OTP is: " + newOTP + "\nValid for 10 minutes.";
            mail.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);
        }
        catch { }

        lblMsg.Text = "New OTP sent successfully.";
    }
}
