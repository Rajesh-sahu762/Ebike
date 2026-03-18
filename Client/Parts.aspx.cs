using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;

public partial class PartsPage : System.Web.UI.Page
{
    static string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadParts();
            LoadCategories();
        }
    }

    private void LoadParts()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            // Sirf Approved parts dikhayenge
            string query = "SELECT * FROM Parts WHERE IsApproved = 1 ORDER BY CreatedAt DESC";
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rptParts.DataSource = dt;
            rptParts.DataBind();
        }
    }

    private void LoadCategories()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = "SELECT DISTINCT Category FROM Parts WHERE IsApproved = 1";
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            string html = "<button type='button' onclick=\"filterParts('')\" class='w-full text-left px-4 py-2 rounded-xl hover:bg-slate-100 font-bold text-slate-600 transition'>All Parts</button>";
            foreach (DataRow dr in dt.Rows)
            {
                html += string.Format("<button type='button' onclick=\"filterParts('{0}')\" class='w-full text-left px-4 py-2 rounded-xl hover:bg-slate-100 font-bold text-slate-600 transition'>{0}</button>", dr["Category"]);
            }
            LitCategories.Text = html;
        }
    }

    public string GetStockBadge(object stock)
    {
        int s = Convert.ToInt32(stock);
        if (s <= 0) return "<span class='bg-red-100 text-red-600 px-2 py-1 rounded text-[10px] font-bold uppercase'>Out of Stock</span>";
        if (s < 5) return "<span class='bg-orange-100 text-orange-600 px-2 py-1 rounded text-[10px] font-bold uppercase'>Low Stock</span>";
        return "<span class='bg-emerald-100 text-emerald-600 px-2 py-1 rounded text-[10px] font-bold uppercase'>In Stock</span>";
    }

    [WebMethod]
    public static string AddToCart(int partId)
    {
        // Yahan Session["UserID"] check karein, abhi humne dummy ID 1 li hai
        int userId = 1;

        try
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                // Check if item already exists in cart
                SqlCommand checkCmd = new SqlCommand("SELECT Qty FROM Cart WHERE UserID=@UID AND PartID=@PID", con);
                checkCmd.Parameters.AddWithValue("@UID", userId);
                checkCmd.Parameters.AddWithValue("@PID", partId);
                object existingQty = checkCmd.ExecuteScalar();

                if (existingQty != null)
                {
                    // Update quantity
                    SqlCommand upCmd = new SqlCommand("UPDATE Cart SET Qty = Qty + 1 WHERE UserID=@UID AND PartID=@PID", con);
                    upCmd.Parameters.AddWithValue("@UID", userId);
                    upCmd.Parameters.AddWithValue("@PID", partId);
                    upCmd.ExecuteNonQuery();
                }
                else
                {
                    // Insert new item
                    SqlCommand insCmd = new SqlCommand("INSERT INTO Cart (UserID, PartID, Qty) VALUES (@UID, @PID, 1)", con);
                    insCmd.Parameters.AddWithValue("@UID", userId);
                    insCmd.Parameters.AddWithValue("@PID", partId);
                    insCmd.ExecuteNonQuery();
                }
            }
            return "Success";
        }
        catch (Exception ex)
        {
            return "Error: " + ex.Message;
        }
    }
}