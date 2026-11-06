using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using EBIke.Security;

public partial class Vendor_VendorProfile : System.Web.UI.Page
{
    private readonly string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
        {
            Response.Redirect("VendorLogin.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }
        if (!IsPostBack) LoadProfile();
    }

    private void LoadProfile()
    {
        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand cmd = new SqlCommand(
            "SELECT FullName, Email, Mobile, ShopName, GSTNo, City, Address, ProfileImage, IsApproved, IsActive FROM dbo.Users WHERE UserID=@id AND Role='Dealer';", con))
        {
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(Session["VendorID"]);
            con.Open();
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                if (!dr.Read()) return;
                txtName.Text = Convert.ToString(dr["FullName"]);
                txtEmail.Text = Convert.ToString(dr["Email"]);
                txtMobile.Text = Convert.ToString(dr["Mobile"]);
                txtShop.Text = Convert.ToString(dr["ShopName"]);
                txtGST.Text = Convert.ToString(dr["GSTNo"]);
                txtCity.Text = Convert.ToString(dr["City"]);
                txtAddress.Text = Convert.ToString(dr["Address"]);
                imgProfile.ImageUrl = String.IsNullOrEmpty(Convert.ToString(dr["ProfileImage"]))
                    ? "~/images/default.png" : Convert.ToString(dr["ProfileImage"]);
                lblApproval.Text = Convert.ToBoolean(dr["IsApproved"]) ? "Approved" : "Pending Approval";
                lblActive.Text = Convert.ToBoolean(dr["IsActive"]) ? "Active" : "Inactive";
            }
        }
    }

    protected void btnUpdateProfile_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand cmd = new SqlCommand(@"
UPDATE dbo.Users SET FullName=@n, Mobile=@m, ShopName=@s, GSTNo=@g, City=@c, Address=@a
WHERE UserID=@id AND Role='Dealer';", con))
        {
            cmd.Parameters.Add("@n", SqlDbType.NVarChar, 150).Value = txtName.Text.Trim();
            cmd.Parameters.Add("@m", SqlDbType.NVarChar, 30).Value = txtMobile.Text.Trim();
            cmd.Parameters.Add("@s", SqlDbType.NVarChar, 150).Value = txtShop.Text.Trim();
            cmd.Parameters.Add("@g", SqlDbType.NVarChar, 50).Value = txtGST.Text.Trim();
            cmd.Parameters.Add("@c", SqlDbType.NVarChar, 100).Value = txtCity.Text.Trim();
            cmd.Parameters.Add("@a", SqlDbType.NVarChar, 500).Value = txtAddress.Text.Trim();
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(Session["VendorID"]);
            con.Open();
            cmd.ExecuteNonQuery();
        }
        lblMsg.Text = "Profile updated successfully.";
    }

    protected void btnUploadImage_Click(object sender, EventArgs e)
    {
        if (!fuProfile.HasFile) return;
        string folder = Server.MapPath("~/Uploads/Vendors/");
        string fileName;
        try { fileName = UploadSecurity.SaveImage(fuProfile, folder); }
        catch (InvalidOperationException ex) { lblMsg.Text = Server.HtmlEncode(ex.Message); return; }

        string relativePath = "~/Uploads/Vendors/" + fileName;
        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand cmd = new SqlCommand(
            "UPDATE dbo.Users SET ProfileImage=@path WHERE UserID=@id AND Role='Dealer';", con))
        {
            cmd.Parameters.Add("@path", SqlDbType.NVarChar, 300).Value = relativePath;
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = Convert.ToInt32(Session["VendorID"]);
            con.Open();
            cmd.ExecuteNonQuery();
        }
        LoadProfile();
    }

    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        if (txtNewPass.Text.Length < 10)
        {
            lblMsg.Text = "Use a password with at least 10 characters.";
            return;
        }
        if (txtNewPass.Text != txtConfirmPass.Text)
        {
            lblMsg.Text = "Passwords do not match.";
            return;
        }

        int vendorId = Convert.ToInt32(Session["VendorID"]);
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            string stored;
            using (SqlCommand check = new SqlCommand(
                "SELECT PasswordHash FROM dbo.Users WHERE UserID=@id AND Role='Dealer' AND IsActive=1;", con))
            {
                check.Parameters.Add("@id", SqlDbType.Int).Value = vendorId;
                object value = check.ExecuteScalar();
                if (value == null || value == DBNull.Value)
                {
                    lblMsg.Text = "Unable to verify account.";
                    return;
                }
                stored = Convert.ToString(value);
            }

            bool valid = PasswordSecurity.IsHashed(stored)
                ? PasswordSecurity.VerifyPassword(txtOldPass.Text, stored)
                : String.Equals(stored, txtOldPass.Text, StringComparison.Ordinal);
            if (!valid)
            {
                lblMsg.Text = "Old password incorrect.";
                return;
            }

            using (SqlCommand update = new SqlCommand(
                "UPDATE dbo.Users SET PasswordHash=@Hash WHERE UserID=@id AND Role='Dealer';", con))
            {
                update.Parameters.Add("@Hash", SqlDbType.NVarChar, 500).Value = PasswordSecurity.HashPassword(txtNewPass.Text);
                update.Parameters.Add("@id", SqlDbType.Int).Value = vendorId;
                update.ExecuteNonQuery();
            }
        }
        lblMsg.Text = "Password changed successfully.";
    }
}
