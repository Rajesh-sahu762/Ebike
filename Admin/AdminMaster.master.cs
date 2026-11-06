using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;


public partial class Admin_AdminMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
        {
            Response.Redirect("AdminLogin.aspx");
        }
    }

    [WebMethod(EnableSession = true)]
    public static object GetNotifications()
    {
        HttpContext context = HttpContext.Current;
        int adminId;
        if (context == null || context.Session == null ||
            !Int32.TryParse(Convert.ToString(context.Session["AdminID"]), out adminId) || adminId <= 0)
            throw new HttpException(401, "Authentication required.");

        string connectionString = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
        using (SqlConnection authConnection = new SqlConnection(connectionString))
        using (SqlCommand authCommand = new SqlCommand(
            "SELECT COUNT(*) FROM dbo.Users WHERE UserID=@UserID AND Role='Admin' AND IsActive=1;", authConnection))
        {
            authCommand.Parameters.Add("@UserID", SqlDbType.Int).Value = adminId;
            authConnection.Open();
            if (Convert.ToInt32(authCommand.ExecuteScalar()) != 1)
                throw new HttpException(403, "Administrator access required.");
        }

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int pendingDealers = Convert.ToInt32(new SqlCommand(
                "SELECT COUNT(*) FROM Users WHERE Role='Dealer' AND IsApproved=0", con).ExecuteScalar());

            int pendingBikes = Convert.ToInt32(new SqlCommand(
                "SELECT COUNT(*) FROM Bikes WHERE IsApproved=0", con).ExecuteScalar());

            int unreadLeads = Convert.ToInt32(new SqlCommand(
                "SELECT COUNT(*) FROM Leads WHERE IsViewed=0", con).ExecuteScalar());

            return new
            {
                PendingDealers = pendingDealers,
                PendingBikes = pendingBikes,
                UnreadLeads = unreadLeads,
                Total = pendingDealers + pendingBikes + unreadLeads
            };
        }
    }


    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("AdminLogin.aspx");
    }
}
