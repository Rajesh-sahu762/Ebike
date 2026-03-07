using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.Services;

public partial class Client_Rental : System.Web.UI.Page
{

    [WebMethod]

    public static object GetRentalBikes(int page, int minPrice, int maxPrice, string range, string[] brands)
    {

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        int pageSize = 6;

        int start = (page - 1) * pageSize;

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            string brandFilter = "";

            if (brands != null && brands.Length > 0)

                brandFilter = " AND B.BrandID IN (" + string.Join(",", brands) + ")";

            string query =

            "SELECT * FROM (" +

            "SELECT ROW_NUMBER() OVER (ORDER BY B.CreatedAt DESC) AS RowNum," +

            "B.BikeID,B.ModelName,B.Price,B.RangeKM,B.Image1,B.Slug " +

            "FROM Bikes B " +

            "WHERE B.IsApproved=1 " +

            "AND ISNULL(B.IsForRent,0)=1 " +

            "AND B.Price BETWEEN @min AND @max" +

            brandFilter +

            (range != "" ? " AND B.RangeKM<=@range" : "") +

            ") X WHERE RowNum BETWEEN @start AND @end";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@min", minPrice);

            cmd.Parameters.AddWithValue("@max", maxPrice);

            cmd.Parameters.AddWithValue("@start", start + 1);

            cmd.Parameters.AddWithValue("@end", start + pageSize);

            if (range != "")

                cmd.Parameters.AddWithValue("@range", range);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();

            da.Fill(dt);

            StringBuilder html = new StringBuilder();

            foreach (DataRow dr in dt.Rows)
            {

                html.Append("<div class='bike-card'>");

                html.Append("<div class='bike-img'>");

                html.Append("<img src='/Uploads/Bikes/" + dr["Image1"] + "'/>");

                html.Append("</div>");

                html.Append("<div class='bike-body'>");

                html.Append("<h6>" + dr["ModelName"] + "</h6>");

                html.Append("<div class='price'>₹ " + Convert.ToDecimal(dr["Price"]).ToString("N0") + "</div>");

                html.Append("<div>Range: " + dr["RangeKM"] + " KM</div>");

                html.Append("<a href='BikeDetails.aspx?slug=" + dr["Slug"] + "' class='view-btn'>View</a>");

                html.Append("</div>");

                html.Append("</div>");

            }

            return new { html = html.ToString(), count = dt.Rows.Count };

        }

    }

}
