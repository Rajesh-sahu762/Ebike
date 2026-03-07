using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_AdminSubscriptionRequests : System.Web.UI.Page
{

    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["AdminID"] == null)
            Response.Redirect("AdminLogin.aspx");

        if (!IsPostBack)
        {

            LoadRequests();
            LoadActiveSubscriptions();

        }

    }

    void LoadRequests()
    {

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(@"

SELECT R.RequestID,U.FullName,R.PlanName,
R.BikeLimit,R.FeaturedLimit,R.Amount,R.CreatedAt

FROM DealerSubscriptionRequests R
INNER JOIN Users U ON R.DealerID=U.UserID

WHERE R.Status='Pending'

ORDER BY R.CreatedAt DESC

", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();

            da.Fill(dt);

            gvRequests.DataSource = dt;
            gvRequests.DataBind();

        }

    }

    void LoadActiveSubscriptions()
    {

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(@"

SELECT S.SubscriptionID,U.FullName,
S.PlanName,S.MaxBikes,
S.StartDate,S.EndDate

FROM DealerSubscriptions S
INNER JOIN Users U ON S.DealerID=U.UserID

ORDER BY S.EndDate DESC

", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();

            da.Fill(dt);

            gvActive.DataSource = dt;
            gvActive.DataBind();

        }

    }

    protected void gvRequests_RowCommand(object sender,
    System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {

        int requestId = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "Approve")
        {

            ApproveRequest(requestId);

        }

        if (e.CommandName == "Reject")
        {

            RejectRequest(requestId);

        }

        LoadRequests();
        LoadActiveSubscriptions();

    }

    void ApproveRequest(int requestId)
    {

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand get = new SqlCommand(@"

SELECT * FROM DealerSubscriptionRequests
WHERE RequestID=@id

", con);

            get.Parameters.AddWithValue("@id", requestId);

            SqlDataReader dr = get.ExecuteReader();

            if (dr.Read())
            {

                int dealerId = Convert.ToInt32(dr["DealerID"]);
                string plan = dr["PlanName"].ToString();
                int bikes = Convert.ToInt32(dr["BikeLimit"]);

                dr.Close();

                SqlCommand insert = new SqlCommand(@"

INSERT INTO DealerSubscriptions
(DealerID,PlanName,StartDate,EndDate,MaxBikes,IsActive)

VALUES

(@d,@p,GETDATE(),DATEADD(MONTH,1,GETDATE()),@b,1)

", con);

                insert.Parameters.AddWithValue("@d", dealerId);
                insert.Parameters.AddWithValue("@p", plan);
                insert.Parameters.AddWithValue("@b", bikes);

                insert.ExecuteNonQuery();

                SqlCommand update = new SqlCommand(

                "UPDATE DealerSubscriptionRequests SET Status='Approved',ApprovedAt=GETDATE() WHERE RequestID=@id", con);

                update.Parameters.AddWithValue("@id", requestId);

                update.ExecuteNonQuery();

            }

        }

    }

    void RejectRequest(int requestId)
    {

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(

            "UPDATE DealerSubscriptionRequests SET Status='Rejected' WHERE RequestID=@id", con);

            cmd.Parameters.AddWithValue("@id", requestId);

            cmd.ExecuteNonQuery();

        }

    }

    protected void gvActive_RowCommand(object sender,
    System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {

        int subId = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "Extend")
        {

            ExtendSubscription(subId);

        }

        if (e.CommandName == "Cancel")
        {

            CancelSubscription(subId);

        }

        LoadActiveSubscriptions();

    }

    void ExtendSubscription(int id)
    {

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(

            "UPDATE DealerSubscriptions SET EndDate=DATEADD(MONTH,1,EndDate) WHERE SubscriptionID=@id", con);

            cmd.Parameters.AddWithValue("@id", id);

            cmd.ExecuteNonQuery();

        }

    }

    void CancelSubscription(int id)
    {

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(

            "UPDATE DealerSubscriptions SET IsActive=0 WHERE SubscriptionID=@id", con);

            cmd.Parameters.AddWithValue("@id", id);

            cmd.ExecuteNonQuery();

        }

    }

}