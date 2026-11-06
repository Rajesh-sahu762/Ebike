using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendor_VendorVerifyOTP : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
    private const int MaxAttempts = 5;
    private const int ResendCooldownSeconds = 60;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string email = Request.QueryString["email"];
            if (string.IsNullOrEmpty(email) && Session["VendorVerifyEmail"] != null)
                email = Session["VendorVerifyEmail"].ToString();

            if (string.IsNullOrEmpty(email))
            {
                Response.Redirect("VendorRegister.aspx");
                return;
            }

            lblEmail.Text = "OTP sent to: " + Server.HtmlEncode(email);
        }
    }

    protected void btnVerify_Click(object sender, EventArgs e)
    {
        string email = Request.QueryString["email"];
        if (string.IsNullOrEmpty(email) && Session["VendorVerifyEmail"] != null)
            email = Session["VendorVerifyEmail"].ToString();

        if (string.IsNullOrEmpty(email))
        {
            Response.Redirect("VendorRegister.aspx");
            return;
        }

        string otp = txtOTP.Text.Trim();
        if (string.IsNullOrEmpty(otp))
        {
            lblMessage.Text = "Please enter the OTP.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            @"SELECT OTPCode, OTPExpiry FROM Users
              WHERE Email=@Email AND Role='Dealer'", con);

            cmd.Parameters.AddWithValue("@Email", email);

            string dbOtp = null;
            DateTime? expiry = null;

            using (SqlDataReader dr = cmd.ExecuteReader())
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
                lblMessage.Text = "OTP Expired. Please click Resend OTP.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int attempts = Session["VendorVerify_Attempts"] != null ? (int)Session["VendorVerify_Attempts"] : 0;

            if (otp != dbOtp)
            {
                attempts++;
                Session["VendorVerify_Attempts"] = attempts;

                if (attempts >= MaxAttempts)
                {
                    SqlCommand invalidate = new SqlCommand(
                        "UPDATE Users SET OTPCode=NULL, OTPExpiry=NULL WHERE Email=@Email", con);
                    invalidate.Parameters.AddWithValue("@Email", email);
                    invalidate.ExecuteNonQuery();

                    Session.Remove("VendorVerify_Attempts");
                    lblMessage.Text = "Too many failed attempts. This OTP has been invalidated. Please click Resend OTP.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    lblMessage.Text = string.Format("Invalid OTP. {0} attempt(s) remaining.", MaxAttempts - attempts);
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                return;
            }

            // One-time validation: clear OTP
            SqlCommand verifyCmd = new SqlCommand(
            @"UPDATE Users SET
              IsEmailVerified=1,
              OTPCode=NULL,
              OTPExpiry=NULL
              WHERE Email=@Email", con);

            verifyCmd.Parameters.AddWithValue("@Email", email);
            verifyCmd.ExecuteNonQuery();

            Session.Remove("VendorVerify_Attempts");
            Session.Remove("VendorVerifyEmail");
            Session.Remove("VendorLastOTPResend");

            lblMessage.Text = "Email verified successfully! Redirecting to login...";
            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.CssClass = "success";

            ScriptManager.RegisterStartupScript(this, this.GetType(),
                "redirect",
                "startRedirect();",
                true);
        }
    }

    protected void btnResend_Click(object sender, EventArgs e)
    {
        string email = Request.QueryString["email"];
        if (string.IsNullOrEmpty(email) && Session["VendorVerifyEmail"] != null)
            email = Session["VendorVerifyEmail"].ToString();

        if (string.IsNullOrEmpty(email))
        {
            Response.Redirect("VendorRegister.aspx");
            return;
        }

        // Resend cooldown check
        if (Session["VendorLastOTPResend"] != null)
        {
            DateTime lastSent = (DateTime)Session["VendorLastOTPResend"];
            double elapsed = (DateTime.Now - lastSent).TotalSeconds;
            if (elapsed < ResendCooldownSeconds)
            {
                int remaining = ResendCooldownSeconds - (int)elapsed;
                lblMessage.Text = string.Format("Please wait {0} seconds before requesting another OTP.", remaining);
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }
        }

        string otp = SecurityHelper.GenerateOtp(6);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

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
        }

        Session["VendorLastOTPResend"] = DateTime.Now;
        Session["VendorVerify_Attempts"] = 0;

        try
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(email);
            mail.Subject = "New OTP - EBikes Duniya";
            mail.Body = "Your new OTP is: " + otp + "\nValid for 10 minutes.";
            mail.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);
        }
        catch { }

        lblMessage.Text = "New OTP sent to your email.";
        lblMessage.ForeColor = System.Drawing.Color.Green;
    }
}
