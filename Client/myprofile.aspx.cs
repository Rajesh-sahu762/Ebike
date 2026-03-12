using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class Client_MyProfile : System.Web.UI.Page
{

    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["CustomerID"] == null)
            Response.Redirect("ClientLogin.aspx");

        if (!IsPostBack)
        {
            LoadProfile();
            LoadStats();
        }

    }

    void LoadProfile()
    {

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT FullName,Email,Mobile,City FROM Users WHERE UserID=@id", con);

            cmd.Parameters.AddWithValue("@id", Session["CustomerID"]);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {

                litName.Text = dr["FullName"].ToString();
                litEmail.Text = dr["Email"].ToString();

                txtName.Text = dr["FullName"].ToString();
                txtEmail.Text = dr["Email"].ToString();
                txtMobile.Text = dr["Mobile"].ToString();
                txtCity.Text = dr["City"].ToString();

            }

        }

    }


    void LoadStats()
    {

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

WHERE UserID=@id

", con);

            cmd.Parameters.AddWithValue("@n", txtName.Text);
            cmd.Parameters.AddWithValue("@e", txtEmail.Text);
            cmd.Parameters.AddWithValue("@m", txtMobile.Text);
            cmd.Parameters.AddWithValue("@c", txtCity.Text);
            cmd.Parameters.AddWithValue("@id", Session["CustomerID"]);

            cmd.ExecuteNonQuery();

        }

        LoadProfile();

    }

    protected void btnChangePass_Click(object sender, EventArgs e)
    {

        if (txtNewPass.Text != txtConfirmPass.Text)
        {
            Response.Write("<script>alert('Passwords do not match');</script>");
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand check = new SqlCommand(
            "SELECT PasswordHash FROM Users WHERE UserID=@id", con);

            check.Parameters.AddWithValue("@id", Session["CustomerID"]);

            string dbPass = Convert.ToString(check.ExecuteScalar());

            if (dbPass != txtOldPass.Text)
            {
                Response.Write("<script>alert('Old password incorrect');</script>");
                return;
            }

            SqlCommand cmd = new SqlCommand(
            "UPDATE Users SET PasswordHash=@p WHERE UserID=@id", con);

            cmd.Parameters.AddWithValue("@p", txtNewPass.Text);
            cmd.Parameters.AddWithValue("@id", Session["CustomerID"]);

            cmd.ExecuteNonQuery();

        }

        Response.Write("<script>alert('Password updated successfully');</script>");

    }

}