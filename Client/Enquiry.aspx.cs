using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web;

public partial class Client_Enquiry : System.Web.UI.Page
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

SELECT b.*,u.FullName,u.Mobile,u.City,u.ShopName

FROM Bikes b
INNER JOIN Users u ON b.DealerID=u.UserID

WHERE b.Slug=@slug", con);

            cmd.Parameters.AddWithValue("@slug", slug);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {

                litBikeName.Text = dr["ModelName"].ToString();
                litPrice.Text = Convert.ToDecimal(dr["Price"]).ToString("N0");

                imgBike.ImageUrl = "/Uploads/Bikes/" + dr["Image1"];

                litRange.Text = dr["RangeKM"] + " KM";
                litSpeed.Text = dr["TopSpeed"] + " km/h";
                litCharge.Text = dr["ChargingTime"].ToString();

                litDealerName.Text = dr["ShopName"] != DBNull.Value
                ? dr["ShopName"].ToString()
                : dr["FullName"].ToString();

                litDealerPhone.Text = dr["Mobile"].ToString();
                litDealerCity.Text = dr["City"].ToString();

                Session["EnquiryBikeID"] = dr["BikeID"];

            }

        }

    }

    [WebMethod]

    public static string SubmitLead(string message)
    {

        if (HttpContext.Current.Session["CustomerID"] == null)
            return "login";

        int userId = Convert.ToInt32(HttpContext.Current.Session["CustomerID"]);
        int bikeId = Convert.ToInt32(HttpContext.Current.Session["EnquiryBikeID"]);

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            // ===== DUPLICATE CHECK (24 HOURS) =====

            SqlCommand dup = new SqlCommand(@"
SELECT COUNT(*)
FROM Leads
WHERE CustomerID=@u
AND BikeID=@b
AND CreatedAt > DATEADD(HOUR,-24,GETDATE())", con);

            dup.Parameters.AddWithValue("@u", userId);
            dup.Parameters.AddWithValue("@b", bikeId);

            if (Convert.ToInt32(dup.ExecuteScalar()) > 0)
                return "duplicate";


            // ===== DAILY LIMIT =====

            SqlCommand limit = new SqlCommand(@"
SELECT COUNT(*)
FROM Leads
WHERE CustomerID=@u
AND CreatedAt > DATEADD(DAY,-1,GETDATE())", con);

            limit.Parameters.AddWithValue("@u", userId);

            if (Convert.ToInt32(limit.ExecuteScalar()) >= 5)
                return "limit";

            int exists = Convert.ToInt32(check.ExecuteScalar());

            if (exists > 0)
                return "exists";

            SqlCommand cmd = new SqlCommand(@"

INSERT INTO Leads
(BikeID,CustomerID,Message,CreatedAt)

VALUES

(@bike,@user,@msg,GETDATE())", con);

            cmd.Parameters.AddWithValue("@bike", bikeId);
            cmd.Parameters.AddWithValue("@user", userId);
            cmd.Parameters.AddWithValue("@msg", message);

            cmd.ExecuteNonQuery();

        }

        return "ok";

    }

}