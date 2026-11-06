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

            using (SqlCommand cmd = new SqlCommand(@"
SELECT UserID, PasswordHash
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
                }
            }

            bool validPassword = PasswordSecurity.IsHashed(storedPassword)
                ? PasswordSecurity.VerifyPassword(password, storedPassword)
                : String.Equals(storedPassword, password, StringComparison.Ordinal);

            if (!validPassword)
            {
                lblMsg.Text = "Invalid email or password.";
                return;
            }

            string newHash = PasswordSecurity.IsHashed(storedPassword)
                ? storedPassword
                : PasswordSecurity.HashPassword(password);

            using (SqlCommand update = new SqlCommand(
                "UPDATE dbo.Users SET PasswordHash=@Hash WHERE UserID=@UserID;", con))
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
