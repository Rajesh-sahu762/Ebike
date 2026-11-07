using System;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Web.Services;
using System.Web;
using System.Web.Caching;

public partial class Client_ClientMaster : System.Web.UI.MasterPage
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    [Serializable]
    private class CachedSiteSettings
    {
        public string SiteTitle { get; set; }
        public string LogoPath { get; set; }
        public string AdminEmail { get; set; }
        public string SupportPhone { get; set; }
        public bool MaintenanceMode { get; set; }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        // Explicit UTF-8 output keeps the Indian rupee sign and other Unicode characters intact.
        Response.ContentEncoding = Encoding.UTF8;
        Response.Charset = "utf-8";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        // Server-validated, cryptographically secure Remember Me check
        if (Session["CustomerID"] == null)
        {
            AuthHelper.ValidateRememberMeCookie(Request, Response, Session, constr);
        }

        if (!IsPostBack)
        {
            LoadSiteSettings();
            UpdateMasterCartCount();
        }

        if (Session["CustomerID"] != null)
        {
            pnlLogin.Visible = false;
            pnlUser.Visible = true;
            lblUserName.Text = Session["CustomerName"] != null ? Session["CustomerName"].ToString() : "My Account";
            if (!IsPostBack)
            {
                LoadWishlistCount();
            }
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
        int userId = Session["CustomerID"] != null ? Convert.ToInt32(Session["CustomerID"]) : 0;

        if (userId == 0) { cartCount.InnerText = "0"; return; }

        using (SqlConnection con = new SqlConnection(constr))
        {
            SqlCommand cmd = new SqlCommand("SELECT ISNULL(SUM(Qty), 0) FROM Cart WHERE UserID = @UID", con);
            cmd.Parameters.AddWithValue("@UID", userId);
            con.Open();
            object res = cmd.ExecuteScalar();
            cartCount.InnerText = res != null ? res.ToString() : "0";
        }
    }

    void LoadSiteSettings()
    {
        const string cacheKey = "SiteSettings_1";
        CachedSiteSettings settings = HttpRuntime.Cache[cacheKey] as CachedSiteSettings;

        if (settings == null)
        {
            settings = new CachedSiteSettings();
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT * FROM SiteSettings WHERE SettingID=1", con);
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        if (dr["SiteTitle"] != DBNull.Value)
                            settings.SiteTitle = dr["SiteTitle"].ToString();

                        if (dr["LogoPath"] != DBNull.Value)
                            settings.LogoPath = dr["LogoPath"].ToString();

                        if (dr["AdminEmail"] != DBNull.Value)
                            settings.AdminEmail = dr["AdminEmail"].ToString();

                        if (dr["SupportPhone"] != DBNull.Value)
                            settings.SupportPhone = dr["SupportPhone"].ToString();

                        if (dr["MaintenanceMode"] != DBNull.Value)
                            settings.MaintenanceMode = Convert.ToBoolean(dr["MaintenanceMode"]);
                    }
                }
            }

            // Cache site settings for 20 minutes to reduce master page database load
            HttpRuntime.Cache.Insert(cacheKey, settings, null, DateTime.Now.AddMinutes(20), Cache.NoSlidingExpiration);
        }

        if (!string.IsNullOrEmpty(settings.SiteTitle))
        {
            // Keep the dynamic browser title; the visible duplicate logo text was removed from the master markup.
            Page.Title = settings.SiteTitle;
        }

        // Use the committed EBikes Duniya SVG mark as the dependable client logo.
        // SiteSettings.LogoPath can contain legacy relative paths from older uploads.
        imgLogo.ImageUrl = ResolveUrl("~/Uploads/EBikes-Duniya-Logo.png");

        if (!string.IsNullOrEmpty(settings.AdminEmail))
        {
            lblFooterEmail.Text = settings.AdminEmail;
        }

        if (!string.IsNullOrEmpty(settings.SupportPhone))
        {
            lblFooterPhone.Text = settings.SupportPhone;
        }

        if (settings.MaintenanceMode)
        {
            Response.Redirect("~/Client/Maintenance.aspx");
        }
    }

    void LoadWishlistCount()
    {
        if (Session["CustomerID"] == null)
        {
            wishCount.InnerText = "0";
            return;
        }

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
                "SELECT COUNT(*) FROM Wishlist WHERE CustomerID = @CustomerID",
                con);

            cmd.Parameters.AddWithValue("@CustomerID",
                Convert.ToInt32(Session["CustomerID"]));

            object result = cmd.ExecuteScalar();

            if (result != null)
                wishCount.InnerText = result.ToString();
            else
                wishCount.InnerText = "0";
        }
    }
}
