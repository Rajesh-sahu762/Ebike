using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

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
            LoadSpareParts();
        }
    }

    void LoadSpareParts()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            // No changes here, same fields: PartName, Price, Category, Image1
            SqlDataAdapter da = new SqlDataAdapter("SELECT TOP 4 PartID, PartName, Price, Category, Image1 FROM Parts WHERE IsApproved=1 ORDER BY CreatedAt DESC", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rptSpareParts.DataSource = dt;
            rptSpareParts.DataBind();
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
            // SQL Schema ke hisaab se: BrandID aur BrandName
            SqlCommand cmd = new SqlCommand("SELECT BrandID, BrandName FROM Brands WHERE IsActive=1 ORDER BY BrandName", con);
            con.Open();
            ddlBrand.DataSource = cmd.ExecuteReader();
            ddlBrand.DataTextField = "BrandName";
            ddlBrand.DataValueField = "BrandID";
            ddlBrand.DataBind();
            ddlBrand.Items.Insert(0, new ListItem("Choose Brand", ""));
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        // Jab search click ho, tab ye parameters pass honge
        LoadFeaturedBikes(ddlBudget.SelectedValue, ddlBrand.SelectedValue);
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
            // Search filter logic as requested
            string query = @"SELECT TOP 10 BikeID, ModelName, Price, RangeKM, Image1, Slug 
                         FROM Bikes 
                         WHERE IsApproved=1 AND IsUsed=0 AND IsForRent=0";

            if (!string.IsNullOrEmpty(budget)) query += " AND Price <= @budget";
            if (!string.IsNullOrEmpty(brandId)) query += " AND BrandID = @brand";

            query += " ORDER BY CreatedAt DESC";

            SqlCommand cmd = new SqlCommand(query, con);
            if (!string.IsNullOrEmpty(budget)) cmd.Parameters.AddWithValue("@budget", budget);
            if (!string.IsNullOrEmpty(brandId)) cmd.Parameters.AddWithValue("@brand", brandId);

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


   
}
