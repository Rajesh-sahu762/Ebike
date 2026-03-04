using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Web.Services;

public partial class Client_ClientMaster : System.Web.UI.MasterPage
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["CustomerID"] != null)
            {
                pnlLogin.Visible = false;
                pnlUser.Visible = true;

                if (Session["CustomerName"] != null)
                    lblUserName.Text = Session["CustomerName"].ToString();
                else
                    lblUserName.Text = "My Account";

                LoadWishlistCount();
            }
            else
            {
                pnlLogin.Visible = true;
                pnlUser.Visible = false;
                wishCount.InnerText = "0";
            }
        }
    }


    [WebMethod(EnableSession = true)]
    public static int GetWishlistCount()
    {
        if (System.Web.HttpContext.Current.Session["CustomerID"] == null)
            return 0;

        int userId = Convert.ToInt32(System.Web.HttpContext.Current.Session["CustomerID"]);

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT COUNT(*) FROM Wishlist WHERE CustomerID=@id", con);

            cmd.Parameters.AddWithValue("@id", userId);

            return Convert.ToInt32(cmd.ExecuteScalar());
        }
    }

    void LoadWishlistCount()
    {
        if (Session["CustomerID"] == null)
        {
            wishCount.InnerText = "0";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT COUNT(*) FROM Wishlist WHERE CustomerID = @CustomerID",
                con);

            cmd.Parameters.AddWithValue("@CustomerID",
                Convert.ToInt32(Session["CustomerID"]));

            object result = cmd.ExecuteScalar();

            if (result != null)
                wishCount.InnerText = result.ToString();
            else
                wishCount.InnerText = "0";
        }
    }

}