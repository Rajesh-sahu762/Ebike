using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
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

            LoadSummary();
            LoadMonthlyChart();
            LoadTopBikes();
            LoadSettlements();

        }

    }

    void LoadSummary()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int dealerId = Convert.ToInt32(Session["VendorID"]);

            decimal leadRevenue = 0;
            decimal rentalRevenue = 0;
            decimal percent = 0;

            // ===== LEAD REVENUE =====

            SqlCommand cmd = new SqlCommand(@"
        SELECT SUM(L.LeadAmount)
        FROM Leads L
        INNER JOIN Bikes B ON L.BikeID=B.BikeID
        WHERE B.DealerID=@d", con);

            cmd.Parameters.AddWithValue("@d", dealerId);

            object leadObj = cmd.ExecuteScalar();

            if (leadObj != DBNull.Value && leadObj != null)
                leadRevenue = Convert.ToDecimal(leadObj);


            // ===== RENTAL REVENUE =====

            SqlCommand rentCmd = new SqlCommand(@"
        SELECT SUM(R.RentAmount)
        FROM RentalBookings R
        WHERE R.DealerID=@d
        AND R.Status='Completed'", con);

            rentCmd.Parameters.AddWithValue("@d", dealerId);

            object rentObj = rentCmd.ExecuteScalar();

            if (rentObj != DBNull.Value && rentObj != null)
                rentalRevenue = Convert.ToDecimal(rentObj);


            // ===== COMMISSION PERCENT =====

            SqlCommand percentCmd = new SqlCommand(
            "SELECT CommissionPercent FROM SiteSettings WHERE SettingID=1", con);

            object percentObj = percentCmd.ExecuteScalar();

            if (percentObj != DBNull.Value && percentObj != null)
                percent = Convert.ToDecimal(percentObj);
            else
                percent = 10;


            decimal totalRevenue = leadRevenue + rentalRevenue;

            decimal commission = totalRevenue * percent / 100;

            decimal net = totalRevenue - commission;

            lblRevenue.Text = totalRevenue.ToString("N0");
            lblCommission.Text = commission.ToString("N0");
            lblNet.Text = net.ToString("N0");


            // ===== LEADS COUNT =====

            SqlCommand leadCount = new SqlCommand(@"
        SELECT COUNT(*)
        FROM Leads L
        INNER JOIN Bikes B ON L.BikeID=B.BikeID
        WHERE B.DealerID=@d", con);

            leadCount.Parameters.AddWithValue("@d", dealerId);

            lblLeads.Text = leadCount.ExecuteScalar().ToString();
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
        ISNULL(SUM(L.LeadAmount),0) AS Revenue

        FROM Leads L
        INNER JOIN Bikes B ON L.BikeID = B.BikeID

        WHERE B.DealerID = @d
        AND L.CreatedAt >= DATEADD(MONTH,-5,GETDATE())

        GROUP BY 
        DATENAME(MONTH, L.CreatedAt),
        MONTH(L.CreatedAt)

        ORDER BY MonthNumber

        ", con);

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
ISNULL(SUM(L.LeadAmount),0) TotalRevenue,
COUNT(L.LeadID) LeadCount

FROM Bikes B
LEFT JOIN Leads L ON B.BikeID=L.BikeID

WHERE B.DealerID=@d

GROUP BY B.ModelName
ORDER BY TotalRevenue DESC

", con);

            cmd.Parameters.AddWithValue("@d", Session["VendorID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();

            da.Fill(dt);

            gvTopBikes.DataSource = dt;
            gvTopBikes.DataBind();

        }

    }

    void LoadSettlements()
    {

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(@"

SELECT TotalRevenue,
CommissionAmount,
NetAmount,
CreatedAt,
IsApproved

FROM Settlements
WHERE DealerID=@d
ORDER BY CreatedAt DESC

", con);

            cmd.Parameters.AddWithValue("@d", Session["VendorID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();

            da.Fill(dt);

            gvSettlement.DataSource = dt;
            gvSettlement.DataBind();

        }

    }

}