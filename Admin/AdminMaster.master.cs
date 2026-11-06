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
    protected void Page_Init(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("AdminLogin.aspx");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("AdminLogin.aspx");
        }
    }

    [WebMethod(EnableSession = true)]
    public static object GetNotifications()
    {
        if (HttpContext.Current == null ||
            HttpContext.Current.Session == null ||
            HttpContext.Current.Session["AdminID"] == null ||
            HttpContext.Current.Session["Role"] == null ||
            HttpContext.Current.Session["Role"].ToString() != "Admin")
        {
            return new
            {
                PendingDealers = 0,
                PendingBikes = 0,
                UnreadLeads = 0,
                Total = 0
            };
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
