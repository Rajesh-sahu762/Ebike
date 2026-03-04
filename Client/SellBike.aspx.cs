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
            lblMsg.Text = "Upload at least 1 image";
            return;
        }

        string folder = Server.MapPath("~/Uploads/UsedBikes/");

        if (!Directory.Exists(folder))
            Directory.CreateDirectory(folder);

        string img1 = "", img2 = "", img3 = "";

        if (fu1.HasFile)
        {
            img1 = Guid.NewGuid() + Path.GetExtension(fu1.FileName);
            fu1.SaveAs(folder + img1);
        }

        if (fu2.HasFile)
        {
            img2 = Guid.NewGuid() + Path.GetExtension(fu2.FileName);
            fu2.SaveAs(folder + img2);
        }

        if (fu3.HasFile)
        {
            img3 = Guid.NewGuid() + Path.GetExtension(fu3.FileName);
            fu3.SaveAs(folder + img3);
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"

INSERT INTO Bikes
(DealerID,BrandID,ModelName,Price,
RangeKM,TopSpeed,MotorPower,Description,
Image1,Image2,Image3,
KMDriven,ManufactureYear,OwnerNumber,
BikeCondition,BatteryHealth,
IsUsed,OwnerType,IsApproved,CreatedAt)

VALUES
(@dealer,@brand,@model,@price,
0,0,'NA',@desc,
@img1,@img2,@img3,
@km,@year,@owner,
@cond,@battery,
1,'User',0,GETDATE())

", con);

            cmd.Parameters.AddWithValue("@dealer",
            Convert.ToInt32(Session["CustomerID"]));

            cmd.Parameters.AddWithValue("@brand", DBNull.Value);
            cmd.Parameters.AddWithValue("@model", txtModel.Text);
            cmd.Parameters.AddWithValue("@price", txtPrice.Text);

            cmd.Parameters.AddWithValue("@desc", txtDesc.Text);

            cmd.Parameters.AddWithValue("@img1", img1);
            cmd.Parameters.AddWithValue("@img2", img2);
            cmd.Parameters.AddWithValue("@img3", img3);

            cmd.Parameters.AddWithValue("@km", txtKM.Text);
            cmd.Parameters.AddWithValue("@year", txtYear.Text);
            cmd.Parameters.AddWithValue("@owner", ddlOwner.SelectedValue);

            cmd.Parameters.AddWithValue("@cond", ddlCondition.SelectedValue);
            cmd.Parameters.AddWithValue("@battery", ddlBattery.SelectedValue);

            cmd.ExecuteNonQuery();

        }

lblMsg.ForeColor = System.Drawing.Color.Green;
lblMsg.Text = "Bike submitted successfully. Waiting for admin approval.";

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