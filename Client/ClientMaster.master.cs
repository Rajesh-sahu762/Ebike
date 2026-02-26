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

    // =========================
    // LIVE SEARCH WEB METHOD
    // =========================

    [WebMethod]
    public static List<SearchResult> GetSearchResults(string keyword)
    {
        string constr = ConfigurationManager
            .ConnectionStrings["Electronic"].ConnectionString;

        List<SearchResult> list = new List<SearchResult>();

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            @"SELECT TOP 5 BikeName, BrandName, Slug
          FROM Bikes
          WHERE IsApproved = 1
          AND (BikeName LIKE @k OR BrandName LIKE @k)", con);

            cmd.Parameters.AddWithValue("@k", "%" + keyword + "%");

            SqlDataReader dr = cmd.ExecuteReader();

            while (dr.Read())
            {
                SearchResult s = new SearchResult();
                s.BikeName = dr["BikeName"].ToString();
                s.BrandName = dr["BrandName"].ToString();
                s.Slug = dr["Slug"].ToString();
                list.Add(s);
            }
        }

        return list;
    }
    public class SearchResult
    {
        public string BikeName { get; set; }
        public string BrandName { get; set; }
        public string Slug { get; set; }
    }
}