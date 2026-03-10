using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web;
using System.Web.Services;

public partial class Dealer_DealerRentalRequests : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }



    [WebMethod(EnableSession = true)]
    public static string GetRentals(string status)
    {

        if (HttpContext.Current.Session["VendorID"] == null)
            return "Login required";

        int dealerId = Convert.ToInt32(HttpContext.Current.Session["VendorID"]);

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        StringBuilder html = new StringBuilder();

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            string q = @"

SELECT
R.RentalID,
R.StartDate,
R.EndDate,
R.TotalDays,
R.RentAmount,
R.Status,
B.ModelName,
B.Image1,
U.FullName,
U.Mobile

FROM RentalBookings R

INNER JOIN Bikes B ON R.BikeID=B.BikeID
INNER JOIN Users U ON R.CustomerID=U.UserID

WHERE R.DealerID=@dealer";

            if (status != "")
                q += " AND R.Status=@status";

            q += " ORDER BY R.CreatedAt DESC";

            SqlCommand cmd = new SqlCommand(q, con);

            cmd.Parameters.AddWithValue("@dealer", dealerId);

            if (status != "")
                cmd.Parameters.AddWithValue("@status", status);

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {

                string s = dr["Status"].ToString().ToLower();

                html.Append("<div class='rental-card'>");

                html.Append("<div class='rental-img'>");
                html.Append("<img src='/Uploads/Bikes/" + dr["Image1"] + "'>");
                html.Append("</div>");

                html.Append("<div class='rental-body'>");

                html.Append("<div class='rental-title'>" + dr["ModelName"] + "</div>");

                html.Append("<div class='rental-customer'>Customer: " + dr["FullName"] + "</div>");

                html.Append("<div class='rental-customer'>Phone: " + dr["Mobile"] + "</div>");

                html.Append("<div class='rental-dates'>Dates: " +
                Convert.ToDateTime(dr["StartDate"]).ToString("dd MMM") +
                " - " +
                Convert.ToDateTime(dr["EndDate"]).ToString("dd MMM") +
                "</div>");

                html.Append("<div class='rental-price'>Total: ₹ " +
                Convert.ToDecimal(dr["RentAmount"]).ToString("N0") +
                "</div>");

                html.Append("<div class='status status-" + s + "'>" + dr["Status"] + "</div>");

                html.Append("<div class='actions'>");

                if (dr["Status"].ToString() == "Pending")
                {

                    html.Append("<button class='btn btn-approve' onclick='updateStatus(" + dr["RentalID"] + ",\"Approved\")'>Approve</button>");

                    html.Append("<button class='btn btn-reject' onclick='updateStatus(" + dr["RentalID"] + ",\"Rejected\")'>Reject</button>");

                }

                if (dr["Status"].ToString() == "Approved")
                {

                    html.Append("<button class='btn btn-start' onclick='updateStatus(" + dr["RentalID"] + ",\"Active\")'>Start</button>");

                }

                if (dr["Status"].ToString() == "Active")
                {

                    html.Append("<button class='btn btn-complete' onclick='updateStatus(" + dr["RentalID"] + ",\"Completed\")'>Complete</button>");

                }
                html.Append("</div>");
                html.Append("</div>");
                html.Append("</div>");

            }

        }

        return html.ToString();

    }


    [WebMethod(EnableSession = true)]
    public static string UpdateStatus(int rentalId, string status)
    {

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();

            SqlCommand cmd = new SqlCommand(

            "UPDATE RentalBookings SET Status=@s WHERE RentalID=@id",

            con);

            cmd.Parameters.AddWithValue("@s", status);
            cmd.Parameters.AddWithValue("@id", rentalId);

            cmd.ExecuteNonQuery();

        }

        return "Rental status updated";

    }

}