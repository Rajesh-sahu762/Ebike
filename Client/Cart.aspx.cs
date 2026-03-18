using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class CartPage : System.Web.UI.Page
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

    
            LoadCart();
    
    }

    void LoadCart()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = @"
SELECT c.CartID, c.PartID, c.Qty, 
       p.PartName, p.Price, p.Image1, p.Category 
FROM Cart c 
LEFT JOIN Parts p ON c.PartID = p.PartID   -- ✅ FIXED (INNER → LEFT)
WHERE c.UserID = @UserID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@UserID", currentUserID);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                rptCartItems.DataSource = dt;
                rptCartItems.DataBind();

                CalculateSummary(dt);

                pnlEmptyCart.Visible = false;
            }
            else
            {
                rptCartItems.DataSource = null;
                rptCartItems.DataBind();

                pnlEmptyCart.Visible = true;

                litSubtotal.Text = "0";
                litTax.Text = "0";
                litTotal.Text = "0";
            }

            litCartCount.Text = dt.Rows.Count.ToString();
        }
    }

    void CalculateSummary(DataTable dt)
    {
        decimal subtotal = 0;

        foreach (DataRow row in dt.Rows)
        {
            if (row["Price"] != DBNull.Value)
                subtotal += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Qty"]);
        }

        decimal total = subtotal;

        litSubtotal.Text = subtotal.ToString("N0");
        litTax.Text = "0"; // GST removed
        litTotal.Text = total.ToString("N0");
    }

    protected void ClearCart_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            SqlCommand cmd = new SqlCommand(
            "DELETE FROM Cart WHERE UserID = @UserID", con);

            cmd.Parameters.AddWithValue("@UserID", currentUserID);

            con.Open();
            cmd.ExecuteNonQuery();
        }

        LoadCart();
    }

    protected void rptCartItems_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int partId = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            if (e.CommandName == "Plus")
            {
                SqlCommand cmd = new SqlCommand(
                "UPDATE Cart SET Qty = Qty + 1 WHERE PartID=@p AND UserID=@u", con);

                cmd.Parameters.AddWithValue("@p", partId);
                cmd.Parameters.AddWithValue("@u", currentUserID);
                cmd.ExecuteNonQuery();
            }
            else if (e.CommandName == "Minus")
            {
                SqlCommand cmd = new SqlCommand(@"
UPDATE Cart 
SET Qty = CASE WHEN Qty > 1 THEN Qty - 1 ELSE 1 END 
WHERE PartID=@p AND UserID=@u", con);

                cmd.Parameters.AddWithValue("@p", partId);
                cmd.Parameters.AddWithValue("@u", currentUserID);
                cmd.ExecuteNonQuery();
            }
            else if (e.CommandName == "Remove")
            {
                SqlCommand cmd = new SqlCommand(
                "DELETE FROM Cart WHERE PartID=@p AND UserID=@u", con);

                cmd.Parameters.AddWithValue("@p", partId);
                cmd.Parameters.AddWithValue("@u", currentUserID);
                cmd.ExecuteNonQuery();
            }
        }

        LoadCart();
    }

    protected void btnCheckout_Click(object sender, EventArgs e)
    {
        Response.Redirect("Checkout.aspx");
    }
}