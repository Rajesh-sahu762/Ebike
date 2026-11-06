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
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("AdminLogin.aspx");
            return;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("AdminLogin.aspx");
            return;
        }

        string name = txtName.Text.Trim();
        string phone = txtPhone.Text.Trim();
        string city = txtCity.Text.Trim();
        string address = txtAddress.Text.Trim();
        string type = txtConnector.Text.Trim();

        if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(city))
        {
            lblMsg.Text = "Station name and city are required.";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            INSERT INTO ChargingStations
            (VendorID, StationName, Phone, City, Address, ConnectorType, IsApproved)
            VALUES
            (NULL, @name, @phone, @city, @address, @type, 1)", con);

            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@phone", phone);
            cmd.Parameters.AddWithValue("@city", city);
            cmd.Parameters.AddWithValue("@address", address);
            cmd.Parameters.AddWithValue("@type", type);

            cmd.ExecuteNonQuery();
        }

        lblMsg.Text = "Station added and LIVE";
    }
}
