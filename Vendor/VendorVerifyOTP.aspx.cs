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

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["email"] == null)
                Response.Redirect("VendorRegister.aspx");

            lblEmail.Text = "OTP sent to: " + Request.QueryString["email"];
        }
    }

    protected void btnVerify_Click(object sender, EventArgs e)
    {
        string email = Request.QueryString["email"];
        string otp = txtOTP.Text.Trim();

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            @"SELECT OTPExpiry FROM Users
              WHERE Email=@Email
              AND OTPCode=@otp", con);

            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@otp", otp);

            object result = cmd.ExecuteScalar();

            if (result == null)
            {
                lblMessage.Text = "Invalid OTP.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            DateTime expiry = Convert.ToDateTime(result);

            if (expiry < DateTime.Now)
            {
                lblMessage.Text = "OTP Expired. Please resend.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            SqlCommand verifyCmd = new SqlCommand(
            @"UPDATE Users SET
              IsEmailVerified=1,
              OTPCode=NULL,
              OTPExpiry=NULL
              WHERE Email=@Email", con);

            verifyCmd.Parameters.AddWithValue("@Email", email);
            verifyCmd.ExecuteNonQuery();

            lblMessage.Text = "Email verified successfully! Redirecting to login...";
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
        string otp = new Random().Next(100000, 999999).ToString();

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
        }

        SendOTPEmail(email, otp);

        lblMessage.Text = "New OTP sent successfully.";
        lblMessage.ForeColor = System.Drawing.Color.Green;
    }

    void SendOTPEmail(string toEmail, string otp)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(toEmail);
            mail.Subject = "Vendor OTP Verification";

            mail.Body =
            "Your new OTP is: " + otp + "\n\n" +
            "Valid for 10 minutes.\n\n" +
            "EBikes Duniya Team";

            mail.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);
        }
        catch
        {
        }
    }
}