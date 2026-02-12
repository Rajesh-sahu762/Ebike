using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class AdminLogin : System.Web.UI.Page
{
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
        SqlConnection con = new SqlConnection(constr);

        con.Open();

        string query = "SELECT * FROM Users WHERE Email=@Email AND PasswordHash=@Password AND Role='Admin' AND IsActive=1";

        SqlCommand cmd = new SqlCommand(query, con);
        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
        cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

        SqlDataReader dr = cmd.ExecuteReader();

        if (dr.Read())
        {
            Session["AdminID"] = dr["UserID"].ToString();
            Session["Role"] = "Admin";
            Response.Redirect("AdminDashboard.aspx");
        }
        else
        {
            lblMsg.Text = "Invalid Email or Password!";
        }

        con.Close();
    }
}
