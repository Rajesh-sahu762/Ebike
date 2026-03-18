using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class CheckoutPage : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
    int currentUserID = 1; // Real project mein Session["UserID"] use karein

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadSummary();
        }
    }

    void LoadSummary()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            // Cart total nikalne ke liye
            string query = "SELECT SUM(p.Price * c.Qty) FROM Cart c JOIN Parts p ON c.PartID = p.PartID WHERE c.UserID = @UID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@UID", currentUserID);
            con.Open();

            object result = cmd.ExecuteScalar();
            decimal subtotal = (result != DBNull.Value) ? Convert.ToDecimal(result) : 0;
            decimal tax = subtotal * 0.18m;
            decimal total = subtotal + tax;

            // Summary labels (Check kar lena ID same ho aspx mein)
            // litTotal.Text = total.ToString("N0"); 
        }
    }

    protected void btnPlaceOrder_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            SqlTransaction trans = con.BeginTransaction(); // Transaction safe purchase ke liye

            try
            {
                // 1. Calculate Grand Total again for safety
                string totalQuery = "SELECT SUM(p.Price * c.Qty) FROM Cart c JOIN Parts p ON c.PartID = p.PartID WHERE c.UserID = @UID";
                SqlCommand cmdTotal = new SqlCommand(totalQuery, con, trans);
                cmdTotal.Parameters.AddWithValue("@UID", currentUserID);
                decimal amount = Convert.ToDecimal(cmdTotal.ExecuteScalar());
                amount = amount + (amount * 0.18m); // Adding 18% Tax

                // 2. Insert into Orders Table
                string orderQuery = @"INSERT INTO Orders (UserID, TotalAmount, OrderStatus, CreatedAt) 
                                    VALUES (@UID, @Total, @Status, GETDATE()); SELECT SCOPE_IDENTITY();";
                SqlCommand cmdOrder = new SqlCommand(orderQuery, con, trans);
                cmdOrder.Parameters.AddWithValue("@UID", currentUserID);
                cmdOrder.Parameters.AddWithValue("@Total", amount);
                cmdOrder.Parameters.AddWithValue("@Status", "Pending");

                int newOrderID = Convert.ToInt32(cmdOrder.ExecuteScalar());

                // 3. Move items from Cart to OrderItems
                string moveItemsQuery = @"INSERT INTO OrderItems (OrderID, PartID, VendorID, Price, Qty)
                                        SELECT @OID, c.PartID, p.VendorID, p.Price, c.Qty 
                                        FROM Cart c JOIN Parts p ON c.PartID = p.PartID 
                                        WHERE c.UserID = @UID";
                SqlCommand cmdMove = new SqlCommand(moveItemsQuery, con, trans);
                cmdMove.Parameters.AddWithValue("@OID", newOrderID);
                cmdMove.Parameters.AddWithValue("@UID", currentUserID);
                cmdMove.ExecuteNonQuery();

                // 4. Update Stock in Parts Table (Inventory Management)
                string stockQuery = @"UPDATE Parts SET Stock = Stock - c.Qty 
                                    FROM Parts p JOIN Cart c ON p.PartID = c.PartID 
                                    WHERE c.UserID = @UID";
                SqlCommand cmdStock = new SqlCommand(stockQuery, con, trans);
                cmdStock.Parameters.AddWithValue("@UID", currentUserID);
                cmdStock.ExecuteNonQuery();

                // 5. Finally, Clear the Cart
                SqlCommand cmdClear = new SqlCommand("DELETE FROM Cart WHERE UserID = @UID", con, trans);
                cmdClear.Parameters.AddWithValue("@UID", currentUserID);
                cmdClear.ExecuteNonQuery();

                trans.Commit(); // Saare kaam sahi huye toh save karo

                // Redirect to Success Page
                Response.Redirect("Confirmation.aspx?id=" + newOrderID);
            }
            catch (Exception ex)
            {
                trans.Rollback(); // Error aayi toh sab cancel karo
                // Log error here
            }
        }
    }
}