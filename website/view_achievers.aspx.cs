using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class view_achievers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("HR_decides_topachievers", conn);
        cmd.CommandType = CommandType.StoredProcedure;


        DateTime mdate = DateTime.Parse((String)Session["month"]);

        cmd.Parameters.Add(new SqlParameter("@hr_employee", (String)Session["username"]));
        cmd.Parameters.Add(new SqlParameter("@target_month", mdate));

        try
        {
            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

            Control myControl = FindControl("achievers");
            while (rdr.Read())
            {
                String username = rdr.GetString(rdr.GetOrdinal("username"));
                String Name = rdr.GetString(rdr.GetOrdinal("Regular Employee Name"));
                int hours = rdr.GetInt32(rdr.GetOrdinal("Month working hours"));
                Label nl = new Label();
                nl.Text = "<br/>" + "Employee username: " + username + "<br />" + "Employee Name: " + Name + "<br />" + "Month working hours: " + hours + "<br />";
                myControl.Controls.Add(nl);
                Button b1 = new Button();
                b1.Text = "Send E-mail";
                b1.Click += send_mail;
                b1.CommandArgument = Convert.ToString(username);
               // b1.CommandName = Convert.ToString(mdate.ToString("MMMM"));
               b1.CommandName = Convert.ToString(mdate);
                myControl.Controls.Add(b1);
                Label n2 = new Label();
                n2.Text = "<br />" + "<br />";
                myControl.Controls.Add(n2);
            }

        }
        catch (SqlException exp)
        {
            Response.Write(exp.Message);
            conn.Close();
        }
    }

    protected void send_mail(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        String username = btn.CommandArgument;
        String month = btn.CommandName;

        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("SendEmails", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        string subject = "CONGRATULATIONS TOP ACHIEVER";
        string body = "Dear valued employee you have been awarded for the month starting " + month + " top achiever. Yours, HR employee";

        cmd.Parameters.Add(new SqlParameter("@sender", (String)Session["username"]));
        cmd.Parameters.Add(new SqlParameter("@recepiant", username));
        cmd.Parameters.Add(new SqlParameter("@email_subject", subject));
        cmd.Parameters.Add(new SqlParameter("@body", body));
        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
           // Response.Write("<script>alert('successfully')</script>");

        }
        catch
        {
            Response.Write("The job name should be unique and all field constraints should be applied");
            conn.Close();
        }
    }


    protected void home_Click(object sender, EventArgs e)
    {
        Response.Redirect("view_high_achievers.aspx", true);
    }

}