using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

public partial class Client_SellBike : System.Web.UI.Page
{

    string constr =
    ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CustomerID"] == null)
            Response.Redirect("ClientLogin.aspx");
    }



    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        if (!fu1.HasFile)
        {
            lblMsg.Text = "Upload at least one image";
            return;
        }


        // numeric validation

        int year;
        int km;
        decimal price;

        if (!int.TryParse(txtYear.Text, out year))
        {
            lblMsg.Text = "Invalid year";
            return;
        }

        if (!int.TryParse(txtKM.Text, out km))
        {
            lblMsg.Text = "Invalid KM driven";
            return;
        }

        if (!decimal.TryParse(txtPrice.Text, out price))
        {
            lblMsg.Text = "Invalid price";
            return;
        }



        string brand = txtBrand.Text.Trim();
        string model = txtModel.Text.Trim();

        string slug =
        brand.Replace(" ", "-") + "-" +
        model.Replace(" ", "-") + "-" +
        DateTime.Now.Ticks;



        string folder = Server.MapPath("~/Uploads/Bikes/");

        if (!Directory.Exists(folder))
            Directory.CreateDirectory(folder);



        string img1 = "", img2 = "", img3 = "";



        // Secure image validation and saving
        string uploadErr;

        if (fu1.HasFile)
        {
            if (!FileUploadHelper.TrySaveImage(fu1, folder, out img1, out uploadErr))
            {
                lblMsg.Text = "Image 1 upload error: " + uploadErr;
                return;
            }
        }

        if (fu2.HasFile)
        {
            if (!FileUploadHelper.TrySaveImage(fu2, folder, out img2, out uploadErr))
            {
                lblMsg.Text = "Image 2 upload error: " + uploadErr;
                return;
            }
        }

        if (fu3.HasFile)
        {
            if (!FileUploadHelper.TrySaveImage(fu3, folder, out img3, out uploadErr))
            {
                lblMsg.Text = "Image 3 upload error: " + uploadErr;
                return;
            }
        }




        using (SqlConnection con = new SqlConnection(constr))
        {

            con.Open();



            // STEP 1 → brand check

            SqlCommand brandCmd = new SqlCommand(
            "SELECT BrandID FROM Brands WHERE BrandName=@name", con);

            brandCmd.Parameters.AddWithValue("@name", brand);

            object brandObj = brandCmd.ExecuteScalar();

            int brandId;



            // STEP 2 → brand insert if not exists

            if (brandObj == null)
            {

                SqlCommand insertBrand = new SqlCommand(
                "INSERT INTO Brands (BrandName) OUTPUT INSERTED.BrandID VALUES(@name)", con);

                insertBrand.Parameters.AddWithValue("@name", brand);

                brandId = Convert.ToInt32(insertBrand.ExecuteScalar());

            }
            else
            {

                brandId = Convert.ToInt32(brandObj);

            }




            // STEP 3 → bike insert

            SqlCommand cmd = new SqlCommand(@"

INSERT INTO Bikes
(
DealerID,
BrandID,
ModelName,
Slug,
Price,
RangeKM,
TopSpeed,
MotorPower,
Description,
Image1,
Image2,
Image3,
KMDriven,
ManufactureYear,
OwnerNumber,
BikeCondition,
BatteryHealth,
IsUsed,
OwnerType,
IsApproved,
CreatedAt
)

VALUES
(
@dealer,
@brand,
@model,
@slug,
@price,
0,
0,
'NA',
@desc,
@img1,
@img2,
@img3,
@km,
@year,
@owner,
@cond,
@battery,
1,
'User',
0,
GETDATE()
)

", con);



            cmd.Parameters.AddWithValue("@dealer",
            Convert.ToInt32(Session["CustomerID"]));

            cmd.Parameters.AddWithValue("@brand", brandId);

            cmd.Parameters.AddWithValue("@model", model);

            cmd.Parameters.AddWithValue("@slug", slug);

            cmd.Parameters.AddWithValue("@price", price);

            cmd.Parameters.AddWithValue("@desc", txtDesc.Text);

            cmd.Parameters.AddWithValue("@img1", img1);
            cmd.Parameters.AddWithValue("@img2", img2);
            cmd.Parameters.AddWithValue("@img3", img3);

            cmd.Parameters.AddWithValue("@km", km);

            cmd.Parameters.AddWithValue("@year", year);

            cmd.Parameters.AddWithValue("@owner", ddlOwner.SelectedValue);

            cmd.Parameters.AddWithValue("@cond", ddlCondition.SelectedValue);

            cmd.Parameters.AddWithValue("@battery", ddlBattery.SelectedValue);

            cmd.ExecuteNonQuery();

        }



        lblMsg.ForeColor = System.Drawing.Color.Green;

        lblMsg.Text =
        "Bike submitted successfully. Waiting for admin approval.";


        ClearForm();

    }



    void ClearForm()
    {

        txtBrand.Text = "";
        txtModel.Text = "";
        txtYear.Text = "";
        txtKM.Text = "";
        txtPrice.Text = "";
        txtDesc.Text = "";

        ddlOwner.SelectedIndex = 0;
        ddlCondition.SelectedIndex = 0;
        ddlBattery.SelectedIndex = 0;

    }

}