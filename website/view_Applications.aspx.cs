using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


public partial class view_Applications : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("HR_view_applications", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@jid", (String)Session["jid"]));
        cmd.Parameters.Add(new SqlParameter("@hr_employee", (String)Session["username"]));
        conn.Open();

        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        Control myControl = FindControl("applications");
        while (rdr.Read())
        {
            int a_id = rdr.GetInt32(rdr.GetOrdinal("a_id"));
            int score = rdr.GetInt32(rdr.GetOrdinal("score"));
            String applicant_status = rdr.GetString(rdr.GetOrdinal("applicant_status"));
            String username = rdr.GetString(rdr.GetOrdinal("username"));
            String Name = rdr.GetString(rdr.GetOrdinal("Name"));
            int age = rdr.GetInt32(rdr.GetOrdinal("age"));
            String personal_email = rdr.GetString(rdr.GetOrdinal("personal_email"));
            int experience_years = rdr.GetInt32(rdr.GetOrdinal("experience_years"));
            DateTime birth_date = rdr.GetDateTime(rdr.GetOrdinal("birth_date"));
            int jid = rdr.GetInt32(rdr.GetOrdinal("job_id"));
            String title = rdr.GetString(rdr.GetOrdinal("title"));
            String short_description = rdr.GetString(rdr.GetOrdinal("short_description"));
            String detailed_description = rdr.GetString(rdr.GetOrdinal("detailed_description"));
            int number_of_vacancies = rdr.GetInt32(rdr.GetOrdinal("number_of_vacancies"));
            double salary = rdr.GetDouble(rdr.GetOrdinal("salary"));
            DateTime application_deadline = rdr.GetDateTime(rdr.GetOrdinal("application_deadline"));
            int working_hours = rdr.GetInt32(rdr.GetOrdinal("working_hours"));
            int minimum_experience_years = rdr.GetInt32(rdr.GetOrdinal("minimum_experience_years"));
            
            Label nl = new Label();
            nl.Text = "<br />" + "application code: " + a_id +  "<br/>" + "Job seeker username: " + username + "<br />" + "Name: " + Name + "<br />" +
                            "birth date: " + birth_date + "<br />" + "age: " + age
                            + "<br />" + "personal email: " + personal_email + "<br />" + "experience years : " + experience_years +
                            "<br />" + "score: " + score + "<br />" + "applicant status: " + applicant_status + 
                            "<br/>" + "Job title: " + title + "<br />" + "Short description: " + short_description + "<br />" +
                            "Detailed description: " + detailed_description + "<br />" + "number of vacancies: " + number_of_vacancies
                             + "<br />" + "salary: " + salary + "<br />" + "application deadline: " + application_deadline +
                             "<br />" + "working hours: " + working_hours + "<br />" + "minimum experience years: " + minimum_experience_years + "<br />";
            myControl.Controls.Add(nl);
            Button b1 = new Button();
            b1.Text = "Accept";
            b1.Click += accept_application;
            b1.CommandArgument = Convert.ToString(a_id);
            b1.CommandName = Convert.ToString(username);
            myControl.Controls.Add(b1);
            Label n2 = new Label();
            n2.Text = "<br />" + "<br />";
            myControl.Controls.Add(n2);
            Button b2 = new Button();
            b2.Text = "Reject";
            b2.Click += reject_application;
            b2.CommandArgument = Convert.ToString(a_id);
            b2.CommandName = Convert.ToString(username);
            myControl.Controls.Add(b2);
            Label n3 = new Label();
            n3.Text = "<br />" + "<br />";
            myControl.Controls.Add(n3);

        }
        rdr.Close();
        conn.Close();
    }

    protected void accept_application(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        String aid = btn.CommandArgument;
        String applicant = btn.CommandName;

        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("HR_checks_applications", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@applicant", applicant));
        cmd.Parameters.Add(new SqlParameter("@a_id", aid));
        cmd.Parameters.Add(new SqlParameter("@hr_employee", (String)Session["username"]));
        cmd.Parameters.Add(new SqlParameter("@hr_response", "Accepted"));

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Response.Redirect("view_Applications.aspx", true);

    }
    protected void reject_application(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        String aid = btn.CommandArgument;
        String applicant = btn.CommandName;

        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("HR_checks_applications", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@applicant", applicant));
        cmd.Parameters.Add(new SqlParameter("@a_id", aid));
        cmd.Parameters.Add(new SqlParameter("@hr_employee", (String)Session["username"]));
        cmd.Parameters.Add(new SqlParameter("@hr_response", "Rejected"));

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Response.Redirect("view_Applications.aspx", true);

    }

    protected void home_Click(object sender, EventArgs e)
    {
        Response.Redirect("view_edit_job.aspx", true);
    }

}