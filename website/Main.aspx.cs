using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Main : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("SearchForCompany", conn);
        cmd.CommandType = CommandType.StoredProcedure;

         cmd.Parameters.Add(new SqlParameter("@type", "international"));
         cmd.Parameters.Add(new SqlParameter("@address", DBNull.Value));
         cmd.Parameters.Add(new SqlParameter("@name", DBNull.Value));

         SqlDataAdapter sda = new SqlDataAdapter(cmd);
         DataTable dt = new DataTable();
         sda.Fill(dt);
         international.DataSource = dt;
         international.DataBind();

        SqlCommand cmd2 = new SqlCommand("SearchForCompany", conn);
        cmd2.CommandType = CommandType.StoredProcedure;

        cmd2.Parameters.Add(new SqlParameter("@type", "national"));
        cmd2.Parameters.Add(new SqlParameter("@address", DBNull.Value));
        cmd2.Parameters.Add(new SqlParameter("@name", DBNull.Value));

        SqlDataAdapter sda2 = new SqlDataAdapter(cmd2);
        DataTable dt2 = new DataTable();
        sda2.Fill(dt2);
        national.DataSource = dt2;
        national.DataBind();

        ///
        //Session["Username"] = "omaradel";
    }

    protected void register(object sender, EventArgs e)
    {
        Response.Redirect("register.aspx", true);
    }

    protected void login(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("Log_in", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string username = txt_username.Text;
        string password = txt_password.Text;
        cmd.Parameters.Add(new SqlParameter("@username", username));
        cmd.Parameters.Add(new SqlParameter("@password", password));

        // output parm 
        // @login: indicate the authentication process 
        SqlParameter flag = cmd.Parameters.Add("@login", SqlDbType.Bit);
        flag.Direction = ParameterDirection.Output;
        // @type: indicate the type of the staff member
        SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.VarChar, 50);
        type.Direction = ParameterDirection.Output;
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Response.Write(flag.Value.ToString());
        if (flag.Value.ToString().Equals("True"))
        {
            //this is how you store data to session variable.
            Session["Username"] = username;
            Session["type"] = type.Value.ToString();
            Response.Write("Passed");

            // if-then-else on the type and redirecting to the specific page of the staff member
            //if he is not of regular/HR/manager type, he will be redirected to the staff member page
            if (type.Value.ToString().Equals("Regular"))
                Response.Redirect("REmployee.aspx", true);
            else if (type.Value.ToString().Equals("Manager"))
                Response.Redirect("Manager.aspx", true);
            else if (type.Value.ToString().Equals("HR"))
                Response.Redirect("HR.aspx", true);
            else if (type.Value.ToString().Equals("Seeker"))
                Response.Redirect("JSeeker.aspx", true);

        }
        else
        {
            Response.Write("Failed");
        }
    }

    public void SearchByName(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("SearchForCompany", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@name", SearchBox.Text));
        cmd.Parameters.Add(new SqlParameter("@address", DBNull.Value));
        cmd.Parameters.Add(new SqlParameter("@type", DBNull.Value));

        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        SCResults.DataSource = dt;
        SCResults.DataBind();

    }
    public void SearchByAddress(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("SearchForCompany", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@address", SearchBox.Text));
        cmd.Parameters.Add(new SqlParameter("@name", DBNull.Value));
        cmd.Parameters.Add(new SqlParameter("@type", DBNull.Value));

        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        SCResults.DataSource = dt;
        SCResults.DataBind();

    }
    public void SearchByType(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("SearchForCompany", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        if(SearchBox.Text.ToLower().Equals("international") || SearchBox.Text.ToLower().Equals("national"))
        {
            cmd.Parameters.Add(new SqlParameter("@type", SearchBox.Text));
            cmd.Parameters.Add(new SqlParameter("@address", DBNull.Value));
            cmd.Parameters.Add(new SqlParameter("@name", DBNull.Value));

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            SCResults.DataSource = dt;
            SCResults.DataBind();
        }
    }
    public void ApplyForAJob(object sender, EventArgs e)
    {
        Object Id = Session["Username"];
        if(Id == null)
        {
            Apply_Err.Text = "You Are Not Logged In !";
            Apply_Err.Visible = true;
            return;
        }
        string userId = Session["Username"].ToString();
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("JobSeekerApply", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@username", userId));
        cmd.Parameters.Add(new SqlParameter("@jid", ApplyJID.Text));
        SqlParameter res = cmd.Parameters.Add("@output", SqlDbType.Int);
        res.Direction = ParameterDirection.Output;

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        if (res.Value.ToString().Equals("1"))
        {
            Apply_Err.Text = "Already Applied !";
            Apply_Err.Visible = true;
            return;
        }
        else
        {
            if (res.Value.ToString().Equals("2"))
            {
                Apply_Err.Text = "Not Enought Experience Years !";
                Apply_Err.Visible = true;
                return;
            }
            else
            {
                if (res.Value.ToString().Equals("3"))
                {
                    Apply_Err.Text = "You Are Not A Job Seeker !";
                    Apply_Err.Visible = true;
                    return;
                }
                else
                {
                    Response.Redirect("Apply?jid="+ ApplyJID.Text, true);
                    //Response.Redirect("Apply?jid=" + res.Value.ToString(), true);

                }
            }
        }
    }
}