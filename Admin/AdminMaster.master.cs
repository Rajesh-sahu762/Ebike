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
    public static int GetNotificationCount()
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string query = @"SELECT 
                        (SELECT COUNT(*) FROM Users WHERE Role='Dealer' AND IsApproved=0) +
                        (SELECT COUNT(*) FROM Bikes WHERE IsApproved=0) +
                        (SELECT COUNT(*) FROM Leads WHERE IsViewed=0)";

            SqlCommand cmd = new SqlCommand(query, con);

            int total = Convert.ToInt32(cmd.ExecuteScalar());

            return total;
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Session.Abandon();
        Response.Redirect("AdminLogin.aspx");
    }
}
