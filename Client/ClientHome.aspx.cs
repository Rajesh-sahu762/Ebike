using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Client_ClientHome : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadFeaturedBikes();
            LoadStats();
        }
    }

    void LoadFeaturedBikes()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            SELECT TOP 6 BikeID, ModelName, Price, Image1, Slug
            FROM Bikes
            WHERE IsApproved=1
            ORDER BY CreatedAt DESC", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptBikes.DataSource = dt;
            rptBikes.DataBind();
        }
    }

    void LoadStats()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            lblTotalBikes.Text =
                new SqlCommand("SELECT COUNT(*) FROM Bikes WHERE IsApproved=1", con)
                .ExecuteScalar().ToString();

            lblDealers.Text =
                new SqlCommand("SELECT COUNT(*) FROM Users WHERE Role='Dealer' AND IsApproved=1", con)
                .ExecuteScalar().ToString();

            lblCustomers.Text =
                new SqlCommand("SELECT COUNT(*) FROM Users WHERE Role='Customer'", con)
                .ExecuteScalar().ToString();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Response.Redirect("BikeListing.aspx?search=" + txtSearch.Text.Trim());
    }
}
