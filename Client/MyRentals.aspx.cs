using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.Services;
using System.Web;

public partial class Client_MyRentals : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod(EnableSession = true)]
    public static string GetRentals(string status)
    {

        if (HttpContext.Current.Session["CustomerID"] == null)
            return "<div class='empty'>Please login first</div>";

        int userId = Convert.ToInt32(HttpContext.Current.Session["CustomerID"]);

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        StringBuilder html = new StringBuilder();

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            string query = @"

SELECT 
R.RentalID,
R.StartDate,
R.EndDate,
R.TotalDays,
R.RentAmount,
R.Status,

B.ModelName,
B.Image1

FROM RentalBookings R

INNER JOIN Bikes B
ON R.BikeID = B.BikeID

WHERE R.CustomerID=@user

";

            if (!string.IsNullOrEmpty(status))
                query += " AND R.Status=@status";

            query += " ORDER BY R.CreatedAt DESC";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@user", userId);

            if (!string.IsNullOrEmpty(status))
                cmd.Parameters.AddWithValue("@status", status);

            SqlDataReader dr = cmd.ExecuteReader();

            if (!dr.HasRows)
                return "<div class='empty'>No rentals found</div>";

            while (dr.Read())
            {

                string statusClass = dr["Status"].ToString().ToLower();

                html.Append("<div class='rental-card'>");

                html.Append("<div class='rental-img'>");
                html.Append("<img src='/Uploads/Bikes/" + dr["Image1"] + "'>");
                html.Append("</div>");

                html.Append("<div class='rental-body'>");

                html.Append("<div class='rental-name'>" + dr["ModelName"] + "</div>");

                html.Append("<div class='rental-dates'>" +
                Convert.ToDateTime(dr["StartDate"]).ToString("dd MMM") + " - " +
                Convert.ToDateTime(dr["EndDate"]).ToString("dd MMM") +
                "</div>");

                html.Append("<div class='rental-price'>₹ " +
                Convert.ToDecimal(dr["RentAmount"]).ToString("N0") +
                "</div>");

                html.Append("<div class='status status-" + statusClass + "'>" +
                dr["Status"] +
                "</div>");

                if (dr["Status"].ToString() == "Pending")
                {

                    html.Append("<div class='rental-actions'>");

                    html.Append("<button class='btn-cancel' onclick='cancelRental(" +
                    dr["RentalID"] + ")'>Cancel</button>");

                    html.Append("</div>");

                }

                html.Append("</div>");

                html.Append("</div>");

            }

        }

        return html.ToString();

    }


    [WebMethod(EnableSession = true)]
    public static string CancelRental(int rentalId)
    {

        if (HttpContext.Current.Session["CustomerID"] == null)
            return "Login required";

        int userId = Convert.ToInt32(HttpContext.Current.Session["CustomerID"]);

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(@"

UPDATE RentalBookings

SET Status='Cancelled'

WHERE RentalID=@id
AND CustomerID=@user
AND Status='Pending'

", con);

            cmd.Parameters.AddWithValue("@id", rentalId);
            cmd.Parameters.AddWithValue("@user", userId);

            cmd.ExecuteNonQuery();

        }

        return "Rental cancelled";

    }

}