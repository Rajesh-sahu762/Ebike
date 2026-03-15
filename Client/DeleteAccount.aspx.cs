using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Client_DeleteAccount : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CustomerID"] == null)
            Response.Redirect("ClientLogin.aspx");
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        int userId = Convert.ToInt32(Session["CustomerID"]);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // Verify password
            SqlCommand check = new SqlCommand(
            "SELECT PasswordHash FROM Users WHERE UserID=@id", con);

            check.Parameters.AddWithValue("@id", userId);

            string dbPass = Convert.ToString(check.ExecuteScalar());

            if (dbPass != txtPassword.Text)
            {
                Response.Write("<script>alert('Incorrect password')</script>");
                return;
            }

            // Delete user data

            SqlCommand cmd1 = new SqlCommand(
            "DELETE FROM Wishlist WHERE CustomerID=@id", con);
            cmd1.Parameters.AddWithValue("@id", userId);
            cmd1.ExecuteNonQuery();

            SqlCommand cmd2 = new SqlCommand(
            "DELETE FROM Leads WHERE CustomerID=@id", con);
            cmd2.Parameters.AddWithValue("@id", userId);
            cmd2.ExecuteNonQuery();

            SqlCommand cmd3 = new SqlCommand(
            "DELETE FROM RentalBookings WHERE CustomerID=@id", con);
            cmd3.Parameters.AddWithValue("@id", userId);
            cmd3.ExecuteNonQuery();

            SqlCommand cmd4 = new SqlCommand(
            "DELETE FROM Users WHERE UserID=@id", con);
            cmd4.Parameters.AddWithValue("@id", userId);
            cmd4.ExecuteNonQuery();
        }

        Session.Clear();
        Session.Abandon();

        Response.Redirect("Home.aspx");
    }
}