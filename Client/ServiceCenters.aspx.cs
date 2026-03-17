using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class ServiceCenters : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCenters();
            LoadCityFilters();
        }
    }

    void LoadCenters()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = @"
SELECT 
CenterName,
Address,
Phone,
City
FROM ServiceCenters
WHERE IsApproved = 1
ORDER BY City
";

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptServiceCenters.DataSource = dt;
            rptServiceCenters.DataBind();
        }
    }

    void LoadCityFilters()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
SELECT DISTINCT City 
FROM ServiceCenters 
WHERE IsApproved = 1
ORDER BY City
", con);

            SqlDataReader dr = cmd.ExecuteReader();

            string html = "<option value=''>All Cities</option>";

            while (dr.Read())
            {
                string city = dr["City"].ToString();

                html += "<option value='" + city + "'>" + city + "</option>";
            }

            CityFilters.Text = html;
        }
    }
}