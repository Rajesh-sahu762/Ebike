using System;
using System.Data.SqlClient;
using System.Configuration;

public partial class ConfirmationPage : System.Web.UI.Page
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
            ValidateOrder();
        }
    }

    void ValidateOrder()
    {
        string orderIdStr = Request.QueryString["id"];

        int orderId;

        if (!int.TryParse(orderIdStr, out orderId))
        {
            Response.Redirect("Parts.aspx");
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"
SELECT COUNT(*) 
FROM Orders 
WHERE OrderID = @id AND UserID = @uid", con);

            cmd.Parameters.AddWithValue("@id", orderId);
            cmd.Parameters.AddWithValue("@uid", Session["CustomerID"]);

            int count = Convert.ToInt32(cmd.ExecuteScalar());

            if (count == 0)
            {
                Response.Redirect("Parts.aspx");
                return;
            }

            // ✅ SAFE DISPLAY
            litOrderID.Text = orderId.ToString();
        }
    }
}