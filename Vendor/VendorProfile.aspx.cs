using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;

public partial class Vendor_VendorProfile : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");

        if (!IsPostBack)
            LoadProfile();
    }

    void LoadProfile()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT * FROM Users WHERE UserID=@id", con);

            cmd.Parameters.AddWithValue("@id", Session["VendorID"]);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                txtName.Text = dr["FullName"].ToString();
                txtEmail.Text = dr["Email"].ToString();
                txtMobile.Text = dr["Mobile"].ToString();
                txtShop.Text = dr["ShopName"].ToString();
                txtGST.Text = dr["GSTNo"].ToString();
                txtCity.Text = dr["City"].ToString();
                txtAddress.Text = dr["Address"].ToString();

                imgProfile.ImageUrl =
                    string.IsNullOrEmpty(dr["ProfileImage"].ToString())
                    ? "~/images/default.png"
                    : dr["ProfileImage"].ToString();

                lblApproval.Text = Convert.ToBoolean(dr["IsApproved"])
                    ? "<span class='badge bg-success'>Approved</span>"
                    : "<span class='badge bg-warning'>Pending Approval</span>";

                lblActive.Text = Convert.ToBoolean(dr["IsActive"])
                    ? "<span class='badge bg-success'>Active</span>"
                    : "<span class='badge bg-danger'>Inactive</span>";
            }

            dr.Close();
        }
    }

    protected void btnUpdateProfile_Click(object sender, EventArgs e)
    {
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

            cmd.Parameters.AddWithValue("@n", txtName.Text);
            cmd.Parameters.AddWithValue("@m", txtMobile.Text);
            cmd.Parameters.AddWithValue("@s", txtShop.Text);
            cmd.Parameters.AddWithValue("@g", txtGST.Text);
            cmd.Parameters.AddWithValue("@c", txtCity.Text);
            cmd.Parameters.AddWithValue("@a", txtAddress.Text);
            cmd.Parameters.AddWithValue("@id", Session["VendorID"]);

            cmd.ExecuteNonQuery();
        }

        lblMsg.Text = "Profile updated successfully.";
    }

    protected void btnUploadImage_Click(object sender, EventArgs e)
    {
        if (!fuProfile.HasFile)
            return;

        string ext = Path.GetExtension(fuProfile.FileName);
        string fileName = Guid.NewGuid().ToString() + ext;

        string folder = Server.MapPath("~/Uploads/Vendors/");

        if (!Directory.Exists(folder))
            Directory.CreateDirectory(folder);

        string path = "~/Uploads/Vendors/" + fileName;
        fuProfile.SaveAs(Path.Combine(folder, fileName));

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "UPDATE Users SET ProfileImage=@p WHERE UserID=@id", con);

            cmd.Parameters.AddWithValue("@p", path);
            cmd.Parameters.AddWithValue("@id", Session["VendorID"]);
            cmd.ExecuteNonQuery();
        }

        LoadProfile();
    }

    protected void btnChangePassword_Click(object sender, EventArgs e)
    {
        if (txtNewPass.Text != txtConfirmPass.Text)
        {
            lblMsg.Text = "Password mismatch.";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand check = new SqlCommand(
                "SELECT COUNT(*) FROM Users WHERE UserID=@id AND PasswordHash=@p", con);

            check.Parameters.AddWithValue("@id", Session["VendorID"]);
            check.Parameters.AddWithValue("@p", txtOldPass.Text);

            if (Convert.ToInt32(check.ExecuteScalar()) == 0)
            {
                lblMsg.Text = "Old password incorrect.";
                return;
            }

            SqlCommand update = new SqlCommand(
                "UPDATE Users SET PasswordHash=@p WHERE UserID=@id", con);

            update.Parameters.AddWithValue("@p", txtNewPass.Text);
            update.Parameters.AddWithValue("@id", Session["VendorID"]);
            update.ExecuteNonQuery();
        }

        lblMsg.Text = "Password changed successfully.";
    }
}
