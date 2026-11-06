using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class Client_MyProfile : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CustomerID"] == null)
        {
            Response.Redirect("ClientLogin.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadProfile();
            LoadStats();
        }
    }

    void LoadProfile()
    {
        if (Session["CustomerID"] == null) return;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT FullName,Email,Mobile,City FROM Users WHERE UserID=@id", con);

            cmd.Parameters.AddWithValue("@id", Session["CustomerID"]);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                litName.Text = dr["FullName"] != DBNull.Value ? dr["FullName"].ToString() : "";
                litEmail.Text = dr["Email"] != DBNull.Value ? dr["Email"].ToString() : "";

                txtName.Text = dr["FullName"] != DBNull.Value ? dr["FullName"].ToString() : "";
                txtEmail.Text = dr["Email"] != DBNull.Value ? dr["Email"].ToString() : "";
                txtMobile.Text = dr["Mobile"] != DBNull.Value ? dr["Mobile"].ToString() : "";
                txtCity.Text = dr["City"] != DBNull.Value ? dr["City"].ToString() : "";
            }
        }
    }

    void LoadStats()
    {
        if (Session["CustomerID"] == null) return;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int id = Convert.ToInt32(Session["CustomerID"]);

            SqlCommand wish = new SqlCommand(
            "SELECT COUNT(*) FROM Wishlist WHERE CustomerID=@u", con);
            wish.Parameters.AddWithValue("@u", id);
            litWishlistCount.Text = wish.ExecuteScalar().ToString();

            SqlCommand enq = new SqlCommand(
            "SELECT COUNT(*) FROM Leads WHERE CustomerID=@u", con);
            enq.Parameters.AddWithValue("@u", id);
            litEnquiryCount.Text = enq.ExecuteScalar().ToString();

            SqlCommand rev = new SqlCommand(
            "SELECT COUNT(*) FROM BikeReviews WHERE CustomerID=@u", con);
            rev.Parameters.AddWithValue("@u", id);
            litReviewCount.Text = rev.ExecuteScalar().ToString();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Session["CustomerID"] == null)
        {
            Response.Redirect("ClientLogin.aspx");
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            UPDATE Users
            SET
            FullName=@n,
            Email=@e,
            Mobile=@m,
            City=@c
            WHERE UserID=@id", con);

            cmd.Parameters.AddWithValue("@n", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@e", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@m", txtMobile.Text.Trim());
            cmd.Parameters.AddWithValue("@c", txtCity.Text.Trim());
            cmd.Parameters.AddWithValue("@id", Session["CustomerID"]);

            cmd.ExecuteNonQuery();
        }

        Session["CustomerName"] = txtName.Text.Trim();
        LoadProfile();
        ClientScript.RegisterStartupScript(this.GetType(), "saved", "alert('Profile updated successfully');", true);
    }

    protected void btnChangePass_Click(object sender, EventArgs e)
    {
        if (Session["CustomerID"] == null)
        {
            Response.Redirect("ClientLogin.aspx");
            return;
        }

        string oldPass = txtOldPass.Text;
        string newPass = txtNewPass.Text;
        string confirmPass = txtConfirmPass.Text;

        if (string.IsNullOrEmpty(oldPass) || string.IsNullOrEmpty(newPass))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please fill all password fields');", true);
            return;
        }

        if (newPass != confirmPass)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('New passwords do not match');", true);
            return;
        }

        if (newPass.Length < 6)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Password must be at least 6 characters long');", true);
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand check = new SqlCommand(
            "SELECT PasswordHash FROM Users WHERE UserID=@id", con);
            check.Parameters.AddWithValue("@id", Session["CustomerID"]);

            string dbPass = Convert.ToString(check.ExecuteScalar());
            bool needsUpgrade;

            if (!SecurityHelper.VerifyPassword(oldPass, dbPass, out needsUpgrade))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Old password incorrect');", true);
                return;
            }

            // Secure PBKDF2 Password Hashing
            string hashedNewPass = SecurityHelper.HashPassword(newPass);

            SqlCommand cmd = new SqlCommand(
            "UPDATE Users SET PasswordHash=@p WHERE UserID=@id", con);
            cmd.Parameters.AddWithValue("@p", hashedNewPass);
            cmd.Parameters.AddWithValue("@id", Session["CustomerID"]);
            cmd.ExecuteNonQuery();
        }

        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Password updated successfully');", true);
    }
}
