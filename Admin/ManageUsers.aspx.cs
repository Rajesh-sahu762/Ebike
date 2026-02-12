using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_ManageUsers : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
            Response.Redirect("AdminLogin.aspx");

        if (!IsPostBack)
            LoadUsers();
    }

    void LoadUsers()
    {
        SqlConnection con = new SqlConnection(constr);

        string query = "SELECT * FROM Users WHERE 1=1";

        if (ddlRole.SelectedValue != "")
            query += " AND Role=@role";

        if (txtSearch.Text.Trim() != "")
            query += " AND (FullName LIKE @search OR Email LIKE @search)";

        SqlCommand cmd = new SqlCommand(query, con);

        if (ddlRole.SelectedValue != "")
            cmd.Parameters.AddWithValue("@role", ddlRole.SelectedValue);

        if (txtSearch.Text.Trim() != "")
            cmd.Parameters.AddWithValue("@search", "%" + txtSearch.Text.Trim() + "%");

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        gvUsers.DataSource = dt;
        gvUsers.DataBind();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadUsers();
    }

    protected void gvUsers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int userId = Convert.ToInt32(e.CommandArgument);

        SqlConnection con = new SqlConnection(constr);
        con.Open();

        if (e.CommandName == "ToggleUser")
        {
            SqlCommand cmd = new SqlCommand(
                "UPDATE Users SET IsActive = CASE WHEN IsActive=1 THEN 0 ELSE 1 END WHERE UserID=@id", con);
            cmd.Parameters.AddWithValue("@id", userId);
            cmd.ExecuteNonQuery();
        }

        if (e.CommandName == "DeleteUser")
        {
            SqlCommand cmd = new SqlCommand(
                "DELETE FROM Users WHERE UserID=@id", con);
            cmd.Parameters.AddWithValue("@id", userId);
            cmd.ExecuteNonQuery();
        }

        if (e.CommandName == "ViewUser")
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM Users WHERE UserID=@id", con);
            cmd.Parameters.AddWithValue("@id", userId);

            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                string details = "<b>Name:</b> " + dr["FullName"] + "<br/>";
                details += "<b>Email:</b> " + dr["Email"] + "<br/>";
                details += "<b>Role:</b> " + dr["Role"] + "<br/>";
                details += "<b>City:</b> " + dr["City"] + "<br/>";
                details += "<b>Status:</b> " + dr["IsActive"] + "<br/>";

                litUserDetails.Text = details;

                ClientScript.RegisterStartupScript(this.GetType(),
                    "Popup", "$('#userModal').modal('show');", true);
            }
        }

        con.Close();
        LoadUsers();
    }
}
