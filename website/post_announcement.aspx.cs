using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class post_announcement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void post_announ(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("HR_post_announcement", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        String title = ((TextBox)FindControl("title")).Text;
        String announcement_type = ((TextBox)FindControl("announcement_type")).Text;
        String announcement_description = ((TextBox)FindControl("announcement_description")).Text;

        cmd.Parameters.Add(new SqlParameter("@title", title));
        cmd.Parameters.Add(new SqlParameter("@announcement_type", announcement_type));
        cmd.Parameters.Add(new SqlParameter("@announcement_description", announcement_description));
        cmd.Parameters.Add(new SqlParameter("@hr_employee", (String)Session["username"]));

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        ((TextBox)FindControl("title")).Text = "";
        ((TextBox)FindControl("announcement_type")).Text = "";
        ((TextBox)FindControl("announcement_description")).Text = "";
        Response.Write("<script>alert('Announcement added successfully')</script>");



    }

    protected void home_Click(object sender, EventArgs e)
    {
        Response.Redirect("HR.aspx");
    }

    protected void post_Click(object sender, EventArgs e)
    {

    }
}