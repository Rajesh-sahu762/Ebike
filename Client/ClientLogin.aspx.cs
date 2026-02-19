using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Client_ClientLogin : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            SELECT UserID, PasswordHash, FailedLoginAttempts,
                   LockoutEndTime, IsActive
            FROM Users
            WHERE Email=@Email AND Role='Customer'", con);

            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

            SqlDataReader dr = cmd.ExecuteReader();

            if (!dr.Read())
            {
                lblMsg.Text = "Invalid credentials.";
                return;
            }

            int userId = Convert.ToInt32(dr["UserID"]);
            string dbPass = dr["PasswordHash"].ToString();
            int failed = Convert.ToInt32(dr["FailedLoginAttempts"]);
            object lockObj = dr["LockoutEndTime"];

            dr.Close();

            // CHECK LOCK
            if (lockObj != DBNull.Value)
            {
                DateTime lockEnd = Convert.ToDateTime(lockObj);

                if (lockEnd > DateTime.Now)
                {
                    int seconds = (int)(lockEnd - DateTime.Now).TotalSeconds;
                    lblMsg.Text = "Account locked. Try after " + seconds + " sec.";
                    return;
                }
                else
                {
                    // Reset after lock expires
                    SqlCommand reset = new SqlCommand(
                        "UPDATE Users SET FailedLoginAttempts=0, LockoutEndTime=NULL WHERE UserID=@id", con);
                    reset.Parameters.AddWithValue("@id", userId);
                    reset.ExecuteNonQuery();
                    failed = 0;
                }
            }

            // CHECK PASSWORD
            if (dbPass == txtPassword.Text.Trim())
            {
                SqlCommand success = new SqlCommand(
                    "UPDATE Users SET FailedLoginAttempts=0 WHERE UserID=@id", con);
                success.Parameters.AddWithValue("@id", userId);
                success.ExecuteNonQuery();

                Session["ClientID"] = userId;
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

                    lblMsg.Text = "Too many attempts. Locked for 45 seconds.";
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
