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

    [WebMethod]
    public static object GetNotifications()
    {
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
