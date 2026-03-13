using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class Vendor_VendorEarnings : System.Web.UI.Page
{

    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["VendorID"] == null)
            Response.Redirect("VendorLogin.aspx");

        if (!IsPostBack)
        {
            LoadSummary();
            LoadEarnings();
        }
    }

    void LoadSummary()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int dealer = Convert.ToInt32(Session["VendorID"]);

            SqlCommand cmd = new SqlCommand(@"

SELECT
SUM(Amount) Revenue,
SUM(Commission) Commission,
SUM(Net) Net
FROM
(
SELECT LeadAmount Amount,
ISNULL(CommissionAmount,0) Commission,
LeadAmount - ISNULL(CommissionAmount,0) Net
FROM Leads L
JOIN Bikes B ON L.BikeID=B.BikeID
WHERE B.DealerID=@d

UNION ALL

SELECT RentAmount,
ISNULL(CommissionAmount,0),
RentAmount - ISNULL(CommissionAmount,0)
FROM RentalBookings
WHERE DealerID=@d
AND Status='Completed'

)X

", con);

            cmd.Parameters.AddWithValue("@d", dealer);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                lblRevenue.Text = Convert.ToDecimal(dr["Revenue"]).ToString("N0");
                lblCommission.Text = Convert.ToDecimal(dr["Commission"]).ToString("N0");
                lblNet.Text = Convert.ToDecimal(dr["Net"]).ToString("N0");
            }

            dr.Close();
        }
    }


    void LoadEarnings()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            int dealer = Convert.ToInt32(Session["VendorID"]);

            SqlCommand cmd = new SqlCommand(@"

SELECT
LeadID RecordID,
'Lead' Source,
B.ModelName,
U.FullName Customer,
L.LeadAmount Amount,
ISNULL(L.CommissionAmount,0) Commission,
L.LeadAmount - ISNULL(L.CommissionAmount,0) Net,
L.CreatedAt Date,
CASE
WHEN L.SettlementRequested=1 THEN 'Requested'
WHEN L.IsSettled=1 THEN 'Settled'
ELSE 'Not Requested'
END Status

FROM Leads L
JOIN Bikes B ON L.BikeID=B.BikeID
JOIN Users U ON L.CustomerID=U.UserID
WHERE B.DealerID=@d

UNION ALL

SELECT
RentalID,
'Rental',
B.ModelName,
U.FullName,
R.RentAmount,
ISNULL(R.CommissionAmount,0),
R.RentAmount - ISNULL(R.CommissionAmount,0),
R.CreatedAt,
'Completed'

FROM RentalBookings R
JOIN Bikes B ON R.BikeID=B.BikeID
JOIN Users U ON R.CustomerID=U.UserID
WHERE R.DealerID=@d
AND R.Status='Completed'

ORDER BY Date DESC

", con);

            cmd.Parameters.AddWithValue("@d", dealer);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvEarnings.DataSource = dt;
            gvEarnings.DataBind();

        }
    }


    protected void btnMassSettlement_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            foreach (GridViewRow row in gvEarnings.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkSelect");

                if (chk != null && chk.Checked)
                {
                    int id = Convert.ToInt32(gvEarnings.DataKeys[row.RowIndex].Values["RecordID"]);
                    string source = gvEarnings.DataKeys[row.RowIndex].Values["Source"].ToString();

                    if (source == "Lead")
                    {
                        SqlCommand cmd = new SqlCommand(
                        "UPDATE Leads SET SettlementRequested=1 WHERE LeadID=@id", con);

                        cmd.Parameters.AddWithValue("@id", id);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }

        LoadSummary();
        LoadEarnings();
    }

    protected void gvEarnings_PageIndexChanging(object sender,
    System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvEarnings.PageIndex = e.NewPageIndex;

        LoadEarnings();
    }


 
}
