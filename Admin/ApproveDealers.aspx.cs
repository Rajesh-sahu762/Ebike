using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.Web.UI.WebControls;

public partial class Admin_ApproveDealers : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminID"] == null)
        {
            Response.Redirect("AdminLogin.aspx");
        }

        if (!IsPostBack)
        {
            LoadDealers("");
            LoadCities();
        }
    }

    void LoadCities()
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = "SELECT DISTINCT City FROM Users WHERE Role='Dealer' AND IsEmailVerified=1";
            SqlCommand cmd = new SqlCommand(query, con);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            ddlCity.Items.Clear();
            ddlCity.Items.Add(new ListItem("Select City...", ""));

            while (dr.Read())
            {
                ddlCity.Items.Add(new ListItem(dr["City"].ToString(), dr["City"].ToString()));
            }
        }
    }

    void LoadDealers(string search)
    {
        using (SqlConnection con = new SqlConnection(constr))
        {
            string query = @"SELECT UserID, FullName, Email, Mobile, ShopName, City
                             FROM Users
                             WHERE Role='Dealer'
                             AND IsApproved=0
                             AND IsEmailVerified=1";

            if (search != "")
                query += " AND (FullName LIKE @search OR Email LIKE @search)";

            if (ddlCity.SelectedValue != "")
                query += " AND City=@city";

            SqlCommand cmd = new SqlCommand(query, con);

            if (search != "")
                cmd.Parameters.AddWithValue("@search", "%" + search + "%");

            if (ddlCity.SelectedValue != "")
                cmd.Parameters.AddWithValue("@city", ddlCity.SelectedValue);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvDealers.DataSource = dt;
            gvDealers.DataBind();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadDealers(txtSearch.Text.Trim());
    }

    protected void gvDealers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int userId = Convert.ToInt32(e.CommandArgument);

        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();

            string dealerEmail = "";
            string dealerName = "";
            bool isVerified = false;

            SqlCommand getCmd = new SqlCommand(
                "SELECT Email, FullName, IsEmailVerified FROM Users WHERE UserID=@id", con);
            getCmd.Parameters.AddWithValue("@id", userId);

            SqlDataReader dr = getCmd.ExecuteReader();

            if (dr.Read())
            {
                dealerEmail = dr["Email"].ToString();
                dealerName = dr["FullName"].ToString();
                isVerified = Convert.ToBoolean(dr["IsEmailVerified"]);
            }
            dr.Close();

            if (e.CommandName == "Approve")
            {
                if (!isVerified)
                    return; // Don't approve if email not verified

                SqlCommand approveCmd = new SqlCommand(
                    "UPDATE Users SET IsApproved=1 WHERE UserID=@id", con);
                approveCmd.Parameters.AddWithValue("@id", userId);
                approveCmd.ExecuteNonQuery();

                SendApprovalEmail(dealerEmail, dealerName);
            }

            if (e.CommandName == "Reject")
            {
                SqlCommand deleteCmd = new SqlCommand(
                    "DELETE FROM Users WHERE UserID=@id", con);
                deleteCmd.Parameters.AddWithValue("@id", userId);
                deleteCmd.ExecuteNonQuery();

                SendRejectEmail(dealerEmail, dealerName);
            }
        }

        LoadDealers("");
    }

    void SendApprovalEmail(string toEmail, string dealerName)
    {
        try
        {
            string loginUrl = "https://yourdomain.com/Vendor/VendorLogin.aspx";

            MailMessage mail = new MailMessage();
            mail.To.Add(toEmail);
            mail.Subject = "Dealer Approved - EBikes Duniya";

            mail.Body = "Hello " + dealerName + ",\n\n" +
                        "Congratulations! Your dealer account has been approved.\n\n" +
                        "Login here:\n" + loginUrl + "\n\n" +
                        "Start uploading your bikes today.\n\n" +
                        "Regards,\nEBikes Duniya Team";

            mail.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);
        }
        catch { }
    }

    void SendRejectEmail(string toEmail, string dealerName)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(toEmail);
            mail.Subject = "Dealer Application Rejected - EBikes Duniya";

            mail.Body = "Hello " + dealerName + ",\n\n" +
                        "Your dealer application has been rejected.\n\n" +
                        "For more information contact support.\n\n" +
                        "Regards,\nEBikes Duniya Team";

            mail.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);
        }
        catch { }
    }
}
