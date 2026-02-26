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

            SqlCommand cmd = new SqlCommand(@"INSERT INTO Bikes
(DealerID, BrandID, ModelName, Slug, Price,
 RangeKM, BatteryType, MotorPower, TopSpeed,
 ChargingTime, Description,
 Image1, Image2, Image3,
 IsApproved,
 IsForRent, RentPerDay, RentPerWeek, RentPerMonth)
VALUES
(@DealerID, @BrandID, @ModelName, @Slug, @Price,
 @RangeKM, @BatteryType, @MotorPower, @TopSpeed,
 @ChargingTime, @Description,
 @Image1, @Image2, @Image3,
 0,
 @IsForRent, @RentPerDay, @RentPerWeek, @RentPerMonth)", con);

            cmd.Parameters.AddWithValue("@DealerID", dealerId);
            cmd.Parameters.AddWithValue("@BrandID", ddlBrand.SelectedValue);
            cmd.Parameters.AddWithValue("@ModelName", txtModel.Text.Trim());
            cmd.Parameters.AddWithValue("@Slug", slug);
            decimal price;
            if (decimal.TryParse(txtPrice.Text, out price))
                cmd.Parameters.AddWithValue("@Price", price);
            else
                cmd.Parameters.AddWithValue("@Price", DBNull.Value);

            // ===== RANGE SAFE PARSE =====
            int range;
            string rangeText = Regex.Match(txtRange.Text, @"\d+").Value;

            if (int.TryParse(rangeText, out range))
                cmd.Parameters.AddWithValue("@RangeKM", range);
            else
                cmd.Parameters.AddWithValue("@RangeKM", DBNull.Value);

            // ===== SPEED SAFE PARSE =====
            int speed;
            string speedText = Regex.Match(txtSpeed.Text, @"\d+").Value;

            if (int.TryParse(speedText, out speed))
                cmd.Parameters.AddWithValue("@TopSpeed", speed);
            else
                cmd.Parameters.AddWithValue("@TopSpeed", DBNull.Value);


            cmd.Parameters.AddWithValue("@BatteryType", txtBattery.Text.Trim());
            cmd.Parameters.AddWithValue("@MotorPower", txtMotor.Text.Trim());
            cmd.Parameters.AddWithValue("@ChargingTime", txtCharge.Text.Trim());
            cmd.Parameters.AddWithValue("@Description", txtDesc.Text.Trim());
            cmd.Parameters.AddWithValue("@Image1", img1);
            cmd.Parameters.AddWithValue("@Image2", img2);
            cmd.Parameters.AddWithValue("@Image3", img3);
            // ===== RENTAL LOGIC =====
            bool isForRent = chkIsForRent.Checked;
            cmd.Parameters.AddWithValue("@IsForRent", isForRent);

            decimal rentDay, rentWeek, rentMonth;

            if (isForRent)
            {
                if (decimal.TryParse(txtRentDay.Text, out rentDay))
                    cmd.Parameters.AddWithValue("@RentPerDay", rentDay);
                else
                    cmd.Parameters.AddWithValue("@RentPerDay", DBNull.Value);

                if (decimal.TryParse(txtRentWeek.Text, out rentWeek))
                    cmd.Parameters.AddWithValue("@RentPerWeek", rentWeek);
                else
                    cmd.Parameters.AddWithValue("@RentPerWeek", DBNull.Value);

                if (decimal.TryParse(txtRentMonth.Text, out rentMonth))
                    cmd.Parameters.AddWithValue("@RentPerMonth", rentMonth);
                else
                    cmd.Parameters.AddWithValue("@RentPerMonth", DBNull.Value);
            }
            else
            {
                cmd.Parameters.AddWithValue("@RentPerDay", DBNull.Value);
                cmd.Parameters.AddWithValue("@RentPerWeek", DBNull.Value);
                cmd.Parameters.AddWithValue("@RentPerMonth", DBNull.Value);
            }

            cmd.ExecuteNonQuery();

            lblMsg.Text = "Bike submitted successfully. Waiting for admin approval.";
            lblMsg.ForeColor = System.Drawing.Color.Green;

            ClearForm(); 

        }
    }

    void ClearForm()
    {
        ddlBrand.SelectedIndex = 0;
        txtModel.Text = "";
        txtPrice.Text = "";
        txtRange.Text = "";
        txtBattery.Text = "";
        txtMotor.Text = "";
        txtSpeed.Text = "";
        txtCharge.Text = "";
        txtDesc.Text = "";

        lblMsg.Text = "";
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

            // ✅ ORIGINAL FILE NAME
            string fileName = Path.GetFileName(fu.FileName);
            string fullPath = Path.Combine(folder, fileName);

            // 🔒 Prevent overwrite
            int count = 1;
            string nameOnly = Path.GetFileNameWithoutExtension(fileName);
            string extension = Path.GetExtension(fileName);

            while (File.Exists(fullPath))
            {
                fileName = nameOnly + "_" + count + extension;
                fullPath = Path.Combine(folder, fileName);
                count++;
            }

            fu.SaveAs(fullPath);

            return fileName;   // ✅ ONLY FILE NAME
        }

        return null;
    }


    string GenerateSlug(string text)
    {
        text = text.ToLower();
        text = Regex.Replace(text, @"[^a-z0-9\s-]", "");
        text = Regex.Replace(text, @"\s+", "-");
        text = text.Trim('-');

        if (text.Length > 200)
            text = text.Substring(0, 200);

        return text;
    }

}
