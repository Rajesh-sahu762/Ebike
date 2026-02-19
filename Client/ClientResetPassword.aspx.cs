using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Client_ClientResetPassword : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnReset_Click(object sender, EventArgs e)
    {
        if (Session["ResetUserID"] == null)
        {
            Response.Redirect("ClientLogin.aspx");
            return;
        }

        int userId = Convert.ToInt32(Session["ResetUserID"]);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT OTPCode, OTPExpiry FROM Users WHERE UserID=@id", con);

            cmd.Parameters.AddWithValue("@id", userId);

            SqlDataReader dr = cmd.ExecuteReader();

            if (!dr.Read())
            {
                lblMsg.Text = "Error.";
                return;
            }

            string dbOTP = dr["OTPCode"].ToString();
            DateTime expiry = Convert.ToDateTime(dr["OTPExpiry"]);

            dr.Close();

            if (expiry < DateTime.Now)
            {
                lblMsg.Text = "OTP expired.";
                return;
            }

            if (dbOTP != txtOTP.Text.Trim())
            {
                lblMsg.Text = "Invalid OTP.";
                return;
            }

            SqlCommand update = new SqlCommand(
                "UPDATE Users SET PasswordHash=@p, OTPCode=NULL, OTPExpiry=NULL WHERE UserID=@id", con);

            update.Parameters.AddWithValue("@p", txtNewPass.Text.Trim());
            update.Parameters.AddWithValue("@id", userId);
            update.ExecuteNonQuery();

            Session.Remove("ResetUserID");
            Response.Redirect("ClientLogin.aspx");
        }
    }
}
