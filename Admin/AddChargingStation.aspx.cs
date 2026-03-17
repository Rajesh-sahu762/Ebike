using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;


    protected void btnSave_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"

INSERT INTO ChargingStations
(VendorID, StationName, Phone, City, Address, ConnectorType, IsApproved)
VALUES
(NULL, @name, @phone, @city, @address, @type, 1)

", con);

            cmd.Parameters.AddWithValue("@name", txtName.Text);
            cmd.Parameters.AddWithValue("@phone", txtPhone.Text);
            cmd.Parameters.AddWithValue("@city", txtCity.Text);
            cmd.Parameters.AddWithValue("@address", txtAddress.Text);
            cmd.Parameters.AddWithValue("@type", txtConnector.Text);

            cmd.ExecuteNonQuery();
        }

        lblMsg.Text = "Station added and LIVE";
    }
}