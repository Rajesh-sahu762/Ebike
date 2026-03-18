using System;

public partial class ConfirmationPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["id"] != null)
            {
                litOrderID.Text = Request.QueryString["id"].ToString();
            }
            else
            {
                // Agar bina order ke is page par aaye toh redirect
                Response.Redirect("Parts.aspx");
            }
        }
    }
}