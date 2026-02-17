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

            // Total Revenue
            SqlCommand totalCmd = new SqlCommand(@"
            SELECT ISNULL(SUM(LeadAmount),0)
            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            WHERE B.DealerID=@d AND LeadAmount>0", con);

            totalCmd.Parameters.AddWithValue("@d", vendorId);
            decimal totalRevenue = Convert.ToDecimal(totalCmd.ExecuteScalar());

            // Total Commission (Frozen)
            SqlCommand comCmd = new SqlCommand(@"
            SELECT ISNULL(SUM(CommissionAmount),0)
            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            WHERE B.DealerID=@d", con);

            comCmd.Parameters.AddWithValue("@d", vendorId);
            decimal totalCommission = Convert.ToDecimal(comCmd.ExecuteScalar());

            // Net
            decimal net = totalRevenue - totalCommission;

            // Settled
            SqlCommand settledCmd = new SqlCommand(@"
            SELECT ISNULL(SUM(LeadAmount - CommissionAmount),0)
            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            WHERE B.DealerID=@d AND L.IsSettled=1", con);

            settledCmd.Parameters.AddWithValue("@d", vendorId);
            decimal settled = Convert.ToDecimal(settledCmd.ExecuteScalar());

            // Pending Settlement
            SqlCommand pendingCmd = new SqlCommand(@"
            SELECT ISNULL(SUM(LeadAmount - CommissionAmount),0)
            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            WHERE B.DealerID=@d AND L.SettlementRequested=1 AND L.IsSettled=0", con);

            pendingCmd.Parameters.AddWithValue("@d", vendorId);
            decimal pending = Convert.ToDecimal(pendingCmd.ExecuteScalar());

            lblRevenue.Text = totalRevenue.ToString("0.00");
            lblCommission.Text = totalCommission.ToString("0.00");
            lblNet.Text = net.ToString("0.00");
            lblSettled.Text = settled.ToString("0.00");
            lblPending.Text = pending.ToString("0.00");
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

                // Freeze Commission if not already frozen
                SqlCommand freezeCmd = new SqlCommand(@"
                UPDATE Leads
                SET CommissionAmount =
                ISNULL(CommissionAmount,
                (LeadAmount *
                (SELECT CommissionPercent FROM SiteSettings WHERE SettingID=1) / 100)),
                SettlementRequested=1
                WHERE LeadID=@id AND IsSettled=0", con);

                freezeCmd.Parameters.AddWithValue("@id", leadId);
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
