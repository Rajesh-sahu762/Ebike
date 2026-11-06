using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;

public partial class Client_ClientLogin : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string inputPassword = txtPassword.Text.Trim();

        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(inputPassword))
        {
            lblMsg.Text = "Please enter both email and password.";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            SELECT UserID, FullName, PasswordHash,
                   FailedLoginAttempts,
                   LockoutEndTime,
                   IsActive,
                   IsEmailVerified
            FROM Users
            WHERE Email=@Email AND Role='Customer'", con);

            cmd.Parameters.AddWithValue("@Email", email);

            SqlDataReader dr = cmd.ExecuteReader();

            if (!dr.Read())
            {
                lblMsg.Text = "Invalid email or password.";
                return;
            }

            int userId = Convert.ToInt32(dr["UserID"]);
            string fullName = dr["FullName"] != DBNull.Value ? dr["FullName"].ToString() : string.Empty;
            string dbPass = dr["PasswordHash"] != DBNull.Value ? dr["PasswordHash"].ToString() : string.Empty;
            int failed = dr["FailedLoginAttempts"] != DBNull.Value ? Convert.ToInt32(dr["FailedLoginAttempts"]) : 0;
            bool isActive = dr["IsActive"] != DBNull.Value && Convert.ToBoolean(dr["IsActive"]);
            bool isVerified = dr["IsEmailVerified"] != DBNull.Value && Convert.ToBoolean(dr["IsEmailVerified"]);
            object lockObj = dr["LockoutEndTime"];

            dr.Close();

            // Email Verification Check
            if (!isVerified)
            {
                lblMsg.Text = "Please verify your email before login.";
                return;
            }

            // Account Active Check
            if (!isActive)
            {
                lblMsg.Text = "Your account is disabled.";
                return;
            }

            // Lock Check
            if (lockObj != DBNull.Value)
            {
                DateTime lockEnd = Convert.ToDateTime(lockObj);

                if (lockEnd > DateTime.Now)
                {
                    int seconds = (int)(lockEnd - DateTime.Now).TotalSeconds;
                    lblMsg.Text = "Account locked. Try after " + seconds + " seconds.";
                    return;
                }
                else
                {
                    SqlCommand reset = new SqlCommand(
                    "UPDATE Users SET FailedLoginAttempts=0, LockoutEndTime=NULL WHERE UserID=@id", con);

                    reset.Parameters.AddWithValue("@id", userId);
                    reset.ExecuteNonQuery();

                    failed = 0;
                }
            }

            // Password Check with PBKDF2 support and safe legacy migration
            bool needsUpgrade;
            if (SecurityHelper.VerifyPassword(inputPassword, dbPass, out needsUpgrade))
            {
                // If legacy plaintext password matched, upgrade immediately to PBKDF2
                if (needsUpgrade)
                {
                    string newHash = SecurityHelper.HashPassword(inputPassword);
                    SqlCommand upgradeCmd = new SqlCommand(
                        "UPDATE Users SET PasswordHash=@p, FailedLoginAttempts=0 WHERE UserID=@id", con);
                    upgradeCmd.Parameters.AddWithValue("@p", newHash);
                    upgradeCmd.Parameters.AddWithValue("@id", userId);
                    upgradeCmd.ExecuteNonQuery();
                }
                else
                {
                    SqlCommand success = new SqlCommand(
                        "UPDATE Users SET FailedLoginAttempts=0 WHERE UserID=@id", con);
                    success.Parameters.AddWithValue("@id", userId);
                    success.ExecuteNonQuery();
                }

                // Create Session
                Session["CustomerID"] = userId;
                Session["CustomerName"] = fullName;
                Session["Role"] = "Customer";

                if (chkRemember.Checked)
                {
                    AuthHelper.IssueRememberMeCookie(userId, Response, constr);
                }

                Response.Redirect("Home.aspx");
            }
            else
            {
                failed++;

                if (failed >= 5)
                {
                    DateTime lockTime = DateTime.Now.AddSeconds(45);

                    SqlCommand lockCmd = new SqlCommand(
                    "UPDATE Users SET FailedLoginAttempts=@f, LockoutEndTime=@l WHERE UserID=@id", con);

                    lockCmd.Parameters.AddWithValue("@f", failed);
                    lockCmd.Parameters.AddWithValue("@l", lockTime);
                    lockCmd.Parameters.AddWithValue("@id", userId);
                    lockCmd.ExecuteNonQuery();

                    lblMsg.Text = "Too many attempts. Account locked for 45 seconds.";
                }
                else
                {
                    SqlCommand failCmd = new SqlCommand(
                    "UPDATE Users SET FailedLoginAttempts=@f WHERE UserID=@id", con);

                    failCmd.Parameters.AddWithValue("@f", failed);
                    failCmd.Parameters.AddWithValue("@id", userId);
                    failCmd.ExecuteNonQuery();

                    lblMsg.Text = "Invalid password. Attempts left: " + (5 - failed);
                }
            }
        }
    }
}
