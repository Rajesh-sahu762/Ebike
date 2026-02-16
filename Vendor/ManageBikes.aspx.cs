using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;

public partial class Vendor_ManageBikes : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");

        if (!IsPostBack)
        {
            LoadBrands();
            LoadBikes();
        }
    }

    void LoadBrands()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT BrandID, BrandName FROM Brands WHERE IsActive=1", con);

            ddlBrandFilter.DataSource = cmd.ExecuteReader();
            ddlBrandFilter.DataTextField = "BrandName";
            ddlBrandFilter.DataValueField = "BrandID";
            ddlBrandFilter.DataBind();

            ddlBrandFilter.Items.Insert(0,
                new System.Web.UI.WebControls.ListItem("All Brands", ""));
        }
    }

    void LoadBikes()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string query = @"
            SELECT B.BikeID, BR.BrandName, B.ModelName, B.Price,
                   B.Image1, B.IsApproved, B.CreatedAt,
                   (SELECT COUNT(*) FROM Leads L WHERE L.BikeID=B.BikeID) AS LeadCount
            FROM Bikes B
            INNER JOIN Brands BR ON B.BrandID=BR.BrandID
            WHERE B.DealerID=@DealerID";

            if (txtSearch.Text.Trim() != "")
                query += " AND B.ModelName LIKE @search";

            if (ddlBrandFilter.SelectedValue != "")
                query += " AND B.BrandID=@brand";

            if (ddlStatusFilter.SelectedValue != "")
                query += " AND B.IsApproved=@status";

            query += " ORDER BY B.CreatedAt DESC";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@DealerID",
                Convert.ToInt32(Session["VendorID"]));

            if (txtSearch.Text.Trim() != "")
                cmd.Parameters.AddWithValue("@search",
                    "%" + txtSearch.Text.Trim() + "%");

            if (ddlBrandFilter.SelectedValue != "")
                cmd.Parameters.AddWithValue("@brand",
                    ddlBrandFilter.SelectedValue);

            if (ddlStatusFilter.SelectedValue != "")
                cmd.Parameters.AddWithValue("@status",
                    ddlStatusFilter.SelectedValue);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvBikes.DataSource = dt;
            gvBikes.DataBind();
        }
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        LoadBikes();
    }

    protected void gvBikes_PageIndexChanging(object sender,
        System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvBikes.PageIndex = e.NewPageIndex;
        LoadBikes();
    }
    protected void gvBikes_RowCommand(object sender,
        System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int bikeId = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "DeleteBike")
        {
            DeleteBike(bikeId);
            LoadBikes();
        }

        if (e.CommandName == "EditBike")
        {
            LoadEditBike(bikeId);
        }

    }

    void LoadEditBike(int bikeId)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT * FROM Bikes WHERE BikeID=@id AND DealerID=@d", con);

            cmd.Parameters.AddWithValue("@id", bikeId);
            cmd.Parameters.AddWithValue("@d",
                Convert.ToInt32(Session["VendorID"]));

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                hfBikeID.Value = bikeId.ToString();
                txtModelEdit.Text = dr["ModelName"].ToString();
                txtPriceEdit.Text = dr["Price"].ToString();
                txtRangeEdit.Text = dr["RangeKM"].ToString();
                txtDescEdit.Text = dr["Description"].ToString();

                LoadBrands();
                ddlBrandEdit.SelectedValue = dr["BrandID"].ToString();
            }

            dr.Close();
        }

        ClientScript.RegisterStartupScript(this.GetType(),
      "OpenModal",
      "var myModal = new bootstrap.Modal(document.getElementById('editModal')); myModal.show();",
      true);

    }

    protected void btnUpdateBike_Click(object sender, EventArgs e)
    {
        int bikeId = Convert.ToInt32(hfBikeID.Value);
        int dealerId = Convert.ToInt32(Session["VendorID"]);

        string newSlug = GenerateSlug(txtModelEdit.Text);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // UNIQUE CHECK
            SqlCommand checkCmd = new SqlCommand(
            @"SELECT COUNT(*) FROM Bikes 
          WHERE DealerID=@d AND BrandID=@b AND ModelName=@m AND BikeID<>@id",
              con);

            checkCmd.Parameters.AddWithValue("@d", dealerId);
            checkCmd.Parameters.AddWithValue("@b", ddlBrandEdit.SelectedValue);
            checkCmd.Parameters.AddWithValue("@m", txtModelEdit.Text.Trim());
            checkCmd.Parameters.AddWithValue("@id", bikeId);

            if (Convert.ToInt32(checkCmd.ExecuteScalar()) > 0)
            {
                lblMsg.Text = "Bike with same name already exists.";
                return;
            }

            string img1 = ReplaceImage(fuImg1Edit, bikeId, "Image1");
            string img2 = ReplaceImage(fuImg2Edit, bikeId, "Image2");
            string img3 = ReplaceImage(fuImg3Edit, bikeId, "Image3");

            SqlCommand updateCmd = new SqlCommand(
            @"UPDATE Bikes SET 
          BrandID=@brand,
          ModelName=@model,
          Slug=@slug,
          Price=@price,
          RangeKM=@range,
          Description=@desc,
          Image1=ISNULL(@img1,Image1),
          Image2=ISNULL(@img2,Image2),
          Image3=ISNULL(@img3,Image3),
          IsApproved=0
          WHERE BikeID=@id AND DealerID=@d", con);

            updateCmd.Parameters.AddWithValue("@brand", ddlBrandEdit.SelectedValue);
            updateCmd.Parameters.AddWithValue("@model", txtModelEdit.Text.Trim());
            updateCmd.Parameters.AddWithValue("@slug", newSlug);
            updateCmd.Parameters.AddWithValue("@price", txtPriceEdit.Text);
            updateCmd.Parameters.AddWithValue("@range", txtRangeEdit.Text);
            updateCmd.Parameters.AddWithValue("@desc", txtDescEdit.Text);
            updateCmd.Parameters.AddWithValue("@img1", (object)img1 ?? DBNull.Value);
            updateCmd.Parameters.AddWithValue("@img2", (object)img2 ?? DBNull.Value);
            updateCmd.Parameters.AddWithValue("@img3", (object)img3 ?? DBNull.Value);
            updateCmd.Parameters.AddWithValue("@id", bikeId);
            updateCmd.Parameters.AddWithValue("@d", dealerId);

            updateCmd.ExecuteNonQuery();
        }

        LoadBikes();
    }

    string ReplaceImage(FileUpload fu, int bikeId, string column)
    {
        if (fu.HasFile)
        {
            string ext = Path.GetExtension(fu.FileName);
            string fileName = Guid.NewGuid().ToString() + ext;
            string folder = Server.MapPath("~/Uploads/Bikes/");

            if (!Directory.Exists(folder))
                Directory.CreateDirectory(folder);

            string path = "~/Uploads/Bikes/" + fileName;
            fu.SaveAs(Path.Combine(folder, fileName));

            return path;
        }

        return null;
    }

    string GenerateSlug(string text)
    {
        text = text.ToLower();
        text = Regex.Replace(text, @"[^a-z0-9\s-]", "");
        text = Regex.Replace(text, @"\s+", "-").Trim('-');
        return text;
    }



    void DeleteBike(int bikeId)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand imgCmd = new SqlCommand(
                "SELECT Image1, Image2, Image3 FROM Bikes WHERE BikeID=@id AND DealerID=@d", con);

            imgCmd.Parameters.AddWithValue("@id", bikeId);
            imgCmd.Parameters.AddWithValue("@d",
                Convert.ToInt32(Session["VendorID"]));

            SqlDataReader dr = imgCmd.ExecuteReader();

            string img1 = "", img2 = "", img3 = "";

            if (dr.Read())
            {
                img1 = dr["Image1"] as string;
                img2 = dr["Image2"] as string;
                img3 = dr["Image3"] as string;
            }
            dr.Close();

            DeleteFile(img1);
            DeleteFile(img2);
            DeleteFile(img3);

            SqlCommand del = new SqlCommand(
                "DELETE FROM Bikes WHERE BikeID=@id AND DealerID=@d", con);

            del.Parameters.AddWithValue("@id", bikeId);
            del.Parameters.AddWithValue("@d",
                Convert.ToInt32(Session["VendorID"]));

            del.ExecuteNonQuery();
        }
    }

    void DeleteFile(string path)
    {
        if (!string.IsNullOrEmpty(path))
        {
            string fullPath = Server.MapPath(path);
            if (File.Exists(fullPath))
                File.Delete(fullPath);
        }
    }
}
