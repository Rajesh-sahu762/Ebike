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
        if (Session["VendorID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Dealer")
        {
            Response.Redirect("VendorLogin.aspx");
            return;
        }
    }

    [WebMethod(EnableSession = true)]
    public static string GetRentals(string status)
    {
        if (HttpContext.Current == null ||
            HttpContext.Current.Session == null ||
            HttpContext.Current.Session["VendorID"] == null ||
            HttpContext.Current.Session["Role"] == null ||
            HttpContext.Current.Session["Role"].ToString() != "Dealer")
        {
            return "Login required";
        }

        int dealerId = Convert.ToInt32(HttpContext.Current.Session["VendorID"]);
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
        StringBuilder html = new StringBuilder();

        // Whitelist status filter
        string sanitizedStatus = "";
        if (!string.IsNullOrEmpty(status))
        {
            status = status.Trim();
            if (status == "Pending" || status == "Approved" || status == "Active" ||
                status == "Completed" || status == "Rejected" || status == "Cancelled")
            {
                sanitizedStatus = status;
            }
        }

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

            if (sanitizedStatus != "")
                q += " AND R.Status=@status";

            q += " ORDER BY R.CreatedAt DESC";

            using (SqlCommand cmd = new SqlCommand(q, con))
            {
                cmd.Parameters.AddWithValue("@dealer", dealerId);

                if (sanitizedStatus != "")
                    cmd.Parameters.AddWithValue("@status", sanitizedStatus);

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        string s = dr["Status"].ToString().ToLower();
                        string rawStatus = dr["Status"].ToString();
                        string encodedModel = HttpUtility.HtmlEncode(dr["ModelName"].ToString());
                        string encodedCustomer = HttpUtility.HtmlEncode(dr["FullName"].ToString());
                        string encodedPhone = HttpUtility.HtmlEncode(dr["Mobile"] != DBNull.Value ? dr["Mobile"].ToString() : "");
                        string image1 = HttpUtility.HtmlAttributeEncode(dr["Image1"] != DBNull.Value ? dr["Image1"].ToString() : "");
                        int rentalId = Convert.ToInt32(dr["RentalID"]);

                        html.Append("<div class='rental-card'>");
                        html.Append("<div class='rental-img'>");
                        html.Append("<img src='/Uploads/Bikes/" + image1 + "' alt='" + encodedModel + "'>");
                        html.Append("</div>");

                        html.Append("<div class='rental-body'>");
                        html.Append("<div class='rental-title'>" + encodedModel + "</div>");
                        html.Append("<div class='rental-customer'>Customer: " + encodedCustomer + "</div>");
                        html.Append("<div class='rental-customer'>Phone: " + encodedPhone + "</div>");

                        html.Append("<div class='rental-dates'>Dates: " +
                            Convert.ToDateTime(dr["StartDate"]).ToString("dd MMM") +
                            " - " +
                            Convert.ToDateTime(dr["EndDate"]).ToString("dd MMM") +
                            "</div>");

                        html.Append("<div class='rental-price'>Total: ₹ " +
                            Convert.ToDecimal(dr["RentAmount"]).ToString("N0") +
                            "</div>");

                        html.Append("<div class='status status-" + s + "'>" + HttpUtility.HtmlEncode(rawStatus) + "</div>");
                        html.Append("<div class='actions'>");

                        if (rawStatus == "Pending")
                        {
                            html.Append("<button class='btn btn-approve' onclick='updateStatus(" + rentalId + ",\"Approved\")'>Approve</button>");
                            html.Append("<button class='btn btn-reject' onclick='updateStatus(" + rentalId + ",\"Rejected\")'>Reject</button>");
                        }
                        else if (rawStatus == "Approved")
                        {
                            html.Append("<button class='btn btn-start' onclick='updateStatus(" + rentalId + ",\"Active\")'>Start</button>");
                        }
                        else if (rawStatus == "Active")
                        {
                            html.Append("<button class='btn btn-complete' onclick='updateStatus(" + rentalId + ",\"Completed\")'>Complete</button>");
                        }

                        html.Append("</div>");
                        html.Append("</div>");
                        html.Append("</div>");
                    }
                }
            }
        }

        return html.ToString();
    }

    [WebMethod(EnableSession = true)]
    public static string UpdateStatus(int rentalId, string status)
    {
        if (HttpContext.Current == null ||
            HttpContext.Current.Session == null ||
            HttpContext.Current.Session["VendorID"] == null ||
            HttpContext.Current.Session["Role"] == null ||
            HttpContext.Current.Session["Role"].ToString() != "Dealer")
        {
            return "Unauthorized";
        }

        int dealerId = Convert.ToInt32(HttpContext.Current.Session["VendorID"]);

        // Whitelist allowed target status values
        if (status != "Approved" && status != "Rejected" && status != "Active" &&
            status != "Completed" && status != "Cancelled")
        {
            return "Invalid status";
        }

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // Enforce dealer ownership check
            SqlCommand cmd = new SqlCommand(
                "UPDATE RentalBookings SET Status=@s WHERE RentalID=@id AND DealerID=@dealerId",
                con);

            cmd.Parameters.AddWithValue("@s", status);
            cmd.Parameters.AddWithValue("@id", rentalId);
            cmd.Parameters.AddWithValue("@dealerId", dealerId);

            int rows = cmd.ExecuteNonQuery();
            if (rows == 0)
            {
                return "Rental request not found or access denied";
            }
        }

        return "Rental status updated";
    }
}
