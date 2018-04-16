using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class view_attendance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void home_Click(object sender, EventArgs e)
    {
        Response.Redirect("HR.aspx", true);
    }
    protected void attendance(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("HR_checks_attendence_of_staffm", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        string sDate = ((TextBox)FindControl("sday")).Text + "/" + ((TextBox)FindControl("smonth")).Text + "/" + ((TextBox)FindControl("syear")).Text + " 11:59";
        string eDate = ((TextBox)FindControl("eday")).Text + "/" + ((TextBox)FindControl("emonth")).Text + "/" + ((TextBox)FindControl("eyear")).Text + " 11:59";
        string staffm_username = ((TextBox)FindControl("username")).Text;

        if (String.IsNullOrWhiteSpace(sDate) || String.IsNullOrWhiteSpace(eDate) || String.IsNullOrWhiteSpace(staffm_username))
        {
            Response.Write("<script>alert('All required fields should have values')</script>");
        }
        else
        {
            DateTime end_Date = DateTime.Parse(eDate);
            DateTime start_Date = DateTime.Parse(sDate);
            if (end_Date < start_Date)
            {
                Response.Write("<script>alert('The start date should be after the end date')</script>");
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@staff_member", staffm_username));
                cmd.Parameters.Add(new SqlParameter("@start_check_date", start_Date));
                cmd.Parameters.Add(new SqlParameter("@end_check_date", end_Date));
                cmd.Parameters.Add(new SqlParameter("@hr_employee", (String)(Session["username"])));
                try
                {
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
                    if (!rdr.HasRows)
                        Response.Write("This staff member is from a different departement or company");
                    Control myControl = FindControl("records");
                    while (rdr.Read())
                    {
                        DateTime date = rdr.GetDateTime(rdr.GetOrdinal("attendance_date"));
                        DateTime start_time = rdr.GetDateTime(rdr.GetOrdinal("start_time"));
                        DateTime end_time = rdr.GetDateTime(rdr.GetOrdinal("end_time"));
                        int duration = rdr.GetInt32(rdr.GetOrdinal("duration"));
                        int missing_hours = rdr.GetInt32(rdr.GetOrdinal("missing hours"));
                        Label nl = new Label();
                        nl.Text = "<br/>" + "date: " + date + "<br />" + "start time: " + start_time + "<br />" +
                            "end time: " + end_time + "<br />" + "duration: " + duration
                            + "<br />" + "missing hours: " + missing_hours + "<br />" + "<br />";
                        myControl.Controls.Add(nl);
                    }

                    ((TextBox)FindControl("username")).Text = "";
                    ((TextBox)FindControl("sday")).Text = "";
                    ((TextBox)FindControl("smonth")).Text = "";
                    ((TextBox)FindControl("syear")).Text = "";
                    ((TextBox)FindControl("eday")).Text = "";
                    ((TextBox)FindControl("emonth")).Text = "";
                    ((TextBox)FindControl("eyear")).Text = "";
                    conn.Close();
                    rdr.Close();
                }
                catch (SqlException exp)
                {
                    Response.Write(exp.Message);
                    conn.Close();
                }
            }
        }
        
    }

}