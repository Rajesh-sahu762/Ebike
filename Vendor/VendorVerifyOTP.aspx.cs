using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web;
using EBIke.Security;

public partial class Vendor_VendorVerifyOTP : System.Web.UI.Page
{
    private readonly string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    private string VerificationEmail
    {
        get { return Convert.ToString(ViewState["VerificationEmail"]); }
        set { ViewState["VerificationEmail"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string email = Request.QueryString["email"];
            if (String.IsNullOrWhiteSpace(email))
            {
                Response.Redirect("VendorRegister.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            VerificationEmail = email.Trim();
            lblEmail.Text = "OTP sent to: " + Server.HtmlEncode(VerificationEmail);
        }
        else if (String.IsNullOrEmpty(VerificationEmail))
        {
            Response.Redirect("VendorRegister.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }

    protected void btnVerify_Click(object sender, EventArgs e)
    {
        string email = VerificationEmail;
        if (String.IsNullOrEmpty(email))
        {
            lblMessage.Text = "Verification session expired. Register again.";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            using (SqlTransaction tx = con.BeginTransaction(IsolationLevel.ReadCommitted))
            {
                string storedOtp = null;
                DateTime? expiry = null;
                int attempts = 0;

                using (SqlCommand read = new SqlCommand(@"
SELECT OTPCode, OTPExpiry, OTPFailedAttempts
FROM dbo.Users WITH (UPDLOCK, ROWLOCK)
WHERE Email=@Email AND Role='Dealer' AND IsActive=1;", con, tx))
                {
                    read.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;
                    using (SqlDataReader dr = read.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            storedOtp = dr["OTPCode"] == DBNull.Value ? null : Convert.ToString(dr["OTPCode"]);
                            expiry = dr["OTPExpiry"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dr["OTPExpiry"]);
                            attempts = dr["OTPFailedAttempts"] == DBNull.Value ? 0 : Convert.ToInt32(dr["OTPFailedAttempts"]);
                        }
                    }
                }

                if (String.IsNullOrEmpty(storedOtp) || !expiry.HasValue || expiry.Value <= DateTime.Now)
                {
                    tx.Rollback();
                    lblMessage.Text = "OTP is invalid or expired. Request a new OTP.";
                    return;
                }
                if (attempts >= 5)
                {
                    tx.Rollback();
                    lblMessage.Text = "Too many incorrect attempts. Request a new OTP after the cooldown.";
                    return;
                }

                if (!String.Equals(txtOTP.Text.Trim(), storedOtp, StringComparison.Ordinal))
                {
                    using (SqlCommand fail = new SqlCommand(@"
UPDATE dbo.Users SET OTPFailedAttempts=OTPFailedAttempts+1
WHERE Email=@Email AND Role='Dealer' AND OTPFailedAttempts<5;", con, tx))
                    {
                        fail.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;
                        fail.ExecuteNonQuery();
                    }
                    tx.Commit();
                    lblMessage.Text = attempts + 1 >= 5
                        ? "Too many incorrect attempts. Request a new OTP after the cooldown."
                        : "Invalid OTP.";
                    return;
                }

                using (SqlCommand verify = new SqlCommand(@"
UPDATE dbo.Users
SET IsEmailVerified=1, OTPCode=NULL, OTPExpiry=NULL,
    OTPFailedAttempts=0, OTPResendAt=NULL
WHERE Email=@Email AND Role='Dealer' AND IsActive=1;", con, tx))
                {
                    verify.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;
                    if (verify.ExecuteNonQuery() != 1)
                    {
                        tx.Rollback();
                        lblMessage.Text = "Unable to verify this vendor account.";
                        return;
                    }
                }
                tx.Commit();
            }
        }

        Response.Redirect("VendorLogin.aspx", false);
        Context.ApplicationInstance.CompleteRequest();
    }

    protected void btnResend_Click(object sender, EventArgs e)
    {
        string email = VerificationEmail;
        if (String.IsNullOrEmpty(email))
        {
            lblMessage.Text = "Verification session expired. Register again.";
            return;
        }

        string otp = OtpSecurity.GenerateSixDigitOtp();
        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand update = new SqlCommand(@"
UPDATE dbo.Users
SET OTPCode=@Otp, OTPExpiry=DATEADD(MINUTE,10,GETDATE()),
    OTPFailedAttempts=0, OTPResendAt=GETDATE()
WHERE Email=@Email AND Role='Dealer' AND IsActive=1
  AND IsEmailVerified=0
  AND (OTPResendAt IS NULL OR DATEADD(SECOND,60,OTPResendAt)<=GETDATE());", con))
        {
            update.Parameters.Add("@Otp", SqlDbType.NVarChar, 10).Value = otp;
            update.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;
            con.Open();
            if (update.ExecuteNonQuery() != 1)
            {
                lblMessage.Text = "Please wait 60 seconds before requesting another OTP.";
                return;
            }
        }

        try
        {
            using (MailMessage mail = new MailMessage())
            {
                mail.To.Add(email);
                mail.Subject = "Vendor OTP Verification - EBikes Duniya";
                mail.Body = "Your new vendor verification OTP is: " + otp + "\nValid for 10 minutes.";
                mail.IsBodyHtml = false;
                using (SmtpClient smtp = new SmtpClient())
                    smtp.Send(mail);
            }
            lblMessage.Text = "A new OTP has been sent.";
        }
        catch (SmtpException)
        {
            lblMessage.Text = "The OTP could not be emailed. Please try again after the cooldown.";
        }
    }
}
