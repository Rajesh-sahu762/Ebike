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
        if (Session["CustomerID"] == null)
        {
            Response.Redirect("ClientLogin.aspx");
            return;
        }

        int userId = Convert.ToInt32(Session["CustomerID"]);
        string inputPass = txtPassword.Text;

        if (string.IsNullOrEmpty(inputPass))
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please enter your password.');", true);
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // Verify password using PBKDF2 / legacy verification
            SqlCommand check = new SqlCommand(
            "SELECT PasswordHash FROM Users WHERE UserID=@id", con);

            check.Parameters.AddWithValue("@id", userId);

            string dbPass = Convert.ToString(check.ExecuteScalar());
            bool needsUpgrade;

            if (!SecurityHelper.VerifyPassword(inputPass, dbPass, out needsUpgrade))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Incorrect password');", true);
                return;
            }

            // Revoke auth tokens
            try
            {
                using (SqlCommand delTokens = new SqlCommand("DELETE FROM UserAuthTokens WHERE UserID=@id", con))
                {
                    delTokens.Parameters.AddWithValue("@id", userId);
                    delTokens.ExecuteNonQuery();
                }
            }
            catch (SqlException) { }

            // Delete user data
            SqlCommand cmd1 = new SqlCommand("DELETE FROM Wishlist WHERE CustomerID=@id", con);
            cmd1.Parameters.AddWithValue("@id", userId);
            cmd1.ExecuteNonQuery();

            SqlCommand cmd2 = new SqlCommand("DELETE FROM Leads WHERE CustomerID=@id", con);
            cmd2.Parameters.AddWithValue("@id", userId);
            cmd2.ExecuteNonQuery();

            SqlCommand cmd3 = new SqlCommand("DELETE FROM RentalBookings WHERE CustomerID=@id", con);
            cmd3.Parameters.AddWithValue("@id", userId);
            cmd3.ExecuteNonQuery();

            SqlCommand cmd4 = new SqlCommand("DELETE FROM Cart WHERE UserID=@id", con);
            cmd4.Parameters.AddWithValue("@id", userId);
            cmd4.ExecuteNonQuery();

            SqlCommand cmd5 = new SqlCommand("DELETE FROM Users WHERE UserID=@id", con);
            cmd5.Parameters.AddWithValue("@id", userId);
            cmd5.ExecuteNonQuery();
        }

        AuthHelper.RevokeRememberMeCookie(Request, Response, constr);

        Session.Clear();
        Session.Abandon();

        Response.Redirect("Home.aspx");
    }
}
