using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SMember : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void home_click(object sender, EventArgs e)
    {

        string type = (String)Session["type"];
        if (type == "HR")
            Response.Redirect("HR.aspx", true);
        else
        if (type == "Manager")
            Response.Redirect("Manager.aspx", true);
        else
        if (type == "Regular")
            Response.Redirect("REmployee.aspx", true);
    }

    protected void Logout(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("Main.aspx", true);
    }
}