using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Client_Default : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadConnectors();  
            LoadStations();
        }
    }

    void LoadConnectors()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(@"

SELECT DISTINCT ConnectorType 
FROM ChargingStations 
WHERE IsApproved = 1 AND ConnectorType IS NOT NULL

", con);

            SqlDataReader dr = cmd.ExecuteReader();

            ddlConnector.Items.Clear();

            ddlConnector.Items.Add(new System.Web.UI.WebControls.ListItem("All Connectors", ""));

            while (dr.Read())
            {
                ddlConnector.Items.Add(new System.Web.UI.WebControls.ListItem(
                    dr["ConnectorType"].ToString(),
                    dr["ConnectorType"].ToString()
                ));
            }
        }
    }
    void LoadStations()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string query = @"

SELECT 
StationName,
City,
Address,
ConnectorType,
IsActive

FROM ChargingStations

WHERE IsApproved = 1
";

            // 🔍 SEARCH FILTER
            if (txtSearch.Value.Trim() != "")
            {
                query += " AND (City LIKE @search OR Address LIKE @search)";
            }

            // 🔌 CONNECTOR FILTER
            if (ddlConnector.SelectedValue != "")
            {
                query += " AND ConnectorType LIKE @type";
            }

            query += " ORDER BY CreatedAt DESC";

            SqlCommand cmd = new SqlCommand(query, con);

            if (txtSearch.Value.Trim() != "")
            {
                cmd.Parameters.AddWithValue("@search", "%" + txtSearch.Value.Trim() + "%");
            }

            if (ddlConnector.SelectedValue != "")
            {
                cmd.Parameters.AddWithValue("@type", "%" + ddlConnector.SelectedValue + "%");
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            rptStations.DataSource = dt;
            rptStations.DataBind();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadStations();
    }
}