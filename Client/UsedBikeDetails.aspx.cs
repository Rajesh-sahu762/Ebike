using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web;

public partial class Client_UsedBikeDetails : System.Web.UI.Page
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

    void LoadBike(string slug)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"

SELECT 
B.*,
U.UserID,
U.FullName,
U.Mobile,
U.Email,
U.City

FROM Bikes B
INNER JOIN Users U ON B.DealerID = U.UserID

WHERE B.Slug=@slug
AND B.IsUsed=1

", con);

            cmd.Parameters.AddWithValue("@slug", slug);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                litBikeName.Text = dr["ModelName"].ToString();

                decimal price = Convert.ToDecimal(dr["Price"]);

                litPrice.Text = price.ToString("N0");

                litStickyName.Text = dr["ModelName"].ToString();
                litStickyPrice.Text = price.ToString("N0");

                ViewState["BikeID"] = dr["BikeID"].ToString();
                ViewState["Price"] = price;

                imgMain.ImageUrl = "/Uploads/Bikes/" + dr["Image1"].ToString();

                // Seller Info

                litDealerName.Text = dr["FullName"].ToString();
                litDealerPhone.Text = dr["Mobile"].ToString();
                litDealerEmail.Text = dr["Email"].ToString();
                litDealerCity.Text = dr["City"].ToString();

                ViewState["DealerID"] = dr["UserID"].ToString();

                // Used Bike Specs

                litKMHighlight.Text = litRange.Text;
                litYearHighlight.Text = litSpeed.Text;
                litOwnerHighlight.Text = litCharge.Text;
                litConditionHighlight.Text = litMotor.Text;

                litRange.Text = dr["KMDriven"] == DBNull.Value ? "N/A" : dr["KMDriven"] + " KM";

                litSpeed.Text = dr["ManufactureYear"] == DBNull.Value ? "N/A" : dr["ManufactureYear"].ToString();

                litCharge.Text = dr["OwnerNumber"] == DBNull.Value ? "N/A" : dr["OwnerNumber"] + " Owner";

                litMotor.Text = dr["BikeCondition"] == DBNull.Value ? "N/A" : dr["BikeCondition"].ToString();

                // Overview

                litOverview.Text = dr["Description"] != DBNull.Value
                ? dr["Description"].ToString()
                : "No description available.";

                string specs = "";

                specs += "<tr><td>KM Driven</td><td>" + dr["KMDriven"] + " KM</td></tr>";
                specs += "<tr><td>Manufacture Year</td><td>" + dr["ManufactureYear"] + "</td></tr>";
                specs += "<tr><td>Owner</td><td>" + dr["OwnerNumber"] + "</td></tr>";
                specs += "<tr><td>Condition</td><td>" + dr["BikeCondition"] + "</td></tr>";
                specs += "<tr><td>Battery Health</td><td>" + dr["BatteryHealth"] + "</td></tr>";

                litSpecsTable.Text = specs;

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

                litBrand.Text = "Used Bike Seller";
                litRating.Text = "★ Used Bike";

                LoadSimilarUsedBikes(dr["BikeID"].ToString());

                Session["BikeID"] = dr["BikeID"];

                LoadReviews(dr["BikeID"].ToString());
            }
        }
    }

    void LoadReviews(string bikeId)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand avgCmd = new SqlCommand(
            "SELECT ISNULL(AVG(CAST(Rating AS FLOAT)),0), COUNT(*) FROM BikeReviews WHERE BikeID=@id",
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

            SqlCommand cmd = new SqlCommand(@"

SELECT TOP 5
ReviewTitle,
ReviewText,
Rating

FROM BikeReviews
WHERE BikeID=@id
ORDER BY CreatedAt DESC

", con);

            cmd.Parameters.AddWithValue("@id", bikeId);

            SqlDataReader dr = cmd.ExecuteReader();

            string html = "";

            while (dr.Read())
            {
                html += "<div class='review-item'>";

                html += "<h4>" + dr["ReviewTitle"] + "</h4>";

                html += "<div class='stars'>" + BuildStars(Convert.ToInt32(dr["Rating"])) + "</div>";

                html += "<p>" + dr["ReviewText"] + "</p>";

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

    void LoadSimilarUsedBikes(string bikeId)
{
    using (SqlConnection con = new SqlConnection(constr))
    {
        con.Open();

        SqlCommand cmd = new SqlCommand(@"

SELECT TOP 10
BikeID,
ModelName,
Price,
Image1,
Slug

FROM Bikes

WHERE IsUsed = 1
AND IsApproved = 1
AND BikeID <> @id

ORDER BY CreatedAt DESC

", con);

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

            html += "<a class='similar-btn' href='UsedBikeDetails.aspx?slug="
            + dr["Slug"] + "'>View Details</a>";

            html += "</div></div>";
        }

        litSimilarBikes.Text = html;
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

            SqlCommand check = new SqlCommand(
            "SELECT COUNT(*) FROM BikeReviews WHERE CustomerID=@u AND BikeID=@b", con);

            check.Parameters.AddWithValue("@u", userId);
            check.Parameters.AddWithValue("@b", bikeId);

            int exists = Convert.ToInt32(check.ExecuteScalar());

            if (exists > 0)
                return "exists";

            SqlCommand cmd = new SqlCommand(@"

INSERT INTO BikeReviews
(BikeID,CustomerID,Rating,ReviewTitle,ReviewText,CreatedAt)
VALUES
(@bike,@user,@rating,@title,@text,GETDATE())

", con);

            cmd.Parameters.AddWithValue("@bike", bikeId);
            cmd.Parameters.AddWithValue("@user", userId);
            cmd.Parameters.AddWithValue("@rating", rating);
            cmd.Parameters.AddWithValue("@title", title);
            cmd.Parameters.AddWithValue("@text", review);

            cmd.ExecuteNonQuery();
        }

        return "ok";
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
}