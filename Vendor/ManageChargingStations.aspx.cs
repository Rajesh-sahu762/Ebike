using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Vendor_ManageChargingStations : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");

        if (!IsPostBack)
        {
            LoadStations();
        }
    }

    void LoadStations()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"

SELECT StationID, StationName, City, ConnectorType, IsApproved
FROM ChargingStations
WHERE VendorID=@vendor
ORDER BY CreatedAt DESC

", con);

            cmd.Parameters.AddWithValue("@vendor", Session["VendorID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvStations.DataSource = dt;
            gvStations.DataBind();
        }
    }

    protected void gvStations_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int id = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            if (e.CommandName == "DeleteStation")
            {
                SqlCommand cmd = new SqlCommand(
                "DELETE FROM ChargingStations WHERE StationID=@id AND VendorID=@vendor", con);

                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@vendor", Session["VendorID"]);

                cmd.ExecuteNonQuery();
            }
        }

        LoadStations();
    }
}