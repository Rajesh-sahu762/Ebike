using System;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Services;

public partial class Client_Wishlist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod(EnableSession = true)]
    public static string GetWishlist()
    {
        if (HttpContext.Current.Session["CustomerID"] == null)
            return "<div class='empty-box'>Please login</div>";

        int userId = Convert.ToInt32(HttpContext.Current.Session["CustomerID"]);

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        StringBuilder html = new StringBuilder();

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"

SELECT B.BikeID,
B.ModelName,
B.Price,
B.Image1,
B.Slug

FROM Wishlist W
INNER JOIN Bikes B ON W.BikeID=B.BikeID

WHERE W.CustomerID=@u
AND B.IsApproved=1

", con);

            cmd.Parameters.AddWithValue("@u", userId);

            SqlDataReader dr = cmd.ExecuteReader();

            bool hasData = false;

            while (dr.Read())
            {
                hasData = true;

                html.Append("<div class='wishlist-card'>");

                html.Append("<div class='remove-btn' onclick='removeWishlist(" + dr["BikeID"] + ")'>❤</div>");

                html.Append("<div class='wishlist-img'>");
                html.Append("<img src='/Uploads/Bikes/" + dr["Image1"] + "'>");
                html.Append("</div>");

                html.Append("<div class='wishlist-body'>");

                html.Append("<div class='wishlist-name'>" + dr["ModelName"] + "</div>");

                html.Append("<div class='wishlist-price'>₹ " +
                Convert.ToDecimal(dr["Price"]).ToString("N0") +
                "</div>");

                html.Append("<button class='btn-view' onclick=\"location.href='BikeDetails.aspx?slug="
                + dr["Slug"] +
                "'\">View Bike</button>");

                html.Append("</div>");

                html.Append("</div>");
            }

            if (!hasData)
            {
                html.Append(@"

<div class='empty-box'>

<img src='/images/empty-wishlist.png'
style='width:120px;opacity:.7;'>

<h3>Your wishlist is empty</h3>

<p>Save bikes you like to view later</p>

</div>

");
            }
        }

        return html.ToString();
    }


    [WebMethod(EnableSession = true)]
    public static string RemoveWishlist(int bikeId)
    {
        if (HttpContext.Current.Session["CustomerID"] == null)
            return "login";

        int userId = Convert.ToInt32(HttpContext.Current.Session["CustomerID"]);

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "DELETE FROM Wishlist WHERE CustomerID=@u AND BikeID=@b", con);

            cmd.Parameters.AddWithValue("@u", userId);
            cmd.Parameters.AddWithValue("@b", bikeId);

            cmd.ExecuteNonQuery();
        }

        return "removed";
    }

}