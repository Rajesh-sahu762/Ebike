using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_ManageChargingStations : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
            Response.Redirect("AdminLogin.aspx");

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

SELECT 
CS.StationID,
CS.StationName,
CS.City,
CS.ConnectorType,
CS.IsApproved,
ISNULL(U.FullName,'Admin') AS VendorName

FROM ChargingStations CS

LEFT JOIN Users U 
ON CS.VendorID = U.UserID

ORDER BY CS.CreatedAt DESC

", con);

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

            if (e.CommandName == "Approve")
            {
                SqlCommand cmd = new SqlCommand(
                "UPDATE ChargingStations SET IsApproved=1 WHERE StationID=@id", con);

                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
            }

            if (e.CommandName == "DeleteStation")
            {
                SqlCommand cmd = new SqlCommand(
                "DELETE FROM ChargingStations WHERE StationID=@id", con);

                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
            }
        }

        LoadStations();
    }
}