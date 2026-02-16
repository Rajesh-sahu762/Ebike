using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendor_VendorMaster : System.Web.UI.MasterPage
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
        {
            Response.Redirect("VendorLogin.aspx");
        }

        if (!IsPostBack)
        {
            LoadNotifications();
            LoadVendorName();
        }

        Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
    }


    void LoadNotifications()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int vendorId = Convert.ToInt32(Session["VendorID"]);

            // Count Unread
            SqlCommand countCmd = new SqlCommand(
            @"SELECT COUNT(*)
          FROM Leads L
          INNER JOIN Bikes B ON L.BikeID=B.BikeID
          WHERE B.DealerID=@id AND L.IsViewed=0", con);

            countCmd.Parameters.AddWithValue("@id", vendorId);

            int count = Convert.ToInt32(countCmd.ExecuteScalar());

            if (count > 0)
            {
                lblNotifCount.Text = count.ToString();
                lblNotifCount.Visible = true;
            }
            else
            {
                lblNotifCount.Visible = false;
            }


            // Load Top 5
            SqlCommand cmd = new SqlCommand(
            @"SELECT TOP 5 L.LeadID, U.FullName, B.ModelName
          FROM Leads L
          INNER JOIN Users U ON L.CustomerID=U.UserID
          INNER JOIN Bikes B ON L.BikeID=B.BikeID
          WHERE B.DealerID=@id AND L.IsViewed=0
          ORDER BY L.CreatedAt DESC", con);

            cmd.Parameters.AddWithValue("@id", vendorId);

            SqlDataReader dr = cmd.ExecuteReader();
            rptNotifications.DataSource = dr;
            rptNotifications.DataBind();
        }
    }

    protected void btnClearNotif_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            @"UPDATE L SET IsViewed=1
          FROM Leads L
          INNER JOIN Bikes B ON L.BikeID=B.BikeID
          WHERE B.DealerID=@id", con);

            cmd.Parameters.AddWithValue("@id",
                Convert.ToInt32(Session["VendorID"]));

            cmd.ExecuteNonQuery();
        }

        LoadNotifications();
    }


    void LoadVendorName()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT FullName FROM Users WHERE UserID=@id", con);

            cmd.Parameters.AddWithValue("@id", Session["VendorID"]);

            object name = cmd.ExecuteScalar();

            if (name != null)
            {
                lblVendorName.Text = name.ToString();
            }
        }
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("VendorLogin.aspx");
    }
}