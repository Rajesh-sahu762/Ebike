using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.Services;

public partial class Client_UsedBikes : System.Web.UI.Page
{

    [WebMethod(EnableSession = true)]
    public static object GetUsedBikes(
    int page, string search, string price, string km, string owner)
    {

        string constr =
        ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        int pageSize = 6;
        int start = (page - 1) * pageSize;

        int userId = 0;

        if (System.Web.HttpContext.Current.Session["CustomerID"] != null)
            userId = Convert.ToInt32(System.Web.HttpContext.Current.Session["CustomerID"]);

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            string query = @"

SELECT * FROM (

SELECT 
ROW_NUMBER() OVER (ORDER BY B.CreatedAt DESC) RowNum,

B.BikeID,
B.ModelName,
B.Price,
B.KMDriven,
B.ManufactureYear,
B.OwnerNumber,
B.Image1,
B.Slug,

CASE WHEN W.BikeID IS NULL THEN 0 ELSE 1 END AS IsWishlisted

FROM Bikes B

LEFT JOIN Wishlist W
ON B.BikeID=W.BikeID AND W.CustomerID=@user

WHERE B.IsApproved=1
AND ISNULL(B.IsUsed,0)=1
AND ISNULL(B.IsForRent,0)=0
";

            if (!string.IsNullOrEmpty(search))
                query += " AND B.ModelName LIKE @search";

            if (!string.IsNullOrEmpty(price))
                query += " AND B.Price<=@price";

            if (!string.IsNullOrEmpty(km))
                query += " AND B.KMDriven<=@km";

            if (!string.IsNullOrEmpty(owner))
                query += " AND B.OwnerNumber=@owner";

            query += " ) X WHERE RowNum BETWEEN @start AND @end";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@start", start + 1);
            cmd.Parameters.AddWithValue("@end", start + pageSize);
            cmd.Parameters.AddWithValue("@user", userId);

            if (!string.IsNullOrEmpty(search))
                cmd.Parameters.AddWithValue("@search", "%" + search + "%");

            decimal p;
            if (decimal.TryParse(price, out p))
                cmd.Parameters.AddWithValue("@price", p);

            int k;
            if (int.TryParse(km, out k))
                cmd.Parameters.AddWithValue("@km", k);

            int o;
            if (int.TryParse(owner, out o))
                cmd.Parameters.AddWithValue("@owner", o);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            StringBuilder html = new StringBuilder();

            if (dt.Rows.Count == 0)
            {
                html.Append("<div style='grid-column:1/-1;text-align:center;padding:40px;font-weight:600;'>No Used Bikes Found</div>");
            }
            else
            {
                foreach (DataRow dr in dt.Rows)
                {
                    string active = dr["IsWishlisted"].ToString() == "1" ? "active" : "";

                    html.Append("<div class='bike-card'>");

                    html.Append("<div class='bike-img'>");

                    html.Append("<img src='/Uploads/Bikes/" + dr["Image1"] + "'/>");

                    html.Append("<div class='wishlist " + active + "' onclick='toggleWishlist(this," + dr["BikeID"] + ")'>♥</div>");

                    html.Append("</div>");

                    html.Append("<div class='bike-body'>");

                    html.Append("<h6>" + dr["ModelName"] + "</h6>");

                    html.Append("<div class='price'>₹ " +
                    Convert.ToDecimal(dr["Price"]).ToString("N0") +
                    "</div>");

                    html.Append("<div>" +
                    dr["ManufactureYear"] +
                    " • " + dr["KMDriven"] + " KM" +
                    "</div>");

                    html.Append("<a href='UsedBikeDetails.aspx?slug=" +
                    dr["Slug"] +
                    "' class='view-btn'>View</a>");

                    html.Append("</div>");

                    html.Append("</div>");
                }
            }

            return new { html = html.ToString(), count = dt.Rows.Count };

        }

    }

}