using System;
using System.Configuration;
using System.Data.SqlClient;

public partial class Vendor_VendorSubscription : System.Web.UI.Page
{

    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");

        if (!IsPostBack)
        {
            LoadCurrentPlan();
        }

    }

    void LoadCurrentPlan()
    {

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(@"

SELECT TOP 1 PlanName,EndDate,MaxBikes
FROM DealerSubscriptions
WHERE DealerID=@d AND IsActive=1
ORDER BY EndDate DESC

", con);

            cmd.Parameters.AddWithValue("@d", Session["VendorID"]);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {

                lblPlan.Text = dr["PlanName"].ToString();
                lblExpiry.Text = Convert.ToDateTime(dr["EndDate"]).ToString("dd MMM yyyy");
                lblBikeLimit.Text = dr["MaxBikes"].ToString();
                lblFeaturedLimit.Text = "-";

            }
            else
            {

                lblPlan.Text = "No Active Plan";
                lblExpiry.Text = "-";
                lblBikeLimit.Text = "0";
                lblFeaturedLimit.Text = "0";

            }

        }

    }

    bool HasPendingRequest()
    {

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(

            "SELECT COUNT(*) FROM DealerSubscriptionRequests WHERE DealerID=@d AND Status='Pending'", con);

            cmd.Parameters.AddWithValue("@d", Session["VendorID"]);

            return Convert.ToInt32(cmd.ExecuteScalar()) > 0;

        }

    }

    void CreateRequest(string plan, int bikes, int featured, int price)
    {

        if (HasPendingRequest())
        {

            lblMsg.Text = "You already have a pending request.";
            return;

        }

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(@"

INSERT INTO DealerSubscriptionRequests
(DealerID,PlanName,BikeLimit,FeaturedLimit,Amount)

VALUES

(@d,@p,@b,@f,@a)

", con);

            cmd.Parameters.AddWithValue("@d", Session["VendorID"]);
            cmd.Parameters.AddWithValue("@p", plan);
            cmd.Parameters.AddWithValue("@b", bikes);
            cmd.Parameters.AddWithValue("@f", featured);
            cmd.Parameters.AddWithValue("@a", price);

            cmd.ExecuteNonQuery();

            lblMsg.Text = "Plan request submitted. Pay cash to admin.";

        }

    }

    protected void btnBasic_Click(object sender, EventArgs e)
    {
        CreateRequest("Basic", 10, 0, 999);
    }

    protected void btnPro_Click(object sender, EventArgs e)
    {
        CreateRequest("Pro", 50, 0, 1999);
    }

    protected void btnFeatured_Click(object sender, EventArgs e)
    {
        CreateRequest("Featured", 0, 1, 499);
    }

    protected void btnCombo_Click(object sender, EventArgs e)
    {
        CreateRequest("Combo", 50, 3, 2499);
    }

}