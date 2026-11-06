using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Services;

public partial class Admin_AdminDashboard : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("AdminLogin.aspx");
            return;
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

    [WebMethod(EnableSession = true)]
    public static NotificationModel GetNotifications()
    {
        NotificationModel model = new NotificationModel();

        if (HttpContext.Current == null ||
            HttpContext.Current.Session == null ||
            HttpContext.Current.Session["AdminID"] == null ||
            HttpContext.Current.Session["Role"] == null ||
            HttpContext.Current.Session["Role"].ToString() != "Admin")
        {
            return model;
        }

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            SELECT
            (SELECT COUNT(*) FROM Users WHERE Role='Dealer' AND IsApproved=0),
            (SELECT COUNT(*) FROM Bikes WHERE IsApproved=0),
            (SELECT COUNT(*) FROM Leads WHERE IsViewed=0)
        ", con);

            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                if (dr.Read())
                {
                    model.PendingDealers = dr[0] != DBNull.Value ? Convert.ToInt32(dr[0]) : 0;
                    model.PendingBikes = dr[1] != DBNull.Value ? Convert.ToInt32(dr[1]) : 0;
                    model.UnreadLeads = dr[2] != DBNull.Value ? Convert.ToInt32(dr[2]) : 0;
                    model.Total = model.PendingDealers + model.PendingBikes + model.UnreadLeads;
                }
            }
        }

        return model;
    }

    void LoadCounts()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            lblDealers.Text = GetCount(con, "SELECT COUNT(*) FROM Users WHERE Role='Dealer'");
            lblPendingDealers.Text = GetCount(con, "SELECT COUNT(*) FROM Users WHERE Role='Dealer' AND IsApproved=0");
            lblBikes.Text = GetCount(con, "SELECT COUNT(*) FROM Bikes");
            lblPendingBikes.Text = GetCount(con, "SELECT COUNT(*) FROM Bikes WHERE IsApproved=0");
            lblCustomers.Text = GetCount(con, "SELECT COUNT(*) FROM Users WHERE Role='Customer'");
            lblLeads.Text = GetCount(con, "SELECT COUNT(*) FROM Leads");
        }
    }

    string GetCount(SqlConnection con, string query)
    {
        using (SqlCommand cmd = new SqlCommand(query, con))
        {
            object res = cmd.ExecuteScalar();
            return res != null ? res.ToString() : "0";
        }
    }

    void LoadRecentLeads()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
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
}
