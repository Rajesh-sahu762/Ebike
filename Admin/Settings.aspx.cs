using System;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

public partial class Admin_Settings : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
            Response.Redirect("AdminLogin.aspx");

        if (!IsPostBack)
        {
            LoadSettings();
        }
    }

    void LoadSettings()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand("SELECT * FROM SiteSettings WHERE SettingID=1", con);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                txtSiteTitle.Text = dr["SiteTitle"] == DBNull.Value ? "" : dr["SiteTitle"].ToString();
                txtTagline.Text = dr["Tagline"] == DBNull.Value ? "" : dr["Tagline"].ToString();
                txtAdminEmail.Text = dr["AdminEmail"] == DBNull.Value ? "" : dr["AdminEmail"].ToString();
                txtSupportPhone.Text = dr["SupportPhone"] == DBNull.Value ? "" : dr["SupportPhone"].ToString();

                txtSMTPHost.Text = dr["SMTPHost"] == DBNull.Value ? "" : dr["SMTPHost"].ToString();
                txtSMTPPort.Text = dr["SMTPPort"] == DBNull.Value ? "" : dr["SMTPPort"].ToString();
                txtSMTPEmail.Text = dr["SMTPEmail"] == DBNull.Value ? "" : dr["SMTPEmail"].ToString();

                txtCommission.Text = dr["CommissionPercent"] == DBNull.Value ? "" : dr["CommissionPercent"].ToString();

                chkSSL.Checked = dr["EnableSSL"] != DBNull.Value && Convert.ToBoolean(dr["EnableSSL"]);
                chkMaintenance.Checked = dr["MaintenanceMode"] != DBNull.Value && Convert.ToBoolean(dr["MaintenanceMode"]);

                txtMaintenanceMsg.Text = dr["MaintenanceMessage"] == DBNull.Value ? "" : dr["MaintenanceMessage"].ToString();

                if (dr["LogoPath"] != DBNull.Value)
                    imgLogo.ImageUrl = dr["LogoPath"].ToString();
            }

            dr.Close();
        }
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string logoPath = imgLogo.ImageUrl;

            // ===== LOGO UPLOAD =====

            if (fuLogo.HasFile)
            {
                string folder = "~/Uploads/";
                string fileName = "logo_" + DateTime.Now.Ticks + Path.GetExtension(fuLogo.FileName);

                string serverPath = Server.MapPath(folder + fileName);

                fuLogo.SaveAs(serverPath);

                logoPath = folder + fileName;

                imgLogo.ImageUrl = logoPath;
            }

            // ===== COMMISSION SAFE =====

            decimal commission = 0;

            if (!string.IsNullOrEmpty(txtCommission.Text))
                commission = Convert.ToDecimal(txtCommission.Text);

            // ===== SMTP PORT SAFE =====

            int port = 0;

            if (!string.IsNullOrEmpty(txtSMTPPort.Text))
                port = Convert.ToInt32(txtSMTPPort.Text);

            // ===== UPDATE SETTINGS =====

            SqlCommand cmd = new SqlCommand(@"

            UPDATE SiteSettings SET

            SiteTitle=@SiteTitle,
            Tagline=@Tagline,
            AdminEmail=@AdminEmail,
            SupportPhone=@SupportPhone,
            LogoPath=@LogoPath,

            SMTPHost=@SMTPHost,
            SMTPPort=@SMTPPort,
            SMTPEmail=@SMTPEmail,
            EnableSSL=@EnableSSL,

            CommissionPercent=@Commission,

            MaintenanceMode=@MaintenanceMode,
            MaintenanceMessage=@MaintenanceMessage

            WHERE SettingID=1

            ", con);

            cmd.Parameters.AddWithValue("@SiteTitle", txtSiteTitle.Text.Trim());
            cmd.Parameters.AddWithValue("@Tagline", txtTagline.Text.Trim());
            cmd.Parameters.AddWithValue("@AdminEmail", txtAdminEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@SupportPhone", txtSupportPhone.Text.Trim());

            cmd.Parameters.AddWithValue("@LogoPath", logoPath);

            cmd.Parameters.AddWithValue("@SMTPHost", txtSMTPHost.Text.Trim());
            cmd.Parameters.AddWithValue("@SMTPPort", port);
            cmd.Parameters.AddWithValue("@SMTPEmail", txtSMTPEmail.Text.Trim());

            cmd.Parameters.AddWithValue("@EnableSSL", chkSSL.Checked);

            cmd.Parameters.AddWithValue("@Commission", commission);

            cmd.Parameters.AddWithValue("@MaintenanceMode", chkMaintenance.Checked);
            cmd.Parameters.AddWithValue("@MaintenanceMessage", txtMaintenanceMsg.Text.Trim());

            cmd.ExecuteNonQuery();
        }

        LoadSettings();
    }
}