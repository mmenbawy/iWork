using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class REmployee : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Logout(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("Main.aspx", true);
    }

    protected void staffm(object sender, EventArgs e)
    {
        Response.Redirect("SMember.aspx", true);
    }

    public void ViewProjects(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("getProject", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));

        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        Projects.DataSource = dt;
        Projects.DataBind();
    }
    public void ViewTasks(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("getTasks", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
        cmd.Parameters.Add(new SqlParameter("@projectname", txt_projectname.Text));

        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        Tasks.DataSource = dt;
        Tasks.DataBind();
    }
    public void FinalizeATask(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("FinalizeATask", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
        cmd.Parameters.Add(new SqlParameter("@projectname", txt_pnameFinalize.Text));
        cmd.Parameters.Add(new SqlParameter("@taskname", txt_taskname.Text));

        SqlParameter output = cmd.Parameters.Add("@output", SqlDbType.Int);
        output.Direction = ParameterDirection.Output;

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        if (output.Value.ToString().Equals("1"))
        {
            resFinalizing.Text = "Deadline Reached !";
            resFinalizing.Visible = true;
        }
        else
        {
            resFinalizing.Text = "Done";
            resFinalizing.Visible = true;
        }
    }

    public void WorkOnATaskAgain(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("WorkOnATaskAgain", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
        cmd.Parameters.Add(new SqlParameter("@projectname", txt_ptagain.Text));
        cmd.Parameters.Add(new SqlParameter("@taskname", txt_tt_again.Text));

        SqlParameter output = cmd.Parameters.Add("@output", SqlDbType.Int);
        output.Direction = ParameterDirection.Output;

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        Response.Write(output.Value.ToString());

        if (output.Value.ToString().Equals("1"))
        {
            WorkOnATaskAgainLabel.Text = "Task Already Reviewed !";
            WorkOnATaskAgainLabel.Visible = true;
        }
        else
        {
            if (output.Value.ToString().Equals("2"))
            {
                WorkOnATaskAgainLabel.Text = "Deadline Reached !";
                WorkOnATaskAgainLabel.Visible = true;
            }
            else
            {
                WorkOnATaskAgainLabel.Text = "Done !";
                WorkOnATaskAgainLabel.Visible = true;
            }
        }
    }
}