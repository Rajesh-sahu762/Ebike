using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Client_ClientResetPassword : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
    private const int MaxAttempts = 5;

    protected void btnReset_Click(object sender, EventArgs e)
    {
        if (Session["ResetUserID"] == null)
        {
            Response.Redirect("ClientLogin.aspx");
            return;
        }

        int userId = Convert.ToInt32(Session["ResetUserID"]);
        string inputOtp = txtOTP.Text.Trim();
        string newPass = txtNewPass.Text.Trim();

        if (string.IsNullOrEmpty(inputOtp))
        {
            lblMsg.Text = "Please enter the OTP.";
            return;
        }

        if (string.IsNullOrEmpty(newPass) || newPass.Length < 6)
        {
            lblMsg.Text = "Password must be at least 6 characters long.";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT OTPCode, OTPExpiry FROM Users WHERE UserID=@id", con);

            cmd.Parameters.AddWithValue("@id", userId);

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
                lblMsg.Text = "No active reset request found. Please request a new OTP.";
                return;
            }

            if (DateTime.Now > expiry.Value)
            {
                lblMsg.Text = "OTP has expired. Please request a new one.";
                return;
            }

            int attempts = Session["ResetOTP_Attempts"] != null ? (int)Session["ResetOTP_Attempts"] : 0;

            if (inputOtp != dbOTP)
            {
                attempts++;
                Session["ResetOTP_Attempts"] = attempts;

                if (attempts >= MaxAttempts)
                {
                    SqlCommand invalidate = new SqlCommand(
                        "UPDATE Users SET OTPCode=NULL, OTPExpiry=NULL WHERE UserID=@id", con);
                    invalidate.Parameters.AddWithValue("@id", userId);
                    invalidate.ExecuteNonQuery();

                    Session.Remove("ResetOTP_Attempts");
                    lblMsg.Text = "Too many incorrect attempts. This OTP has been invalidated. Please request a new password reset.";
                }
                else
                {
                    lblMsg.Text = string.Format("Invalid OTP. {0} attempt(s) remaining.", MaxAttempts - attempts);
                }
                return;
            }

            // Secure PBKDF2 Password Hashing on Reset
            string newPasswordHash = SecurityHelper.HashPassword(newPass);

            // One-time validation: update password hash and clear OTP
            SqlCommand update = new SqlCommand(
                "UPDATE Users SET PasswordHash=@p, OTPCode=NULL, OTPExpiry=NULL, FailedLoginAttempts=0, LockoutEndTime=NULL WHERE UserID=@id", con);

            update.Parameters.AddWithValue("@p", newPasswordHash);
            update.Parameters.AddWithValue("@id", userId);
            update.ExecuteNonQuery();

            Session.Remove("ResetUserID");
            Session.Remove("ResetOTP_Attempts");
            Session.Remove("LastResetOTP_Sent");

            Response.Redirect("ClientLogin.aspx");
        }
    }
}
