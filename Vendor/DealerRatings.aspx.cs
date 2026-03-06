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

            // ===== AVG RATING =====

            SqlCommand avgCmd = new SqlCommand(@"

        SELECT ISNULL(AVG(CAST(R.Rating AS FLOAT)),0)

        FROM BikeReviews R
        INNER JOIN Bikes B ON R.BikeID = B.BikeID

        WHERE B.DealerID=@d
        AND R.IsApproved=1

        ", con);

            avgCmd.Parameters.AddWithValue("@d", dealerId);

            double avg = Convert.ToDouble(avgCmd.ExecuteScalar());

            lblAvg.Text = Math.Round(avg, 1).ToString();


            // ===== TOTAL REVIEWS =====

            SqlCommand totalCmd = new SqlCommand(@"

        SELECT COUNT(*)

        FROM BikeReviews R
        INNER JOIN Bikes B ON R.BikeID = B.BikeID

        WHERE B.DealerID=@d

        ", con);

            totalCmd.Parameters.AddWithValue("@d", dealerId);

            lblTotal.Text = totalCmd.ExecuteScalar().ToString();


            // ===== 5 STAR REVIEWS =====

            SqlCommand fiveCmd = new SqlCommand(@"

        SELECT COUNT(*)

        FROM BikeReviews R
        INNER JOIN Bikes B ON R.BikeID = B.BikeID

        WHERE B.DealerID=@d
        AND R.Rating=5
        AND R.IsApproved=1

        ", con);

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

SELECT 
R.ReviewID,
B.ModelName,
U.FullName,
R.Rating,
R.ReviewText,
R.IsApproved,
R.CreatedAt

FROM BikeReviews R

INNER JOIN Bikes B
ON R.BikeID = B.BikeID

INNER JOIN Users U
ON R.CustomerID = U.UserID

WHERE B.DealerID = @d

ORDER BY R.CreatedAt DESC

";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@d", Session["VendorID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvRatings.DataSource = dt;
            gvRatings.DataBind();
        }
    }

    protected void gvRatings_RowCommand(object sender,
    System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int reviewId = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            if (e.CommandName == "approve")
            {
                SqlCommand cmd = new SqlCommand(
                "UPDATE BikeReviews SET IsApproved=1 WHERE ReviewID=@id", con);

                cmd.Parameters.AddWithValue("@id", reviewId);
                cmd.ExecuteNonQuery();
            }

            if (e.CommandName == "reject")
            {
                SqlCommand cmd = new SqlCommand(
                "UPDATE BikeReviews SET IsApproved=0 WHERE ReviewID=@id", con);

                cmd.Parameters.AddWithValue("@id", reviewId);
                cmd.ExecuteNonQuery();
            }

            if (e.CommandName == "delete")
            {
                SqlCommand cmd = new SqlCommand(
                "DELETE FROM BikeReviews WHERE ReviewID=@id", con);

                cmd.Parameters.AddWithValue("@id", reviewId);
                cmd.ExecuteNonQuery();
            }
        }

        LoadRatings();
        LoadSummary();
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
