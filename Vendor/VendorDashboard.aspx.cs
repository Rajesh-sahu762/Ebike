using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class Vendor_VendorDashboard : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadSummary();
            LoadRecentLeads();
        }
    }

    void LoadSummary()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int vendorId = Convert.ToInt32(Session["VendorID"]);

            // Total Bikes
            SqlCommand totalBikes = new SqlCommand(
                "SELECT COUNT(*) FROM Bikes WHERE DealerID=@id", con);
            totalBikes.Parameters.AddWithValue("@id", vendorId);
            lblTotalBikes.Text = totalBikes.ExecuteScalar().ToString();

            // Approved Bikes
            SqlCommand approved = new SqlCommand(
                "SELECT COUNT(*) FROM Bikes WHERE DealerID=@id AND IsApproved=1", con);
            approved.Parameters.AddWithValue("@id", vendorId);
            lblApprovedBikes.Text = approved.ExecuteScalar().ToString();

            // Pending Bikes
            SqlCommand pending = new SqlCommand(
                "SELECT COUNT(*) FROM Bikes WHERE DealerID=@id AND IsApproved=0", con);
            pending.Parameters.AddWithValue("@id", vendorId);
            lblPendingBikes.Text = pending.ExecuteScalar().ToString();

            // Total Leads
            SqlCommand leads = new SqlCommand(
            @"SELECT COUNT(*) FROM Leads L
              INNER JOIN Bikes B ON L.BikeID=B.BikeID
              WHERE B.DealerID=@id", con);
            leads.Parameters.AddWithValue("@id", vendorId);
            lblTotalLeads.Text = leads.ExecuteScalar().ToString();
        }
    }

    void LoadRecentLeads()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int vendorId = Convert.ToInt32(Session["VendorID"]);

            SqlCommand cmd = new SqlCommand(
            @"SELECT TOP 5 U.FullName, B.ModelName, L.CreatedAt
              FROM Leads L
              INNER JOIN Users U ON L.CustomerID=U.UserID
              INNER JOIN Bikes B ON L.BikeID=B.BikeID
              WHERE B.DealerID=@id
              ORDER BY L.CreatedAt DESC", con);

            cmd.Parameters.AddWithValue("@id", vendorId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvRecentLeads.DataSource = dt;
            gvRecentLeads.DataBind();
        }
    }
}
