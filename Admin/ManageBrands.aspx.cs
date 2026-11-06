using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

public partial class Admin_ManageBrands : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    private static readonly string[] AllowedSortColumns = new string[] { "BrandName", "BikeCount", "IsActive", "BrandID" };

    string SortDirection
    {
        get { return ViewState["SortDirection"] as string ?? "ASC"; }
        set { ViewState["SortDirection"] = value; }
    }

    string SortExpression
    {
        get { return ViewState["SortExpression"] as string ?? "BrandName"; }
        set { ViewState["SortExpression"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("AdminLogin.aspx");
            return;
        }

        if (!IsPostBack)
            LoadBrands();
    }

    void LoadBrands()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = @"SELECT B.BrandID, B.BrandName, B.LogoPath, B.IsActive,
                        (SELECT COUNT(*) FROM Bikes WHERE BrandID=B.BrandID) AS BikeCount
                        FROM Brands B";

            if (txtSearch.Text.Trim() != "")
                query += " WHERE B.BrandName LIKE @search";

            // Whitelist sort expression and sort direction against SQL injection
            string safeColumn = SecurityHelper.SanitizeSortColumn(SortExpression, AllowedSortColumns, "BrandName");
            string safeDirection = SecurityHelper.SanitizeSortDirection(SortDirection);
            query += " ORDER BY " + safeColumn + " " + safeDirection;

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (txtSearch.Text.Trim() != "")
                    cmd.Parameters.AddWithValue("@search", "%" + txtSearch.Text.Trim() + "%");

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvBrands.DataSource = dt;
                gvBrands.DataBind();
            }
        }
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
        SortExpression = SecurityHelper.SanitizeSortColumn(e.SortExpression, AllowedSortColumns, "BrandName");

        if (SortDirection == "ASC")
            SortDirection = "DESC";
        else
            SortDirection = "ASC";

        LoadBrands();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("AdminLogin.aspx");
            return;
        }

        string brandName = txtBrand.Text.Trim();
        if (string.IsNullOrEmpty(brandName))
            return;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand check = new SqlCommand(
                "SELECT COUNT(*) FROM Brands WHERE BrandName=@name", con);
            check.Parameters.AddWithValue("@name", brandName);

            if (Convert.ToInt32(check.ExecuteScalar()) > 0)
            {
                return;
            }

            string logoFileName = "";

            // Secure file upload validation (extension, MIME, magic bytes, size limit, GUID rename)
            if (fuLogo.HasFile)
            {
                string folder = Server.MapPath("~/Uploads/Brands/");
                string savedName;
                string uploadErr;

                if (!FileUploadHelper.TrySaveImage(fuLogo, folder, out savedName, out uploadErr))
                {
                    return;
                }

                logoFileName = savedName;
            }

            SqlCommand cmd = new SqlCommand(
                "INSERT INTO Brands (BrandName, LogoPath, IsActive) VALUES (@name,@logo,@active)", con);

            cmd.Parameters.AddWithValue("@name", brandName);
            cmd.Parameters.AddWithValue("@logo", logoFileName);
            cmd.Parameters.AddWithValue("@active", chkActive.Checked);

            cmd.ExecuteNonQuery();
        }

        LoadBrands();
    }

    protected void gvBrands_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (Session["AdminID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("AdminLogin.aspx");
            return;
        }

        int brandId = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(constr))
        {
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

                    using (SqlDataReader dr = bikeCmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            for (int i = 0; i < 3; i++)
                            {
                                string path = dr[i] as string;
                                if (!string.IsNullOrEmpty(path))
                                {
                                    string fullPath = Server.MapPath(path.StartsWith("~") ? path : ("~/Uploads/Bikes/" + path));
                                    if (File.Exists(fullPath))
                                        File.Delete(fullPath);
                                }
                            }
                        }
                    }

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
        }

        LoadBrands();
    }
}
