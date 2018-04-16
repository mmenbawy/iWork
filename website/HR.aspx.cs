using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


public partial class HR : System.Web.UI.Page
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
                int department_code = rdr.GetInt32(rdr.GetOrdinal("department_code"));
                String department_company = rdr.GetString(rdr.GetOrdinal("department_company"));
                int job = rdr.GetInt32(rdr.GetOrdinal("job"));
                double salary = rdr.GetDouble(rdr.GetOrdinal("salary"));
                String company_email = rdr.GetString(rdr.GetOrdinal("company_email"));
                String day_off = rdr.GetString(rdr.GetOrdinal("day_off"));
                int total_number_of_leaves = rdr.GetInt32(rdr.GetOrdinal("total_number_of_leaves"));

                Label nl = new Label();
                nl.Text = "<br/>" + "username: " + username + "<br />" + "personal email: " + personal_email + "<br />" +
                          "birth date: " + birth_date + "<br />" + "first name: " + first_name
                          + "<br />" + "middle name: " + middle_name + "<br />" + "last name: " + last_name +
                           "<br />" + "experience years: " + experience_years + "<br />" + "age: " + age + "<br />" +
                          "department company: " + department_company + "<br />" + "department code: " + department_code
                           + "<br />" + "job: " + job + "<br />" + "salary: " + salary +
                           "<br />" + "company email: " + company_email + "<br />" + "day off: " + day_off + "<br />"
                           + "total number of leaves: " + total_number_of_leaves + "<br />"+ "<br />";
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
        Response.Redirect("edit_profile.aspx", true);

    }

    protected void add_job(object sender, EventArgs e)
    {
        Response.Redirect("add_job.aspx", true);

    }

    protected void view_edit_job(object sender, EventArgs e)
    {
        Response.Redirect("view_edit_job.aspx", true);
    }

    protected void post_announcement(object sender, EventArgs e)
    {
        Response.Redirect("post_announcement.aspx", true);
    }

    protected void view_check_requests(object sender, EventArgs e)
    {
        Response.Redirect("view_check_requests.aspx", true);
    }

    protected void view_attendance(object sender, EventArgs e)
    {
        Response.Redirect("view_attendance.aspx", true);
    }

    protected void total_hours(object sender, EventArgs e)
    {
        Response.Redirect("total_hours.aspx", true);
    }
    protected void view_high_achievers(object sender, EventArgs e)
    {
        Response.Redirect("view_high_achievers.aspx", true);
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