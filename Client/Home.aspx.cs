using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Client_Home : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadBrands();
            LoadBikes();
        }
    }

    void LoadBrands()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT BrandID,BrandName FROM Brands WHERE IsActive=1", con);
            ddlBrand.DataSource = cmd.ExecuteReader();
            ddlBrand.DataTextField = "BrandName";
            ddlBrand.DataValueField = "BrandID";
            ddlBrand.DataBind();

            ddlBrand.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Brand", ""));
        }
    }

    void LoadBikes()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string query = @"SELECT BikeID,ModelName,Price,RangeKM,Image1,Slug
                             FROM Bikes
                             WHERE IsApproved=1";

            if (ddlBudget.SelectedValue != "")
                query += " AND Price <= " + ddlBudget.SelectedValue;

            if (ddlBrand.SelectedValue != "")
                query += " AND BrandID = " + ddlBrand.SelectedValue;

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptBikes.DataSource = dt;
            rptBikes.DataBind();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadBikes();
    }
}
