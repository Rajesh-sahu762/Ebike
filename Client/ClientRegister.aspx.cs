using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class Client_ClientRegister : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (txtPassword.Text != txtConfirm.Text)
        {
            lblMsg.Text = "Passwords do not match.";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // Check email duplicate
            SqlCommand check = new SqlCommand(
                "SELECT COUNT(*) FROM Users WHERE Email=@Email", con);

            check.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

            if (Convert.ToInt32(check.ExecuteScalar()) > 0)
            {
                lblMsg.Text = "Email already exists.";
                return;
            }

            // Insert Customer
            SqlCommand cmd = new SqlCommand(@"
            INSERT INTO Users
            (Role, FullName, Email, Mobile, PasswordHash,
             IsApproved, IsActive, CreatedAt)
            VALUES
            ('Customer', @Name, @Email, @Mobile, @Pass,
             1, 1, GETDATE())", con);

            cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
            cmd.Parameters.AddWithValue("@Pass", txtPassword.Text.Trim());

            cmd.ExecuteNonQuery();
        }

        Response.Redirect("ClientLogin.aspx");
    }
}
