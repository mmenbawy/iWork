using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class JSeeker : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("getMyInfo", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@username", (String)Session["username"]));
        conn.Open();

        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        Control myControl = FindControl("information");

        while (rdr.Read())
        {
            String username = rdr.GetString(rdr.GetOrdinal("username"));
            String personal_email = rdr.GetString(rdr.GetOrdinal("personal_email"));
            DateTime birth_date = rdr.GetDateTime(rdr.GetOrdinal("birth_date"));
            String first_name = rdr.GetString(rdr.GetOrdinal("first_name"));
            String middle_name = rdr.GetString(rdr.GetOrdinal("middle_name"));
            String last_name = rdr.GetString(rdr.GetOrdinal("last_name"));
            int experience_years = rdr.GetInt32(rdr.GetOrdinal("experience_years"));
            int age = rdr.GetInt32(rdr.GetOrdinal("age"));
            Label nl = new Label();
            nl.Text = "<br/>" + "username: " + username + "<br />" + "personal email: " + personal_email + "<br />" +
                "birth date: " + birth_date + "<br />" + "first name: " + first_name
                + "<br />" + "middle name: " + middle_name + "<br />" + "last name: " + last_name +
                "<br />" + "experience years: " + experience_years + "<br />" + "age: " + age + "<br />";
            myControl.Controls.Add(nl);
            Button b1 = new Button();
            b1.Text = "Edit profile";
            b1.Click += edit_profile;
            myControl.Controls.Add(b1);

        }
        rdr.Close();
        conn.Close();
    }

    protected void edit_profile(object sender, EventArgs e)
    {
        Response.Redirect("seeker_edit_profile.aspx", true);

    }

    protected void Logout(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("Main.aspx", true);
    }

    public void getApplications(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("getApplications", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));

        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);

        Applications.DataSource = dt;
        Applications.DataBind();
    }
    public void DeleteApplication(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("deleteApplication", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
        cmd.Parameters.Add(new SqlParameter("@a_id", txt_Applicationid.Text));
        SqlParameter res = cmd.Parameters.Add("@output", SqlDbType.Int);
        res.Direction = ParameterDirection.Output;

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();


        if (res.Value.ToString().Equals("0"))
        {
            DelResLabel.Text = "Deleted Successfully !";
            DelResLabel.Visible = true;
        }
        else
        {
            if(res.Value.ToString().Equals("1"))
            {
                DelResLabel.Text = "No Application Was Found !";
                DelResLabel.Visible = true;
            }
            else
            {
                DelResLabel.Text = "Application Already Reviewed !";
                DelResLabel.Visible = true;
            }
        }
    }
    public void AcceptingApplications(object sender, EventArgs e)
    {
        if (Session["Username"] == null) return;
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("TakeTheJob", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
        cmd.Parameters.Add(new SqlParameter("@a_id", txt_accApp.Text));
        cmd.Parameters.Add(new SqlParameter("@dayOff", txt_dayOff.Text));
        SqlParameter res = cmd.Parameters.Add("@output", SqlDbType.Int);
        res.Direction = ParameterDirection.Output;

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        if (res.Value.ToString().Equals("0"))
        {
            AccResLabel.Text = "Congratulations !";
            AccResLabel.Visible = true;
            Response.Redirect("SMember",true);
        }
        else
        {
            if (res.Value.ToString().Equals("1"))
            {
                AccResLabel.Text = "Application Not Accepted !";
                AccResLabel.Visible = true;
            }
            else
            {
                AccResLabel.Text = "Already Accepted !";
                AccResLabel.Visible = true;
            }
        }

    }
}