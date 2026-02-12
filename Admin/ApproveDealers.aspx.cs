using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.Net;


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
        SqlConnection con = new SqlConnection(constr);
        string query = "SELECT DISTINCT City FROM Users WHERE Role='Dealer'";
        SqlCommand cmd = new SqlCommand(query, con);

        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();

        ddlCity.Items.Clear();
        ddlCity.Items.Add(new ListItem("Select City...", ""));

        while (dr.Read())
        {
            ddlCity.Items.Add(new ListItem(dr["City"].ToString(), dr["City"].ToString()));
        }

        con.Close();
    }



    void LoadDealers(string search)
    {
        SqlConnection con = new SqlConnection(constr);

        string query = @"SELECT UserID, FullName, Email, Mobile, ShopName, City
                     FROM Users
                     WHERE Role='Dealer'
                     AND IsApproved=0";

        if (search != "")
        {
            query += " AND (FullName LIKE @search OR Email LIKE @search)";
        }

        if (ddlCity.SelectedValue != "")
        {
            query += " AND City=@city";
        }

        SqlCommand cmd = new SqlCommand(query, con);

        if (search != "")
        {
            cmd.Parameters.AddWithValue("@search", "%" + search + "%");
        }

        if (ddlCity.SelectedValue != "")
        {
            cmd.Parameters.AddWithValue("@city", ddlCity.SelectedValue);
        }

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        gvDealers.DataSource = dt;
        gvDealers.DataBind();
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadDealers(txtSearch.Text.Trim());
    }

    protected void gvDealers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int userId = Convert.ToInt32(e.CommandArgument);

        SqlConnection con = new SqlConnection(constr);
        con.Open();

        if (e.CommandName == "Approve")
        {
            // Get Dealer Email & Name
            string dealerEmail = "";
            string dealerName = "";

            SqlCommand getCmd = new SqlCommand("SELECT Email, FullName FROM Users WHERE UserID=@id", con);
            getCmd.Parameters.AddWithValue("@id", userId);

            SqlDataReader dr = getCmd.ExecuteReader();

            if (dr.Read())
            {
                dealerEmail = dr["Email"].ToString();
                dealerName = dr["FullName"].ToString();
            }
            dr.Close();

            // Approve Dealer
            SqlCommand approveCmd = new SqlCommand("UPDATE Users SET IsApproved=1, ApprovedAt=GETDATE() WHERE UserID=@id", con);
            approveCmd.Parameters.AddWithValue("@id", userId);
            approveCmd.ExecuteNonQuery();

            // Send Email
            SendApprovalEmail(dealerEmail, dealerName);
        }


        if (e.CommandName == "Reject")
        {
            string dealerEmail = "";
            string dealerName = "";

            SqlCommand getCmd = new SqlCommand("SELECT Email, FullName FROM Users WHERE UserID=@id", con);
            getCmd.Parameters.AddWithValue("@id", userId);

            SqlDataReader dr = getCmd.ExecuteReader();
            if (dr.Read())
            {
                dealerEmail = dr["Email"].ToString();
                dealerName = dr["FullName"].ToString();
            }
            dr.Close();

            SqlCommand deleteCmd = new SqlCommand("DELETE FROM Users WHERE UserID=@id", con);
            deleteCmd.Parameters.AddWithValue("@id", userId);
            deleteCmd.ExecuteNonQuery();

            SendRejectEmail(dealerEmail, dealerName);
        }


        if (e.CommandName == "ViewDealer")
        {
            string query = "SELECT * FROM Users WHERE UserID=@id";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@id", userId);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                string details = "<b>Name:</b> " + dr["FullName"] + "<br/>";
                details += "<b>Email:</b> " + dr["Email"] + "<br/>";
                details += "<b>Mobile:</b> " + dr["Mobile"] + "<br/>";
                details += "<b>Shop:</b> " + dr["ShopName"] + "<br/>";
                details += "<b>City:</b> " + dr["City"] + "<br/>";
                details += "<b>Address:</b> " + dr["Address"] + "<br/>";

                litDealerDetails.Text = details;

                ClientScript.RegisterStartupScript(this.GetType(),
    "Popup", "$('#dealerModal').modal('show');", true);

            }
        }


        con.Close();

        LoadDealers("");
    }

    void SendApprovalEmail(string toEmail, string dealerName)
    {
        try
        {
            string loginUrl = "https://yourdomain.com/Dealer/Login.aspx";

            MailMessage mail = new MailMessage();
            mail.To.Add(toEmail);
            mail.Subject = "Dealer Approved - EBikes Duniya";

            mail.Body = "Hello " + dealerName + ",\n\n" +
                        "🎉 Congratulations! Your dealer account has been approved.\n\n" +
                        "You can login here:\n" + loginUrl + "\n\n" +
                        "Start uploading your bikes today.\n\n" +
                        "Regards,\nEBikes Duniya Team";

            mail.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);
        }
        catch (Exception ex)
        {
        }
    }

    void SendRejectEmail(string toEmail, string dealerName)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.To.Add(toEmail);
            mail.Subject = "Dealer Application Rejected - EBikes Duniya";

            mail.Body = "Hello " + dealerName + ",\n\n" +
                        "We regret to inform you that your dealer application has been rejected.\n\n" +
                        "For more information please contact support.\n\n" +
                        "Regards,\nEBikes Duniya Team";

            mail.IsBodyHtml = false;

            SmtpClient smtp = new SmtpClient();
            smtp.Send(mail);
        }
        catch (Exception ex)
        {
        }
    }


}
