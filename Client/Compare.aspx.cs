using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class Compare : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadSelectors();
            LoadPopular();   // 🔥 THIS WAS MISSING

            string b1 = Request.QueryString["b1"];
            string b2 = Request.QueryString["b2"];

            if (!string.IsNullOrEmpty(b1) &&
                !string.IsNullOrEmpty(b2) &&
                b1 != b2)
            {
                LoadHero(b1, b2);
                LoadSpecs(b1, b2);
                LoadGallery(b1, b2);
                LoadScore(b1, b2);

                CompareHeroPanel.Visible = true;
                CompareSpecsPanel.Visible = true;
                CompareGalleryPanel.Visible = true;
                CompareScorePanel.Visible = true;
            }
        }
    }



    void LoadScore(string id1, string id2)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT Price, RangeKM, TopSpeed FROM Bikes WHERE BikeID=@b1 OR BikeID=@b2",
            con);

            cmd.Parameters.AddWithValue("@b1", id1);
            cmd.Parameters.AddWithValue("@b2", id2);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count < 2) return;

            DataRow b1 = dt.Rows[0];
            DataRow b2 = dt.Rows[1];

            decimal score1 = CalculateScore(b1);
            decimal score2 = CalculateScore(b2);

            ScoreBike1.Text = BuildScoreHtml(score1);
            ScoreBike2.Text = BuildScoreHtml(score2);
        }
    }

    decimal CalculateScore(DataRow bike)
    {
        decimal price = bike["Price"] == DBNull.Value ? 0 : Convert.ToDecimal(bike["Price"]);
        decimal range = bike["RangeKM"] == DBNull.Value ? 0 : Convert.ToDecimal(bike["RangeKM"]);
        decimal speed = bike["TopSpeed"] == DBNull.Value ? 0 : Convert.ToDecimal(bike["TopSpeed"]);

        // Example scoring formula
        decimal score = (range * 0.4m) + (speed * 0.3m) - (price * 0.0001m);

        if (score < 0) score = 0;
        if (score > 100) score = 100;

        return Math.Round(score, 1);
    }

    string BuildScoreHtml(decimal score)
    {
        decimal percent = score; // since score is out of 100

        return
        "<div class='score-circle' style='--percent:" + percent + "%'>" +
            "<div class='score-inner'>" +
                "<div class='score-value'>" + score + "</div>" +
                "<div class='score-label'>Score</div>" +
            "</div>" +
        "</div>";
    }



    void LoadGallery(string id1, string id2)
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

            GalleryBike1.Text = BuildGallery(dt.Rows[0]);
            GalleryBike2.Text = BuildGallery(dt.Rows[1]);
        }
    }

    string BuildGallery(DataRow bike)
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
                        "' />";
            }
        }

        return html;
    }


    void LoadHero(string id1, string id2)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT BikeID, ModelName, Price, Image1 FROM Bikes WHERE BikeID=@b1 OR BikeID=@b2",
            con);

            cmd.Parameters.AddWithValue("@b1", id1);
            cmd.Parameters.AddWithValue("@b2", id2);

            SqlDataReader dr = cmd.ExecuteReader();

            string html1 = "";
            string html2 = "";

            int count = 0;

            while (dr.Read())
            {
                string html =
                "<img src='/Uploads/Bikes/" + dr["Image1"] + "' />" +
                "<h3>" + dr["ModelName"] + "</h3>" +
                "<p>₹ " + Convert.ToDecimal(dr["Price"]).ToString("N0") + "</p>";

                if (count == 0)
                    html1 = html;
                else
                    html2 = html;

                count++;
            }

            HeroBike1.Text = html1;
            HeroBike2.Text = html2;
        }
    }

    void LoadSpecs(string id1, string id2)
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
            System.Data.DataTable dt = new System.Data.DataTable();
            da.Fill(dt);

            if (dt.Rows.Count < 2) return;

            System.Data.DataRow bike1 = dt.Rows[0];
            System.Data.DataRow bike2 = dt.Rows[1];

            SpecRows.Text = "";

            foreach (System.Data.DataColumn col in dt.Columns)
            {
                string colName = col.ColumnName;

                if (colName == "BikeID" ||
                    colName == "DealerID" ||
                    colName == "BrandID" ||
                    colName == "Slug" ||
                    colName.StartsWith("Image") ||
                    colName == "IsApproved" ||
                    colName == "ApprovedAt" ||
                    colName == "CreatedAt")
                    continue;

                string v1 = bike1[colName] == DBNull.Value ? "N/A" : bike1[colName].ToString();
                string v2 = bike2[colName] == DBNull.Value ? "N/A" : bike2[colName].ToString();

                SpecRows.Text += BuildSpecRow(colName, v1, v2);
            }
        }
    }


    string BuildSpecRow(string title, string val1, string val2)
    {
        decimal n1, n2;
        bool isNum1 = decimal.TryParse(val1.Replace("₹", "").Replace(",", ""), out n1);
        bool isNum2 = decimal.TryParse(val2.Replace("₹", "").Replace(",", ""), out n2);

        if (isNum1 && isNum2 && n1 != n2)
        {
            if (n1 > n2)
                val1 = "<span class='spec-highlight'>" + val1 + "</span>";
            else
                val2 = "<span class='spec-highlight'>" + val2 + "</span>";
        }

        return "<div class='spec-row'>" +
               "<div class='spec-title'>" + title + "</div>" +
               "<div class='spec-value'>" + val1 + "</div>" +
               "<div class='spec-value'>" + val2 + "</div>" +
               "</div>";
    }


    void LoadSelectors()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT BikeID, ModelName FROM Bikes WHERE IsApproved=1",
            con);

            SqlDataReader dr = cmd.ExecuteReader();

            string s1 = "<select name='bike1'>";
            string s2 = "<select name='bike2'>";

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

    void LoadPopular()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlDataAdapter da = new SqlDataAdapter(@"
        SELECT TOP 6
            b1.BikeID AS BikeID1,
            b2.BikeID AS BikeID2,
            b1.ModelName,
            b2.ModelName AS ModelName2,
            b1.Image1,
            b2.Image1 AS Image2
        FROM Bikes b1
        INNER JOIN Bikes b2 
            ON b1.BikeID < b2.BikeID
        WHERE b1.IsApproved = 1 
        AND b2.IsApproved = 1
        ORDER BY b1.CreatedAt DESC
        ", con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                rptPopular.DataSource = dt;
                rptPopular.DataBind();
            }
        }
    }


    protected void CompareNow(object sender, EventArgs e)
    {
        string b1 = Request.Form["bike1"];
        string b2 = Request.Form["bike2"];

        if (!string.IsNullOrEmpty(b1) &&
            !string.IsNullOrEmpty(b2) &&
            b1 != b2)
        {
            Response.Redirect("Compare.aspx?b1=" + b1 + "&b2=" + b2);
        }
    }
}
