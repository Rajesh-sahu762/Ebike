using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Client_Home : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadBrowseBrands();
            LoadFeaturedBikes(null, null);
        }
    }

    void LoadBrowseBrands()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // TOP 10
            SqlCommand cmdTop = new SqlCommand(
                "SELECT TOP 10 BrandID, BrandName, LogoPath FROM Brands WHERE IsActive=1 ORDER BY BrandID",
                con);

            SqlDataAdapter daTop = new SqlDataAdapter(cmdTop);
            DataTable dtTop = new DataTable();
            daTop.Fill(dtTop);

            rptBrandsTop.DataSource = dtTop;
            rptBrandsTop.DataBind();

            // ALL
            SqlCommand cmdAll = new SqlCommand(
                "SELECT BrandID, BrandName, LogoPath FROM Brands WHERE IsActive=1 ORDER BY BrandID",
                con);

            SqlDataAdapter daAll = new SqlDataAdapter(cmdAll);
            DataTable dtAll = new DataTable();
            daAll.Fill(dtAll);

            rptBrandsAll.DataSource = dtAll;
            rptBrandsAll.DataBind();
        }
    }



    void LoadFeaturedBikes(string budget, string brandId)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string query = @"SELECT TOP 6 BikeID, ModelName, Price,
                             RangeKM, Image1, Slug
                             FROM Bikes
                             WHERE IsApproved=1";

            if (!string.IsNullOrEmpty(budget))
                query += " AND Price <= @budget";

            if (!string.IsNullOrEmpty(brandId))
                query += " AND BrandID = @brand";

            query += " ORDER BY BikeID DESC";

            SqlCommand cmd = new SqlCommand(query, con);

            if (!string.IsNullOrEmpty(budget))
                cmd.Parameters.AddWithValue("@budget", budget);

            if (!string.IsNullOrEmpty(brandId))
                cmd.Parameters.AddWithValue("@brand", brandId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptFeatured.DataSource = dt;
            rptFeatured.DataBind();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadFeaturedBikes(
            ddlBudget.SelectedValue,
            ddlBrand.SelectedValue);
    }
}
