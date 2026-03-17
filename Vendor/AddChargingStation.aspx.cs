using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Vendor_AddChargingStation : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        // VALIDATION
        if (txtName.Text.Trim() == "" || txtCity.Text.Trim() == "")
        {
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Text = "Station Name and City required";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"

INSERT INTO ChargingStations
(VendorID, StationName, Phone, City, Address, ConnectorType, IsApproved)
VALUES
(@vendor, @name, @phone, @city, @address, @type, 0)

", con);

            cmd.Parameters.AddWithValue("@vendor", Session["VendorID"]);
            cmd.Parameters.AddWithValue("@name", txtName.Text);
            cmd.Parameters.AddWithValue("@phone", txtPhone.Text);
            cmd.Parameters.AddWithValue("@city", txtCity.Text);
            cmd.Parameters.AddWithValue("@address", txtAddress.Text);
            cmd.Parameters.AddWithValue("@type", txtConnector.Text);

            cmd.ExecuteNonQuery();

            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Station added successfully (Pending approval)";

            txtName.Text = "";
            txtPhone.Text = "";
            txtCity.Text = "";
            txtAddress.Text = "";
            txtConnector.Text = "";
        }
    }
}