using System;
using System.Configuration;
using System.Web;

public partial class Client_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string constr = ConfigurationManager.ConnectionStrings["Electronic"] != null 
            ? ConfigurationManager.ConnectionStrings["Electronic"].ConnectionString 
            : null;

        // Revoke server-side auth token and clear cookies securely
        if (!string.IsNullOrEmpty(constr))
        {
            AuthHelper.RevokeRememberMeCookie(Request, Response, constr);
        }

        Session.Clear();
        Session.Abandon();

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));

        Response.Redirect("Home.aspx");
    }
}
