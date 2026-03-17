using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_AddServiceCenter : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
            Response.Redirect("AdminLogin.aspx");

        if (!IsPostBack)
        {
            LoadCenters();
        }
    }

    // LOAD DATA
    void LoadCenters()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string query = "SELECT * FROM ServiceCenters ORDER BY CreatedAt DESC";

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvCenters.DataSource = dt;
            gvCenters.DataBind();
        }
    }

    // ADD CENTER
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (txtName.Text.Trim() == "" || txtCity.Text.Trim() == "")
        {
            lblMsg.Text = "Required fields missing";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // 🔥 DUPLICATE CHECK
            SqlCommand check = new SqlCommand(
            "SELECT COUNT(*) FROM ServiceCenters WHERE CenterName=@n AND City=@c", con);

            check.Parameters.AddWithValue("@n", txtName.Text);
            check.Parameters.AddWithValue("@c", txtCity.Text);

            int exists = Convert.ToInt32(check.ExecuteScalar());

            if (exists > 0)
            {
                lblMsg.Text = "Already exists!";
                return;
            }

            SqlCommand cmd = new SqlCommand(@"
INSERT INTO ServiceCenters
(VendorID, CenterName, Phone, City, Address, ServiceType, IsApproved)
VALUES
(NULL, @n, @p, @c, @a, @s, 1)
", con);

            cmd.Parameters.AddWithValue("@n", txtName.Text);
            cmd.Parameters.AddWithValue("@p", txtPhone.Text);
            cmd.Parameters.AddWithValue("@c", txtCity.Text);
            cmd.Parameters.AddWithValue("@a", txtAddress.Text);
            cmd.Parameters.AddWithValue("@s", txtService.Text);

            cmd.ExecuteNonQuery();
        }

        lblMsg.Text = "Added Successfully";

        // 🔥 CLEAR INPUTS
        txtName.Text = "";
        txtPhone.Text = "";
        txtCity.Text = "";
        txtAddress.Text = "";
        txtService.Text = "";

        LoadCenters();
    }

    // SEARCH
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
SELECT * FROM ServiceCenters
WHERE CenterName LIKE @s OR City LIKE @s
", con);

            cmd.Parameters.AddWithValue("@s", "%" + txtSearch.Text + "%");

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvCenters.DataSource = dt;
            gvCenters.DataBind();
        }
    }

    // GRID ACTIONS
    protected void gvCenters_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int id = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            if (e.CommandName == "Approve")
            {
                SqlCommand cmd = new SqlCommand(
                "UPDATE ServiceCenters SET IsApproved=1 WHERE ServiceID=@id", con);

                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
            }

            if (e.CommandName == "DeleteCenter")
            {
                SqlCommand cmd = new SqlCommand(
                "DELETE FROM ServiceCenters WHERE ServiceID=@id", con);

                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
            }
        }

        LoadCenters();
    }
}