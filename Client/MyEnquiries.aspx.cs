using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;

public partial class Client_MyEnquiries : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CustomerID"] == null)
            Response.Redirect("ClientLogin.aspx");

        if (!IsPostBack)
        {
            LoadEnquiries();
        }
    }

    void LoadEnquiries()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            // 1. Load Enquiries (Bike Wali)
            SqlCommand cmd = new SqlCommand(@"
            SELECT L.LeadID, L.Message, L.CreatedAt, L.IsViewed, 
                   B.ModelName, B.Image1, B.Slug, U.ShopName 
            FROM Leads L 
            INNER JOIN Bikes B ON L.BikeID=B.BikeID 
            INNER JOIN Users U ON B.DealerID=U.UserID 
            WHERE L.CustomerID=@c 
            ORDER BY L.CreatedAt DESC", con);

            cmd.Parameters.AddWithValue("@c", Session["CustomerID"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            rptEnquiries.DataSource = dt;
            rptEnquiries.DataBind();
            emptyEnq.Visible = (dt.Rows.Count == 0);

            // 2. LOAD ORDERS (Spare Parts Wali)
            // NOTE: Yahan Column Names wahi likhna jo tumhari SQL Table mein hain!
            SqlCommand cmdOrd = new SqlCommand(@"
SELECT 
    O.OrderID,
    O.OrderID AS OrderNumber,
    O.CreatedAt,
    O.TotalAmount,
    O.OrderStatus,
    COUNT(OI.ItemID) AS TotalItems
FROM Orders O
LEFT JOIN OrderItems OI ON O.OrderID = OI.OrderID
WHERE O.UserID = @c
GROUP BY O.OrderID, O.CreatedAt, O.TotalAmount, O.OrderStatus
ORDER BY O.CreatedAt DESC
", con);

            cmdOrd.Parameters.AddWithValue("@c", Session["CustomerID"]);
            SqlDataAdapter daOrd = new SqlDataAdapter(cmdOrd);
            DataTable dtOrd = new DataTable();

            try
            {
                daOrd.Fill(dtOrd);
                rptOrders.DataSource = dtOrd;
                rptOrders.DataBind();
                if (dtOrd.Rows.Count == 0)
                {
                    rptOrders.DataSource = null;
                    rptOrders.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Agar column name galat hoga toh yahan error dikhayega
                System.Diagnostics.Debug.WriteLine("SQL Order Error: " + ex.Message);
                emptyOrd.Visible = true;
            }

        }

    }

    [WebMethod(EnableSession = true)]
    public static string DeleteEnquiry(int id)
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

        if (System.Web.HttpContext.Current.Session["CustomerID"] == null)
            return "login";

        int user = Convert.ToInt32(System.Web.HttpContext.Current.Session["CustomerID"]);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"

DELETE FROM Leads
WHERE LeadID=@id
AND CustomerID=@c

", con);

            cmd.Parameters.AddWithValue("@id", id);
            cmd.Parameters.AddWithValue("@c", user);

            cmd.ExecuteNonQuery();
        }

        return "ok";
    }

}