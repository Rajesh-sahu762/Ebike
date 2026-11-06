using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class AdminLogin : System.Web.UI.Page
{
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string password = txtPassword.Text.Trim();

        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
        {
            lblMsg.Text = "Please enter both email and password.";
            return;
        }

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string query = "SELECT UserID, PasswordHash, FullName FROM Users WHERE Email=@Email AND Role='Admin' AND IsActive=1";
            int userId = 0;
            string dbPass = null;
            string fullName = null;

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Email", email);
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        userId = Convert.ToInt32(dr["UserID"]);
                        dbPass = dr["PasswordHash"] != DBNull.Value ? dr["PasswordHash"].ToString() : string.Empty;
                        fullName = dr["FullName"] != DBNull.Value ? dr["FullName"].ToString() : "Admin";
                    }
                }
            }

            bool needsUpgrade;
            if (userId > 0 && SecurityHelper.VerifyPassword(password, dbPass, out needsUpgrade))
            {
                // Safe migration: upgrade legacy plaintext password to PBKDF2 hash upon successful login
                if (needsUpgrade)
                {
                    string newHash = SecurityHelper.HashPassword(password);
                    using (SqlCommand upgradeCmd = new SqlCommand("UPDATE Users SET PasswordHash=@Hash WHERE UserID=@ID", con))
                    {
                        upgradeCmd.Parameters.AddWithValue("@Hash", newHash);
                        upgradeCmd.Parameters.AddWithValue("@ID", userId);
                        upgradeCmd.ExecuteNonQuery();
                    }
                }

                Session["AdminID"] = userId.ToString();
                Session["AdminName"] = fullName;
                Session["Role"] = "Admin";
                Response.Redirect("AdminDashboard.aspx");
            }
            else
            {
                lblMsg.Text = "Invalid Email or Password!";
            }
        }
    }
}
