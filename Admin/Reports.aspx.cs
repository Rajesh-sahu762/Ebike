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
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            decimal leadRevenue = 0;
            decimal rentalRevenue = 0;

            // Lead Revenue
            SqlCommand cmd1 = new SqlCommand(
            "SELECT ISNULL(SUM(LeadAmount),0) FROM Leads", con);

            object obj1 = cmd1.ExecuteScalar();

            if (obj1 != DBNull.Value && obj1 != null)
                leadRevenue = Convert.ToDecimal(obj1);


            // Rental Revenue
            SqlCommand cmd2 = new SqlCommand(
            "SELECT ISNULL(SUM(RentAmount),0) FROM RentalBookings WHERE Status='Completed'", con);

            object obj2 = cmd2.ExecuteScalar();

            if (obj2 != DBNull.Value && obj2 != null)
                rentalRevenue = Convert.ToDecimal(obj2);


            decimal totalRevenue = leadRevenue + rentalRevenue;

            lblRevenue.Text = "₹ " + totalRevenue.ToString("N0");


            // This Month Revenue
            SqlCommand cmd3 = new SqlCommand(@"

            SELECT 
            ISNULL(SUM(LeadAmount),0)
            FROM Leads
            WHERE MONTH(CreatedAt)=MONTH(GETDATE())
            AND YEAR(CreatedAt)=YEAR(GETDATE())

            ", con);

            decimal monthLead = Convert.ToDecimal(cmd3.ExecuteScalar());


            SqlCommand cmd4 = new SqlCommand(@"

            SELECT 
            ISNULL(SUM(RentAmount),0)
            FROM RentalBookings
            WHERE MONTH(CreatedAt)=MONTH(GETDATE())
            AND YEAR(CreatedAt)=YEAR(GETDATE())
            AND Status='Completed'

            ", con);

            decimal monthRental = Convert.ToDecimal(cmd4.ExecuteScalar());

            lblMonthRevenue.Text = "₹ " + (monthLead + monthRental).ToString("N0");


            lblLeads.Text = new SqlCommand(
            "SELECT COUNT(*) FROM Leads", con).ExecuteScalar().ToString();

            lblUnread.Text = new SqlCommand(
            "SELECT COUNT(*) FROM Leads WHERE IsViewed=0", con).ExecuteScalar().ToString();
        }
    }


    void LoadCharts()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // =========================
            // Monthly Leads
            // =========================

            SqlCommand cmd = new SqlCommand(@"

            SELECT MONTH(L.CreatedAt) M, COUNT(*) C

            FROM Leads L

            GROUP BY MONTH(L.CreatedAt)

            ORDER BY M

            ", con);

            SqlDataReader dr = cmd.ExecuteReader();

            StringBuilder months = new StringBuilder();
            StringBuilder counts = new StringBuilder();

            while (dr.Read())
            {
                months.Append("'" + dr["M"] + "',");
                counts.Append(dr["C"] + ",");
            }

            dr.Close();

            ClientScript.RegisterStartupScript(
            this.GetType(),
            "leadChart",
            "renderChart('leadChart','line',[" + months + "],[" + counts + "],'Monthly Leads');",
            true);


            // =========================
            // Monthly Revenue
            // =========================

            SqlCommand cmd2 = new SqlCommand(@"

            SELECT 
            MONTH(L.CreatedAt) M,
            SUM(L.LeadAmount) R

            FROM Leads L

            GROUP BY MONTH(L.CreatedAt)

            ORDER BY M

            ", con);

            SqlDataReader dr2 = cmd2.ExecuteReader();

            StringBuilder months2 = new StringBuilder();
            StringBuilder revenue = new StringBuilder();

            while (dr2.Read())
            {
                months2.Append("'" + dr2["M"] + "',");

                if (dr2["R"] == DBNull.Value)
                    revenue.Append("0,");
                else
                    revenue.Append(dr2["R"] + ",");
            }

            dr2.Close();

            ClientScript.RegisterStartupScript(
            this.GetType(),
            "revChart",
            "renderChart('revenueChart','bar',[" + months2 + "],[" + revenue + "],'Monthly Revenue');",
            true);


            // =========================
            // Dealer Revenue
            // =========================

            SqlCommand cmd3 = new SqlCommand(@"

            SELECT TOP 5 
            U.ShopName,
            SUM(L.LeadAmount) AS Total

            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            INNER JOIN Users U ON B.DealerID=U.UserID

            GROUP BY U.ShopName
            ORDER BY Total DESC

            ", con);

            SqlDataReader dr3 = cmd3.ExecuteReader();

            StringBuilder dealers = new StringBuilder();
            StringBuilder totals = new StringBuilder();

            while (dr3.Read())
            {
                dealers.Append("'" + dr3["ShopName"] + "',");

                if (dr3["Total"] == DBNull.Value)
                    totals.Append("0,");
                else
                    totals.Append(dr3["Total"] + ",");
            }

            dr3.Close();

            ClientScript.RegisterStartupScript(
            this.GetType(),
            "dealerRevChart",
            "renderChart('dealerRevenueChart','bar',[" + dealers + "],[" + totals + "],'Top Dealer Revenue');",
            true);
        }
    }
}