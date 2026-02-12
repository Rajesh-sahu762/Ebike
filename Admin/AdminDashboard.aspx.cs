using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_AdminDashboard : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
        {
            Response.Redirect("AdminLogin.aspx");
        }

        if (!IsPostBack)
        {
            LoadCounts();
            LoadRecentLeads();
        }
    }


    public class NotificationModel
    {
        public int PendingDealers { get; set; }
        public int PendingBikes { get; set; }
        public int UnreadLeads { get; set; }
        public int Total { get; set; }
    }

    [WebMethod]
    public static NotificationModel GetNotifications()
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        NotificationModel model = new NotificationModel();

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            SELECT
            (SELECT COUNT(*) FROM Users WHERE Role='Dealer' AND IsApproved=0),
            (SELECT COUNT(*) FROM Bikes WHERE IsApproved=0),
            (SELECT COUNT(*) FROM Leads WHERE IsViewed=0)
        ", con);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                model.PendingDealers = Convert.ToInt32(dr[0]);
                model.PendingBikes = Convert.ToInt32(dr[1]);
                model.UnreadLeads = Convert.ToInt32(dr[2]);
                model.Total = model.PendingDealers + model.PendingBikes + model.UnreadLeads;
            }
        }

        return model;
    }



    void LoadCounts()
    {
        SqlConnection con = new SqlConnection(constr);
        con.Open();

        lblDealers.Text = GetCount(con, "SELECT COUNT(*) FROM Users WHERE Role='Dealer'");
        lblPendingDealers.Text = GetCount(con, "SELECT COUNT(*) FROM Users WHERE Role='Dealer' AND IsApproved=0");
        lblBikes.Text = GetCount(con, "SELECT COUNT(*) FROM Bikes");
        lblPendingBikes.Text = GetCount(con, "SELECT COUNT(*) FROM Bikes WHERE IsApproved=0");
        lblCustomers.Text = GetCount(con, "SELECT COUNT(*) FROM Users WHERE Role='Customer'");
        lblLeads.Text = GetCount(con, "SELECT COUNT(*) FROM Leads");

        con.Close();
    }

    string GetCount(SqlConnection con, string query)
    {
        SqlCommand cmd = new SqlCommand(query, con);
        return cmd.ExecuteScalar().ToString();
    }

    void LoadRecentLeads()
    {
        SqlConnection con = new SqlConnection(constr);

        string query = @"SELECT TOP 5 U.FullName, B.ModelName, L.CreatedAt
                         FROM Leads L
                         INNER JOIN Users U ON L.CustomerID = U.UserID
                         INNER JOIN Bikes B ON L.BikeID = B.BikeID
                         ORDER BY L.CreatedAt DESC";

        SqlDataAdapter da = new SqlDataAdapter(query, con);
        DataTable dt = new DataTable();
        da.Fill(dt);

        gvLeads.DataSource = dt;
        gvLeads.DataBind();
    }
}
