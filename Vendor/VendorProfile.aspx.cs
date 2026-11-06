using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

public partial class Vendor_VendorProfile : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Dealer")
        {
            Response.Redirect("VendorLogin.aspx");
            return;
        }

        if (!IsPostBack)
            LoadProfile();
    }

    void LoadProfile()
    {
        if (Session["VendorID"] == null) return;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT * FROM Users WHERE UserID=@id", con);

            cmd.Parameters.AddWithValue("@id", Session["VendorID"]);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                txtName.Text = dr["FullName"] != DBNull.Value ? dr["FullName"].ToString() : "";
                txtEmail.Text = dr["Email"] != DBNull.Value ? dr["Email"].ToString() : "";
                txtMobile.Text = dr["Mobile"] != DBNull.Value ? dr["Mobile"].ToString() : "";
                txtShop.Text = dr["ShopName"] != DBNull.Value ? dr["ShopName"].ToString() : "";
                txtGST.Text = dr["GSTNo"] != DBNull.Value ? dr["GSTNo"].ToString() : "";
                txtCity.Text = dr["City"] != DBNull.Value ? dr["City"].ToString() : "";
                txtAddress.Text = dr["Address"] != DBNull.Value ? dr["Address"].ToString() : "";

                string profileImg = dr["ProfileImage"] != DBNull.Value ? dr["ProfileImage"].ToString() : "";
                imgProfile.ImageUrl = string.IsNullOrEmpty(profileImg) ? "~/Uploads/images/dealer.png" : profileImg;

                bool isApproved = dr["IsApproved"] != DBNull.Value && Convert.ToBoolean(dr["IsApproved"]);
                bool isActive = dr["IsActive"] != DBNull.Value && Convert.ToBoolean(dr["IsActive"]);

                lblApproval.Text = isApproved
                    ? "<span class='badge bg-success'>Approved</span>"
                    : "<span class='badge bg-warning'>Pending Approval</span>";

                lblActive.Text = isActive
                    ? "<span class='badge bg-success'>Active</span>"
                    : "<span class='badge bg-danger'>Inactive</span>";
            }

            dr.Close();
        }
    }

    protected void btnUpdateProfile_Click(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
        {
            Response.Redirect("VendorLogin.aspx");
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            @"UPDATE Users SET 
              FullName=@n,
              Mobile=@m,
              ShopName=@s,
              GSTNo=@g,
              City=@c,
              Address=@a
              WHERE UserID=@id", con);

            cmd.Parameters.AddWithValue("@n", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@m", txtMobile.Text.Trim());
            cmd.Parameters.AddWithValue("@s", txtShop.Text.Trim());
            cmd.Parameters.AddWithValue("@g", txtGST.Text.Trim());
            cmd.Parameters.AddWithValue("@c", txtCity.Text.Trim());
            cmd.Parameters.AddWithValue("@a", txtAddress.Text.Trim());
            cmd.Parameters.AddWithValue("@id", Session["VendorID"]);

            cmd.ExecuteNonQuery();
        }

        Session["VendorName"] = txtName.Text.Trim();
        lblMsg.Text = "Profile updated successfully.";
    }

    protected void btnUploadImage_Click(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
        {
            Response.Redirect("VendorLogin.aspx");
            return;
        }

        if (!fuProfile.HasFile)
            return;

        string folder = Server.MapPath("~/Uploads/Vendors/");
        string savedFileName;
        string uploadError;

        if (!FileUploadHelper.TrySaveImage(fuProfile, folder, out savedFileName, out uploadError))
        {
            lblMsg.Text = "Image upload failed: " + uploadError;
            return;
        }

        string relativePath = "~/Uploads/Vendors/" + savedFileName;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "UPDATE Users SET ProfileImage=@p WHERE UserID=@id", con);

            cmd.Parameters.AddWithValue("@p", relativePath);
            cmd.Parameters.AddWithValue("@id", Session["VendorID"]);
            cmd.ExecuteNonQuery();
        }

        LoadProfile();
    }

    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
        {
            Response.Redirect("VendorLogin.aspx");
            return;
        }

        string oldPass = txtOldPass.Text;
        string newPass = txtNewPass.Text.Trim();
        string confirmPass = txtConfirmPass.Text.Trim();

        if (string.IsNullOrEmpty(oldPass) || string.IsNullOrEmpty(newPass))
        {
            lblMsg.Text = "Please fill all password fields.";
            return;
        }

        if (newPass != confirmPass)
        {
            lblMsg.Text = "Password mismatch.";
            return;
        }

        if (newPass.Length < 6)
        {
            lblMsg.Text = "Password must be at least 6 characters long.";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand check = new SqlCommand(
                "SELECT PasswordHash FROM Users WHERE UserID=@id", con);
            check.Parameters.AddWithValue("@id", Session["VendorID"]);

            string dbPass = Convert.ToString(check.ExecuteScalar());
            bool needsUpgrade;

            if (!SecurityHelper.VerifyPassword(oldPass, dbPass, out needsUpgrade))
            {
                lblMsg.Text = "Old password incorrect.";
                return;
            }

            string newHash = SecurityHelper.HashPassword(newPass);

            SqlCommand update = new SqlCommand(
                "UPDATE Users SET PasswordHash=@p WHERE UserID=@id", con);

            update.Parameters.AddWithValue("@p", newHash);
            update.Parameters.AddWithValue("@id", Session["VendorID"]);
            update.ExecuteNonQuery();
        }

        lblMsg.Text = "Password changed successfully.";
    }
}
