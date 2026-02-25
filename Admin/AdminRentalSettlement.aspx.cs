using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_AdminRentalSettlement : System.Web.UI.Page
{
    string conStr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadSettlementData();
        }
    }

    void LoadSettlementData()
    {
        using (SqlConnection con = new SqlConnection(conStr))
        {
            string query = @"
            SELECT 
            R.DealerID,
            U.FullName AS DealerName,
            COUNT(R.RentalID) AS TotalRentals,
            SUM(R.RentAmount) AS TotalRevenue,
            SUM(R.CommissionAmount) AS TotalCommission,
            SUM(R.RentAmount - R.CommissionAmount) AS NetAmount
            FROM RentalBookings R
            INNER JOIN Users U ON R.DealerID = U.UserID
            WHERE R.Status='Completed' AND R.IsSettled=0
            GROUP BY R.DealerID, U.FullName";

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvSettlement.DataSource = dt;
            gvSettlement.DataBind();
        }
    }

    protected void gvSettlement_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ApproveSettlement")
        {
            int dealerID = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlTransaction trans = con.BeginTransaction();

                try
                {
                    // Calculate values
                    SqlCommand cmdCalc = new SqlCommand(@"
                        SELECT 
                        SUM(RentAmount),
                        SUM(CommissionAmount),
                        SUM(RentAmount - CommissionAmount)
                        FROM RentalBookings
                        WHERE DealerID=@DealerID
                        AND Status='Completed'
                        AND IsSettled=0", con, trans);

                    cmdCalc.Parameters.AddWithValue("@DealerID", dealerID);

                    SqlDataReader dr = cmdCalc.ExecuteReader();
                    dr.Read();

                    decimal totalRevenue = dr.IsDBNull(0) ? 0 : dr.GetDecimal(0);
                    decimal totalCommission = dr.IsDBNull(1) ? 0 : dr.GetDecimal(1);
                    decimal netAmount = dr.IsDBNull(2) ? 0 : dr.GetDecimal(2);
                    dr.Close();

                    // Insert settlement
                    SqlCommand cmdInsert = new SqlCommand(@"
                        INSERT INTO Settlements
                        (DealerID, TotalRevenue, CommissionAmount, NetAmount)
                        VALUES (@DealerID, @TotalRevenue, @Commission, @NetAmount);
                        SELECT SCOPE_IDENTITY();", con, trans);

                    cmdInsert.Parameters.AddWithValue("@DealerID", dealerID);
                    cmdInsert.Parameters.AddWithValue("@TotalRevenue", totalRevenue);
                    cmdInsert.Parameters.AddWithValue("@Commission", totalCommission);
                    cmdInsert.Parameters.AddWithValue("@NetAmount", netAmount);

                    int settlementID = Convert.ToInt32(cmdInsert.ExecuteScalar());

                    // Mark rentals as settled
                    SqlCommand cmdUpdate = new SqlCommand(@"
                        UPDATE RentalBookings
                        SET IsSettled=1, SettlementID=@SettlementID
                        WHERE DealerID=@DealerID
                        AND Status='Completed'
                        AND IsSettled=0", con, trans);

                    cmdUpdate.Parameters.AddWithValue("@SettlementID", settlementID);
                    cmdUpdate.Parameters.AddWithValue("@DealerID", dealerID);
                    cmdUpdate.ExecuteNonQuery();

                    trans.Commit();
                }
                catch
                {
                    trans.Rollback();
                }
            }

            LoadSettlementData();
        }
    }
}