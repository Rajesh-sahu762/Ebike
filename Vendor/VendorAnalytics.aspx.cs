using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Collections.Generic;

public partial class Vendor_VendorAnalytics : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    public string MonthLabels = "[]";
    public string MonthRevenue = "[]";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");

        if (!IsPostBack)
        {
            LoadMonthlyComparison();
            LoadSummary();
            LoadMonthlyChart();
            LoadTopBikes();
            LoadCommissionHistory();
        }
    }

    void LoadSummary()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int dealerId = Convert.ToInt32(Session["VendorID"]);

            decimal totalRevenue = 0;

            SqlCommand cmdRevenue = new SqlCommand(@"
            SELECT ISNULL(SUM(L.LeadAmount),0)
            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            WHERE B.DealerID=@d", con);

            cmdRevenue.Parameters.AddWithValue("@d", dealerId);

            totalRevenue = Convert.ToDecimal(cmdRevenue.ExecuteScalar());

            SqlCommand cmdPercent = new SqlCommand(
            "SELECT ISNULL(CommissionPercent,0) FROM SiteSettings WHERE SettingID=1", con);

            decimal commissionPercent = Convert.ToDecimal(cmdPercent.ExecuteScalar());

            decimal totalCommission = totalRevenue * commissionPercent / 100;
            decimal totalNet = totalRevenue - totalCommission;

            lblRevenue.Text = totalRevenue.ToString("0.00");
            lblCommission.Text = totalCommission.ToString("0.00");
            lblNet.Text = totalNet.ToString("0.00");

            SqlCommand cmdLeads = new SqlCommand(@"
            SELECT COUNT(*)
            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            WHERE B.DealerID=@d", con);

            cmdLeads.Parameters.AddWithValue("@d", dealerId);

            lblLeads.Text = cmdLeads.ExecuteScalar().ToString();
        }
    }

    void LoadMonthlyComparison()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int dealerId = Convert.ToInt32(Session["VendorID"]);

            SqlCommand cmdThis = new SqlCommand(@"
            SELECT ISNULL(SUM(L.LeadAmount),0)
            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            WHERE B.DealerID=@d
            AND MONTH(L.CreatedAt)=MONTH(GETDATE())
            AND YEAR(L.CreatedAt)=YEAR(GETDATE())", con);

            cmdThis.Parameters.AddWithValue("@d", dealerId);

            decimal thisMonth = Convert.ToDecimal(cmdThis.ExecuteScalar());

            SqlCommand cmdLast = new SqlCommand(@"
            SELECT ISNULL(SUM(L.LeadAmount),0)
            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            WHERE B.DealerID=@d
            AND MONTH(L.CreatedAt)=MONTH(DATEADD(MONTH,-1,GETDATE()))
            AND YEAR(L.CreatedAt)=YEAR(DATEADD(MONTH,-1,GETDATE()))", con);

            cmdLast.Parameters.AddWithValue("@d", dealerId);

            decimal lastMonth = Convert.ToDecimal(cmdLast.ExecuteScalar());

            decimal growth = 0;

            if (lastMonth > 0)
                growth = ((thisMonth - lastMonth) / lastMonth) * 100;

            lblThisMonth.Text = thisMonth.ToString("0.00");
            lblLastMonth.Text = lastMonth.ToString("0.00");

            if (growth >= 0)
                lblGrowth.Text = "<span style='color:green'>▲ " + growth.ToString("0.00") + "%</span>";
            else
                lblGrowth.Text = "<span style='color:red'>▼ " + growth.ToString("0.00") + "%</span>";

            SqlCommand cmdSettle = new SqlCommand(@"
            SELECT ISNULL(SUM(NetAmount),0)
            FROM Settlements
            WHERE DealerID=@d AND IsApproved=1", con);

            cmdSettle.Parameters.AddWithValue("@d", dealerId);

            lblSettled.Text = Convert.ToDecimal(cmdSettle.ExecuteScalar()).ToString("0.00");
        }
    }

    void LoadMonthlyChart()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            SELECT DATENAME(MONTH,L.CreatedAt) AS MonthName,
                   MONTH(L.CreatedAt) AS MonthNumber,
                   SUM(L.LeadAmount) AS Revenue
            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            WHERE B.DealerID=@d
            AND L.CreatedAt >= DATEADD(MONTH,-5,GETDATE())
            GROUP BY DATENAME(MONTH,L.CreatedAt), MONTH(L.CreatedAt)
            ORDER BY MonthNumber", con);

            cmd.Parameters.AddWithValue("@d", Session["VendorID"]);

            SqlDataReader dr = cmd.ExecuteReader();

            List<string> labels = new List<string>();
            List<string> data = new List<string>();

            while (dr.Read())
            {
                labels.Add("'" + dr["MonthName"].ToString() + "'");
                data.Add(dr["Revenue"].ToString());
            }

            dr.Close();

            MonthLabels = "[" + string.Join(",", labels) + "]";
            MonthRevenue = "[" + string.Join(",", data) + "]";
        }
    }

    void LoadTopBikes()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            SELECT TOP 5 B.ModelName,
            ISNULL(SUM(L.LeadAmount),0) AS TotalRevenue,
            COUNT(L.LeadID) AS LeadCount
            FROM Bikes B
            LEFT JOIN Leads L ON B.BikeID=L.BikeID
            WHERE B.DealerID=@d
            GROUP BY B.ModelName
            ORDER BY TotalRevenue DESC", con);

            cmd.Parameters.AddWithValue("@d", Session["VendorID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvTopBikes.DataSource = dt;
            gvTopBikes.DataBind();
        }
    }

    void LoadCommissionHistory()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            SELECT TotalRevenue,CommissionAmount,
                   NetAmount,CreatedAt,IsApproved
            FROM Settlements
            WHERE DealerID=@d
            ORDER BY CreatedAt DESC", con);

            cmd.Parameters.AddWithValue("@d", Session["VendorID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvCommissionHistory.DataSource = dt;
            gvCommissionHistory.DataBind();
        }
    }
}