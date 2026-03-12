using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;

public partial class Client_Wishlist : System.Web.UI.Page
{

    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["CustomerID"] == null)
            Response.Redirect("ClientLogin.aspx");

        if (!IsPostBack)
        {
            LoadWishlist();
        }

    }

    void LoadWishlist()
    {

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(@"

SELECT
B.BikeID,
B.ModelName,
B.Price,
B.Image1,
B.Slug

FROM Wishlist W
INNER JOIN Bikes B ON W.BikeID=B.BikeID
WHERE W.CustomerID=@c
ORDER BY W.CreatedAt DESC

", con);

            cmd.Parameters.AddWithValue("@c", Session["CustomerID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();

            da.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                wishlistGrid.Visible = false;
                emptyWishlist.Visible = true;
            }
            else
            {
                wishlistGrid.Visible = true;
                emptyWishlist.Visible = false;

                rptWishlist.DataSource = dt;
                rptWishlist.DataBind();
            }

        }

    }

    [WebMethod(EnableSession = true)]
    public static string Remove(int bikeId)
    {

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        int user = Convert.ToInt32(HttpContext.Current.Session["CustomerID"]);

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(@"

DELETE FROM Wishlist

WHERE CustomerID=@c AND BikeID=@b

", con);

            cmd.Parameters.AddWithValue("@c", user);
            cmd.Parameters.AddWithValue("@b", bikeId);

            cmd.ExecuteNonQuery();

        }

        return "Removed";

    }

}