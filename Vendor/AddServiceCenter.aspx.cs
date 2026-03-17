using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Vendor_AddServiceCenter : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");

        if (!IsPostBack)
        {
            LoadCenters();
        }
    }

    void LoadCenters()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT * FROM ServiceCenters WHERE VendorID=@v ORDER BY CreatedAt DESC", con);

            cmd.Parameters.AddWithValue("@v", Session["VendorID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvCenters.DataSource = dt;
            gvCenters.DataBind();
        }
    }

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

            // DUPLICATE CHECK
            SqlCommand check = new SqlCommand(
            "SELECT COUNT(*) FROM ServiceCenters WHERE CenterName=@n AND City=@c", con);

            check.Parameters.AddWithValue("@n", txtName.Text);
            check.Parameters.AddWithValue("@c", txtCity.Text);

            if (Convert.ToInt32(check.ExecuteScalar()) > 0)
            {
                lblMsg.Text = "Already exists";
                return;
            }

            SqlCommand cmd = new SqlCommand(@"
INSERT INTO ServiceCenters
(VendorID, CenterName, Phone, City, Address, ServiceType, IsApproved)
VALUES
(@v,@n,@p,@c,@a,@s,0)", con);

            cmd.Parameters.AddWithValue("@v", Session["VendorID"]);
            cmd.Parameters.AddWithValue("@n", txtName.Text);
            cmd.Parameters.AddWithValue("@p", txtPhone.Text);
            cmd.Parameters.AddWithValue("@c", txtCity.Text);
            cmd.Parameters.AddWithValue("@a", txtAddress.Text);
            cmd.Parameters.AddWithValue("@s", txtService.Text);

            cmd.ExecuteNonQuery();
        }

        lblMsg.Text = "Added (Pending Approval)";

        // CLEAR
        txtName.Text = "";
        txtPhone.Text = "";
        txtCity.Text = "";
        txtAddress.Text = "";
        txtService.Text = "";

        LoadCenters();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string query = @"
SELECT * FROM ServiceCenters
WHERE VendorID=@v
AND (CenterName LIKE @s OR City LIKE @s)
";

            if (ddlFilterStatus.SelectedValue != "")
                query += " AND IsApproved=@status";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@v", Session["VendorID"]);
            cmd.Parameters.AddWithValue("@s", "%" + txtSearch.Text + "%");

            if (ddlFilterStatus.SelectedValue != "")
                cmd.Parameters.AddWithValue("@status", ddlFilterStatus.SelectedValue);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvCenters.DataSource = dt;
            gvCenters.DataBind();
        }
    }

    protected void gvCenters_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DeleteCenter")
        {
            int id = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(
                "DELETE FROM ServiceCenters WHERE ServiceID=@id AND VendorID=@v", con);

                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@v", Session["VendorID"]);

                cmd.ExecuteNonQuery();
            }

            LoadCenters();
        }
    }
}