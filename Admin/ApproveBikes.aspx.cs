using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_ApproveBikes : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
        {
            Response.Redirect("AdminLogin.aspx");
        }

        if (!IsPostBack)
        {
            LoadBikes();
        }
    }

    void LoadBikes()
    {
        SqlConnection con = new SqlConnection(constr);

        string query = @"SELECT B.BikeID, B.ModelName, B.Price, B.RangeKM,
                        B.Image1, BR.BrandName
                        FROM Bikes B
                        INNER JOIN Brands BR ON B.BrandID = BR.BrandID
                        WHERE B.IsApproved=0";

        SqlDataAdapter da = new SqlDataAdapter(query, con);
        DataTable dt = new DataTable();
        da.Fill(dt);

        gvBikes.DataSource = dt;
        gvBikes.DataBind();
    }

    protected void gvBikes_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int bikeId = Convert.ToInt32(e.CommandArgument);

        SqlConnection con = new SqlConnection(constr);
        con.Open();

        if (e.CommandName == "ApproveBike")
        {
            SqlCommand cmd = new SqlCommand("UPDATE Bikes SET IsApproved=1 WHERE BikeID=@id", con);
            cmd.Parameters.AddWithValue("@id", bikeId);
            cmd.ExecuteNonQuery();
        }

        if (e.CommandName == "RejectBike")
        {
            SqlCommand cmd = new SqlCommand("DELETE FROM Bikes WHERE BikeID=@id", con);
            cmd.Parameters.AddWithValue("@id", bikeId);
            cmd.ExecuteNonQuery();
        }

        if (e.CommandName == "ViewBike")
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM Bikes WHERE BikeID=@id", con);
            cmd.Parameters.AddWithValue("@id", bikeId);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                string details = "<b>Model:</b> " + dr["ModelName"] + "<br/>";
                details += "<b>Price:</b> ₹" + dr["Price"] + "<br/>";
                details += "<b>Range:</b> " + dr["RangeKM"] + " KM<br/>";
                details += "<b>Battery:</b> " + dr["BatteryType"] + "<br/>";
                details += "<b>Description:</b><br/>" + dr["Description"] + "<br/><br/>";

                string img1 = dr["Image1"] == DBNull.Value ? "" : dr["Image1"].ToString();
                string img2 = dr["Image2"] == DBNull.Value ? "" : dr["Image2"].ToString();
                string img3 = dr["Image3"] == DBNull.Value ? "" : dr["Image3"].ToString();

                string gallery = "";

                if (!string.IsNullOrEmpty(img1))
                    gallery += "<img src='/Uploads/Bikes/" + img1 + "' style=\"width:100%;margin-bottom:10px;border-radius:10px;\" />";

                if (!string.IsNullOrEmpty(img2))
                    gallery += "<img src='/Uploads/Bikes/" + img2 + "' style=\"width:100%;margin-bottom:10px;border-radius:10px;\" />";

                if (!string.IsNullOrEmpty(img3))
                    gallery += "<img src='/Uploads/Bikes/" + img3 + "' style=\"width:100%;border-radius:10px;\" />";

                dr.Close();

                litBikeDetails.Text = details;

                ClientScript.RegisterStartupScript(this.GetType(),
                    "ShowModal",
                    "document.getElementById('bikeGallery').innerHTML = \"" + gallery.Replace("\"", "\\\"") + "\";" +
                    "var myModal = new bootstrap.Modal(document.getElementById('bikeModal')); myModal.show();",
                    true);
            }
        }



        con.Close();

        LoadBikes();
    }
}
