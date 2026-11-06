using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using EBIke.Security;

public partial class Client_MyProfile : System.Web.UI.Page
{
    private readonly string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CustomerID"] == null)
        {
            Response.Redirect("ClientLogin.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }
        if (!IsPostBack)
        {
            LoadProfile();
            LoadStats();
        }
    }

    private void LoadProfile()
    {
        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand cmd = new SqlCommand(
            "SELECT FullName,Email,Mobile,City FROM dbo.Users WHERE UserID=@id AND Role='Customer';", con))
        {
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(Session["CustomerID"]);
            con.Open();
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                if (!dr.Read()) return;
                litName.Text = Server.HtmlEncode(Convert.ToString(dr["FullName"]));
                litEmail.Text = Server.HtmlEncode(Convert.ToString(dr["Email"]));
                txtName.Text = Convert.ToString(dr["FullName"]);
                txtEmail.Text = Convert.ToString(dr["Email"]);
                txtMobile.Text = Convert.ToString(dr["Mobile"]);
                txtCity.Text = Convert.ToString(dr["City"]);
            }
        }
    }

    private void LoadStats()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            int id = Convert.ToInt32(Session["CustomerID"]);
            using (SqlCommand wish = new SqlCommand("SELECT COUNT(*) FROM dbo.Wishlist WHERE CustomerID=@u;", con))
            {
                wish.Parameters.Add("@u", SqlDbType.Int).Value = id;
                litWishlistCount.Text = Convert.ToString(wish.ExecuteScalar());
            }
            using (SqlCommand enq = new SqlCommand("SELECT COUNT(*) FROM dbo.Leads WHERE CustomerID=@u;", con))
            {
                enq.Parameters.Add("@u", SqlDbType.Int).Value = id;
                litEnquiryCount.Text = Convert.ToString(enq.ExecuteScalar());
            }
            using (SqlCommand rev = new SqlCommand("SELECT COUNT(*) FROM dbo.BikeReviews WHERE CustomerID=@u;", con))
            {
                rev.Parameters.Add("@u", SqlDbType.Int).Value = id;
                litReviewCount.Text = Convert.ToString(rev.ExecuteScalar());
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        // Email changes need a separate verification workflow; do not let this form
        // replace the verified login identifier.
        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand cmd = new SqlCommand(@"
UPDATE dbo.Users SET FullName=@n, Mobile=@m, City=@c
WHERE UserID=@id AND Role='Customer';", con))
        {
            cmd.Parameters.Add("@n", SqlDbType.NVarChar, 150).Value = txtName.Text.Trim();
            cmd.Parameters.Add("@m", SqlDbType.NVarChar, 30).Value = txtMobile.Text.Trim();
            cmd.Parameters.Add("@c", SqlDbType.NVarChar, 100).Value = txtCity.Text.Trim();
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(Session["CustomerID"]);
            con.Open();
            cmd.ExecuteNonQuery();
        }
        LoadProfile();
    }

    protected void btnChangePass_Click(object sender, EventArgs e)
    {
        if (txtNewPass.Text.Length < 10)
        {
            ClientScript.RegisterStartupScript(GetType(), "passLength",
                "alert('Use a password with at least 10 characters.');", true);
            return;
        }
        if (txtNewPass.Text != txtConfirmPass.Text)
        {
            ClientScript.RegisterStartupScript(GetType(), "passMismatch",
                "alert('Passwords do not match.');", true);
            return;
        }

        int userId = Convert.ToInt32(Session["CustomerID"]);
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            string stored;
            using (SqlCommand check = new SqlCommand(
                "SELECT PasswordHash FROM dbo.Users WHERE UserID=@id AND Role='Customer' AND IsActive=1;", con))
            {
                check.Parameters.Add("@id", SqlDbType.Int).Value = userId;
                object value = check.ExecuteScalar();
                if (value == null || value == DBNull.Value)
                {
                    ClientScript.RegisterStartupScript(GetType(), "oldPass",
                        "alert('Unable to verify account.');", true);
                    return;
                }
                stored = Convert.ToString(value);
            }

            bool valid = PasswordSecurity.IsHashed(stored)
                ? PasswordSecurity.VerifyPassword(txtOldPass.Text, stored)
                : String.Equals(stored, txtOldPass.Text, StringComparison.Ordinal);
            if (!valid)
            {
                ClientScript.RegisterStartupScript(GetType(), "oldPass",
                    "alert('Old password incorrect.');", true);
                return;
            }

            using (SqlTransaction tx = con.BeginTransaction())
            {
                using (SqlCommand update = new SqlCommand(@"
UPDATE dbo.Users SET PasswordHash=@PasswordHash
WHERE UserID=@UserID AND Role='Customer';", con, tx))
                {
                    update.Parameters.Add("@PasswordHash", SqlDbType.NVarChar, 500).Value =
                        PasswordSecurity.HashPassword(txtNewPass.Text);
                    update.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                    update.ExecuteNonQuery();
                }
                try
                {
                    using (SqlCommand revoke = new SqlCommand(@"
UPDATE dbo.RememberMeTokens SET RevokedAtUtc=SYSUTCDATETIME()
WHERE UserID=@UserID AND RevokedAtUtc IS NULL;", con, tx))
                    {
                        revoke.Parameters.Add("@UserID", SqlDbType.Int).Value = userId;
                        revoke.ExecuteNonQuery();
                    }
                }
                catch (SqlException ex)
                {
                    if (ex.Number != 208) throw;
                }
                tx.Commit();
            }
        }
        RememberMeSecurity.RevokeCurrent(Context);
        ClientScript.RegisterStartupScript(GetType(), "passChanged",
            "alert('Password updated successfully. Please login again.');", true);
        Session.Clear();
    }
}
