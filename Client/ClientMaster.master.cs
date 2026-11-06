using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using EBIke.Security;

public partial class Client_ClientMaster : System.Web.UI.MasterPage
{
    private readonly string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CustomerID"] == null)
            RememberMeSecurity.TryRestore(Context);

        if (!IsPostBack)
        {
            LoadSiteSettings();
            UpdateMasterCartCount();
        }

        if (Session["CustomerID"] != null)
        {
            pnlLogin.Visible = false;
            pnlUser.Visible = true;
            lblUserName.Text = Session["CustomerName"] != null
                ? Convert.ToString(Session["CustomerName"]) : "My Account";
            LoadWishlistCount();
        }
        else
        {
            pnlLogin.Visible = true;
            pnlUser.Visible = false;
            wishCount.InnerText = "0";
            cartCount.InnerText = "0";
        }
    }

    public void UpdateMasterCartCount()
    {
        int userId = Session["CustomerID"] == null ? 0 : Convert.ToInt32(Session["CustomerID"]);
        if (userId <= 0)
        {
            cartCount.InnerText = "0";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand cmd = new SqlCommand(
            "SELECT ISNULL(SUM(Qty), 0) FROM dbo.Cart WHERE UserID=@UID;", con))
        {
            cmd.Parameters.Add("@UID", SqlDbType.Int).Value = userId;
            con.Open();
            cartCount.InnerText = Convert.ToString(cmd.ExecuteScalar());
        }
    }

    private void LoadSiteSettings()
    {
        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand cmd = new SqlCommand(@"
SELECT SiteTitle, LogoPath, AdminEmail, SupportPhone, MaintenanceMode
FROM dbo.SiteSettings WHERE SettingID=1;", con))
        {
            con.Open();
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                if (!dr.Read()) return;

                if (dr["SiteTitle"] != DBNull.Value)
                {
                    Page.Title = Convert.ToString(dr["SiteTitle"]);
                    lblSiteTitle.Text = Convert.ToString(dr["SiteTitle"]);
                }
                if (dr["LogoPath"] != DBNull.Value)
                    imgLogo.ImageUrl = Convert.ToString(dr["LogoPath"]);
                if (dr["AdminEmail"] != DBNull.Value)
                    lblFooterEmail.Text = Convert.ToString(dr["AdminEmail"]);
                if (dr["SupportPhone"] != DBNull.Value)
                    lblFooterPhone.Text = Convert.ToString(dr["SupportPhone"]);

                bool maintenance = dr["MaintenanceMode"] != DBNull.Value &&
                    Convert.ToBoolean(dr["MaintenanceMode"]);
                if (maintenance && !Request.AppRelativeCurrentExecutionFilePath.EndsWith(
                    "Maintenance.aspx", StringComparison.OrdinalIgnoreCase))
                    Response.Redirect("~/Client/Maintenance.aspx", false);
            }
        }
    }

    private void LoadWishlistCount()
    {
        int userId = Convert.ToInt32(Session["CustomerID"]);
        using (SqlConnection con = new SqlConnection(constr))
        using (SqlCommand cmd = new SqlCommand(
            "SELECT COUNT(*) FROM dbo.Wishlist WHERE CustomerID=@CustomerID;", con))
        {
            cmd.Parameters.Add("@CustomerID", SqlDbType.Int).Value = userId;
            con.Open();
            wishCount.InnerText = Convert.ToString(cmd.ExecuteScalar());
        }
    }
}
