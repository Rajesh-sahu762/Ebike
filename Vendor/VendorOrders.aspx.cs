using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.Services;

public partial class Vendor_VendorOrders : System.Web.UI.Page
{
    private readonly string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
        {
            Response.Redirect("VendorLogin.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
            return;
        }
        if (!IsPostBack)
        {
            LoadOrders();
            LoadDashboard();
        }
    }

    private int CurrentVendorId
    {
        get { return Convert.ToInt32(Session["VendorID"]); }
    }

    private void LoadOrders()
    {
        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand cmd = new SqlCommand(@"
SELECT DISTINCT O.OrderID, O.TotalAmount, O.OrderStatus, O.CreatedAt
FROM dbo.Orders O
INNER JOIN dbo.OrderItems OI ON O.OrderID=OI.OrderID
WHERE OI.VendorID=@VendorID
ORDER BY O.CreatedAt DESC;", con))
        {
            cmd.Parameters.Add("@VendorID", SqlDbType.Int).Value = CurrentVendorId;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            rptOrders.DataSource = dt;
            rptOrders.DataBind();
        }
    }

    private void LoadDashboard()
    {
        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand cmd = new SqlCommand(@"
SELECT COUNT(DISTINCT O.OrderID) AS TotalOrders,
       COUNT(DISTINCT CASE WHEN O.OrderStatus='Pending' THEN O.OrderID END) AS Pending,
       COUNT(DISTINCT CASE WHEN O.OrderStatus='Delivered' THEN O.OrderID END) AS Delivered,
       SUM(CASE WHEN O.OrderStatus<>'Cancelled' THEN OI.Price * OI.Qty ELSE 0 END) AS Earnings
FROM dbo.Orders O
INNER JOIN dbo.OrderItems OI ON O.OrderID=OI.OrderID
WHERE OI.VendorID=@VendorID;", con))
        {
            cmd.Parameters.Add("@VendorID", SqlDbType.Int).Value = CurrentVendorId;
            con.Open();
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                if (!dr.Read()) return;
                litOrders.Text = Convert.ToString(dr["TotalOrders"]);
                litPending.Text = Convert.ToString(dr["Pending"]);
                litDelivered.Text = Convert.ToString(dr["Delivered"]);
                litEarn.Text = dr["Earnings"] != DBNull.Value
                    ? Convert.ToDecimal(dr["Earnings"]).ToString("N0") : "0";
            }
        }
    }

    public string GetStatusClass(string status)
    {
        switch (status)
        {
            case "Pending": return "bg-yellow-100 text-yellow-700";
            case "Shipped": return "bg-blue-100 text-blue-700";
            case "Delivered": return "bg-green-100 text-green-700";
            case "Cancelled": return "bg-red-100 text-red-700";
            default: return "bg-gray-100 text-gray-700";
        }
    }

    [WebMethod(EnableSession = true)]
    public static object GetOrderItems(int orderId)
    {
        HttpContext context = HttpContext.Current;
        if (context == null || context.Session == null || context.Session["VendorID"] == null)
            throw new HttpException(401, "Authentication required.");

        int vendorId;
        if (!Int32.TryParse(Convert.ToString(context.Session["VendorID"]), out vendorId) ||
            vendorId <= 0 || orderId <= 0)
            throw new HttpException(400, "Invalid request.");

        List<object> items = new List<object>();
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand cmd = new SqlCommand(@"
SELECT P.PartName, OI.Qty, OI.Price
FROM dbo.OrderItems OI
INNER JOIN dbo.Parts P ON OI.PartID=P.PartID
WHERE OI.OrderID=@OrderID AND OI.VendorID=@VendorID;", con))
        {
            cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = orderId;
            cmd.Parameters.Add("@VendorID", SqlDbType.Int).Value = vendorId;
            con.Open();
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                while (dr.Read())
                {
                    items.Add(new
                    {
                        PartName = Convert.ToString(dr["PartName"]),
                        Qty = Convert.ToInt32(dr["Qty"]),
                        Price = Convert.ToDecimal(dr["Price"])
                    });
                }
            }
        }
        return items;
    }

    [WebMethod(EnableSession = true)]
    public static string UpdateStatus(int orderId, string status)
    {
        HttpContext context = HttpContext.Current;
        if (context == null || context.Session == null || context.Session["VendorID"] == null)
            return "Authentication required.";

        int vendorId;
        if (!Int32.TryParse(Convert.ToString(context.Session["VendorID"]), out vendorId) ||
            vendorId <= 0 || orderId <= 0)
            return "Invalid request.";

        // Orders has one global status (not a per-vendor status). Do not permit one
        // vendor to change a multi-vendor order belonging partly to another vendor.
        string expectedStatus;
        switch (status)
        {
            case "Shipped":
            case "Cancelled":
                expectedStatus = "Pending";
                break;
            case "Delivered":
                expectedStatus = "Shipped";
                break;
            default:
                return "Invalid order status transition.";
        }

        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand cmd = new SqlCommand(@"
UPDATE O
SET O.OrderStatus=@NewStatus
FROM dbo.Orders O
WHERE O.OrderID=@OrderID
  AND O.OrderStatus=@ExpectedStatus
  AND EXISTS (
      SELECT 1 FROM dbo.OrderItems V
      WHERE V.OrderID=O.OrderID AND V.VendorID=@VendorID
  )
  AND NOT EXISTS (
      SELECT 1 FROM dbo.OrderItems X
      WHERE X.OrderID=O.OrderID AND (X.VendorID IS NULL OR X.VendorID<>@VendorID)
  );", con))
        {
            cmd.Parameters.Add("@NewStatus", SqlDbType.NVarChar, 30).Value = status;
            cmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = orderId;
            cmd.Parameters.Add("@ExpectedStatus", SqlDbType.NVarChar, 30).Value = expectedStatus;
            cmd.Parameters.Add("@VendorID", SqlDbType.Int).Value = vendorId;
            con.Open();
            int affected = cmd.ExecuteNonQuery();
            return affected == 1
                ? "Order status updated."
                : "Order not found, belongs to another vendor, contains other vendors' items, or transition is not allowed.";
        }
    }
}
