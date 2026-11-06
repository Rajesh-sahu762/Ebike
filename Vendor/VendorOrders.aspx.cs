using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Services;

public partial class Vendor_VendorOrders : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null || Session["Role"] == null || Session["Role"].ToString() != "Dealer")
        {
            Response.Redirect("VendorLogin.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadOrders();
            LoadDashboard();
        }
    }

    void LoadOrders()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string q = @"
SELECT DISTINCT O.OrderID, O.TotalAmount, O.OrderStatus, O.CreatedAt
FROM Orders O
INNER JOIN OrderItems OI ON O.OrderID = OI.OrderID
WHERE OI.VendorID = @v
ORDER BY O.CreatedAt DESC";

            SqlCommand cmd = new SqlCommand(q, con);
            cmd.Parameters.AddWithValue("@v", Session["VendorID"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptOrders.DataSource = dt;
            rptOrders.DataBind();
        }
    }

    void LoadDashboard()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string q = @"
SELECT 
COUNT(DISTINCT O.OrderID) TotalOrders,
SUM(CASE WHEN O.OrderStatus='Pending' THEN 1 ELSE 0 END) Pending,
SUM(CASE WHEN O.OrderStatus='Delivered' THEN 1 ELSE 0 END) Delivered,
SUM(CASE WHEN O.OrderStatus!='Cancelled' THEN OI.Price * OI.Qty ELSE 0 END) Earnings
FROM Orders O
INNER JOIN OrderItems OI ON O.OrderID = OI.OrderID
WHERE OI.VendorID=@v";

            SqlCommand cmd = new SqlCommand(q, con);
            cmd.Parameters.AddWithValue("@v", Session["VendorID"]);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                litOrders.Text = dr["TotalOrders"] != DBNull.Value ? dr["TotalOrders"].ToString() : "0";
                litPending.Text = dr["Pending"] != DBNull.Value ? dr["Pending"].ToString() : "0";
                litDelivered.Text = dr["Delivered"] != DBNull.Value ? dr["Delivered"].ToString() : "0";
                litEarn.Text = dr["Earnings"] != DBNull.Value ? Convert.ToDecimal(dr["Earnings"]).ToString("N0") : "0";
            }
        }
    }

    public string GetStatusClass(string status)
    {
        switch (status)
        {
            case "Pending": return "bg-yellow-100 text-yellow-700";
            case "Delivered": return "bg-green-100 text-green-700";
            case "Cancelled": return "bg-red-100 text-red-700";
            default: return "bg-blue-100 text-blue-700";
        }
    }

    [WebMethod(EnableSession = true)]
    public static string GetOrderItems(int orderId)
    {
        if (HttpContext.Current == null ||
            HttpContext.Current.Session == null ||
            HttpContext.Current.Session["VendorID"] == null ||
            HttpContext.Current.Session["Role"] == null ||
            HttpContext.Current.Session["Role"].ToString() != "Dealer")
        {
            return "";
        }

        int vendorId = Convert.ToInt32(HttpContext.Current.Session["VendorID"]);
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // Enforce vendor ownership: only return items belonging to this vendor for this order
            SqlCommand cmd = new SqlCommand(@"
SELECT P.PartName, OI.Qty, OI.Price
FROM OrderItems OI
INNER JOIN Parts P ON OI.PartID = P.PartID
WHERE OI.OrderID = @id AND OI.VendorID = @v", con);

            cmd.Parameters.AddWithValue("@id", orderId);
            cmd.Parameters.AddWithValue("@v", vendorId);

            SqlDataReader dr = cmd.ExecuteReader();

            string result = "";

            while (dr.Read())
            {
                string partName = HttpUtility.HtmlEncode(dr["PartName"].ToString());
                result += partName + "~" +
                          dr["Qty"].ToString() + "~" +
                          dr["Price"].ToString() + "|";
            }

            return result;
        }
    }

    [WebMethod(EnableSession = true)]
    public static string UpdateStatus(int orderId, string status)
    {
        if (HttpContext.Current == null ||
            HttpContext.Current.Session == null ||
            HttpContext.Current.Session["VendorID"] == null ||
            HttpContext.Current.Session["Role"] == null ||
            HttpContext.Current.Session["Role"].ToString() != "Dealer")
        {
            return "unauthorized";
        }

        int vendorId = Convert.ToInt32(HttpContext.Current.Session["VendorID"]);
        string s = (status ?? "").Trim();

        if (s != "Pending" && s != "Processing" && s != "Shipped" && s != "Delivered" && s != "Cancelled")
        {
            return "invalid_status";
        }

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // Enforce vendor ownership: verify this order contains items belonging to this vendor
            SqlCommand cmd = new SqlCommand(@"
IF EXISTS (SELECT 1 FROM OrderItems WHERE OrderID=@id AND VendorID=@v)
BEGIN
    UPDATE Orders SET OrderStatus=@s WHERE OrderID=@id;
    SELECT 1;
END
ELSE
BEGIN
    SELECT 0;
END", con);

            cmd.Parameters.AddWithValue("@s", s);
            cmd.Parameters.AddWithValue("@id", orderId);
            cmd.Parameters.AddWithValue("@v", vendorId);

            object result = cmd.ExecuteScalar();
            if (Convert.ToInt32(result) == 0)
            {
                return "unauthorized";
            }
        }

        return "ok";
    }
}
