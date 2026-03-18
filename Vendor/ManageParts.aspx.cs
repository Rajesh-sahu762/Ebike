using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Vendor_ManageParts : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");

        if (!IsPostBack)
        {
            LoadCategories();
            LoadParts();
        }
    }

    void LoadCategories()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand("SELECT DISTINCT Category FROM Parts", con);

            ddlCategory.DataSource = cmd.ExecuteReader();
            ddlCategory.DataTextField = "Category";
            ddlCategory.DataValueField = "Category";
            ddlCategory.DataBind();
        }

        // Default categories अगर DB empty हो
        if (ddlCategory.Items.Count == 0)
        {
            ddlCategory.Items.Add("Battery");
            ddlCategory.Items.Add("Motor");
            ddlCategory.Items.Add("Controller");
            ddlCategory.Items.Add("Charger");
        }
    }

    void LoadParts()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            SqlDataAdapter da = new SqlDataAdapter(
            "SELECT * FROM Parts WHERE VendorID=@v ORDER BY PartID DESC", con);

            da.SelectCommand.Parameters.AddWithValue("@v", Session["VendorID"]);

            DataTable dt = new DataTable();
            da.Fill(dt);

            gvParts.DataSource = dt;
            gvParts.DataBind();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        decimal price;
        int stock;

        if (!decimal.TryParse(txtPrice.Text, out price))
        {
            lblMsg.Text = "Invalid price";
            return;
        }

        if (!int.TryParse(txtStock.Text, out stock))
        {
            stock = 0;
        }

        string fileName = "";

        if (fuImage.HasFile)
        {
            fileName = fuImage.FileName;

            if (fileName.Contains("\\"))
                fileName = fileName.Substring(fileName.LastIndexOf("\\") + 1);

            string path = Server.MapPath("~/Uploads/Parts/" + fileName);

            fuImage.SaveAs(path);
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
INSERT INTO Parts
(VendorID,PartName,Category,Price,Stock,Description,Image1,IsApproved)
VALUES
(@v,@n,@c,@p,@s,@d,@img,0)", con);

            cmd.Parameters.AddWithValue("@v", Session["VendorID"]);
            cmd.Parameters.AddWithValue("@n", txtName.Text);
            cmd.Parameters.AddWithValue("@c", ddlCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@p", price);
            cmd.Parameters.AddWithValue("@s", stock);
            cmd.Parameters.AddWithValue("@d", txtDesc.Text);
            cmd.Parameters.AddWithValue("@img", fileName);

            cmd.ExecuteNonQuery();
        }

        lblMsg.Text = "Added Successfully";

        // CLEAR FORM
        txtName.Text = "";
        txtPrice.Text = "";
        txtStock.Text = "";
        txtDesc.Text = "";

        LoadParts();
    }



    protected void gvParts_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DeletePart")
        {
            int id = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(
                "DELETE FROM Parts WHERE PartID=@id AND VendorID=@v", con);

                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@v", Session["VendorID"]);

                cmd.ExecuteNonQuery();
            }

            LoadParts();
        }
    }
}