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
            LoadSettings();
    }

    void LoadSettings()
    {
        SqlConnection con = new SqlConnection(constr);
        con.Open();

        SqlCommand cmd = new SqlCommand("SELECT * FROM SiteSettings WHERE SettingID=1", con);
        SqlDataReader dr = cmd.ExecuteReader();

        if (dr.Read())
        {
            txtSiteTitle.Text = dr["SiteTitle"].ToString();
            txtTagline.Text = dr["Tagline"].ToString();
            txtAdminEmail.Text = dr["AdminEmail"].ToString();
            txtSupportPhone.Text = dr["SupportPhone"].ToString();
            imgLogo.ImageUrl = dr["LogoPath"].ToString();

            txtSMTPHost.Text = dr["SMTPHost"].ToString();
            txtSMTPPort.Text = dr["SMTPPort"].ToString();
            txtSMTPEmail.Text = dr["SMTPEmail"].ToString();
            txtSMTPPassword.Attributes["value"] = dr["SMTPPassword"].ToString();
            chkSSL.Checked = dr["EnableSSL"] != DBNull.Value && Convert.ToBoolean(dr["EnableSSL"]);

            txtLeadPrice.Text = dr["LeadPrice"].ToString();
            txtCommission.Text = dr["CommissionPercent"].ToString();
            chkMaintenance.Checked = dr["MaintenanceMode"] != DBNull.Value && Convert.ToBoolean(dr["MaintenanceMode"]);
            txtMaintenanceMsg.Text = dr["MaintenanceMessage"].ToString();
        }

        con.Close();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(constr);
        con.Open();

        string logoPath = imgLogo.ImageUrl;

        if (fuLogo.HasFile)
        {
            string ext = Path.GetExtension(fuLogo.FileName);
            string fileName = Guid.NewGuid().ToString() + ext;
            logoPath = "/Uploads/Site/" + fileName;

            if (!Directory.Exists(Server.MapPath("/Uploads/Site/")))
                Directory.CreateDirectory(Server.MapPath("/Uploads/Site/"));

            fuLogo.SaveAs(Server.MapPath(logoPath));
        }

        SqlCommand cmd = new SqlCommand(
            @"UPDATE SiteSettings SET
            SiteTitle=@title,
            Tagline=@tagline,
            AdminEmail=@email,
            SupportPhone=@phone,
            LogoPath=@logo,
            SMTPHost=@host,
            SMTPPort=@port,
            SMTPEmail=@smtpEmail,
            SMTPPassword=@smtpPass,
            EnableSSL=@ssl,
            LeadPrice=@price,
            CommissionPercent=@commission,
            MaintenanceMode=@maint,
            MaintenanceMessage=@msg
            WHERE SettingID=1", con);

        cmd.Parameters.AddWithValue("@title", txtSiteTitle.Text);
        cmd.Parameters.AddWithValue("@tagline", txtTagline.Text);
        cmd.Parameters.AddWithValue("@email", txtAdminEmail.Text);
        cmd.Parameters.AddWithValue("@phone", txtSupportPhone.Text);
        cmd.Parameters.AddWithValue("@logo", logoPath);
        cmd.Parameters.AddWithValue("@host", txtSMTPHost.Text);
        cmd.Parameters.AddWithValue("@port", txtSMTPPort.Text);
        cmd.Parameters.AddWithValue("@smtpEmail", txtSMTPEmail.Text);
        cmd.Parameters.AddWithValue("@smtpPass", txtSMTPPassword.Text);
        cmd.Parameters.AddWithValue("@ssl", chkSSL.Checked);
        cmd.Parameters.AddWithValue("@price", txtLeadPrice.Text);
        cmd.Parameters.AddWithValue("@commission", txtCommission.Text);
        cmd.Parameters.AddWithValue("@maint", chkMaintenance.Checked);
        cmd.Parameters.AddWithValue("@msg", txtMaintenanceMsg.Text);

        cmd.ExecuteNonQuery();
        con.Close();

        LoadSettings();
    }
}
