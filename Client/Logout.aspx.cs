using System;
using System.Web;
using EBIke.Security;

public partial class Client_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        RememberMeSecurity.RevokeCurrent(Context);

        Session.Clear();
        Session.Abandon();

        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetNoStore();
        Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));

        Response.Redirect("Home.aspx", false);
        Context.ApplicationInstance.CompleteRequest();
    }
}
