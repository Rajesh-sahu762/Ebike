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
            LoadHomeCategories();
            LoadBrowseBrands();
            LoadFeaturedBikes(null, null);
            LoadSpareParts();
        }
    }


    // Categories are inferred from existing bike data; no schema changes are needed.
    void LoadHomeCategories()
    {
        string[] names = { "Electric Bikes", "Electric Scooters", "Mopeds", "Off-Road EVs", "Daily Commute", "Long Range" };
        string[] slugs = { "electric-bikes", "electric-scooters", "mopeds", "off-road-evs", "daily-commute", "long-range" };
        string[] icons = { "fa-solid fa-motorcycle", "fa-solid fa-motorcycle", "fa-solid fa-person-biking", "fa-solid fa-mountain-sun", "fa-solid fa-route", "fa-solid fa-road" };
        int[] counts = new int[names.Length];
        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand cmd = new SqlCommand(@"SELECT ModelName, Description, ISNULL(RangeKM,0) AS RangeKM FROM Bikes WHERE IsApproved=1 AND ISNULL(IsUsed,0)=0 AND ISNULL(IsForRent,0)=0", con))
        {
            con.Open();
            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    string model = reader["ModelName"] == DBNull.Value ? "" : Convert.ToString(reader["ModelName"]);
                    string description = reader["Description"] == DBNull.Value ? "" : Convert.ToString(reader["Description"]);
                    string text = (model + " " + description).ToLowerInvariant();
                    int range = Convert.ToInt32(reader["RangeKM"]);
                    bool scooter = ContainsAny(text, "scooter", "ather 450", "ather rizta", "ola s1", "vida v2", "tvs iqube", "activa e");
                    bool moped = ContainsAny(text, "moped");
                    bool offRoad = ContainsAny(text, "off-road", "off road", "dirt bike", "enduro", "trail riding");
                    bool daily = ContainsAny(text, "commut", "urban", "city ride", "daily ride", "family-friendly", "everyday ride");
                    bool longRange = range >= 150 || ContainsAny(text, "long range", "extended range");
                    if (!scooter && !moped && !offRoad) counts[0]++;
                    if (scooter) counts[1]++;
                    if (moped) counts[2]++;
                    if (offRoad) counts[3]++;
                    if (daily) counts[4]++;
                    if (longRange) counts[5]++;
                }
            }
        }
        DataTable categories = new DataTable();
        categories.Columns.Add("CategoryName", typeof(string));
        categories.Columns.Add("CategorySlug", typeof(string));
        categories.Columns.Add("CategoryIcon", typeof(string));
        categories.Columns.Add("BikeCount", typeof(int));
        for (int i = 0; i < names.Length; i++)
        {
            DataRow row = categories.NewRow();
            row["CategoryName"] = names[i]; row["CategorySlug"] = slugs[i];
            row["CategoryIcon"] = icons[i]; row["BikeCount"] = counts[i];
            categories.Rows.Add(row);
        }
        rptHomeCategories.DataSource = categories;
        rptHomeCategories.DataBind();
    }

    private bool ContainsAny(string value, params string[] keywords)
    {
        foreach (string keyword in keywords)
            if (value.IndexOf(keyword, StringComparison.OrdinalIgnoreCase) >= 0) return true;
        return false;
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


    // Build reliable URLs for database image values. Supports filename-only values,
    // "Bikes/file.jpg", "Uploads/Bikes/file.jpg", "~/Uploads/Bikes/file.jpg"
    // and "/Uploads/Bikes/file.jpg" without duplicating folder names.
    public string GetHomeAssetUrl(object value, string folder)
    {
        string raw = value == null || value == DBNull.Value ? "" : Convert.ToString(value).Trim();
        if (string.IsNullOrWhiteSpace(raw))
            return ResolveUrl("~/Uploads/images/bike.png");

        raw = raw.Replace((char)92, '/');
        if (raw.StartsWith("http://", StringComparison.OrdinalIgnoreCase) ||
            raw.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
            return raw;

        raw = raw.Replace("~/", "").TrimStart('/');
        int uploadsIndex = raw.IndexOf("Uploads/", StringComparison.OrdinalIgnoreCase);
        if (uploadsIndex >= 0)
            raw = raw.Substring(uploadsIndex + "Uploads/".Length);

        string folderName = (folder ?? "").Replace(((char)92).ToString(), "/").Trim('/');
        if (folderName.StartsWith("Uploads/", StringComparison.OrdinalIgnoreCase))
            folderName = folderName.Substring("Uploads/".Length);

        if (raw.StartsWith(folderName + "/", StringComparison.OrdinalIgnoreCase))
            raw = raw.Substring(folderName.Length + 1);

        string relativePath = "~/Uploads/" + folderName + "/" + raw;
        string resolvedPath = ResolveUrl(relativePath);
        string physicalPath = Server.MapPath(resolvedPath);

        if (!System.IO.File.Exists(physicalPath))
        {
            if (folderName.Equals("Brands", StringComparison.OrdinalIgnoreCase))
                return ResolveUrl("~/Uploads/favicon/favicon-ebd.svg");
            if (folderName.Equals("Parts", StringComparison.OrdinalIgnoreCase))
                return ResolveUrl("~/Uploads/images/parts.png");
            if (folderName.Equals("Profile", StringComparison.OrdinalIgnoreCase))
                return ResolveUrl("~/Uploads/user.jpg");
            return ResolveUrl("~/Uploads/images/bike.png");
        }

        return resolvedPath;
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
