using System;
using System.Web;
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

    [WebMethod(EnableSession = true)]
    public static NotificationModel GetNotifications()
    {
        HttpContext context = HttpContext.Current;
        int adminId;
        if (context == null || context.Session == null ||
            !Int32.TryParse(Convert.ToString(context.Session["AdminID"]), out adminId) || adminId <= 0)
            throw new HttpException(401, "Authentication required.");

        string connectionString = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
        using (SqlConnection authConnection = new SqlConnection(connectionString))
        using (SqlCommand authCommand = new SqlCommand(
            "SELECT COUNT(*) FROM dbo.Users WHERE UserID=@UserID AND Role='Admin' AND IsActive=1;", authConnection))
        {
            authCommand.Parameters.Add("@UserID", SqlDbType.Int).Value = adminId;
            authConnection.Open();
            if (Convert.ToInt32(authCommand.ExecuteScalar()) != 1)
                throw new HttpException(403, "Administrator access required.");
        }

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
