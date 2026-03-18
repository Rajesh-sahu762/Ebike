using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class CartPage : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;
    int currentUserID = 1; // Temporary: Isse Session["UserID"] se replace karein

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadCart();
        }
    }

    void LoadCart()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            // Join query to get Part details from Parts table
            string query = @"SELECT c.CartID, c.PartID, c.Qty, p.PartName, p.Price, p.Image1, p.Category 
                             FROM Cart c INNER JOIN Parts p ON c.PartID = p.PartID 
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
            subtotal += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Qty"]);
        }
        decimal tax = subtotal * 0.18m; // 18% GST
        decimal total = subtotal + tax;

        litSubtotal.Text = subtotal.ToString("N0");
        litTax.Text = tax.ToString("N0");
        litTotal.Text = total.ToString("N0");
    }

    // Is method ki wajah se error aa rahi thi
    protected void ClearCart_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            SqlCommand cmd = new SqlCommand("DELETE FROM Cart WHERE UserID = @UserID", con);
            cmd.Parameters.AddWithValue("@UserID", currentUserID);
            con.Open();
            cmd.ExecuteNonQuery();
        }
        LoadCart();
    }

    protected void rptCartItems_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        int partId = Convert.ToInt32(e.CommandArgument);
        string query = "";

        if (e.CommandName == "Plus")
            query = "UPDATE Cart SET Qty = Qty + 1 WHERE PartID = @PID AND UserID = @UID";
        else if (e.CommandName == "Minus")
            query = "UPDATE Cart SET Qty = CASE WHEN Qty > 1 THEN Qty - 1 ELSE 1 END WHERE PartID = @PID AND UserID = @UID";
        else if (e.CommandName == "Remove")
            query = "DELETE FROM Cart WHERE PartID = @PID AND UserID = @UID";

        using (SqlConnection con = new SqlConnection(constr))
        {
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@PID", partId);
            cmd.Parameters.AddWithValue("@UID", currentUserID);
            con.Open();
            cmd.ExecuteNonQuery();
        }
        LoadCart();
    }

    protected void btnCheckout_Click(object sender, EventArgs e)
    {
        Response.Redirect("Checkout.aspx");
    }
}