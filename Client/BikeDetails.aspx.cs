using System;
using System.Data.SqlClient;
using System.Configuration;

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

    void LoadBike(string slug)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            SELECT b.*, br.BrandName
            FROM Bikes b
            INNER JOIN Brands br ON b.BrandID = br.BrandID
            WHERE b.Slug=@slug AND b.IsApproved=1", con);

            cmd.Parameters.AddWithValue("@slug", slug);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                litBikeName.Text = dr["ModelName"].ToString();
                litBrand.Text = dr["BrandName"].ToString();

                decimal price = Convert.ToDecimal(dr["Price"]);
                litPrice.Text = price.ToString("N0");

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
            }
        }
    }
}