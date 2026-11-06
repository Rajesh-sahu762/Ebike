using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using EBIke.Security;

public partial class Client_ClientLogin : System.Web.UI.Page
{
    private readonly string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string password = txtPassword.Text;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int userId;
            string fullName;
            string storedPassword;
            int failedAttempts;
            DateTime? lockoutEnd;
            bool isActive;
            bool isVerified;

            using (SqlCommand cmd = new SqlCommand(@"
SELECT UserID, FullName, PasswordHash, FailedLoginAttempts,
       LockoutEndTime, IsActive, IsEmailVerified
FROM dbo.Users
WHERE Email=@Email AND Role='Customer';", con))
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
                    fullName = Convert.ToString(dr["FullName"]);
                    storedPassword = Convert.ToString(dr["PasswordHash"]);
                    failedAttempts = dr["FailedLoginAttempts"] == DBNull.Value ? 0 : Convert.ToInt32(dr["FailedLoginAttempts"]);
                    lockoutEnd = dr["LockoutEndTime"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dr["LockoutEndTime"]);
                    isActive = dr["IsActive"] != DBNull.Value && Convert.ToBoolean(dr["IsActive"]);
                    isVerified = dr["IsEmailVerified"] != DBNull.Value && Convert.ToBoolean(dr["IsEmailVerified"]);
                }
            }

            if (lockoutEnd.HasValue && lockoutEnd.Value > DateTime.Now)
            {
                int seconds = Math.Max(1, (int)Math.Ceiling((lockoutEnd.Value - DateTime.Now).TotalSeconds));
                lblMsg.Text = "Account locked. Try again after " + seconds + " seconds.";
                return;
            }

            if (!isVerified)
            {
                lblMsg.Text = "Please verify your email before login.";
                return;
            }

            if (!isActive)
            {
                lblMsg.Text = "Your account is disabled.";
                return;
            }

            bool validPassword = PasswordSecurity.IsHashed(storedPassword)
                ? PasswordSecurity.VerifyPassword(password, storedPassword)
                : String.Equals(storedPassword, password, StringComparison.Ordinal);

            if (!validPassword)
            {
                failedAttempts++;
                DateTime? newLockout = failedAttempts >= 5 ? DateTime.Now.AddMinutes(5) : (DateTime?)null;

                using (SqlCommand fail = new SqlCommand(@"
UPDATE dbo.Users
SET FailedLoginAttempts=@Attempts, LockoutEndTime=@Lockout
WHERE UserID=@UserID;", con))
                {
                    fail.Parameters.Add("@Attempts", SqlDbType.Int).Value = failedAttempts;
                    fail.Parameters.Add("@Lockout", SqlDbType.DateTime).Value = (object)newLockout ?? DBNull.Value;
                    fail.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                    fail.ExecuteNonQuery();
                }

                lblMsg.Text = newLockout.HasValue
                    ? "Too many attempts. Account locked for 5 minutes."
                    : "Invalid email or password.";
                return;
            }

            // Gradually migrate legacy plaintext passwords after a successful login.
            string newHash = PasswordSecurity.IsHashed(storedPassword)
                ? storedPassword
                : PasswordSecurity.HashPassword(password);

            using (SqlCommand success = new SqlCommand(@"
UPDATE dbo.Users
SET PasswordHash=@PasswordHash, FailedLoginAttempts=0, LockoutEndTime=NULL
WHERE UserID=@UserID;", con))
            {
                success.Parameters.Add("@PasswordHash", SqlDbType.NVarChar, 500).Value = newHash;
                success.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                success.ExecuteNonQuery();
            }

            Session.Clear();
            Session["CustomerID"] = userId;
            Session["CustomerName"] = fullName;

            if (chkRemember.Checked)
                RememberMeSecurity.Issue(Context, userId);
            else
                RememberMeSecurity.RevokeCurrent(Context);

            Response.Redirect("Home.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
