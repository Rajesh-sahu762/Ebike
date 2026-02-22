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
            LoadReviews();
            LoadHeroBrands();
            LoadBrowseBrands();
            LoadFeaturedBikes(null, null);
        }
    }


    void LoadReviews()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string query = @"
        SELECT TOP 10 R.*, U.FullName, U.ProfileImage,
               B.ModelName, B.Image1, B.Slug
        FROM BikeReviews R
        INNER JOIN Users U ON R.CustomerID = U.UserID
        INNER JOIN Bikes B ON R.BikeID = B.BikeID
        WHERE R.IsApproved=1
        ORDER BY R.CreatedAt DESC";

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptReviews.DataSource = dt;
            rptReviews.DataBind();
        }
    }


    void LoadHeroBrands()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT BrandID, BrandName FROM Brands WHERE IsActive=1 ORDER BY BrandName",
                con);

            SqlDataReader dr = cmd.ExecuteReader();

            ddlBrand.DataSource = dr;
            ddlBrand.DataTextField = "BrandName";
            ddlBrand.DataValueField = "BrandID";
            ddlBrand.DataBind();

            ddlBrand.Items.Insert(0,
                new System.Web.UI.WebControls.ListItem("Select Brand", ""));
        }
    }


    void LoadBrowseBrands()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // Get ALL active brands
            SqlCommand cmd = new SqlCommand(
                "SELECT BrandID, BrandName, LogoPath FROM Brands WHERE IsActive=1 ORDER BY BrandID",
                con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            // TOP 10 only
            DataTable dtTop = dt.Clone();
            for (int i = 0; i < dt.Rows.Count && i < 10; i++)
            {
                dtTop.ImportRow(dt.Rows[i]);
            }

            // REMAINING brands
            DataTable dtMore = dt.Clone();
            for (int i = 10; i < dt.Rows.Count; i++)
            {
                dtMore.ImportRow(dt.Rows[i]);
            }

            rptBrandsTop.DataSource = dtTop;
            rptBrandsTop.DataBind();

            rptBrandsAll.DataSource = dtMore;
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

    public string GenerateStars(int rating)
    {
        string stars = "";
        for (int i = 1; i <= 5; i++)
        {
            if (i <= rating)
                stars += "<span>★</span>";
            else
                stars += "<span style='color:#e5e7eb'>★</span>";
        }
        return stars;
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadFeaturedBikes(
            ddlBudget.SelectedValue,
            ddlBrand.SelectedValue);
    }
}
