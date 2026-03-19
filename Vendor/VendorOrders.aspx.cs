using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;

public partial class Vendor_VendorOrders : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");

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
                litOrders.Text = dr["TotalOrders"].ToString();
                litPending.Text = dr["Pending"].ToString();
                litDelivered.Text = dr["Delivered"].ToString();
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
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
SELECT 
    OI.PartID,
    OI.Qty,
    OI.Price,
    P.PartName
FROM OrderItems OI
INNER JOIN Parts P ON OI.PartID = P.PartID
WHERE OI.OrderID = @id", con);

            cmd.Parameters.AddWithValue("@id", orderId);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            return Newtonsoft.Json.JsonConvert.SerializeObject(dt);
        }
    }


    [WebMethod(EnableSession = true)]
    public static string UpdateStatus(int orderId, string status)
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "UPDATE Orders SET OrderStatus=@s WHERE OrderID=@id", con);

            cmd.Parameters.AddWithValue("@s", status);
            cmd.Parameters.AddWithValue("@id", orderId);

            cmd.ExecuteNonQuery();
        }

        return "ok";
    }
}