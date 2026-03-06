using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web;

public partial class Client_BikeDetails : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string slug = Request.QueryString["slug"];

            if (!string.IsNullOrEmpty(slug))
            {
                LoadBike(slug);
            }
        }
    }

    [WebMethod]
    public static string SubmitReview(int rating, string title, string review)
    {
        if (HttpContext.Current.Session["CustomerID"] == null)
            return "login";

        int userId = Convert.ToInt32(HttpContext.Current.Session["CustomerID"]);
        int bikeId = Convert.ToInt32(HttpContext.Current.Session["BikeID"]);

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // check duplicate review
            SqlCommand check = new SqlCommand(
            "SELECT COUNT(*) FROM BikeReviews WHERE CustomerID=@u AND BikeID=@b", con);

            check.Parameters.AddWithValue("@u", userId);
            check.Parameters.AddWithValue("@b", bikeId);

            int exists = Convert.ToInt32(check.ExecuteScalar());

            if (exists > 0)
                return "exists";

            SqlCommand cmd = new SqlCommand(@"
        INSERT INTO BikeReviews
        (BikeID,CustomerID,Rating,ReviewTitle,ReviewText,IsApproved,CreatedAt)
        VALUES
        (@bike,@user,@rating,@title,@text,0,GETDATE())", con);

            cmd.Parameters.AddWithValue("@bike", bikeId);
            cmd.Parameters.AddWithValue("@user", userId);
            cmd.Parameters.AddWithValue("@rating", rating);
            cmd.Parameters.AddWithValue("@title", title);
            cmd.Parameters.AddWithValue("@text", review);

            cmd.ExecuteNonQuery();
        }

        return "ok";
    }



    void LoadBike(string slug)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            SELECT b.*, br.BrandName,
