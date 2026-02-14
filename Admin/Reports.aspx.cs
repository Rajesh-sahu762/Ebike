using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

public partial class Admin_Reports : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
            Response.Redirect("AdminLogin.aspx");

        if (!IsPostBack)
        {
            LoadSummary();
            LoadCharts();
        }
    }

    void LoadSummary()
    {
        SqlConnection con = new SqlConnection(constr);
        con.Open();

        object totalRev = new SqlCommand("SELECT ISNULL(SUM(LeadAmount),0) FROM Leads", con).ExecuteScalar();
        lblRevenue.Text = "₹ " + totalRev.ToString();

        object monthRev = new SqlCommand(
            "SELECT ISNULL(SUM(LeadAmount),0) FROM Leads WHERE MONTH(CreatedAt)=MONTH(GETDATE()) AND YEAR(CreatedAt)=YEAR(GETDATE())",
            con).ExecuteScalar();
        lblMonthRevenue.Text = "₹ " + monthRev.ToString();

        lblLeads.Text = new SqlCommand("SELECT COUNT(*) FROM Leads", con).ExecuteScalar().ToString();
        lblUnread.Text = new SqlCommand("SELECT COUNT(*) FROM Leads WHERE IsViewed=0", con).ExecuteScalar().ToString();

        con.Close();
    }

    void LoadCharts()
    {
        SqlConnection con = new SqlConnection(constr);
        con.Open();

        // Monthly Leads Chart
        SqlCommand cmd = new SqlCommand(
            "SELECT MONTH(CreatedAt) M, COUNT(*) C FROM Leads GROUP BY MONTH(CreatedAt)", con);

        SqlDataReader dr = cmd.ExecuteReader();
        StringBuilder months = new StringBuilder();
        StringBuilder counts = new StringBuilder();

        while (dr.Read())
        {
            months.Append("'" + dr["M"] + "',");
            counts.Append(dr["C"] + ",");
        }
        dr.Close();

        ClientScript.RegisterStartupScript(this.GetType(), "leadChart",
            "renderChart('leadChart','line',[" + months + "],[" + counts + "],'Monthly Leads');", true);


        // Monthly Revenue Chart
        SqlCommand cmd2 = new SqlCommand(
            "SELECT MONTH(CreatedAt) M, SUM(LeadAmount) R FROM Leads GROUP BY MONTH(CreatedAt)", con);

        SqlDataReader dr2 = cmd2.ExecuteReader();
        StringBuilder months2 = new StringBuilder();
        StringBuilder revenue = new StringBuilder();

        while (dr2.Read())
        {
            months2.Append("'" + dr2["M"] + "',");
            revenue.Append(dr2["R"] == DBNull.Value ? "0," : dr2["R"] + ",");
        }
        dr2.Close();

        ClientScript.RegisterStartupScript(this.GetType(), "revChart",
            "renderChart('revenueChart','bar',[" + months2 + "],[" + revenue + "],'Monthly Revenue');", true);


        // Dealer Revenue Chart
        SqlCommand cmd3 = new SqlCommand(
            @"SELECT TOP 5 U.ShopName, SUM(L.LeadAmount) AS Total
              FROM Leads L
              INNER JOIN Bikes B ON L.BikeID=B.BikeID
              INNER JOIN Users U ON B.DealerID=U.UserID
              GROUP BY U.ShopName
              ORDER BY Total DESC", con);

        SqlDataReader dr3 = cmd3.ExecuteReader();
        StringBuilder dealers = new StringBuilder();
        StringBuilder totals = new StringBuilder();

        while (dr3.Read())
        {
            dealers.Append("'" + dr3["ShopName"] + "',");
            totals.Append(dr3["Total"] == DBNull.Value ? "0," : dr3["Total"] + ",");
        }
        dr3.Close();

        ClientScript.RegisterStartupScript(this.GetType(), "dealerRevChart",
            "renderChart('dealerRevenueChart','bar',[" + dealers + "],[" + totals + "],'Top Dealer Revenue');", true);

        con.Close();
    }
}
