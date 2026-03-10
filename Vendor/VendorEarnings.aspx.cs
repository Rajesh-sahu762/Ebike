using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Vendor_VendorEarnings : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");

        if (!IsPostBack)
        {
            LoadSummary();
            LoadEarnings();
        }
    }

    void LoadSummary()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int vendorId = Convert.ToInt32(Session["VendorID"]);

            decimal totalRevenue = 0;
            decimal totalCommission = 0;
            decimal net = 0;
            decimal settled = 0;
            decimal pending = 0;

            // ===== TOTAL REVENUE =====
            SqlCommand totalCmd = new SqlCommand(@"
        SELECT ISNULL(SUM(L.LeadAmount),0)
        FROM Leads L
        INNER JOIN Bikes B ON L.BikeID=B.BikeID
        WHERE B.DealerID=@d AND L.LeadAmount>0", con);

            totalCmd.Parameters.AddWithValue("@d", vendorId);

            totalRevenue = Convert.ToDecimal(totalCmd.ExecuteScalar());


            // GET COMMISSION %
            SqlCommand percentCmd = new SqlCommand(
            "SELECT CommissionPercent FROM SiteSettings WHERE SettingID=1", con);

            object percentObj = percentCmd.ExecuteScalar();

            decimal percent = 0;

            if (percentObj != DBNull.Value && percentObj != null)
            {
                percent = Convert.ToDecimal(percentObj);
            }
            else
            {
                percent = 10; // default commission
            }


            // TOTAL COMMISSION
            SqlCommand comCmd = new SqlCommand(@"

SELECT ISNULL(SUM(
ISNULL(L.CommissionAmount,
(L.LeadAmount * @percent / 100))
),0)

FROM Leads L
INNER JOIN Bikes B ON L.BikeID=B.BikeID

WHERE B.DealerID=@d
AND L.LeadAmount>0

", con);

            comCmd.Parameters.AddWithValue("@d", vendorId);
            comCmd.Parameters.AddWithValue("@percent", percent);

            object comObj = comCmd.ExecuteScalar();

            if (comObj != DBNull.Value && comObj != null)
                totalCommission = Convert.ToDecimal(comObj);
            else
                totalCommission = 0;

            // ===== SETTLED =====
            SqlCommand settledCmd = new SqlCommand(@"
        SELECT ISNULL(SUM(L.LeadAmount - ISNULL(L.CommissionAmount,0)),0)
        FROM Leads L
        INNER JOIN Bikes B ON L.BikeID=B.BikeID
        WHERE B.DealerID=@d AND L.IsSettled=1", con);

            settledCmd.Parameters.AddWithValue("@d", vendorId);

            settled = Convert.ToDecimal(settledCmd.ExecuteScalar());


            // ===== PENDING =====
            SqlCommand pendingCmd = new SqlCommand(@"
        SELECT ISNULL(SUM(L.LeadAmount - ISNULL(L.CommissionAmount,0)),0)
        FROM Leads L
        INNER JOIN Bikes B ON L.BikeID=B.BikeID
        WHERE B.DealerID=@d
        AND L.SettlementRequested=1
        AND L.IsSettled=0", con);

            pendingCmd.Parameters.AddWithValue("@d", vendorId);

            pending = Convert.ToDecimal(pendingCmd.ExecuteScalar());


            lblRevenue.Text = totalRevenue.ToString("N0");
            lblCommission.Text = totalCommission.ToString("N0");
            lblNet.Text = net.ToString("N0");
            lblSettled.Text = settled.ToString("N0");
            lblPending.Text = pending.ToString("N0");
        }
    }

    void LoadEarnings()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string query = @"
            SELECT L.LeadID,
                   U.FullName,
                   B.ModelName,
                   L.LeadAmount,
                   ISNULL(L.CommissionAmount,0) AS Commission,
                   (L.LeadAmount - ISNULL(L.CommissionAmount,0)) AS NetAmount,
                   L.CreatedAt,
                   L.SettlementRequested,
                   L.IsSettled
            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            INNER JOIN Users U ON L.CustomerID=U.UserID
            WHERE B.DealerID=@d AND L.LeadAmount>0
            ORDER BY L.CreatedAt DESC";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@d", Session["VendorID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvEarnings.DataSource = dt;
            gvEarnings.DataBind();
        }
    }

    protected void gvEarnings_RowCommand(object sender,
        System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (e.CommandName == "RequestSettlement")
        {
            int leadId = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();

                SqlCommand freezeCmd = new SqlCommand(@"
                UPDATE L
                SET CommissionAmount =
                ISNULL(L.CommissionAmount,
                (L.LeadAmount *
                (SELECT CommissionPercent FROM SiteSettings WHERE SettingID=1)/100)),
                SettlementRequested=1
                FROM Leads L
                INNER JOIN Bikes B ON L.BikeID=B.BikeID
                WHERE L.LeadID=@id 
                AND B.DealerID=@d
                AND L.IsSettled=0", con);

                freezeCmd.Parameters.AddWithValue("@id", leadId);
                freezeCmd.Parameters.AddWithValue("@d", Session["VendorID"]);

                freezeCmd.ExecuteNonQuery();
            }

            LoadSummary();
            LoadEarnings();
        }
    }

    protected void gvEarnings_PageIndexChanging(object sender,
        System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvEarnings.PageIndex = e.NewPageIndex;
        LoadEarnings();
    }
}