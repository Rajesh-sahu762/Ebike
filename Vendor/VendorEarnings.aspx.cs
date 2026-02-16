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

            decimal commissionPercent = 0;

            // SAFE Commission Fetch
            SqlCommand comCmd = new SqlCommand(
                "SELECT CommissionPercent FROM SiteSettings WHERE SettingID=1", con);

            object comObj = comCmd.ExecuteScalar();

            if (comObj != DBNull.Value && comObj != null)
                commissionPercent = Convert.ToDecimal(comObj);
            else
                commissionPercent = 0;  // Default 0%

            // SAFE Revenue Fetch
            SqlCommand revCmd = new SqlCommand(@"
            SELECT ISNULL(SUM(L.LeadAmount),0)
            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            WHERE B.DealerID=@d AND L.LeadAmount>0", con);

            revCmd.Parameters.AddWithValue("@d", Session["VendorID"]);

            decimal revenue = Convert.ToDecimal(revCmd.ExecuteScalar());

            decimal commission = revenue * commissionPercent / 100;
            decimal net = revenue - commission;

            lblRevenue.Text = revenue.ToString("0.00");
            lblCommission.Text = commission.ToString("0.00");
            lblNet.Text = net.ToString("0.00");

            // THIS MONTH SAFE
            SqlCommand monthCmd = new SqlCommand(@"
            SELECT ISNULL(SUM(L.LeadAmount),0)
            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            WHERE B.DealerID=@d
            AND MONTH(L.CreatedAt)=MONTH(GETDATE())
            AND YEAR(L.CreatedAt)=YEAR(GETDATE())", con);

            monthCmd.Parameters.AddWithValue("@d", Session["VendorID"]);

            lblMonth.Text = monthCmd.ExecuteScalar().ToString();
        }
    }


    void LoadEarnings()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string query = @"
            SELECT L.LeadID, U.FullName, B.ModelName, L.LeadAmount,
            L.CreatedAt,
            (L.LeadAmount * S.CommissionPercent / 100) AS Commission,
            (L.LeadAmount - (L.LeadAmount * S.CommissionPercent / 100)) AS NetAmount
            FROM Leads L
            INNER JOIN Bikes B ON L.BikeID=B.BikeID
            INNER JOIN Users U ON L.CustomerID=U.UserID
            CROSS JOIN SiteSettings S
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
        if (e.CommandName == "MarkPaid")
        {
            int leadId = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(
                    "UPDATE Leads SET LeadAmount=LeadAmount WHERE LeadID=@id", con);
                cmd.Parameters.AddWithValue("@id", leadId);
                cmd.ExecuteNonQuery();
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
