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
            LoadApprovedBikes();
        }
    }


    void LoadApprovedBikes(string keyword = "", string type = "")
    {

        SqlConnection con = new SqlConnection(constr);

        string query = @"SELECT 
B.BikeID,
ISNULL(BR.BrandName,'User Added') AS BrandName,
B.ModelName,
B.Price,
B.Image1,
ISNULL(B.IsUsed,0) AS IsUsed
FROM Bikes B
LEFT JOIN Brands BR ON B.BrandID = BR.BrandID
WHERE B.IsApproved = 1";


        if (keyword != "")
            query += " AND B.ModelName LIKE @search";

        if (type != "")
            query += " AND B.IsUsed=@type";


        SqlCommand cmd = new SqlCommand(query, con);

        if (keyword != "")
            cmd.Parameters.AddWithValue("@search", "%" + keyword + "%");

        if (type != "")
            cmd.Parameters.AddWithValue("@type", type);


        SqlDataAdapter da = new SqlDataAdapter(cmd);

        DataTable dt = new DataTable();
        da.Fill(dt);

        gvApproved.DataSource = dt;
        gvApproved.DataBind();

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {

        LoadApprovedBikes(
        txtSearch.Text.Trim(),
        ddlType.SelectedValue
        );

    }

    protected void gvApproved_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {

        if (e.CommandName == "HardDelete")
        {

            int bikeId = Convert.ToInt32(e.CommandArgument);

            SqlConnection con = new SqlConnection(constr);
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT Image1,Image2,Image3 FROM Bikes WHERE BikeID=@id", con);

            cmd.Parameters.AddWithValue("@id", bikeId);

            SqlDataReader dr = cmd.ExecuteReader();

            string i1 = "", i2 = "", i3 = "";

            if (dr.Read())
            {

                i1 = dr["Image1"].ToString();
                i2 = dr["Image2"].ToString();
                i3 = dr["Image3"].ToString();

            }

            dr.Close();


            string path = Server.MapPath("~/Uploads/Bikes/");

            if (i1 != "" && System.IO.File.Exists(path + i1))
                System.IO.File.Delete(path + i1);

            if (i2 != "" && System.IO.File.Exists(path + i2))
                System.IO.File.Delete(path + i2);

            if (i3 != "" && System.IO.File.Exists(path + i3))
                System.IO.File.Delete(path + i3);


            SqlCommand del = new SqlCommand(
            "DELETE FROM Bikes WHERE BikeID=@id", con);

            del.Parameters.AddWithValue("@id", bikeId);

            del.ExecuteNonQuery();

            con.Close();

            LoadApprovedBikes();

        }

    }

    void LoadBikes()
    {
        SqlConnection con = new SqlConnection(constr);

        string query = @"SELECT 
B.BikeID,
ISNULL(BR.BrandName,'User Added') AS BrandName,
B.ModelName,
B.Price,
B.RangeKM,
B.Image1,
B.IsUsed
FROM Bikes B
LEFT JOIN Brands BR ON B.BrandID = BR.BrandID
WHERE B.IsApproved = 0";

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
