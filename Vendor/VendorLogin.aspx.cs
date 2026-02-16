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
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            @"SELECT UserID, PasswordHash, IsApproved, IsActive,
              IsEmailVerified, FailedLoginAttempts, LockoutEndTime
              FROM Users
              WHERE Email=@Email AND Role='Dealer'", con);

            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

            SqlDataReader dr = cmd.ExecuteReader();

            if (!dr.Read())
            {
                lblMessage.Text = "Invalid Email or Password.";
                return;
            }

            int userId = Convert.ToInt32(dr["UserID"]);
            string dbPass = dr["PasswordHash"].ToString();
            bool isApproved = Convert.ToBoolean(dr["IsApproved"]);
            bool isActive = Convert.ToBoolean(dr["IsActive"]);
            bool isVerified = Convert.ToBoolean(dr["IsEmailVerified"]);
            int failedAttempts = Convert.ToInt32(dr["FailedLoginAttempts"]);
            DateTime? lockEnd = dr["LockoutEndTime"] as DateTime?;

            dr.Close();

            if (lockEnd != null && lockEnd > DateTime.Now)
            {
                lblMessage.Text = "Account locked. Try again after 45 seconds.";
                return;
            }

            if (dbPass != txtPassword.Text.Trim())
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

            // Reset failed attempts
            SqlCommand resetCmd = new SqlCommand(
                "UPDATE Users SET FailedLoginAttempts=0, LockoutEndTime=NULL WHERE UserID=@id", con);

            resetCmd.Parameters.AddWithValue("@id", userId);
            resetCmd.ExecuteNonQuery();

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
            Response.Redirect("VendorDashboard.aspx");
        }
    }
}