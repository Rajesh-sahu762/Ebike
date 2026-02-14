using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

public partial class Admin_ManageBrands : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

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
        SqlConnection con = new SqlConnection(constr);
        con.Open();

        SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM Brands WHERE BrandName=@name", con);
        check.Parameters.AddWithValue("@name", txtBrand.Text.Trim());

        if (Convert.ToInt32(check.ExecuteScalar()) > 0)
        {
            con.Close();
            return;
        }

        string logoPath = "";

        if (fuLogo.HasFile)
        {
            string ext = Path.GetExtension(fuLogo.FileName);
            string fileName = Guid.NewGuid().ToString() + ext;
            logoPath = "/Uploads/Brands/" + fileName;
            fuLogo.SaveAs(Server.MapPath(logoPath));
        }

        SqlCommand cmd = new SqlCommand(
            "INSERT INTO Brands (BrandName,LogoPath,IsActive) VALUES (@name,@logo,@active)", con);

        cmd.Parameters.AddWithValue("@name", txtBrand.Text.Trim());
        cmd.Parameters.AddWithValue("@logo", logoPath);
        cmd.Parameters.AddWithValue("@active", chkActive.Checked);

        cmd.ExecuteNonQuery();
        con.Close();

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
