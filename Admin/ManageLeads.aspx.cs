using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_ManageLeads : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    private static readonly string[] AllowedLeadSortColumns = new string[] { "LeadID", "FullName", "ModelName", "DealerName", "IsViewed", "CreatedAt" };

    string SortDirection
    {
        get { return ViewState["SortDirection"] as string ?? "DESC"; }
        set { ViewState["SortDirection"] = value; }
    }

    string SortExpression
    {
        get { return ViewState["SortExpression"] as string ?? "CreatedAt"; }
        set { ViewState["SortExpression"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("AdminLogin.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadDealers();
            LoadLeads();
            LoadSummary();
        }
    }

    void LoadDealers()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            SqlCommand cmd = new SqlCommand(
                "SELECT UserID, ShopName FROM Users WHERE Role='Dealer'", con);

            con.Open();
            ddlDealer.DataSource = cmd.ExecuteReader();
            ddlDealer.DataTextField = "ShopName";
            ddlDealer.DataValueField = "UserID";
            ddlDealer.DataBind();
            ddlDealer.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All Dealers", ""));
        }
    }

    void LoadSummary()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            lblToday.Text = new SqlCommand(
                "SELECT COUNT(*) FROM Leads WHERE CAST(CreatedAt AS DATE)=CAST(GETDATE() AS DATE)", con
            ).ExecuteScalar().ToString();

            lblMonth.Text = new SqlCommand(
                "SELECT COUNT(*) FROM Leads WHERE MONTH(CreatedAt)=MONTH(GETDATE()) AND YEAR(CreatedAt)=YEAR(GETDATE())", con
            ).ExecuteScalar().ToString();

            lblUnread.Text = new SqlCommand(
                "SELECT COUNT(*) FROM Leads WHERE IsViewed=0", con
            ).ExecuteScalar().ToString();
        }
    }

    void LoadLeads()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = @"
SELECT 
L.LeadID,
U.FullName,
B.ModelName,
D.ShopName AS DealerName,
L.IsViewed,
L.CreatedAt
FROM Leads L
INNER JOIN Users U ON L.CustomerID = U.UserID
INNER JOIN Bikes B ON L.BikeID = B.BikeID
INNER JOIN Users D ON B.DealerID = D.UserID
WHERE 1=1";

            if (ddlDealer.SelectedValue != "")
                query += " AND D.UserID=@dealer";

            DateTime fromDate, toDate;
            bool hasFrom = DateTime.TryParse(txtFrom.Text.Trim(), out fromDate);
            bool hasTo = DateTime.TryParse(txtTo.Text.Trim(), out toDate);

            if (hasFrom)
                query += " AND L.CreatedAt >= @from";

            if (hasTo)
                query += " AND L.CreatedAt <= @to";

            // Whitelist sort expression and sort direction against SQL injection
            string safeColumn = SecurityHelper.SanitizeSortColumn(SortExpression, AllowedLeadSortColumns, "CreatedAt");
            string safeDirection = SecurityHelper.SanitizeSortDirection(SortDirection);
            query += " ORDER BY " + safeColumn + " " + safeDirection;

            SqlCommand cmd = new SqlCommand(query, con);

            if (ddlDealer.SelectedValue != "")
            {
                int dId;
                if (int.TryParse(ddlDealer.SelectedValue, out dId))
                    cmd.Parameters.AddWithValue("@dealer", dId);
                else
                    cmd.Parameters.AddWithValue("@dealer", ddlDealer.SelectedValue);
            }

            if (hasFrom)
                cmd.Parameters.AddWithValue("@from", fromDate);

            if (hasTo)
                cmd.Parameters.AddWithValue("@to", toDate.Date.AddDays(1).AddTicks(-1));

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

    protected void btnBulkDelete_Click(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("AdminLogin.aspx");
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            foreach (System.Web.UI.WebControls.GridViewRow row in gvLeads.Rows)
            {
                System.Web.UI.WebControls.CheckBox chk =
                    (System.Web.UI.WebControls.CheckBox)row.FindControl("chkSelect");

                if (chk != null && chk.Checked)
                {
                    int leadId = Convert.ToInt32(gvLeads.DataKeys[row.RowIndex].Value);

                    SqlCommand cmd = new SqlCommand(
                        "DELETE FROM Leads WHERE LeadID=@id", con);

                    cmd.Parameters.AddWithValue("@id", leadId);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        LoadLeads();
        LoadSummary();
    }

    protected void gvLeads_RowCommand(object sender,
      System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (Session["AdminID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("AdminLogin.aspx");
            return;
        }

        int leadId = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            if (e.CommandName == "ViewLead")
            {
                SqlCommand cmd = new SqlCommand(@"
                SELECT Message 
                FROM Leads 
                WHERE LeadID=@id", con);

                cmd.Parameters.AddWithValue("@id", leadId);

                object msg = cmd.ExecuteScalar();

                if (msg != null)
                    litLeadMessage.Text = Server.HtmlEncode(msg.ToString());
                else
                    litLeadMessage.Text = "No message";

                ClientScript.RegisterStartupScript(this.GetType(),
                "openModal",
                @"var myModal = new bootstrap.Modal(document.getElementById('leadModal'));
                myModal.show();",
                true);
            }

            if (e.CommandName == "DeleteLead")
            {
                SqlCommand cmd = new SqlCommand(
                "DELETE FROM Leads WHERE LeadID=@id", con);

                cmd.Parameters.AddWithValue("@id", leadId);
                cmd.ExecuteNonQuery();
            }
        }

        LoadLeads();
        LoadSummary();
    }

    protected void gvLeads_PageIndexChanging(object sender,
        System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvLeads.PageIndex = e.NewPageIndex;
        LoadLeads();
    }

    protected void gvLeads_Sorting(object sender,
        System.Web.UI.WebControls.GridViewSortEventArgs e)
    {
        SortExpression = SecurityHelper.SanitizeSortColumn(e.SortExpression, AllowedLeadSortColumns, "CreatedAt");
        SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
        LoadLeads();
    }
}
