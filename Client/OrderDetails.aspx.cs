using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Client_OrderDetails : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CustomerID"] == null)
        {
            Response.Redirect("ClientLogin.aspx");
            return;
        }

        if (!IsPostBack)
        {
            string idStr = Request.QueryString["id"];
            int orderId;

            // ✅ ONLY VALIDATION
            if (string.IsNullOrEmpty(idStr) || !int.TryParse(idStr, out orderId))
            {
                Response.Write("Invalid Order ID");
                return;
            }

            // ✅ CALL METHOD
            LoadOrderInfo(orderId);
        }
    }

    void LoadOrderInfo(int id)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // ✅ ORDER MAIN INFO
            SqlCommand cmd = new SqlCommand(@"
SELECT OrderID, CreatedAt, TotalAmount, OrderStatus
FROM Orders 
WHERE OrderID = @id AND UserID = @uid", con);

            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.Add("@uid", SqlDbType.Int).Value = Convert.ToInt32(Session["CustomerID"]);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                lblOrderNo.Text = "#" + dr["OrderID"].ToString();
                lblDate.Text = Convert.ToDateTime(dr["CreatedAt"]).ToString("dd MMM yyyy");
                lblStatus.Text = dr["OrderStatus"].ToString();

                string total = "₹" + String.Format("{0:N0}", dr["TotalAmount"]);
                lblTotal.Text = total;
                lblTotal2.Text = total;
            }
            else
            {
                Response.Redirect("MyEnquiries.aspx");
            }

            dr.Close();

            // ✅ ORDER ITEMS
            SqlCommand cmdItems = new SqlCommand(@"
SELECT 
    OI.PartID,
    OI.Price,
    OI.Qty,
    P.PartName,
    P.Image1
FROM OrderItems OI
INNER JOIN Parts P ON OI.PartID = P.PartID
WHERE OI.OrderID = @id", con);

            cmdItems.Parameters.AddWithValue("@id", id);

            SqlDataAdapter da = new SqlDataAdapter(cmdItems);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptOrderItems.DataSource = dt;
            rptOrderItems.DataBind();
        }
    }
}