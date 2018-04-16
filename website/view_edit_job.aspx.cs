using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class view_edit_job : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("HR_view_all_jobs", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@hr_employee", (String)Session["username"]));
        conn.Open();

        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        Control myControl = FindControl("jobs");
        while (rdr.Read())
        {
            int jid =  rdr.GetInt32(rdr.GetOrdinal("job_id"));
            String title = rdr.GetString(rdr.GetOrdinal("title"));
            String short_description = rdr.GetString(rdr.GetOrdinal("short_description"));
            String detailed_description = rdr.GetString(rdr.GetOrdinal("detailed_description"));
            int number_of_vacancies = rdr.GetInt32(rdr.GetOrdinal("number_of_vacancies"));
            double salary = rdr.GetDouble(rdr.GetOrdinal("salary"));
            DateTime application_deadline = rdr.GetDateTime(rdr.GetOrdinal("application_deadline"));
            int working_hours = rdr.GetInt32(rdr.GetOrdinal("working_hours"));
            int minimum_experience_years = rdr.GetInt32(rdr.GetOrdinal("minimum_experience_years"));
            Label nl = new Label();
            nl.Text = "<br/>" + "Job title: " + title + "<br />" + "Short description: " + short_description + "<br />" +
                "Detailed description: " + detailed_description + "<br />" + "number of vacancies: " + number_of_vacancies 
                + "<br />" + "salary: " + salary + "<br />" + "application deadline: " + application_deadline +
                "<br />" + "working hours: " + working_hours + "<br />" +"minimum experience years: " + minimum_experience_years  + "<br />";
            myControl.Controls.Add(nl);
            Button b1 = new Button();
            b1.Text = "view Interview questions and answers";
            b1.Click += question_answer;
            b1.CommandArgument = Convert.ToString(jid);
            myControl.Controls.Add( b1 );
            Label n2 = new Label();
            n2.Text = "<br />" + "<br />";
            myControl.Controls.Add(n2);
            Button b2 = new Button();
            b2.Text = "Edit this job";
            b2.Click += edit_job;
            b2.CommandArgument = Convert.ToString(jid);
            myControl.Controls.Add(b2);
            Label n3 = new Label();
            n3.Text = "<br />" + "<br />";
            myControl.Controls.Add(n3);
            Button b3 = new Button();
            b3.Text = "Add interview questions";
            b3.Click += add_question;
            b3.CommandArgument = Convert.ToString(jid);
            myControl.Controls.Add( b3 );
            Label n4 = new Label();
            n4.Text = "<br />" + "<br />";
            myControl.Controls.Add(n4);
            Button b4 = new Button();
            b4.Text = "view pending applications";
            b4.Click += view_applications;
            b4.CommandArgument = Convert.ToString(jid);
            myControl.Controls.Add(b4);
            Label n5 = new Label();
            n5.Text = "<br />" + "<br />";
            myControl.Controls.Add(n5);
        }
        rdr.Close();
        conn.Close();
    }

    protected void question_answer(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        String job_id = btn.CommandArgument;
        Session["jid"] = job_id;
        Response.Redirect("view_questions.aspx", true);
    }
    protected void edit_job(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        String job_id = btn.CommandArgument;
        Session["jid"] = job_id;
        Response.Redirect("edit_job.aspx", true);

    }
    protected void add_question(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        String job_id = btn.CommandArgument;
        Session["jid"] = job_id;
        Response.Redirect("Question_answer.aspx", true);

    }

    protected void view_applications(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        String job_id = btn.CommandArgument;
        Session["jid"] = job_id;
        Response.Redirect("view_Applications.aspx", true);

    }

    protected void home_Click(object sender, EventArgs e)
    {
        Response.Redirect("HR.aspx", true);
    }

}