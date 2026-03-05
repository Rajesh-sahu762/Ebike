using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.Services;

public partial class Client_Bikes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string keyword = Request.QueryString["search"];
            string dealer = Request.QueryString["dealer"];

            if (!string.IsNullOrEmpty(keyword))
                hfSearch.Value = keyword;

            if (!string.IsNullOrEmpty(dealer))
                hfDealer.Value = dealer;
        }
    }


    [WebMethod]
    public static object GetBikes(int page, int minPrice, int maxPrice,
     string range, string sort, string[] brands, string search, string dealer)
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        int pageSize = 6;
        int start = (page - 1) * pageSize;

        int userId = 0;

        if (System.Web.HttpContext.Current.Session["CustomerID"] != null)
            userId = Convert.ToInt32(System.Web.HttpContext.Current.Session["CustomerID"]);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string order = "B.CreatedAt DESC";

            if (sort == "priceAsc") order = "B.Price ASC";
            if (sort == "priceDesc") order = "B.Price DESC";

            string brandFilter = "";
            if (brands != null && brands.Length > 0)
                brandFilter = " AND B.BrandID IN (" + string.Join(",", brands) + ")";

            string dealerFilter = "";
            if (!string.IsNullOrEmpty(dealer))
                dealerFilter = " AND B.DealerID=@dealer";

            string searchFilter = "";
            if (!string.IsNullOrEmpty(search))
                searchFilter = " AND B.ModelName LIKE @search";


            string query =
 "SELECT * FROM (" +
 " SELECT ROW_NUMBER() OVER (ORDER BY " + order + ") AS RowNum," +
 " B.BikeID,B.ModelName,B.Price,B.RangeKM,B.Image1,B.Slug," +
 " CASE WHEN W.BikeID IS NULL THEN 0 ELSE 1 END AS IsWishlisted" +
 " FROM Bikes B " +
 " LEFT JOIN Wishlist W ON B.BikeID=W.BikeID AND W.CustomerID=@user " +
 " WHERE B.IsApproved=1 " +
 " AND ISNULL(B.IsUsed,0)=0 " +
 " AND ISNULL(B.IsForRent,0)=0 " +
 " AND B.Price BETWEEN @min AND @max" +
 brandFilter +
 dealerFilter +
 searchFilter +
 (range != "" ? " AND B.RangeKM<=@range" : "") +
 ") X WHERE RowNum BETWEEN @start AND @end";


            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@min", minPrice);
            cmd.Parameters.AddWithValue("@max", maxPrice);
            cmd.Parameters.AddWithValue("@start", start + 1);
            cmd.Parameters.AddWithValue("@end", start + pageSize);
            cmd.Parameters.AddWithValue("@user", userId);

            if (range != "")
                cmd.Parameters.AddWithValue("@range", range);

            if (!string.IsNullOrEmpty(search))
                cmd.Parameters.AddWithValue("@search", "%" + search + "%");

            if (!string.IsNullOrEmpty(dealer))
                cmd.Parameters.AddWithValue("@dealer", dealer);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            StringBuilder html = new StringBuilder();

            foreach (DataRow dr in dt.Rows)
            {
                string active = dr["IsWishlisted"].ToString() == "1" ? "active" : "";

                html.Append("<div class='bike-card'>");

                html.Append("<div class='bike-img'>");

                html.Append("<img src='/Uploads/Bikes/" + dr["Image1"] + "'/>");

                html.Append("<div class='wishlist " + active + "' onclick='toggleWishlist(this," + dr["BikeID"] + ")'>♥</div>");

                html.Append("<label class='compare-label'>");

                html.Append("<input type='checkbox' onchange='toggleCompare(this," + dr["BikeID"] + ")'/> Compare");

                html.Append("</label>");

                html.Append("</div>");

                html.Append("<div class='bike-body'>");

                html.Append("<h6>" + dr["ModelName"] + "</h6>");

                html.Append("<div class='price'>₹ " +
                Convert.ToDecimal(dr["Price"]).ToString("N0") +
                "</div>");

                html.Append("<div>Range: " + dr["RangeKM"] + " KM</div>");

                html.Append("<a href='BikeDetails.aspx?slug=" +
                dr["Slug"] +
                "' class='view-btn'>View</a>");

                html.Append("</div>");

                html.Append("</div>");
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

            SqlCommand cmd = new SqlCommand(
            "SELECT BrandID,BrandName FROM Brands WHERE IsActive=1", con);

            SqlDataReader dr = cmd.ExecuteReader();

            StringBuilder html = new StringBuilder();

            while (dr.Read())
            {
                html.Append("<div>");

                html.Append("<input type='checkbox' class='brand-check' value='" +
                dr["BrandID"] +
                "'/> ");

                html.Append(dr["BrandName"]);

                html.Append("</div>");
            }

            return html.ToString();
        }
    }


    [WebMethod(EnableSession = true)]
    public static string ToggleWishlist(int bikeId)
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        if (System.Web.HttpContext.Current.Session["CustomerID"] == null)
        {
            return "login";
        }

        int userId = Convert.ToInt32(System.Web.HttpContext.Current.Session["CustomerID"]);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand check = new SqlCommand(
            "SELECT COUNT(*) FROM Wishlist WHERE CustomerID=@u AND BikeID=@b", con);

            check.Parameters.AddWithValue("@u", userId);
            check.Parameters.AddWithValue("@b", bikeId);

            int exists = Convert.ToInt32(check.ExecuteScalar());

            if (exists > 0)
            {
                SqlCommand delete = new SqlCommand(
                "DELETE FROM Wishlist WHERE CustomerID=@u AND BikeID=@b", con);

                delete.Parameters.AddWithValue("@u", userId);
                delete.Parameters.AddWithValue("@b", bikeId);

                delete.ExecuteNonQuery();

                return "removed";
            }
            else
            {
                SqlCommand insert = new SqlCommand(
                "INSERT INTO Wishlist(CustomerID,BikeID) VALUES(@u,@b)", con);

                insert.Parameters.AddWithValue("@u", userId);
                insert.Parameters.AddWithValue("@b", bikeId);

                insert.ExecuteNonQuery();

                return "added";
            }
        }
    }
}