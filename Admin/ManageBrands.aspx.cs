using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using EBIke.Security;

public partial class Admin_ManageBrands : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    private static string NormalizeSortExpression(string value)
    {
        switch (value)
        {
            case "BrandName": return "BrandName";
            case "BikeCount": return "BikeCount";
            case "IsActive": return "IsActive";
            default: return "BrandName";
        }
    }

    string SortDirection
    {
        get
        {
            string value = ViewState["SortDirection"] as string;
            return String.Equals(value, "DESC", StringComparison.OrdinalIgnoreCase) ? "DESC" : "ASC";
        }
        set
        {
            ViewState["SortDirection"] = String.Equals(value, "DESC", StringComparison.OrdinalIgnoreCase)
                ? "DESC" : "ASC";
        }
    }

    string SortExpression
    {
        get { return NormalizeSortExpression(ViewState["SortExpression"] as string); }
        set { ViewState["SortExpression"] = NormalizeSortExpression(value); }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
            Response.Redirect("AdminLogin.aspx");

        if (!IsPostBack)
            LoadBrands();
    }

    void LoadBrands()
    {
        SqlConnection con = new SqlConnection(constr);

        string query = @"SELECT B.BrandID, B.BrandName, B.LogoPath, B.IsActive,
                    (SELECT COUNT(*) FROM Bikes WHERE BrandID=B.BrandID) AS BikeCount
                    FROM Brands B";

        if (txtSearch.Text.Trim() != "")
            query += " WHERE B.BrandName LIKE @search";

        query += " ORDER BY " + SortExpression + " " + SortDirection;

        SqlCommand cmd = new SqlCommand(query, con);

        if (txtSearch.Text.Trim() != "")
            cmd.Parameters.AddWithValue("@search", "%" + txtSearch.Text.Trim() + "%");

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        gvBrands.DataSource = dt;
        gvBrands.DataBind();
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadBrands();
    }

    protected void gvBrands_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvBrands.PageIndex = e.NewPageIndex;
        LoadBrands();
    }

    protected void gvBrands_Sorting(object sender, System.Web.UI.WebControls.GridViewSortEventArgs e)
    {
        SortExpression = e.SortExpression;

        if (SortDirection == "ASC")
            SortDirection = "DESC";
        else
            SortDirection = "ASC";

        LoadBrands();
    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand check = new SqlCommand(
                "SELECT COUNT(*) FROM Brands WHERE BrandName=@name", con);

            check.Parameters.AddWithValue("@name", txtBrand.Text.Trim());

            if (Convert.ToInt32(check.ExecuteScalar()) > 0)
            {
                return;
            }

            string logoFileName = "";

            if (fuLogo.HasFile)
            {
                try
                {
                    logoFileName = UploadSecurity.SaveImage(fuLogo, Server.MapPath("~/Uploads/Brands/"));
                }
                catch (InvalidOperationException)
                {
                    ClientScript.RegisterStartupScript(GetType(), "invalidBrandLogo",
                        "alert('Brand logo upload rejected. Upload a valid JPG, PNG or WEBP image up to 5 MB.');", true);
                    return;
                }
            }

            SqlCommand cmd = new SqlCommand(
                "INSERT INTO Brands (BrandName, LogoPath, IsActive) VALUES (@name,@logo,@active)", con);

            cmd.Parameters.AddWithValue("@name", txtBrand.Text.Trim());
            cmd.Parameters.AddWithValue("@logo", logoFileName);  // ✅ ONLY FILE NAME
            cmd.Parameters.AddWithValue("@active", chkActive.Checked);

            cmd.ExecuteNonQuery();
        }

        LoadBrands();
    }



    protected void gvBrands_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int brandId = Convert.ToInt32(e.CommandArgument);

        SqlConnection con = new SqlConnection(constr);
        con.Open();

        if (e.CommandName == "DeleteBrand")
        {
            SqlCommand countCmd = new SqlCommand(
                "SELECT COUNT(*) FROM Bikes WHERE BrandID=@id", con);
            countCmd.Parameters.AddWithValue("@id", brandId);

            int bikeCount = Convert.ToInt32(countCmd.ExecuteScalar());

            if (bikeCount > 0)
            {
                // Delete bike images
                SqlCommand bikeCmd = new SqlCommand(
                    "SELECT Image1,Image2,Image3 FROM Bikes WHERE BrandID=@id", con);
                bikeCmd.Parameters.AddWithValue("@id", brandId);

                SqlDataReader dr = bikeCmd.ExecuteReader();
                while (dr.Read())
                {
                    for (int i = 0; i < 3; i++)
                    {
                        string path = dr[i] as string;
                        if (!string.IsNullOrEmpty(path))
                        {
                            string fullPath = Server.MapPath(path);
                            if (File.Exists(fullPath))
                                File.Delete(fullPath);
                        }
                    }
                }
                dr.Close();

                SqlCommand delBikes = new SqlCommand(
                    "DELETE FROM Bikes WHERE BrandID=@id", con);
                delBikes.Parameters.AddWithValue("@id", brandId);
                delBikes.ExecuteNonQuery();
            }

            SqlCommand delBrand = new SqlCommand(
                "DELETE FROM Brands WHERE BrandID=@id", con);
            delBrand.Parameters.AddWithValue("@id", brandId);
            delBrand.ExecuteNonQuery();
        }

        con.Close();
        LoadBrands();
    }
}
