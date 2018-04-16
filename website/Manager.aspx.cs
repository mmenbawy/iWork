using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void staffm(object sender, EventArgs e)
    {
        Response.Redirect("SMember.aspx", true);
    }

    protected void Logout(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("Main.aspx", true);
    }
}