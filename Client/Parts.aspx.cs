using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class PartsPage : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadParts();
            LoadCategoryFilters();
        }
    }

    void LoadParts()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = "SELECT * FROM Parts WHERE IsApproved = 1 ORDER BY CreatedAt DESC";
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptParts.DataSource = dt;
            rptParts.DataBind();
        }
    }

    void LoadCategoryFilters()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT DISTINCT Category FROM Parts WHERE IsApproved = 1", con);
            SqlDataReader dr = cmd.ExecuteReader();

            string html = "<div onclick='filterParts()' class='category-pill px-4 py-2 rounded-lg text-sm font-semibold text-slate-700 bg-slate-100 mb-1 border border-transparent'>All Parts</div>";
            
            while (dr.Read())
            {
                string cat = dr["Category"].ToString();
                html += string.Format("<div onclick=\"filterParts('{0}')\" class='category-pill px-4 py-2 rounded-lg text-sm font-semibold text-slate-600 hover:text-blue-600 border border-transparent'>{0}</div>", cat);
            }
            LitCategories.Text = html;
        }
    }

    public string GetStockBadge(object stock)
    {
        int s = Convert.ToInt32(stock);
        if (s <= 0) 
            return "<span class='badge-stock bg-red-100 text-red-600'>Out of Stock</span>";
        if (s <= 5) 
            return "<span class='badge-stock bg-amber-100 text-amber-600'>Only " + s + " Left</span>";
        
        return "<span class='badge-stock bg-emerald-100 text-emerald-600'>In Stock</span>";
    }
}