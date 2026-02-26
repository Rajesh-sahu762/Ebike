using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text.RegularExpressions;

public partial class Vendor_ManageBikes : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");

        if (!IsPostBack)
        {
            LoadBrandFilter();
            LoadBikes();
        }
    }

    // ================= LOAD BRAND FILTER =================
    void LoadBrandFilter()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(
                "SELECT BrandID, BrandName FROM Brands WHERE IsActive=1", con);

            ddlBrandFilter.DataSource = cmd.ExecuteReader();
            ddlBrandFilter.DataTextField = "BrandName";
            ddlBrandFilter.DataValueField = "BrandID";
            ddlBrandFilter.DataBind();
            ddlBrandFilter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All Brands", ""));
        }
    }

    // ================= LOAD BIKES =================
    void LoadBikes()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string query = @"
SELECT B.BikeID, BR.BrandName, B.ModelName, B.Price,
       B.Image1, B.IsApproved, B.CreatedAt,
       ISNULL(B.IsForRent,0) AS IsForRent,
       (SELECT COUNT(*) FROM Leads L WHERE L.BikeID=B.BikeID) AS LeadCount
FROM Bikes B
INNER JOIN Brands BR ON B.BrandID=BR.BrandID
WHERE B.DealerID=@DealerID
ORDER BY B.CreatedAt DESC";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@DealerID",
                Convert.ToInt32(Session["VendorID"]));

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvBikes.DataSource = dt;
            gvBikes.DataBind();
        }
    }

    // ================= ROW COMMAND =================
    protected void gvBikes_RowCommand(object sender,
        System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int bikeId = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "ToggleRent")
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                "UPDATE Bikes SET IsForRent = CASE WHEN IsForRent=1 THEN 0 ELSE 1 END WHERE BikeID=@id AND DealerID=@d", con);

                cmd.Parameters.AddWithValue("@id", bikeId);
                cmd.Parameters.AddWithValue("@d", Convert.ToInt32(Session["VendorID"]));
                cmd.ExecuteNonQuery();
            }
            LoadBikes();
        }

        if (e.CommandName == "EditBike")
        {
            LoadEditBike(bikeId);
        }

        if (e.CommandName == "DeleteBike")
        {
            DeleteBike(bikeId);
            LoadBikes();
        }
    }

    // ================= LOAD EDIT MODAL =================
    void LoadEditBike(int bikeId)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(
                "SELECT * FROM Bikes WHERE BikeID=@id AND DealerID=@d", con);

            cmd.Parameters.AddWithValue("@id", bikeId);
            cmd.Parameters.AddWithValue("@d",
                Convert.ToInt32(Session["VendorID"]));

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                hfBikeID.Value = bikeId.ToString();
                txtModelEdit.Text = dr["ModelName"].ToString();
                txtPriceEdit.Text = dr["Price"].ToString();
                txtRangeEdit.Text = dr["RangeKM"].ToString();
                txtDescEdit.Text = dr["Description"].ToString();

                chkRentEdit.Checked = dr["IsForRent"] != DBNull.Value &&
                                      Convert.ToBoolean(dr["IsForRent"]);

                txtRentDayEdit.Text = dr["RentPerDay"] == DBNull.Value ? "" : dr["RentPerDay"].ToString();
                txtRentWeekEdit.Text = dr["RentPerWeek"] == DBNull.Value ? "" : dr["RentPerWeek"].ToString();
                txtRentMonthEdit.Text = dr["RentPerMonth"] == DBNull.Value ? "" : dr["RentPerMonth"].ToString();
            }

            dr.Close();
        }

        ClientScript.RegisterStartupScript(this.GetType(),
    "OpenModal",
    "var myModal = new bootstrap.Modal(document.getElementById('editModal')); myModal.show();",
    true);
    }

    // ================= UPDATE BIKE =================
    protected void btnUpdateBike_Click(object sender, EventArgs e)
    {
        int bikeId = Convert.ToInt32(hfBikeID.Value);
        int dealerId = Convert.ToInt32(Session["VendorID"]);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
@"UPDATE Bikes SET
ModelName=@model,
Price=@price,
RangeKM=@range,
Description=@desc,
IsForRent=@rent,
RentPerDay=@rentDay,
RentPerWeek=@rentWeek,
RentPerMonth=@rentMonth,
IsApproved=0
WHERE BikeID=@id AND DealerID=@d", con);

            cmd.Parameters.AddWithValue("@model", txtModelEdit.Text.Trim());
            cmd.Parameters.AddWithValue("@price", txtPriceEdit.Text);
            cmd.Parameters.AddWithValue("@range", txtRangeEdit.Text);
            cmd.Parameters.AddWithValue("@desc", txtDescEdit.Text);
            cmd.Parameters.AddWithValue("@rent", chkRentEdit.Checked);

            cmd.Parameters.AddWithValue("@rentDay",
                string.IsNullOrEmpty(txtRentDayEdit.Text) ? (object)DBNull.Value : txtRentDayEdit.Text);

            cmd.Parameters.AddWithValue("@rentWeek",
                string.IsNullOrEmpty(txtRentWeekEdit.Text) ? (object)DBNull.Value : txtRentWeekEdit.Text);

            cmd.Parameters.AddWithValue("@rentMonth",
                string.IsNullOrEmpty(txtRentMonthEdit.Text) ? (object)DBNull.Value : txtRentMonthEdit.Text);

            cmd.Parameters.AddWithValue("@id", bikeId);
            cmd.Parameters.AddWithValue("@d", dealerId);

            cmd.ExecuteNonQuery();
        }

        LoadBikes();
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        LoadBikes();
    }

    protected void gvBikes_PageIndexChanging(object sender,
    System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvBikes.PageIndex = e.NewPageIndex;
        LoadBikes();
    }

    // ================= DELETE =================
    void DeleteBike(int bikeId)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand(
                "DELETE FROM Bikes WHERE BikeID=@id AND DealerID=@d", con);

            cmd.Parameters.AddWithValue("@id", bikeId);
            cmd.Parameters.AddWithValue("@d",
                Convert.ToInt32(Session["VendorID"]));

            cmd.ExecuteNonQuery();
        }
    }
}