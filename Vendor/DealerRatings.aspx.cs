using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Vendor_DealerRatings : System.Web.UI.Page
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
        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");

        if (!IsPostBack)
        {
            LoadSummary();
            LoadRatings();
        }
    }

    void LoadSummary()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int dealerId = Convert.ToInt32(Session["VendorID"]);

            SqlCommand avgCmd = new SqlCommand(
                "SELECT ISNULL(AVG(CAST(Rating AS FLOAT)),0) FROM DealerRatings WHERE DealerID=@d", con);
            avgCmd.Parameters.AddWithValue("@d", dealerId);
            lblAvg.Text = Math.Round(Convert.ToDouble(avgCmd.ExecuteScalar()), 1).ToString();

            SqlCommand totalCmd = new SqlCommand(
                "SELECT COUNT(*) FROM DealerRatings WHERE DealerID=@d", con);
            totalCmd.Parameters.AddWithValue("@d", dealerId);
            lblTotal.Text = totalCmd.ExecuteScalar().ToString();

            SqlCommand fiveCmd = new SqlCommand(
                "SELECT COUNT(*) FROM DealerRatings WHERE DealerID=@d AND Rating=5", con);
            fiveCmd.Parameters.AddWithValue("@d", dealerId);
            lblFive.Text = fiveCmd.ExecuteScalar().ToString();
        }
    }

    void LoadRatings()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string query = @"
            SELECT U.FullName, R.Rating, R.Review, R.CreatedAt
            FROM DealerRatings R
            INNER JOIN Users U ON R.CustomerID=U.UserID
            WHERE R.DealerID=@d
            ORDER BY " + SortExpression + " " + SortDirection;

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@d", Session["VendorID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvRatings.DataSource = dt;
            gvRatings.DataBind();
        }
    }

    protected void gvRatings_PageIndexChanging(object sender,
        System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvRatings.PageIndex = e.NewPageIndex;
        LoadRatings();
    }

    protected void gvRatings_Sorting(object sender,
        System.Web.UI.WebControls.GridViewSortEventArgs e)
    {
        SortExpression = e.SortExpression;
        SortDirection = SortDirection == "ASC" ? "DESC" : "ASC";
        LoadRatings();
    }

    public string GetStars(int rating)
    {
        string stars = "";
        for (int i = 1; i <= 5; i++)
        {
            if (i <= rating)
                stars += "<i class='fa fa-star text-warning'></i>";
            else
                stars += "<i class='fa fa-star text-secondary'></i>";
        }
        return stars;
    }
}
