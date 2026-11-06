using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using EBIke.Security;

public partial class AdminLogin : System.Web.UI.Page
{
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
        string email = txtEmail.Text.Trim();
        string password = txtPassword.Text;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            int userId;
            string storedPassword;
            int failedAttempts;
            DateTime? lockoutEnd;

            using (SqlCommand cmd = new SqlCommand(@"
SELECT UserID, PasswordHash, FailedLoginAttempts, LockoutEndTime
FROM dbo.Users
WHERE Email=@Email AND Role='Admin' AND IsActive=1;", con))
            {
                cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (!dr.Read())
                    {
                        lblMsg.Text = "Invalid email or password.";
                        return;
                    }
                    userId = Convert.ToInt32(dr["UserID"]);
                    storedPassword = Convert.ToString(dr["PasswordHash"]);
                    failedAttempts = dr["FailedLoginAttempts"] == DBNull.Value ? 0 : Convert.ToInt32(dr["FailedLoginAttempts"]);
                    lockoutEnd = dr["LockoutEndTime"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dr["LockoutEndTime"]);
                }
            }

            if (lockoutEnd.HasValue && lockoutEnd.Value > DateTime.Now)
            {
                lblMsg.Text = "Account temporarily locked. Try again later.";
                return;
            }

            bool validPassword = PasswordSecurity.IsHashed(storedPassword)
                ? PasswordSecurity.VerifyPassword(password, storedPassword)
                : String.Equals(storedPassword, password, StringComparison.Ordinal);

            if (!validPassword)
            {
                failedAttempts++;
                DateTime? nextLockout = failedAttempts >= 5 ? DateTime.Now.AddMinutes(5) : (DateTime?)null;

                using (SqlCommand fail = new SqlCommand(@"
UPDATE dbo.Users
SET FailedLoginAttempts=@Attempts, LockoutEndTime=@Lockout
WHERE UserID=@UserID AND Role='Admin';", con))
                {
                    fail.Parameters.Add("@Attempts", SqlDbType.Int).Value = failedAttempts;
                    fail.Parameters.Add("@Lockout", SqlDbType.DateTime).Value = (object)nextLockout ?? DBNull.Value;
                    fail.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                    fail.ExecuteNonQuery();
                }

                lblMsg.Text = nextLockout.HasValue
                    ? "Too many attempts. Account locked for 5 minutes."
                    : "Invalid email or password.";
                return;
            }

            string newHash = PasswordSecurity.IsHashed(storedPassword)
                ? storedPassword : PasswordSecurity.HashPassword(password);

            using (SqlCommand update = new SqlCommand(@"
UPDATE dbo.Users
SET PasswordHash=@Hash, FailedLoginAttempts=0, LockoutEndTime=NULL
WHERE UserID=@UserID AND Role='Admin';", con))
            {
                update.Parameters.Add("@Hash", SqlDbType.NVarChar, 500).Value = newHash;
                update.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                update.ExecuteNonQuery();
            }

            Session.Clear();
            Session["AdminID"] = userId;
            Session["Role"] = "Admin";
            Response.Redirect("AdminDashboard.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
