using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

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
        }
    }



    void LoadCommissionHistory()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
        SELECT TotalRevenue, CommissionAmount,
               NetAmount, CreatedAt, IsApproved
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


    void LoadMonthlyComparison()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int dealerId = Convert.ToInt32(Session["VendorID"]);

            // THIS MONTH
            SqlCommand cmdThis = new SqlCommand(@"
        SELECT ISNULL(SUM(L.LeadAmount),0)
        FROM Leads L
        INNER JOIN Bikes B ON L.BikeID=B.BikeID
        WHERE B.DealerID=@d
        AND MONTH(L.CreatedAt)=MONTH(GETDATE())
        AND YEAR(L.CreatedAt)=YEAR(GETDATE())", con);

            cmdThis.Parameters.AddWithValue("@d", dealerId);
            decimal thisMonth = Convert.ToDecimal(cmdThis.ExecuteScalar());

            // LAST MONTH
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

            // SETTLEMENT SUMMARY
            SqlCommand cmdSettle = new SqlCommand(@"
        SELECT ISNULL(SUM(NetAmount),0)
        FROM Settlements
        WHERE DealerID=@d AND IsApproved=1", con);

            cmdSettle.Parameters.AddWithValue("@d", dealerId);

            lblSettled.Text = Convert.ToDecimal(cmdSettle.ExecuteScalar()).ToString("0.00");
        }
    }


    void LoadSummary()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int dealerId = Convert.ToInt32(Session["VendorID"]);

            decimal totalRevenue = 0;
            decimal totalCommission = 0;
            decimal totalNet = 0;

            // ===== TOTAL REVENUE =====
            SqlCommand cmdRevenue = new SqlCommand(@"
        SELECT ISNULL(SUM(L.LeadAmount),0)
        FROM Leads L
        INNER JOIN Bikes B ON L.BikeID=B.BikeID
        WHERE B.DealerID=@d", con);

            cmdRevenue.Parameters.AddWithValue("@d", dealerId);

            object revObj = cmdRevenue.ExecuteScalar();

            if (revObj != DBNull.Value && revObj != null)
                totalRevenue = Convert.ToDecimal(revObj);

            // ===== COMMISSION % =====
            SqlCommand cmdPercent = new SqlCommand(
                "SELECT ISNULL(CommissionPercent,0) FROM SiteSettings WHERE SettingID=1", con);

            object percentObj = cmdPercent.ExecuteScalar();

            decimal commissionPercent = 0;

            if (percentObj != DBNull.Value && percentObj != null)
                commissionPercent = Convert.ToDecimal(percentObj);

            // ===== CALCULATIONS =====
            totalCommission = totalRevenue * commissionPercent / 100;
            totalNet = totalRevenue - totalCommission;

            lblRevenue.Text = totalRevenue.ToString("0.00");
            lblCommission.Text = totalCommission.ToString("0.00");
            lblNet.Text = totalNet.ToString("0.00");

            // ===== TOTAL LEADS =====
            SqlCommand cmdLeads = new SqlCommand(@"
        SELECT COUNT(*)
        FROM Leads L
        INNER JOIN Bikes B ON L.BikeID=B.BikeID
        WHERE B.DealerID=@d", con);

            cmdLeads.Parameters.AddWithValue("@d", dealerId);

            lblLeads.Text = cmdLeads.ExecuteScalar().ToString();
        }
    }


    void LoadMonthlyChart()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            SELECT 
                DATENAME(MONTH, L.CreatedAt) AS MonthName,
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

            StringBuilder labels = new StringBuilder("[");
            StringBuilder data = new StringBuilder("[");

            while (dr.Read())
            {
                labels.Append("'" + dr["MonthName"].ToString() + "',");
                data.Append(dr["Revenue"].ToString() + ",");
            }

            dr.Close();

            labels.Append("]");
            data.Append("]");

            MonthLabels = labels.ToString();
            MonthRevenue = data.ToString();
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
}
