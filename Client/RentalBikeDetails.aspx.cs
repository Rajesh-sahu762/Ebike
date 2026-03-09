using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

public partial class Client_Default : System.Web.UI.Page
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

SELECT b.*,br.BrandName,
u.UserID,
u.FullName,
u.Mobile,
u.Email,
u.ShopName,
u.City

FROM Bikes b
INNER JOIN Brands br ON b.BrandID=br.BrandID
INNER JOIN Users u ON b.DealerID=u.UserID

WHERE b.Slug=@slug
AND b.IsApproved=1
AND b.IsForRent=1

", con);

            cmd.Parameters.AddWithValue("@slug", slug);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {

                litBikeName.Text = dr["ModelName"].ToString();
                litBrand.Text = dr["BrandName"].ToString();

                decimal rent = Convert.ToDecimal(dr["RentPerDay"]);

                litRentPerDay.Text = rent.ToString("N0");

                ViewState["RentPerDay"] = rent;
                ViewState["BikeID"] = dr["BikeID"].ToString();

                imgMain.ImageUrl = "/Uploads/Bikes/" + dr["Image1"].ToString();

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
                litOverview.Text = dr["Description"] != DBNull.Value
? dr["Description"].ToString()
: "No overview available.";

                string specsHtml = "";

                specsHtml += "<tr><td>Range</td><td>" + dr["RangeKM"] + " KM</td></tr>";
                specsHtml += "<tr><td>Top Speed</td><td>" + dr["TopSpeed"] + " km/h</td></tr>";
                specsHtml += "<tr><td>Charging Time</td><td>" + dr["ChargingTime"] + "</td></tr>";
                specsHtml += "<tr><td>Motor Power</td><td>" + dr["MotorPower"] + "</td></tr>";
                specsHtml += "<tr><td>Battery Type</td><td>" + dr["BatteryType"] + "</td></tr>";

                litSpecsTable.Text = specsHtml;
                litFeatures.Text =
"<div class='feature-item'>No features available</div>";



                // Dealer Info

                litDealerName.Text = dr["ShopName"] != DBNull.Value
                ? dr["ShopName"].ToString()
                : dr["FullName"].ToString();

                litDealerPhone.Text = dr["Mobile"].ToString();

                litDealerEmail.Text = dr["Email"].ToString();

                litDealerCity.Text = dr["City"].ToString();

                ViewState["DealerID"] = dr["UserID"].ToString();

                LoadReviews(dr["BikeID"].ToString());
                LoadSimilarBikes(dr["BrandID"].ToString(), dr["BikeID"].ToString());

                string thumbs = "";
                
                for (int i = 1; i <= 3; i++)
                {

                    string col = "Image" + i;

                    if (dr[col] != DBNull.Value)
                    {

                        thumbs += "<img src='/Uploads/Bikes/" + dr[col] +
                        "' onclick=\"changeImage(this.src)\"/>";

                    }

                }

                litThumbs.Text = thumbs;

            }

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
    void LoadReviews(string bikeId)
    {

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand avgCmd = new SqlCommand(

            "SELECT ISNULL(AVG(CAST(Rating AS FLOAT)),0),COUNT(*) FROM BikeReviews WHERE BikeID=@id AND IsApproved=1",

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

        }
    }


    void LoadSimilarBikes(string brandId, string bikeId)
    {

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(@"

SELECT TOP 10
BikeID,
ModelName,
RentPerDay,
Image1,
Slug

FROM Bikes

WHERE BrandID=@brand
AND BikeID<>@id
AND IsApproved=1
AND IsForRent=1

ORDER BY NEWID()

", con);

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
                + Convert.ToDecimal(dr["RentPerDay"]).ToString("N0")
                + " / Day</div>";

                html += "<a class='similar-btn' href='RentalBikeDetails.aspx?slug="
                + dr["Slug"]
                + "'>View Details</a>";

                html += "</div>";

                html += "</div>";

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
(BikeID,CustomerID,Rating,ReviewTitle,ReviewText,IsApproved,CreatedAt)

VALUES
(@bike,@user,@rating,@title,@text,0,GETDATE())

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

}