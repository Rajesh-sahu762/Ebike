using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_RentalManagement : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDashboard();
            LoadRentals();
        }
    }

    void LoadDashboard()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            con.Open();

            lblTotal.Text = GetScalar(con, "SELECT COUNT(*) FROM RentalBookings");
            lblPending.Text = GetScalar(con, "SELECT COUNT(*) FROM RentalBookings WHERE Status='Pending'");
            lblActive.Text = GetScalar(con, "SELECT COUNT(*) FROM RentalBookings WHERE Status='Active'");
            lblCompleted.Text = GetScalar(con, "SELECT COUNT(*) FROM RentalBookings WHERE Status='Completed'");
            lblCommission.Text = GetScalar(con, "SELECT ISNULL(SUM(CommissionAmount),0) FROM RentalBookings");
        }
    }

    string GetScalar(SqlConnection con, string query)
    {
        SqlCommand cmd = new SqlCommand(query, con);
        object obj = cmd.ExecuteScalar();
        return obj != null ? obj.ToString() : "0";
    }

    void LoadRentals()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"SELECT R.RentalID, B.ModelName,
                            U.FullName AS CustomerName,
                            D.FullName AS DealerName,
                            R.StartDate, R.EndDate,
                            R.RentAmount, R.CommissionAmount,
                            R.Status
                            FROM RentalBookings R
                            INNER JOIN Bikes B ON R.BikeID = B.BikeID
                            INNER JOIN Users U ON R.CustomerID = U.UserID
                            INNER JOIN Users D ON R.DealerID = D.UserID";

            if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
            {
                query += " WHERE R.Status = @Status";
            }

            SqlDataAdapter da = new SqlDataAdapter(query, con);

            if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
            {
                da.SelectCommand.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
            }

            DataTable dt = new DataTable();
            da.Fill(dt);

            gvRentals.DataSource = dt;
            gvRentals.DataBind();
        }
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        LoadRentals();
    }

    protected void gvRentals_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int rentalID = Convert.ToInt32(e.CommandArgument);

        string status = "";

        if (e.CommandName == "SetActive")
            status = "Active";
        else if (e.CommandName == "Complete")
            status = "Completed";
        else if (e.CommandName == "CancelRental")
            status = "Cancelled";

        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = "UPDATE RentalBookings SET Status=@Status WHERE RentalID=@ID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Status", status);
            cmd.Parameters.AddWithValue("@ID", rentalID);
            con.Open();
            cmd.ExecuteNonQuery();
        }

        LoadDashboard();
        LoadRentals();
    }
}