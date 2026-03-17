using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_ManageParts : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
            Response.Redirect("AdminLogin.aspx");

        if (!IsPostBack)
        {
            LoadParts();
        }
    }

    void LoadParts()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = @"

SELECT 
P.PartID,
P.PartName,
P.Category,
P.Price,
P.Stock,
P.Image1,
P.IsApproved,
U.FullName AS VendorName

FROM Parts P
INNER JOIN Users U ON P.VendorID = U.UserID

ORDER BY P.PartID DESC

";

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvParts.DataSource = dt;
            gvParts.DataBind();
        }
    }

    protected void gvParts_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int id = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // ✅ APPROVE
            if (e.CommandName == "ApprovePart")
            {
                SqlCommand cmd = new SqlCommand(
                "UPDATE Parts SET IsApproved=1 WHERE PartID=@id", con);

                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
            }

            // ❌ DELETE
            if (e.CommandName == "DeletePart")
            {
                SqlCommand cmd = new SqlCommand(
                "DELETE FROM Parts WHERE PartID=@id", con);

                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
            }
        }

        LoadParts();
    }
}