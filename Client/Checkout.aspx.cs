using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class CheckoutPage : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
    int currentUserID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CustomerID"] == null)
        {
            Response.Redirect("ClientLogin.aspx");
            return;
        }

        currentUserID = Convert.ToInt32(Session["CustomerID"]);

        if (!IsPostBack)
        {
            LoadSummary();
        }
    }

    void LoadSummary()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = @"
SELECT SUM(p.Price * c.Qty) 
FROM Cart c 
JOIN Parts p ON c.PartID = p.PartID 
WHERE c.UserID = @UID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@UID", currentUserID);

            con.Open();

            object result = cmd.ExecuteScalar();

            decimal total = 0;

            if (result != DBNull.Value && result != null)
                total = Convert.ToDecimal(result);

            // 👉 अगर तू future में label add करे तो यहाँ bind कर सकता है
        }
    }

    protected void btnPlaceOrder_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlTransaction trans = con.BeginTransaction();

            try
            {
                // ✅ TOTAL WITHOUT GST
                string totalQuery = @"
SELECT SUM(p.Price * c.Qty) 
FROM Cart c 
JOIN Parts p ON c.PartID = p.PartID 
WHERE c.UserID = @UID";

                SqlCommand cmdTotal = new SqlCommand(totalQuery, con, trans);
                cmdTotal.Parameters.AddWithValue("@UID", currentUserID);

                object result = cmdTotal.ExecuteScalar();

                decimal amount = 0;

                if (result != DBNull.Value && result != null)
                    amount = Convert.ToDecimal(result);

                if (amount <= 0)
                    throw new Exception("Cart Empty");

                // ✅ ORDER INSERT (COD)
                string orderQuery = @"
INSERT INTO Orders (UserID, TotalAmount, OrderStatus, CreatedAt)
VALUES (@UID, @Total, @Status, GETDATE()); 
SELECT SCOPE_IDENTITY();";

                SqlCommand cmdOrder = new SqlCommand(orderQuery, con, trans);
                cmdOrder.Parameters.AddWithValue("@UID", currentUserID);
                cmdOrder.Parameters.AddWithValue("@Total", amount);
                cmdOrder.Parameters.AddWithValue("@Status", "Pending");

                int orderId = Convert.ToInt32(cmdOrder.ExecuteScalar());

                // ✅ MOVE ITEMS
                string moveQuery = @"
INSERT INTO OrderItems (OrderID, PartID, VendorID, Price, Qty)
SELECT @OID, c.PartID, p.VendorID, p.Price, c.Qty 
FROM Cart c 
JOIN Parts p ON c.PartID = p.PartID
WHERE c.UserID = @UID";

                SqlCommand cmdMove = new SqlCommand(moveQuery, con, trans);
                cmdMove.Parameters.AddWithValue("@OID", orderId);
                cmdMove.Parameters.AddWithValue("@UID", currentUserID);
                cmdMove.ExecuteNonQuery();

                // ✅ STOCK UPDATE
                string stockQuery = @"
UPDATE p 
SET p.Stock = p.Stock - c.Qty
FROM Parts p 
JOIN Cart c ON p.PartID = c.PartID
WHERE c.UserID = @UID";

                SqlCommand cmdStock = new SqlCommand(stockQuery, con, trans);
                cmdStock.Parameters.AddWithValue("@UID", currentUserID);
                cmdStock.ExecuteNonQuery();

                // ✅ CLEAR CART
                SqlCommand cmdClear = new SqlCommand(
                    "DELETE FROM Cart WHERE UserID=@UID", con, trans);

                cmdClear.Parameters.AddWithValue("@UID", currentUserID);
                cmdClear.ExecuteNonQuery();

                trans.Commit();

                Response.Redirect("Confirmation.aspx?id=" + orderId);
            }
            catch (Exception ex)
            {
                trans.Rollback();
                Response.Write("Error: " + ex.Message);
            }
        }

    }
}