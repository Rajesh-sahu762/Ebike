using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using EBIke.Security;

public partial class Vendor_VendorLogin : System.Web.UI.Page
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
            string storedPassword;
            bool isApproved, isActive, isVerified;
            int failedAttempts;
            DateTime? lockEnd;

            using (SqlCommand cmd = new SqlCommand(@"
SELECT UserID, PasswordHash, IsApproved, IsActive, IsEmailVerified,
       FailedLoginAttempts, LockoutEndTime
FROM dbo.Users
WHERE Email=@Email AND Role='Dealer';", con))
            {
                cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 256).Value = email;
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (!dr.Read())
                    {
                        lblMessage.Text = "Invalid email or password.";
                        return;
                    }
                    userId = Convert.ToInt32(dr["UserID"]);
                    storedPassword = Convert.ToString(dr["PasswordHash"]);
                    isApproved = dr["IsApproved"] != DBNull.Value && Convert.ToBoolean(dr["IsApproved"]);
                    isActive = dr["IsActive"] != DBNull.Value && Convert.ToBoolean(dr["IsActive"]);
                    isVerified = dr["IsEmailVerified"] != DBNull.Value && Convert.ToBoolean(dr["IsEmailVerified"]);
                    failedAttempts = dr["FailedLoginAttempts"] == DBNull.Value ? 0 : Convert.ToInt32(dr["FailedLoginAttempts"]);
                    lockEnd = dr["LockoutEndTime"] == DBNull.Value ? (DateTime?)null : Convert.ToDateTime(dr["LockoutEndTime"]);
                }
            }

            if (lockEnd.HasValue && lockEnd.Value > DateTime.Now)
            {
                lblMessage.Text = "Account temporarily locked. Try again later.";
                return;
            }

            bool validPassword = PasswordSecurity.IsHashed(storedPassword)
                ? PasswordSecurity.VerifyPassword(password, storedPassword)
                : String.Equals(storedPassword, password, StringComparison.Ordinal);

            if (!validPassword)
            {
                failedAttempts++;
                DateTime? nextLock = failedAttempts >= 5 ? DateTime.Now.AddMinutes(5) : (DateTime?)null;
                using (SqlCommand fail = new SqlCommand(@"
UPDATE dbo.Users SET FailedLoginAttempts=@Attempts, LockoutEndTime=@Lockout
WHERE UserID=@UserID;", con))
                {
                    fail.Parameters.Add("@Attempts", SqlDbType.Int).Value = failedAttempts;
                    fail.Parameters.Add("@Lockout", SqlDbType.DateTime).Value = (object)nextLock ?? DBNull.Value;
                    fail.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                    fail.ExecuteNonQuery();
                }
                lblMessage.Text = "Invalid email or password.";
                return;
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
            Session["VendorID"] = userId;
            Session["Role"] = "Dealer";
            Response.Redirect("VendorDashboard.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
