using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Home : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadBikes();
        }
    }

    void LoadBikes()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
            SELECT TOP 6 B.BikeID, B.ModelName, B.Price,
                   B.Image1, B.Slug,
                   BR.BrandName
            FROM Bikes B
            INNER JOIN Brands BR ON B.BrandID=BR.BrandID
            WHERE B.IsApproved=1
            ORDER BY B.CreatedAt DESC", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptBikes.DataSource = dt;
            rptBikes.DataBind();
        }
    }
}
