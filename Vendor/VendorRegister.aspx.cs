using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Vendor_VendorRegister : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (txtFullName.Text.Trim() == "" ||
            txtEmail.Text.Trim() == "" ||
            txtMobile.Text.Trim() == "" ||
            txtShop.Text.Trim() == "" ||
            txtPassword.Text.Trim() == "")
        {
            return;
        }

        if (txtPassword.Text != txtConfirm.Text)
        {
            return;
        }

        SqlConnection con = new SqlConnection(constr);
        con.Open();

        // Duplicate Email
        SqlCommand checkEmail = new SqlCommand(
            "SELECT COUNT(*) FROM Users WHERE Email=@Email", con);
        checkEmail.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

        if (Convert.ToInt32(checkEmail.ExecuteScalar()) > 0)
        {
            con.Close();
            return;
        }

        // Duplicate Mobile
        SqlCommand checkMobile = new SqlCommand(
            "SELECT COUNT(*) FROM Users WHERE Mobile=@Mobile", con);
        checkMobile.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());

        if (Convert.ToInt32(checkMobile.ExecuteScalar()) > 0)
        {
            con.Close();
            return;
        }

        // Insert Vendor
        SqlCommand cmd = new SqlCommand(
        @"INSERT INTO Users
        (FullName, Email, Mobile, PasswordHash, Role,
         ShopName, City,
         IsApproved, IsActive, CreatedAt)
        VALUES
        (@FullName, @Email, @Mobile, @Password, 'Dealer',
         @ShopName, @City,
         0, 1, GETDATE())", con);

        cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
        cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
        cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
        cmd.Parameters.AddWithValue("@ShopName", txtShop.Text.Trim());
        cmd.Parameters.AddWithValue("@City", txtCity.Text.Trim());

        cmd.ExecuteNonQuery();

        con.Close();

        Response.Redirect("VendorLogin.aspx");
    }
}