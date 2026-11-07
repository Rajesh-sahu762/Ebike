using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.Web.Caching;
using System.Web.Services;

public partial class Client_Bikes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string keyword = Request.QueryString["search"];
            if (!string.IsNullOrEmpty(keyword))
                hfSearch.Value = keyword;

            string category = Request.QueryString["category"];
            if (!string.IsNullOrEmpty(category)) hfCategory.Value = category.Trim().ToLowerInvariant();

            string dealer = Request.QueryString["dealer"];
            if (!string.IsNullOrEmpty(dealer))
                hfDealer.Value = dealer;

            CheckAndExpireSubscriptions();
        }
    }

    private void CheckAndExpireSubscriptions()
    {
        const string cacheKey = "LastBikeExpiryCheck";
        if (HttpRuntime.Cache[cacheKey] == null)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString))
                {
                    con.Open();

                    using (SqlCommand cmd1 = new SqlCommand("UPDATE DealerSubscriptions SET IsActive=0 WHERE EndDate < GETDATE() AND IsActive=1", con))
                    {
                        cmd1.ExecuteNonQuery();
                    }

                    using (SqlCommand cmd2 = new SqlCommand("UPDATE FeaturedBikes SET IsActive=0 WHERE EndDate < GETDATE() AND IsActive=1", con))
                    {
                        cmd2.ExecuteNonQuery();
                    }
                }
            }
            catch { }

            // Throttle to run at most once every 15 minutes
            HttpRuntime.Cache.Insert(cacheKey, true, null, DateTime.Now.AddMinutes(15), Cache.NoSlidingExpiration);
        }
    }

    [WebMethod(EnableSession = true)]
    public static object GetBikes(int page, int minPrice, int maxPrice,
     string range, string sort, string[] brands, string search, string dealer, string category)
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        int pageSize = 6;
        int start = (page - 1) * pageSize;

        int userId = 0;
        if (HttpContext.Current != null &&
            HttpContext.Current.Session != null &&
            HttpContext.Current.Session["CustomerID"] != null)
        {
            userId = Convert.ToInt32(HttpContext.Current.Session["CustomerID"]);
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string order = "B.CreatedAt DESC";
            if (sort == "priceAsc") order = "B.Price ASC";
            if (sort == "priceDesc") order = "B.Price DESC";

            // Parameterize brands array to prevent SQL injection
            List<int> validBrandIds = new List<int>();
            if (brands != null)
            {
                foreach (string b in brands)
                {
                    int bId;
                    if (int.TryParse(b, out bId))
                        validBrandIds.Add(bId);
                }
            }

            string brandFilter = "";
            if (validBrandIds.Count > 0)
            {
                List<string> pNames = new List<string>();
                for (int i = 0; i < validBrandIds.Count; i++)
                {
                    pNames.Add("@brand" + i);
                }
                brandFilter = " AND B.BrandID IN (" + string.Join(",", pNames) + ")";
            }

            string dealerFilter = "";
            int dealerIdVal = 0;
            bool hasDealer = !string.IsNullOrEmpty(dealer) && int.TryParse(dealer, out dealerIdVal);
            if (hasDealer)
                dealerFilter = " AND B.DealerID=@dealer";


            string searchFilter = "";
            if (!string.IsNullOrEmpty(search))
                searchFilter = " AND (B.ModelName LIKE @search OR B.Description LIKE @search)";

            // Whitelisted category rules mirror the homepage's inference logic.
            string categoryFilter = "";
            string categoryText = "LOWER(ISNULL(B.ModelName,'') + ' ' + ISNULL(B.Description,''))";
            switch ((category ?? "").Trim().ToLowerInvariant())
            {
                case "electric-bikes":
                    categoryFilter = " AND " + categoryText + " NOT LIKE '%scooter%' AND " + categoryText + " NOT LIKE '%moped%' AND " + categoryText + " NOT LIKE '%off-road%' AND " + categoryText + " NOT LIKE '%off road%' AND " + categoryText + " NOT LIKE '%dirt bike%' AND " + categoryText + " NOT LIKE '%enduro%' AND " + categoryText + " NOT LIKE '%trail riding%' AND " + categoryText + " NOT LIKE '%ather 450%' AND " + categoryText + " NOT LIKE '%ather rizta%' AND " + categoryText + " NOT LIKE '%ola s1%' AND " + categoryText + " NOT LIKE '%vida v2%' AND " + categoryText + " NOT LIKE '%tvs iqube%' AND " + categoryText + " NOT LIKE '%activa e%'";
                    break;
                case "electric-scooters":
                    categoryFilter = " AND (" + categoryText + " LIKE '%scooter%' OR " + categoryText + " LIKE '%ather 450%' OR " + categoryText + " LIKE '%ather rizta%' OR " + categoryText + " LIKE '%ola s1%' OR " + categoryText + " LIKE '%vida v2%' OR " + categoryText + " LIKE '%tvs iqube%' OR " + categoryText + " LIKE '%activa e%')";
                    break;
                case "mopeds": categoryFilter = " AND " + categoryText + " LIKE '%moped%'"; break;
                case "off-road-evs":
                    categoryFilter = " AND (" + categoryText + " LIKE '%off-road%' OR " + categoryText + " LIKE '%off road%' OR " + categoryText + " LIKE '%dirt bike%' OR " + categoryText + " LIKE '%enduro%' OR " + categoryText + " LIKE '%trail riding%')";
                    break;
                case "daily-commute":
                    categoryFilter = " AND (" + categoryText + " LIKE '%commut%' OR " + categoryText + " LIKE '%urban%' OR " + categoryText + " LIKE '%city ride%' OR " + categoryText + " LIKE '%daily ride%' OR " + categoryText + " LIKE '%family-friendly%' OR " + categoryText + " LIKE '%everyday ride%')";
                    break;
                case "long-range":
                    categoryFilter = " AND (ISNULL(B.RangeKM,0)>=150 OR " + categoryText + " LIKE '%long range%' OR " + categoryText + " LIKE '%extended range%')";
                    break;
            }

            string query =
@"SELECT * FROM (
 SELECT ROW_NUMBER() OVER (ORDER BY 
 CASE WHEN FB.IsActive=1 THEN 1 ELSE 2 END,
 CASE WHEN DS.IsActive=1 THEN 1 ELSE 2 END,
 " + order + @") AS RowNum,
 B.BikeID,B.ModelName,B.Price,B.RangeKM,B.Image1,B.Slug,
 CASE WHEN W.BikeID IS NULL THEN 0 ELSE 1 END AS IsWishlisted
 FROM Bikes B 
 LEFT JOIN Wishlist W ON B.BikeID=W.BikeID AND W.CustomerID=@user 
 LEFT JOIN FeaturedBikes FB ON B.BikeID=FB.BikeID AND FB.IsActive=1 AND FB.EndDate>=GETDATE() 
 LEFT JOIN DealerSubscriptions DS ON B.DealerID=DS.DealerID AND DS.IsActive=1 AND DS.EndDate>=GETDATE() 
 WHERE B.IsApproved=1 
 AND ISNULL(B.IsUsed,0)=0 
 AND ISNULL(B.IsForRent,0)=0 
 AND B.Price BETWEEN @min AND @max" +
brandFilter +
dealerFilter +
searchFilter +
categoryFilter +
(!string.IsNullOrEmpty(range) ? " AND B.RangeKM<=@range" : "") +
@") X WHERE RowNum BETWEEN @start AND @end";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@min", minPrice);
            cmd.Parameters.AddWithValue("@max", maxPrice);
            cmd.Parameters.AddWithValue("@start", start + 1);
            cmd.Parameters.AddWithValue("@end", start + pageSize);
            cmd.Parameters.AddWithValue("@user", userId);

            // Add parameterized brand IDs
            for (int i = 0; i < validBrandIds.Count; i++)
            {
                cmd.Parameters.AddWithValue("@brand" + i, validBrandIds[i]);
            }

            int rangeVal;
            if (!string.IsNullOrEmpty(range) && int.TryParse(range, out rangeVal))
                cmd.Parameters.AddWithValue("@range", rangeVal);
            else if (!string.IsNullOrEmpty(range))
                cmd.Parameters.AddWithValue("@range", 999999);

            if (!string.IsNullOrEmpty(search))
                cmd.Parameters.AddWithValue("@search", "%" + search.Trim() + "%");

            if (hasDealer)
                cmd.Parameters.AddWithValue("@dealer", dealerIdVal);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            StringBuilder html = new StringBuilder();

            if (dt.Rows.Count == 0)
            {
                html.Append("<div style='grid-column:1/-1;text-align:center;padding:40px;font-weight:600;'>No Bikes Found</div>");
            }
            else
            {
                foreach (DataRow dr in dt.Rows)
                {
                    string active = dr["IsWishlisted"].ToString() == "1" ? "active" : "";
                    string encodedModel = HttpUtility.HtmlEncode(dr["ModelName"].ToString());
                    string encodedSlug = HttpUtility.HtmlAttributeEncode(dr["Slug"] != DBNull.Value ? dr["Slug"].ToString() : "");
                    string image1 = HttpUtility.HtmlAttributeEncode(dr["Image1"] != DBNull.Value ? dr["Image1"].ToString() : "");
                    int bikeId = Convert.ToInt32(dr["BikeID"]);

                    html.Append("<div class='bike-card'>");
                    html.Append("<div class='bike-img'>");
                    html.Append("<img src='/Uploads/Bikes/" + image1 + "' alt='" + encodedModel + "'/>");
                    html.Append("<div class='wishlist " + active + "' onclick='toggleWishlist(this," + bikeId + ")'>♥</div>");
                    html.Append("<label class='compare-label'>");
                    html.Append("<input type='checkbox' onchange='toggleCompare(this," + bikeId + ")'/> Compare");
                    html.Append("</label>");
                    html.Append("</div>");

                    html.Append("<div class='bike-body'>");
                    html.Append("<h6>" + encodedModel + "</h6>");
                    html.Append("<div class='price'>₹ " +
                        Convert.ToDecimal(dr["Price"]).ToString("N0") +
                        " /-</div>");
                    html.Append("<div>Range: " + HttpUtility.HtmlEncode(dr["RangeKM"].ToString()) + " KM</div>");
                    html.Append("<a href='BikeDetails.aspx?slug=" + encodedSlug + "' class='view-btn'>View</a>");
                    html.Append("</div>");
                    html.Append("</div>");
                }
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
                int bId = Convert.ToInt32(dr["BrandID"]);
                string bName = HttpUtility.HtmlEncode(dr["BrandName"].ToString());

                html.Append("<div>");
                html.Append("<input type='checkbox' class='brand-check' value='" + bId + "'/> ");
                html.Append(bName);
                html.Append("</div>");
            }

            return html.ToString();
        }
    }

    [WebMethod(EnableSession = true)]
    public static string ToggleWishlist(int bikeId)
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        if (HttpContext.Current == null ||
            HttpContext.Current.Session == null ||
            HttpContext.Current.Session["CustomerID"] == null)
        {
            return "login";
        }

        int userId = Convert.ToInt32(HttpContext.Current.Session["CustomerID"]);

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

    [WebMethod(EnableSession = true)]
    public static int GetWishlistCount()
    {
        if (HttpContext.Current == null ||
            HttpContext.Current.Session == null ||
            HttpContext.Current.Session["CustomerID"] == null)
        {
            return 0;
        }

        int userId = Convert.ToInt32(HttpContext.Current.Session["CustomerID"]);
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT COUNT(*) FROM Wishlist WHERE CustomerID=@id", con);
            cmd.Parameters.AddWithValue("@id", userId);

            return Convert.ToInt32(cmd.ExecuteScalar());
        }
    }
}
