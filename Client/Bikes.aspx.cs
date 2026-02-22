using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.Services;

public partial class Client_Bikes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e) { }

    [WebMethod]
    public static object GetBikes(int page, int minPrice, int maxPrice, string range, string sort, string[] brands)
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
        int pageSize = 6;
        int start = (page - 1) * pageSize;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string order = "CreatedAt DESC";
            if (sort == "priceAsc") order = "Price ASC";
            if (sort == "priceDesc") order = "Price DESC";

            string brandFilter = "";
            if (brands != null && brands.Length > 0)
                brandFilter = " AND BrandID IN (" + string.Join(",", brands) + ")";

            string query =
            "SELECT * FROM (" +
            " SELECT ROW_NUMBER() OVER (ORDER BY " + order + ") AS RowNum," +
            " BikeID,ModelName,Price,RangeKM,Image1,Slug" +
            " FROM Bikes WHERE IsApproved=1" +
            " AND Price BETWEEN @min AND @max" +
            brandFilter +
            (range != "" ? " AND RangeKM<=@range" : "") +
            ") X WHERE RowNum BETWEEN @start AND @end";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@min", minPrice);
            cmd.Parameters.AddWithValue("@max", maxPrice);
            cmd.Parameters.AddWithValue("@start", start + 1);
            cmd.Parameters.AddWithValue("@end", start + pageSize);
            if (range != "") cmd.Parameters.AddWithValue("@range", range);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            StringBuilder html = new StringBuilder();
            foreach (DataRow dr in dt.Rows)
            {
                html.Append("<div class='bike-card'>");
                html.Append("<div class='bike-img'>");
                html.Append("<img src='/Uploads/Bikes/" + dr["Image1"] + "'/>");
                html.Append("<div class='wishlist' onclick='addWishlist(this," + dr["BikeID"] + ")'>♥</div>");
                html.Append("<label class='compare-label'><input type='checkbox' onclick='toggleCompare(" + dr["BikeID"] + ")'/> Compare</label>");
                html.Append("</div>");
                html.Append("<div class='bike-body'>");
                html.Append("<h6>" + dr["ModelName"] + "</h6>");
                html.Append("<div class='price'>₹ " + Convert.ToDecimal(dr["Price"]).ToString("N0") + "</div>");
                html.Append("<div>Range: " + dr["RangeKM"] + " KM</div>");
                html.Append("<a href='BikeDetails.aspx?slug=" + dr["Slug"] + "' class='view-btn'>View</a>");
                html.Append("</div></div>");
            }

            return new { html = html.ToString(), count = dt.Rows.Count };
        }
    }

    [WebMethod]
    public static string GetBrands()
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT BrandID,BrandName FROM Brands WHERE IsActive=1", con);
            SqlDataReader dr = cmd.ExecuteReader();

            StringBuilder html = new StringBuilder();
            while (dr.Read())
            {
                html.Append("<div><input type='checkbox' class='brand-check' value='" + dr["BrandID"] + "'/> " + dr["BrandName"] + "</div>");
            }
            return html.ToString();
        }
    }

    [WebMethod]
    public static void AddWishlist(int bikeId)
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("INSERT INTO Wishlist(CustomerID,BikeID) VALUES(1,@b)", con);
            cmd.Parameters.AddWithValue("@b", bikeId);
            cmd.ExecuteNonQuery();
        }
    }
}
