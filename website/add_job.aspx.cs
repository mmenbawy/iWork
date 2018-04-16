using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class add_job : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void home_Click(object sender, EventArgs e)
    {
        Response.Redirect("HR.aspx", true);
    }

    protected void add_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("HR_adds_jobs", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        string Date = ((TextBox)FindControl("day")).Text + "/" + ((TextBox)FindControl("month")).Text + "/" + ((TextBox)FindControl("year")).Text + " 11:59";
        DateTime application_deadline = DateTime.Parse(Date);
        DateTime currentTime = DateTime.Today;
        if( application_deadline < currentTime)
        {
            Response.Write("<script>alert('application deadline has passsed')</script>");
        }
        else
        {
            string title = ((TextBox)FindControl("title")).Text;
            string re1 = "((?:[a-z][a-z]+))";   // Word 1
            string re2 = "(\\s+)";  // White Space 1
            string re3 = "(-)"; // Any Single Character 1
            string re4 = "(\\s+)";  // White Space 2
            string re5 = "((?:[a-z][a-z]+))";	// Word 2
            Regex rgx = new Regex(re1 + re2 + re3 + re4 + re5, RegexOptions.IgnoreCase | RegexOptions.Singleline);
            if(! rgx.IsMatch (title))
            {
                Response.Write("<script>alert('title should be in the form (job role) - (job name)')</script>");
            }
            else
            {
                string short_description = ((TextBox)FindControl("short_description")).Text;
                string detailed_description = ((TextBox)FindControl("detailed_description")).Text;
                string number_of_vacancies = ((TextBox)FindControl("number_of_vacancies")).Text;
                string salary = ((TextBox)FindControl("salary")).Text;
                string working_hours = ((TextBox)FindControl("working_hours")).Text;
                string minimum_experience_years = ((TextBox)FindControl("minimum_experience_years")).Text;

                cmd.Parameters.Add(new SqlParameter("@title", title));
                cmd.Parameters.Add(new SqlParameter("@short_description", short_description));
                cmd.Parameters.Add(new SqlParameter("@detailed_description", detailed_description));
                cmd.Parameters.Add(new SqlParameter("@number_of_vacancies", number_of_vacancies));
                cmd.Parameters.Add(new SqlParameter("@application_deadline", application_deadline));
                cmd.Parameters.Add(new SqlParameter("@salary", salary));
                cmd.Parameters.Add(new SqlParameter("@working_hours", working_hours));
                cmd.Parameters.Add(new SqlParameter("@minimum_experience_years", minimum_experience_years));
                cmd.Parameters.Add(new SqlParameter("@hr_employee", (String)Session["username"]));

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    ((TextBox)FindControl("title")).Text = "";
                    ((TextBox)FindControl("short_description")).Text = "";
                    ((TextBox)FindControl("detailed_description")).Text = "";
                    ((TextBox)FindControl("number_of_vacancies")).Text = "";
                    ((TextBox)FindControl("salary")).Text = "";
                    ((TextBox)FindControl("working_hours")).Text = "";
                    ((TextBox)FindControl("minimum_experience_years")).Text = "";
                    ((TextBox)FindControl("day")).Text = "";
                    ((TextBox)FindControl("month")).Text = "";
                    ((TextBox)FindControl("year")).Text = "";


                    Response.Write("<script>alert('Job added successfully')</script>");
                }
                catch (Exception)
                {
                    Response.Write("Exception");
                    Response.Write("The job name should be unique and all field constraints should be applied");
                    conn.Close();
                }
            }
        }
        

    }

}