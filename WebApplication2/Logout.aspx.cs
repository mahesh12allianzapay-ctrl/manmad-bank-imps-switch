using System;

namespace WebApplication2
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            Response.Cookies.Clear();

            Response.Redirect("About.aspx");
        }
    }
}