using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;

public partial class Client_ClientVerifyOTP : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VerifyEmail"] == null)
            Response.Redirect("ClientRegister.aspx");
    }

    protected void btnVerify_Click(object sender, EventArgs e)
    {
        string email = Session["VerifyEmail"].ToString();

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT OTPCode, OTPExpiry FROM Users WHERE Email=@e", con);

            cmd.Parameters.AddWithValue("@e", email);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                string dbOTP = dr["OTPCode"].ToString();
                DateTime expiry = Convert.ToDateTime(dr["OTPExpiry"]);

                if (DateTime.Now > expiry)
                {
                    lblMsg.Text = "OTP expired.";
                    return;
                }

                if (txtOTP.Text.Trim() == dbOTP)
                {
                    dr.Close();

                    SqlCommand update = new SqlCommand(
                        "UPDATE Users SET IsEmailVerified=1, OTPCode=NULL, OTPExpiry=NULL WHERE Email=@e", con);

                    update.Parameters.AddWithValue("@e", email);
                    update.ExecuteNonQuery();

                    Response.Redirect("ClientLogin.aspx");
                }
                else
                {
                    lblMsg.Text = "Invalid OTP.";
                }
            }
        }
    }

    protected void btnResend_Click(object sender, EventArgs e)
    {
        string email = Session["VerifyEmail"].ToString();
        string newOTP = new Random().Next(100000, 999999).ToString();

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "UPDATE Users SET OTPCode=@otp, OTPExpiry=DATEADD(MINUTE,5,GETDATE()) WHERE Email=@e", con);

            cmd.Parameters.AddWithValue("@otp", newOTP);
            cmd.Parameters.AddWithValue("@e", email);
            cmd.ExecuteNonQuery();
        }

        MailMessage mail = new MailMessage();
        mail.To.Add(email);
        mail.Subject = "Your OTP - EBikes";
        mail.Body = "Your new OTP is: " + newOTP;
        mail.IsBodyHtml = false;

        SmtpClient smtp = new SmtpClient();
        smtp.Send(mail);

        lblMsg.Text = "New OTP sent.";
        btnResend.Enabled = false;
    }
}
