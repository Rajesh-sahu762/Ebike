using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_ManageLeads : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

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
        if (Session["AdminID"] == null)
            Response.Redirect("AdminLogin.aspx");

        if (!IsPostBack)
        {
            LoadDealers();
            LoadLeads();
            LoadSummary();
        }
    }

    void LoadDealers()
    {
        SqlConnection con = new SqlConnection(constr);
        SqlCommand cmd = new SqlCommand("SELECT UserID, ShopName FROM Users WHERE Role='Dealer'", con);

        con.Open();
        ddlDealer.DataSource = cmd.ExecuteReader();
        ddlDealer.DataTextField = "ShopName";
        ddlDealer.DataValueField = "UserID";
        ddlDealer.DataBind();
        con.Close();

        ddlDealer.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All Dealers", ""));
    }

    void LoadSummary()
    {
        SqlConnection con = new SqlConnection(constr);
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

        con.Close();
    }

    void LoadLeads()
    {
        SqlConnection con = new SqlConnection(constr);

        string query = @"SELECT L.LeadID, U.FullName, B.ModelName,
                        D.ShopName AS DealerName,
                        L.CreatedAt, L.IsViewed
                        FROM Leads L
                        INNER JOIN Users U ON L.CustomerID = U.UserID
                        INNER JOIN Bikes B ON L.BikeID = B.BikeID
                        INNER JOIN Users D ON B.DealerID = D.UserID
                        WHERE 1=1";

        if (ddlDealer.SelectedValue != "")
            query += " AND D.UserID=@dealer";

        if (txtFrom.Text != "")
            query += " AND L.CreatedAt >= @from";

        if (txtTo.Text != "")
            query += " AND L.CreatedAt <= @to";

        query += " ORDER BY " + SortExpression + " " + SortDirection;

        SqlCommand cmd = new SqlCommand(query, con);

        if (ddlDealer.SelectedValue != "")
            cmd.Parameters.AddWithValue("@dealer", ddlDealer.SelectedValue);

        if (txtFrom.Text != "")
            cmd.Parameters.AddWithValue("@from", txtFrom.Text);

        if (txtTo.Text != "")
            cmd.Parameters.AddWithValue("@to", txtTo.Text);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        gvLeads.DataSource = dt;
        gvLeads.DataBind();
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        LoadLeads();
    }

    protected void gvLeads_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvLeads.PageIndex = e.NewPageIndex;
        LoadLeads();
    }

    protected void gvLeads_Sorting(object sender, System.Web.UI.WebControls.GridViewSortEventArgs e)
    {
        SortExpression = e.SortExpression;
        SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
        LoadLeads();
    }

    protected void btnBulkDelete_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(constr);
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

        con.Close();
        LoadLeads();
        LoadSummary();
    }

    protected void gvLeads_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int leadId = Convert.ToInt32(e.CommandArgument);

        SqlConnection con = new SqlConnection(constr);
        con.Open();

        if (e.CommandName == "MarkLead")
        {
            SqlCommand cmd = new SqlCommand("UPDATE Leads SET IsViewed=1 WHERE LeadID=@id", con);
            cmd.Parameters.AddWithValue("@id", leadId);
            cmd.ExecuteNonQuery();
        }

        if (e.CommandName == "DeleteLead")
        {
            SqlCommand cmd = new SqlCommand("DELETE FROM Leads WHERE LeadID=@id", con);
            cmd.Parameters.AddWithValue("@id", leadId);
            cmd.ExecuteNonQuery();
        }

        if (e.CommandName == "ViewLead")
        {
            SqlCommand cmd = new SqlCommand("SELECT Message FROM Leads WHERE LeadID=@id", con);
            cmd.Parameters.AddWithValue("@id", leadId);

            object msgObj = cmd.ExecuteScalar();
            string msg = msgObj == null ? "" : msgObj.ToString();

            litLeadMessage.Text = "<div style='padding:15px'>" + msg + "</div>";

            ClientScript.RegisterStartupScript(this.GetType(),
                "ShowModal",
                "var myModal = new bootstrap.Modal(document.getElementById('leadModal')); myModal.show();",
                true);
        }

        con.Close();
        LoadLeads();
        LoadSummary();
    }
}
