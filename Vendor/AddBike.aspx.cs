using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;

public partial class Vendor_AddBike : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");

        if (!IsPostBack)
            LoadBrands();
    }

    void LoadBrands()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(
                "SELECT BrandID, BrandName FROM Brands WHERE IsActive=1", con);

            ddlBrand.DataSource = cmd.ExecuteReader();
            ddlBrand.DataTextField = "BrandName";
            ddlBrand.DataValueField = "BrandID";
            ddlBrand.DataBind();

            ddlBrand.Items.Insert(0,
                new System.Web.UI.WebControls.ListItem("Select Brand", ""));
        }
    }

    protected void btnAddBike_Click(object sender, EventArgs e)
    {
        if (ddlBrand.SelectedValue == "" || txtModel.Text.Trim() == "")
        {
            lblMsg.Text = "Brand and Model are required.";
            lblMsg.ForeColor = System.Drawing.Color.Red;
            return;
        }

        int dealerId = Convert.ToInt32(Session["VendorID"]);
        string slug = GenerateSlug(txtModel.Text.Trim());

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // Unique check (DealerID, BrandID, ModelName)
            SqlCommand check = new SqlCommand(
                "SELECT COUNT(*) FROM Bikes WHERE DealerID=@d AND BrandID=@b AND ModelName=@m", con);

            check.Parameters.AddWithValue("@d", dealerId);
            check.Parameters.AddWithValue("@b", ddlBrand.SelectedValue);
            check.Parameters.AddWithValue("@m", txtModel.Text.Trim());

            if (Convert.ToInt32(check.ExecuteScalar()) > 0)
            {
                lblMsg.Text = "Bike already exists for this brand.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string img1 = SaveImage(fu1);
            string img2 = SaveImage(fu2);
            string img3 = SaveImage(fu3);

            SqlCommand cmd = new SqlCommand(
            @"INSERT INTO Bikes
            (DealerID, BrandID, ModelName, Slug, Price,
             RangeKM, BatteryType, MotorPower, TopSpeed,
             ChargingTime, Description,
             Image1, Image2, Image3,
             IsApproved)
            VALUES
            (@DealerID, @BrandID, @ModelName, @Slug, @Price,
             @RangeKM, @BatteryType, @MotorPower, @TopSpeed,
             @ChargingTime, @Description,
             @Image1, @Image2, @Image3,
             0)", con);

            cmd.Parameters.AddWithValue("@DealerID", dealerId);
            cmd.Parameters.AddWithValue("@BrandID", ddlBrand.SelectedValue);
            cmd.Parameters.AddWithValue("@ModelName", txtModel.Text.Trim());
            cmd.Parameters.AddWithValue("@Slug", slug);
            cmd.Parameters.AddWithValue("@Price", txtPrice.Text == "" ? (object)DBNull.Value : txtPrice.Text);
            cmd.Parameters.AddWithValue("@RangeKM", txtRange.Text == "" ? (object)DBNull.Value : txtRange.Text);
            cmd.Parameters.AddWithValue("@BatteryType", txtBattery.Text);
            cmd.Parameters.AddWithValue("@MotorPower", txtMotor.Text);
            cmd.Parameters.AddWithValue("@TopSpeed", txtSpeed.Text == "" ? (object)DBNull.Value : txtSpeed.Text);
            cmd.Parameters.AddWithValue("@ChargingTime", txtCharge.Text);
            cmd.Parameters.AddWithValue("@Description", txtDesc.Text);
            cmd.Parameters.AddWithValue("@Image1", img1);
            cmd.Parameters.AddWithValue("@Image2", img2);
            cmd.Parameters.AddWithValue("@Image3", img3);

            cmd.ExecuteNonQuery();

            lblMsg.Text = "Bike submitted successfully. Waiting for admin approval.";
            lblMsg.ForeColor = System.Drawing.Color.Green;
        }
    }

    string SaveImage(System.Web.UI.WebControls.FileUpload fu)
    {
        if (fu.HasFile)
        {
            string ext = Path.GetExtension(fu.FileName).ToLower();

            if (ext != ".jpg" && ext != ".jpeg" && ext != ".png")
                return null;

            if (fu.PostedFile.ContentLength > 2 * 1024 * 1024)
                return null;

            string folder = Server.MapPath("~/Uploads/Bikes/");
            if (!Directory.Exists(folder))
                Directory.CreateDirectory(folder);

            string fileName = Guid.NewGuid().ToString() + ext;
            fu.SaveAs(Path.Combine(folder, fileName));

            return "~/Uploads/Bikes/" + fileName;
        }

        return null;
    }

    string GenerateSlug(string text)
    {
        text = text.ToLower();
        text = Regex.Replace(text, @"[^a-z0-9\s-]", "");
        text = Regex.Replace(text, @"\s+", "-");
        return text;
    }
}
