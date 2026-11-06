using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendor_VendorLogin : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string inputPassword = txtPassword.Text.Trim();

        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(inputPassword))
        {
            lblMessage.Text = "Please enter both email and password.";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            @"SELECT UserID, FullName, PasswordHash, IsApproved, IsActive,
              IsEmailVerified, FailedLoginAttempts, LockoutEndTime
              FROM Users
              WHERE Email=@Email AND Role='Dealer'", con);

            cmd.Parameters.AddWithValue("@Email", email);

            SqlDataReader dr = cmd.ExecuteReader();

            if (!dr.Read())
            {
                lblMessage.Text = "Invalid Email or Password.";
                return;
            }

            int userId = Convert.ToInt32(dr["UserID"]);
            string fullName = dr["FullName"] != DBNull.Value ? dr["FullName"].ToString() : "Vendor";
            string dbPass = dr["PasswordHash"] != DBNull.Value ? dr["PasswordHash"].ToString() : string.Empty;
            bool isApproved = dr["IsApproved"] != DBNull.Value && Convert.ToBoolean(dr["IsApproved"]);
            bool isActive = dr["IsActive"] != DBNull.Value && Convert.ToBoolean(dr["IsActive"]);
            bool isVerified = dr["IsEmailVerified"] != DBNull.Value && Convert.ToBoolean(dr["IsEmailVerified"]);
            int failedAttempts = dr["FailedLoginAttempts"] != DBNull.Value ? Convert.ToInt32(dr["FailedLoginAttempts"]) : 0;
            DateTime? lockEnd = dr["LockoutEndTime"] as DateTime?;

            dr.Close();

            if (lockEnd != null && lockEnd > DateTime.Now)
            {
                lblMessage.Text = "Account locked. Try again after 45 seconds.";
                return;
            }

            bool needsUpgrade;
            if (!SecurityHelper.VerifyPassword(inputPassword, dbPass, out needsUpgrade))
            {
                failedAttempts++;

                SqlCommand failCmd = new SqlCommand(
                @"UPDATE Users SET
                  FailedLoginAttempts=@fail,
                  LockoutEndTime=@lock
                  WHERE UserID=@id", con);

                failCmd.Parameters.AddWithValue("@fail", failedAttempts);

                if (failedAttempts >= 5)
                    failCmd.Parameters.AddWithValue("@lock", DateTime.Now.AddSeconds(45));
                else
                    failCmd.Parameters.AddWithValue("@lock", DBNull.Value);

                failCmd.Parameters.AddWithValue("@id", userId);
                failCmd.ExecuteNonQuery();

                lblMessage.Text = "Invalid Email or Password.";
                return;
            }

            // Reset failed attempts & upgrade password to PBKDF2 if needed
            if (needsUpgrade)
            {
                string newHash = SecurityHelper.HashPassword(inputPassword);
                SqlCommand upgradeCmd = new SqlCommand(
                    "UPDATE Users SET PasswordHash=@p, FailedLoginAttempts=0, LockoutEndTime=NULL WHERE UserID=@id", con);
                upgradeCmd.Parameters.AddWithValue("@p", newHash);
                upgradeCmd.Parameters.AddWithValue("@id", userId);
                upgradeCmd.ExecuteNonQuery();
            }
            else
            {
                SqlCommand resetCmd = new SqlCommand(
                    "UPDATE Users SET FailedLoginAttempts=0, LockoutEndTime=NULL WHERE UserID=@id", con);
                resetCmd.Parameters.AddWithValue("@id", userId);
                resetCmd.ExecuteNonQuery();
            }

            if (!isVerified)
            {
                lblMessage.Text = "Please verify your email first.";
                return;
            }

            if (!isApproved)
            {
                lblMessage.Text = "Waiting for admin approval.";
                return;
            }

            if (!isActive)
            {
                lblMessage.Text = "Account inactive.";
                return;
            }

            Session["VendorID"] = userId;
            Session["VendorName"] = fullName;
            Session["Role"] = "Dealer";
            Response.Redirect("VendorDashboard.aspx");
        }
    }
}
