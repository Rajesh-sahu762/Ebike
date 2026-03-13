using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;

public partial class Client_MyEnquiries : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CustomerID"] == null)
            Response.Redirect("ClientLogin.aspx");

        if (!IsPostBack)
        {
            LoadEnquiries();
        }
    }

    void LoadEnquiries()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"

SELECT 
L.LeadID,
L.Message,
L.CreatedAt,
L.IsViewed,

B.ModelName,
B.Image1,
B.Slug,

U.ShopName

FROM Leads L

INNER JOIN Bikes B ON L.BikeID=B.BikeID
INNER JOIN Users U ON B.DealerID=U.UserID

WHERE L.CustomerID=@c

ORDER BY L.CreatedAt DESC

", con);

            cmd.Parameters.AddWithValue("@c", Session["CustomerID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                emptyBox.Visible = true;
            }
            else
            {
                rptEnquiries.DataSource = dt;
                rptEnquiries.DataBind();
            }
        }
    }


    [WebMethod(EnableSession = true)]
    public static string DeleteEnquiry(int id)
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        int user = Convert.ToInt32(System.Web.HttpContext.Current.Session["CustomerID"]);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"

DELETE FROM Leads
WHERE LeadID=@id
AND CustomerID=@c

", con);

            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@c", user);

            cmd.ExecuteNonQuery();
        }

        return "ok";
    }

}