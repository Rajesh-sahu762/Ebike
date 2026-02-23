using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

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

            if (!string.IsNullOrEmpty(b1) &&
                !string.IsNullOrEmpty(b2) &&
                b1 != b2)
            {
                LoadComparison(b1, b2);
                ComparePanel.Visible = true;
            }
        }
    }

    // ================= SELECT DROPDOWNS =================

    void LoadSelectors()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT BikeID,ModelName FROM Bikes WHERE IsApproved=1",
            con);

            SqlDataReader dr = cmd.ExecuteReader();

            string s1 = "<select name='bike1' class='form-control'>";
            string s2 = "<select name='bike2' class='form-control'>";

            s1 += "<option value=''>Select Bike</option>";
            s2 += "<option value=''>Select Bike</option>";

            while (dr.Read())
            {
                s1 += "<option value='" + dr["BikeID"] + "'>" +
                      dr["ModelName"] + "</option>";

                s2 += "<option value='" + dr["BikeID"] + "'>" +
                      dr["ModelName"] + "</option>";
            }

            s1 += "</select>";
            s2 += "</select>";

            Bike1Select.Text = s1;
            Bike2Select.Text = s2;
        }
    }

    protected void CompareNow(object sender, EventArgs e)
    {
        string b1 = Request.Form["bike1"];
        string b2 = Request.Form["bike2"];

        if (string.IsNullOrEmpty(b1) ||
            string.IsNullOrEmpty(b2) ||
            b1 == b2)
            return;

        Response.Redirect("Compare.aspx?b1=" + b1 + "&b2=" + b2);
    }

    // ================= LOAD COMPARISON =================

    void LoadComparison(string id1, string id2)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT * FROM Bikes WHERE BikeID=@b1 OR BikeID=@b2",
            con);

            cmd.Parameters.AddWithValue("@b1", id1);
            cmd.Parameters.AddWithValue("@b2", id2);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count < 2) return;

            DataRow b1 = dt.Rows[0];
            DataRow b2 = dt.Rows[1];

            // HEADER
            Bike1Header.Text =
            "<div><img src='/Uploads/Bikes/" + b1["Image1"] +
            "'/><h6>" + b1["ModelName"] + "</h6></div>";

            Bike2Header.Text =
            "<div><img src='/Uploads/Bikes/" + b2["Image1"] +
            "'/><h6>" + b2["ModelName"] + "</h6></div>";

            // SPEC TABLE (ALL COLUMNS DYNAMIC)
            SpecRows.Text = "";

            foreach (DataColumn col in dt.Columns)
            {
                string name = col.ColumnName;

                if (name == "BikeID" ||
                    name.StartsWith("Image"))
                    continue;

                SpecRows.Text += BuildRow(name,
                    b1[name],
                    b2[name]);
            }

            // IMAGES
            ImageRows.Text =
            "<tr><th>Gallery</th><td>" +
            BuildImages(b1) +
            "</td><td>" +
            BuildImages(b2) +
            "</td></tr>";

            // REVIEWS
            ReviewRows.Text =
            "<tr><th>User Rating</th><td>" +
            GetAverageRating(id1) +
            "</td><td>" +
            GetAverageRating(id2) +
            "</td></tr>";
        }
    }

    // ================= BUILD ROW =================

    string BuildRow(string title, object v1, object v2)
    {
        string s1 = v1 == DBNull.Value ? "N/A" : v1.ToString();
        string s2 = v2 == DBNull.Value ? "N/A" : v2.ToString();

        decimal a, b;

        bool n1 = decimal.TryParse(s1.Replace("₹", "")
                                      .Replace(",", "")
                                      .Trim(), out a);

        bool n2 = decimal.TryParse(s2.Replace("₹", "")
                                      .Replace(",", "")
                                      .Trim(), out b);

        if (n1 && n2 && a != b)
        {
            if (a > b)
                s1 = "<span class='highlight'>" + s1 + "</span>";
            else
                s2 = "<span class='highlight'>" + s2 + "</span>";
        }

        return "<tr><th>" + title + "</th><td>" +
               s1 + "</td><td>" + s2 + "</td></tr>";
    }

    // ================= IMAGES =================

    string BuildImages(DataRow bike)
    {
        string html = "";

        for (int i = 1; i <= 4; i++)
        {
            string col = "Image" + i;

            if (bike.Table.Columns.Contains(col) &&
                bike[col] != DBNull.Value &&
                bike[col].ToString() != "")
            {
                html += "<img src='/Uploads/Bikes/" +
                        bike[col] +
                        "' height='80' style='margin:5px;border-radius:8px;' />";
            }
        }

        return html;
    }

    // ================= REVIEWS =================

    string GetAverageRating(string bikeId)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT ISNULL(AVG(CAST(Rating AS FLOAT)),0) " +
            "FROM BikeReviews " +
            "WHERE BikeID=@id AND IsApproved=1",
            con);

            cmd.Parameters.AddWithValue("@id", bikeId);

            decimal avg = Convert.ToDecimal(cmd.ExecuteScalar());

            return BuildStars(avg) +
                   " <br/><small>(" + GetReviewCount(bikeId) + " Reviews)</small>";
        }
    }

    string GetReviewCount(string bikeId)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT COUNT(*) FROM BikeReviews WHERE BikeID=@id AND IsApproved=1",
            con);

            cmd.Parameters.AddWithValue("@id", bikeId);

            return cmd.ExecuteScalar().ToString();
        }
    }



    string BuildStars(decimal rating)
    {
        string stars = "";
        int full = (int)Math.Round(rating);

        for (int i = 1; i <= 5; i++)
        {
            stars += i <= full
                ? "<span style='color:#facc15;'>★</span>"
                : "<span style='color:#475569;'>★</span>";
        }

        return stars + " (" + rating.ToString("0.0") + ")";
    }

    // ================= POPULAR =================

    void LoadPopular()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlDataAdapter da = new SqlDataAdapter(
            "SELECT TOP 4 b1.BikeID AS BikeID1, b2.BikeID AS BikeID2, " +
            "b1.ModelName AS ModelName, b2.ModelName AS ModelName2, " +
            "b1.Image1, b2.Image1 AS Image2 " +
            "FROM Bikes b1 CROSS JOIN Bikes b2 " +
            "WHERE b1.BikeID <> b2.BikeID " +
            "AND b1.IsApproved=1 AND b2.IsApproved=1",
            con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            rptPopular.DataSource = dt;
            rptPopular.DataBind();
        }
    }
}
