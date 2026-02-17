using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class Vendor_VendorManageLeads : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");

        if (!IsPostBack)
        {
            LoadBikeFilter();
            LoadSummary();
            LoadLeads();
        }
    }

    void LoadBikeFilter()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT BikeID, ModelName FROM Bikes WHERE DealerID=@d", con);

            cmd.Parameters.AddWithValue("@d", Session["VendorID"]);

            ddlBikeFilter.DataSource = cmd.ExecuteReader();
            ddlBikeFilter.DataTextField = "ModelName";
            ddlBikeFilter.DataValueField = "BikeID";
            ddlBikeFilter.DataBind();

            ddlBikeFilter.Items.Insert(0, new ListItem("All Bikes", ""));
        }
    }

    void LoadSummary()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int dealerId = Convert.ToInt32(Session["VendorID"]);

            SqlCommand cmdToday = new SqlCommand(
                @"SELECT COUNT(*) FROM Leads L
                  INNER JOIN Bikes B ON L.BikeID=B.BikeID
                  WHERE B.DealerID=@d AND L.IsSpam=0
                  AND CAST(L.CreatedAt AS DATE)=CAST(GETDATE() AS DATE)", con);

            cmdToday.Parameters.AddWithValue("@d", dealerId);
            lblToday.Text = cmdToday.ExecuteScalar().ToString();

            SqlCommand cmdMonth = new SqlCommand(
                @"SELECT COUNT(*) FROM Leads L
                  INNER JOIN Bikes B ON L.BikeID=B.BikeID
                  WHERE B.DealerID=@d AND L.IsSpam=0
                  AND MONTH(L.CreatedAt)=MONTH(GETDATE())
                  AND YEAR(L.CreatedAt)=YEAR(GETDATE())", con);

            cmdMonth.Parameters.AddWithValue("@d", dealerId);
            lblMonth.Text = cmdMonth.ExecuteScalar().ToString();

            SqlCommand cmdUnread = new SqlCommand(
                @"SELECT COUNT(*) FROM Leads L
                  INNER JOIN Bikes B ON L.BikeID=B.BikeID
                  WHERE B.DealerID=@d AND L.IsViewed=0 AND L.IsSpam=0", con);

            cmdUnread.Parameters.AddWithValue("@d", dealerId);
            lblUnread.Text = cmdUnread.ExecuteScalar().ToString();

            SqlCommand cmdRevenue = new SqlCommand(
                @"SELECT ISNULL(SUM(LeadAmount - ISNULL(CommissionAmount,0)),0)
                  FROM Leads L
                  INNER JOIN Bikes B ON L.BikeID=B.BikeID
                  WHERE B.DealerID=@d AND L.IsSpam=0", con);

            cmdRevenue.Parameters.AddWithValue("@d", dealerId);
            lblRevenue.Text = cmdRevenue.ExecuteScalar().ToString();
        }
    }

    void LoadLeads()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string query = @"
            SELECT L.LeadID,
                   U.FullName,
                   B.ModelName,
                   L.LeadAmount,
                   ISNULL(L.CommissionAmount,0) AS CommissionAmount,
                   L.CreatedAt,
                   L.IsViewed,
                   L.SettlementRequested,
                   L.IsSettled
            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            INNER JOIN Users U ON L.CustomerID=U.UserID
            WHERE B.DealerID=@d AND L.IsSpam=0";

            if (ddlBikeFilter.SelectedValue != "")
                query += " AND B.BikeID=@bike";

            if (ddlStatus.SelectedValue != "")
                query += " AND L.IsViewed=@status";

            if (txtSearch.Text.Trim() != "")
                query += " AND U.FullName LIKE @search";

            query += " ORDER BY L.CreatedAt DESC";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@d", Session["VendorID"]);

            if (ddlBikeFilter.SelectedValue != "")
                cmd.Parameters.AddWithValue("@bike", ddlBikeFilter.SelectedValue);

            if (ddlStatus.SelectedValue != "")
                cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);

            if (txtSearch.Text.Trim() != "")
                cmd.Parameters.AddWithValue("@search", "%" + txtSearch.Text + "%");

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvLeads.DataSource = dt;
            gvLeads.DataBind();
        }
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        LoadLeads();
    }

    protected void gvLeads_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLeads.PageIndex = e.NewPageIndex;
        LoadLeads();
    }

    protected void gvLeads_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int leadId = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            if (e.CommandName == "MarkViewed")
            {
                SqlCommand cmd = new SqlCommand(
                    "UPDATE Leads SET IsViewed=1 WHERE LeadID=@id", con);

                cmd.Parameters.AddWithValue("@id", leadId);
                cmd.ExecuteNonQuery();
            }

            if (e.CommandName == "DeleteLead")
            {
                SqlCommand cmd = new SqlCommand(
                    "DELETE FROM Leads WHERE LeadID=@id AND IsSpam=0", con);

                cmd.Parameters.AddWithValue("@id", leadId);
                cmd.ExecuteNonQuery();
            }

            if (e.CommandName == "RequestSettlement")
            {
                SqlCommand cmd = new SqlCommand(@"
                UPDATE Leads
                SET CommissionAmount =
                ISNULL(CommissionAmount,
                (LeadAmount *
                (SELECT CommissionPercent FROM SiteSettings WHERE SettingID=1) / 100)),
                SettlementRequested=1
                WHERE LeadID=@id AND IsSettled=0", con);

                cmd.Parameters.AddWithValue("@id", leadId);
                cmd.ExecuteNonQuery();
            }
        }

        LoadLeads();
        LoadSummary();
    }
}
