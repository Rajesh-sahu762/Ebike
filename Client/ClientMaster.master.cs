using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Client_ClientMaster : System.Web.UI.MasterPage
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CustomerID"] != null)
        {
            pnlLogin.Visible = false;
            pnlUser.Visible = true;
            lblUserName.Text = Session["CustomerName"].ToString();

            LoadWishlistCount();
        }
    }

    void LoadWishlistCount()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT COUNT(*) FROM Wishlist WHERE CustomerID=@c", con);

            cmd.Parameters.AddWithValue("@c", Session["CustomerID"]);

            wishCount.InnerText = cmd.ExecuteScalar().ToString();
        }
    }
}
