using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web;
using System.Web.Services;
using System.IO;

public partial class Dealer_DealerRentalRequests : System.Web.UI.Page
{
    private static string ConnectionString
    {
        get { return ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
        {
            Response.Redirect("VendorLogin.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
    }

    [WebMethod(EnableSession = true)]
    public static string GetRentals(string status)
    {
        HttpContext context = HttpContext.Current;
        if (context == null || context.Session == null || context.Session["VendorID"] == null)
            return "Login required";

        int dealerId;
        if (!Int32.TryParse(Convert.ToString(context.Session["VendorID"]), out dealerId) || dealerId <= 0)
            return "Login required";

        string filter = status ?? String.Empty;
        string[] allowedFilters = { "", "Pending", "Approved", "Active", "Completed", "Rejected" };
        if (Array.IndexOf(allowedFilters, filter) < 0)
            return "Invalid status filter.";

        StringBuilder html = new StringBuilder();
        using (SqlConnection con = new SqlConnection(ConnectionString))
        using (SqlCommand cmd = new SqlCommand(@"
SELECT R.RentalID, R.StartDate, R.EndDate, R.TotalDays, R.RentAmount, R.Status,
       B.ModelName, B.Image1, U.FullName, U.Mobile
FROM dbo.RentalBookings R
INNER JOIN dbo.Bikes B ON R.BikeID=B.BikeID
INNER JOIN dbo.Users U ON R.CustomerID=U.UserID
WHERE R.DealerID=@DealerID
  AND (@Status=N'' OR R.Status=@Status)
ORDER BY R.CreatedAt DESC;", con))
        {
            cmd.Parameters.Add("@DealerID", SqlDbType.Int).Value = dealerId;
            cmd.Parameters.Add("@Status", SqlDbType.NVarChar, 30).Value = filter;
            con.Open();
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    int rentalId = Convert.ToInt32(dr["RentalID"]);
                    string rawStatus = Convert.ToString(dr["Status"]);
                    string statusClass = GetStatusClass(rawStatus);
                    string imageName = SafeImageName(Convert.ToString(dr["Image1"]));
                    string imageUrl = String.IsNullOrEmpty(imageName)
                        ? "/Uploads/images/bike.png"
                        : "/Uploads/Bikes/" + imageName;

                    html.Append("<div class='rental-card'><div class='rental-img'><img src='")
                        .Append(HttpUtility.HtmlAttributeEncode(imageUrl))
                        .Append("' alt='Bike image' /></div><div class='rental-body'>")
                        .Append("<div class='rental-title'>").Append(HttpUtility.HtmlEncode(Convert.ToString(dr["ModelName"]))).Append("</div>")
                        .Append("<div class='rental-customer'>Customer: ").Append(HttpUtility.HtmlEncode(Convert.ToString(dr["FullName"]))).Append("</div>")
                        .Append("<div class='rental-customer'>Phone: ").Append(HttpUtility.HtmlEncode(Convert.ToString(dr["Mobile"]))).Append("</div>")
                        .Append("<div class='rental-dates'>Dates: ")
                        .Append(Convert.ToDateTime(dr["StartDate"]).ToString("dd MMM yyyy"))
                        .Append(" - ").Append(Convert.ToDateTime(dr["EndDate"]).ToString("dd MMM yyyy")).Append("</div>")
                        .Append("<div class='rental-price'>Total: ₹ ")
                        .Append(Convert.ToDecimal(dr["RentAmount"]).ToString("N0"))
                        .Append("</div><div class='status ").Append(statusClass).Append("'>")
                        .Append(HttpUtility.HtmlEncode(rawStatus)).Append("</div><div class='actions'>");

                    if (rawStatus == "Pending")
                    {
                        AppendAction(html, rentalId, "Approved", "Approve", "btn-approve");
                        AppendAction(html, rentalId, "Rejected", "Reject", "btn-reject");
                    }
                    else if (rawStatus == "Approved")
                        AppendAction(html, rentalId, "Active", "Start", "btn-start");
                    else if (rawStatus == "Active")
                        AppendAction(html, rentalId, "Completed", "Complete", "btn-complete");

                    html.Append("</div></div></div>");
                }
            }
        }
        return html.ToString();
    }

    private static void AppendAction(StringBuilder html, int id, string status, string label, string css)
    {
        // ID is a validated integer and status is a server-side allow-listed constant.
        html.Append("<button type='button' class='btn ").Append(css)
            .Append("' onclick=\"updateStatus(").Append(id).Append(",'")
            .Append(status).Append("')\">").Append(label).Append("</button>");
    }

    private static string GetStatusClass(string status)
    {
        switch (status)
        {
            case "Pending": return "status-pending";
            case "Approved": return "status-approved";
            case "Active": return "status-active";
            case "Completed": return "status-completed";
            case "Rejected": return "status-rejected";
            default: return "status-rejected";
        }
    }

    private static string SafeImageName(string name)
    {
        if (String.IsNullOrWhiteSpace(name)) return String.Empty;
        string only = Path.GetFileName(name);
        string ext = Path.GetExtension(only).ToLowerInvariant();
        if (only != name || (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".webp"))
            return String.Empty;
        return only;
    }

    [WebMethod(EnableSession = true)]
    public static string UpdateStatus(int rentalId, string status)
    {
        HttpContext context = HttpContext.Current;
        if (context == null || context.Session == null || context.Session["VendorID"] == null)
            return "Login required.";

        int dealerId;
        if (!Int32.TryParse(Convert.ToString(context.Session["VendorID"]), out dealerId) || dealerId <= 0)
            return "Login required.";
        if (rentalId <= 0) return "Invalid rental.";

        string expectedStatus;
        switch (status)
        {
            case "Approved":
            case "Rejected":
                expectedStatus = "Pending";
                break;
            case "Active":
                expectedStatus = "Approved";
                break;
            case "Completed":
                expectedStatus = "Active";
                break;
            default:
                return "Invalid status transition.";
        }

        using (SqlConnection con = new SqlConnection(ConnectionString))
        using (SqlCommand cmd = new SqlCommand(@"
UPDATE dbo.RentalBookings
SET Status=@NewStatus
WHERE RentalID=@RentalID
  AND DealerID=@DealerID
  AND Status=@ExpectedStatus;", con))
        {
            cmd.Parameters.Add("@NewStatus", SqlDbType.NVarChar, 30).Value = status;
            cmd.Parameters.Add("@RentalID", SqlDbType.Int).Value = rentalId;
            cmd.Parameters.Add("@DealerID", SqlDbType.Int).Value = dealerId;
            cmd.Parameters.Add("@ExpectedStatus", SqlDbType.NVarChar, 30).Value = expectedStatus;
            con.Open();
            int affected = cmd.ExecuteNonQuery();
            return affected == 1 ? "Rental status updated." : "Rental not found or transition is not allowed.";
        }
    }
}
