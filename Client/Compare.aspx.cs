using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;


public partial class Compare : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadSelectors();
            LoadPopular();

            string b1 = Request.QueryString["b1"];
            string b2 = Request.QueryString["b2"];

            if (!string.IsNullOrEmpty(b1) && !string.IsNullOrEmpty(b2))
            {
                LoadComparison(b1, b2);
                ComparePanel.Visible = true;
            }
        }
    }

    void LoadSelectors()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT BikeID,ModelName FROM Bikes WHERE IsApproved=1", con);
            SqlDataReader dr = cmd.ExecuteReader();

            string s1 = "<div class='add-bike-card'><select name='bike1' class='form-control'>";
            string s2 = "<div class='add-bike-card'><select name='bike2' class='form-control'>";

            s1 += "<option value=''>Select Bike</option>";
            s2 += "<option value=''>Select Bike</option>";

            while (dr.Read())
            {
                s1 += "<option value='" + dr["BikeID"] + "'>" + dr["ModelName"] + "</option>";
                s2 += "<option value='" + dr["BikeID"] + "'>" + dr["ModelName"] + "</option>";
            }

            s1 += "</select></div>";
            s2 += "</select></div>";

            Bike1Select.Text = s1;
            Bike2Select.Text = s2;
        }
    }


    [WebMethod]
    public static string LoadTabData(string tab, string b1, string b2)
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
"SELECT * FROM Bikes WHERE BikeID=@b1 OR BikeID=@b2", con);

cmd.Parameters.AddWithValue("@b1", b1);
cmd.Parameters.AddWithValue("@b2", b2);


            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count < 2) return "";

            DataRow bike1 = dt.Rows[0];
            DataRow bike2 = dt.Rows[1];

            if (tab == "features")
            {
                return "<tr><th>ABS</th><td>" + bike1["ABS"] + "</td><td>" + bike2["ABS"] + "</td></tr>"
                     + "<tr><th>Bluetooth</th><td>" + bike1["Bluetooth"] + "</td><td>" + bike2["Bluetooth"] + "</td></tr>";
            }

            if (tab == "colours")
            {
                return "<tr><th>Available Colours</th><td>" + bike1["Colours"] + "</td><td>" + bike2["Colours"] + "</td></tr>";
            }

            if (tab == "reviews")
            {
                return "<tr><th>User Rating</th><td>" + GetStars(bike1["Rating"]) + "</td><td>" + GetStars(bike2["Rating"]) + "</td></tr>";
            }


            if (tab == "images")
            {
                return "<tr><th>Gallery</th><td><img src='/Uploads/Bikes/" + bike1["Image1"] + "' height='100'/></td>"
                     + "<td><img src='/Uploads/Bikes/" + bike2["Image1"] + "' height='100'/></td></tr>";
            }

            return "";
        }
    }

    static string GetStars(object ratingObj)
    {
        int rating = Convert.ToInt32(ratingObj);
        string stars = "";

        for (int i = 1; i <= 5; i++)
        {
            if (i <= rating)
                stars += "<span style='color:gold;font-size:18px;'>★</span>";
            else
                stars += "<span style='color:#555;font-size:18px;'>☆</span>";
        }

        return stars;
    }



    protected void CompareNow(object sender, EventArgs e)
    {
        string b1 = Request.Form["bike1"];
        string b2 = Request.Form["bike2"];

        if (string.IsNullOrEmpty(b1) || string.IsNullOrEmpty(b2))
        {
            return; // nothing selected
        }

        if (b1 == b2)
        {
            return; // same bike selected, do nothing
        }

        Response.Redirect("Compare.aspx?b1=" + b1 + "&b2=" + b2);
    }


    void LoadComparison(string id1, string id2)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT * FROM Bikes WHERE BikeID IN (" + id1 + "," + id2 + ")", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count < 2) return;

            DataRow b1 = dt.Rows[0];
            DataRow b2 = dt.Rows[1];

            Bike1Header.Text =
            "<img src='/Uploads/Bikes/" + b1["Image1"] + "'/><h6>" + b1["ModelName"] + "</h6>";

            Bike2Header.Text =
            "<img src='/Uploads/Bikes/" + b2["Image1"] + "'/><h6>" + b2["ModelName"] + "</h6>";

            PriceRow.Text = CompareValue(b1["Price"], b2["Price"], false);
            RangeRow.Text = CompareValue(b1["RangeKM"], b2["RangeKM"], true);
            SpeedRow.Text = CompareValue(b1["TopSpeed"], b2["TopSpeed"], true);
            MotorRow.Text = "<td>" + b1["MotorPower"] + "</td><td>" + b2["MotorPower"] + "</td>";
            BatteryRow.Text = "<td>" + b1["BatteryType"] + "</td><td>" + b2["BatteryType"] + "</td>";
        }
    }

    string CompareValue(object v1, object v2, bool higherBetter)
    {
        decimal a = Convert.ToDecimal(v1);
        decimal b = Convert.ToDecimal(v2);

        if (a == b)
            return "<td>" + a + "</td><td>" + b + "</td>";

        if (higherBetter)
        {
            if (a > b)
                return "<td class='highlight'>" + a + "</td><td>" + b + "</td>";
            else
                return "<td>" + a + "</td><td class='highlight'>" + b + "</td>";
        }
        else
        {
            if (a < b)
                return "<td class='highlight'>₹" + a + "</td><td>₹" + b + "</td>";
            else
                return "<td>₹" + a + "</td><td class='highlight'>₹" + b + "</td>";
        }
    }


    void LoadPopular()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(
            "SELECT TOP 3 * FROM Bikes WHERE IsApproved=1 ORDER BY CreatedAt DESC", con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            rptPopular.DataSource = dt;
            rptPopular.DataBind();
        }
    }
}