u.UserID,
u.FullName,
u.Mobile,
u.Email,
u.ShopName,
u.City
FROM Bikes b
INNER JOIN Brands br ON b.BrandID = br.BrandID
INNER JOIN Users u ON b.DealerID = u.UserID
WHERE b.Slug=@slug AND b.IsApproved=1", con);

            cmd.Parameters.AddWithValue("@slug", slug);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                litBikeName.Text = dr["ModelName"].ToString();
                litBrand.Text = dr["BrandName"].ToString();

                decimal price = Convert.ToDecimal(dr["Price"]);
                litPrice.Text = price.ToString("N0");

                litStickyName.Text = dr["ModelName"].ToString();
                litStickyPrice.Text = price.ToString("N0");

                // Dealer Info

                litDealerName.Text = dr["ShopName"] != DBNull.Value
                ? dr["ShopName"].ToString()
                : dr["FullName"].ToString();

                litDealerPhone.Text = dr["Mobile"].ToString();
                litDealerEmail.Text = dr["Email"].ToString();
                litDealerCity.Text = dr["City"].ToString();
                ViewState["DealerID"] = dr["UserID"].ToString();

                imgMain.ImageUrl = "/Uploads/Bikes/" + dr["Image1"].ToString();

                ViewState["BikeID"] = dr["BikeID"].ToString();
                ViewState["Price"] = price;

                // Highlights

                litRange.Text = dr["RangeKM"] != DBNull.Value
                    ? dr["RangeKM"].ToString() + " KM"
                    : "N/A";

                litSpeed.Text = dr["TopSpeed"] != DBNull.Value
                    ? dr["TopSpeed"].ToString() + " km/h"
                    : "N/A";

                litCharge.Text = dr["ChargingTime"] != DBNull.Value
                    ? dr["ChargingTime"].ToString()
                    : "N/A";

                litMotor.Text = dr["MotorPower"] != DBNull.Value
                    ? dr["MotorPower"].ToString()
                    : "N/A";

                // Thumbnails
                string thumbs = "";

                for (int i = 1; i <= 3; i++)
                {
                    string col = "Image" + i;

                    if (dr[col] != DBNull.Value && dr[col].ToString() != "")
                    {
                        thumbs += "<img src='/Uploads/Bikes/" +
                                  dr[col] +
                                  "' onclick=\"changeImage(this.src)\" />";
                    }
                }

                litThumbs.Text = thumbs;

                // Dummy rating (replace later with review table)
                litRating.Text = "★ 4.5 (124 Reviews)";


                // Overview
                litOverview.Text = dr["Description"] != DBNull.Value
                    ? dr["Description"].ToString()
                    : "No overview available.";


                // Specifications (basic example)
                string specsHtml = "";

                specsHtml += "<tr><td>Range</td><td>" + dr["RangeKM"] + " KM</td></tr>";
                specsHtml += "<tr><td>Top Speed</td><td>" + dr["TopSpeed"] + " km/h</td></tr>";
                specsHtml += "<tr><td>Charging Time</td><td>" + dr["ChargingTime"] + "</td></tr>";
                specsHtml += "<tr><td>Motor Power</td><td>" + dr["MotorPower"] + "</td></tr>";
                specsHtml += "<tr><td>Battery Type</td><td>" + dr["BatteryType"] + "</td></tr>";

                litSpecsTable.Text = specsHtml;


                if (dr.GetSchemaTable().Columns.Contains("Features"))
                {
                    if (dr["Features"] != DBNull.Value)
                    {
                        string featuresRaw = dr["Features"].ToString();

                        if (!string.IsNullOrEmpty(featuresRaw))
                        {
                            string[] features = featuresRaw.Split(',');

                            string featureHtml = "";

                            foreach (string f in features)
                            {
                                featureHtml += "<div class='feature-item'>✔ " + f.Trim() + "</div>";
                            }

                            litFeatures.Text = featureHtml;
                        }
                    }
                }
                else
                {
                    litFeatures.Text = "<div class='feature-item'>No features available</div>";
                }
                LoadSimilarBikes(dr["BrandID"].ToString(), dr["BikeID"].ToString());
                LoadReviews(dr["BikeID"].ToString());
                Session["BikeID"] = dr["BikeID"];
            }
        }
    }

    [WebMethod]
    public static string ToggleWishlist(int bikeId)
    {
        if (HttpContext.Current.Session["CustomerID"] == null)
            return "login";

        int userId = Convert.ToInt32(HttpContext.Current.Session["CustomerID"]);

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

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


    [WebMethod]
    public static string CheckWishlist(int bikeId)
    {
        if (HttpContext.Current.Session["CustomerID"] == null)
            return "no";

        int userId = Convert.ToInt32(HttpContext.Current.Session["CustomerID"]);

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT COUNT(*) FROM Wishlist WHERE CustomerID=@u AND BikeID=@b", con);

            cmd.Parameters.AddWithValue("@u", userId);
            cmd.Parameters.AddWithValue("@b", bikeId);

            int exists = Convert.ToInt32(cmd.ExecuteScalar());

            if (exists > 0)
                return "yes";
            else
                return "no";
        }
    }

    void LoadSimilarBikes(string brandId, string bikeId)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
        SELECT TOP 10 BikeID, ModelName, Price, Image1, Slug
        FROM Bikes
        WHERE BrandID=@brand
        AND BikeID<>@id
        AND IsApproved=1
        ORDER BY NEWID()", con);

            cmd.Parameters.AddWithValue("@brand", brandId);
            cmd.Parameters.AddWithValue("@id", bikeId);

            SqlDataReader dr = cmd.ExecuteReader();

            string html = "";

            while (dr.Read())
            {
                html += "<div class='similar-card'>";

                html += "<div class='similar-img'>";
                html += "<img src='/Uploads/Bikes/" + dr["Image1"] + "'>";
                html += "</div>";

                html += "<div class='similar-body'>";

                html += "<div class='similar-name'>" + dr["ModelName"] + "</div>";

                html += "<div class='similar-price'>₹ "
                + Convert.ToDecimal(dr["Price"]).ToString("N0") + "</div>";

                html += "<a class='similar-btn' href='BikeDetails.aspx?slug="
                + dr["Slug"] + "'>View Details</a>";

                html += "</div></div>";
            }

            litSimilarBikes.Text = html;
        }
    }

    void LoadReviews(string bikeId)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // AVG RATING

            SqlCommand avgCmd = new SqlCommand(
            "SELECT ISNULL(AVG(CAST(Rating AS FLOAT)),0), COUNT(*) FROM BikeReviews WHERE BikeID=@id AND IsApproved=1",
            con);

            avgCmd.Parameters.AddWithValue("@id", bikeId);

            SqlDataReader avgDr = avgCmd.ExecuteReader();

            double avg = 0;
            int count = 0;

            if (avgDr.Read())
            {
                avg = Convert.ToDouble(avgDr[0]);
                count = Convert.ToInt32(avgDr[1]);
            }

            avgDr.Close();

            litAvgRating.Text = avg.ToString("0.0");
            litAvgStars.Text = BuildStars(avg);
            litReviewCount.Text = count + " Reviews";

            // RATING BREAKDOWN

            string breakdownHtml = "";

            for (int i = 5; i >= 1; i--)
            {
                SqlCommand cmd = new SqlCommand(
                "SELECT COUNT(*) FROM BikeReviews WHERE BikeID=@id AND Rating=@r AND IsApproved=1",
                con);

                cmd.Parameters.AddWithValue("@id", bikeId);
                cmd.Parameters.AddWithValue("@r", i);

                int starCount = Convert.ToInt32(cmd.ExecuteScalar());

                int percent = count == 0 ? 0 : (starCount * 100 / count);

                breakdownHtml +=
                "<div class='breakdown-row'>" +
                i + " ★" +
                "<div class='breakdown-bar'>" +
                "<div class='breakdown-fill' style='width:" + percent + "%'></div>" +
                "</div>" +
                "<span>" + starCount + "</span>" +
                "</div>";
            }

            litBreakdown.Text = breakdownHtml;


            // =========================
            // RECENT REVIEWS
            // =========================

            SqlCommand reviewCmd = new SqlCommand(@"

        SELECT TOP 5
        ReviewTitle,
        ReviewText,
        Rating

        FROM BikeReviews

        WHERE BikeID=@id
        AND IsApproved=1

        ORDER BY CreatedAt DESC

        ", con);

            reviewCmd.Parameters.AddWithValue("@id", bikeId);

            SqlDataReader dr = reviewCmd.ExecuteReader();

            string html = "";

            while (dr.Read())
            {
                html += "<div class='review-card'>";

                html += "<div class='review-user'>";

                html += "<div class='user-avatar'>"
                + dr["ReviewTitle"].ToString().Substring(0, 1)
                + "</div>";

                html += "<div>";

                html += "<div class='review-stars'>"
                + BuildStars(Convert.ToInt32(dr["Rating"]))
                + "</div>";

                html += "<div class='review-title'>"
                + dr["ReviewTitle"] +
                "</div>";

                html += "</div>";

                html += "</div>";

                html += "<div class='review-text'>"
                + dr["ReviewText"] +
                "</div>";

                html += "</div>";
            }

            litRecentReviews.Text = html;
        }
    }

    string BuildStars(double rating)
    {
        string stars = "";

        for (int i = 1; i <= 5; i++)
        {
            if (i <= Math.Round(rating))
                stars += "★";
            else
                stars += "☆";
        }

        return stars;
    }
}