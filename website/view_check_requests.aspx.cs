using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class view_check_requests : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("HR_view_business_requests", conn); 
        cmd.CommandType = CommandType.StoredProcedure;
        SqlCommand cmd2 = new SqlCommand("HR_view_leave_requests", conn);
        cmd2.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@hr_employee", (String)Session["username"]));
        cmd2.Parameters.Add(new SqlParameter("@hr_employee", (String)Session["username"]));
        conn.Open();

        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        SqlDataReader rdr2 = cmd2.ExecuteReader(CommandBehavior.CloseConnection);
        Control myControl = FindControl("business");
        Control myControl2 = FindControl("leave");

        while (rdr.Read())
        {   
            int rid = rdr.GetInt32(rdr.GetOrdinal("rid"));
            int total_no_of_leaves = rdr.GetInt32(rdr.GetOrdinal("total_no_of_leaves"));
            String replacement_employee = rdr.GetString(rdr.GetOrdinal("replacement_employee"));
            String staff_Member = rdr.GetString(rdr.GetOrdinal("staff_Member"));
            String review_by = rdr.GetString(rdr.GetOrdinal("review_by"));
            String request_status_manager = rdr.GetString(rdr.GetOrdinal("request_status_manager"));
            DateTime startdate = rdr.GetDateTime(rdr.GetOrdinal("startdate"));
            DateTime enddate = rdr.GetDateTime(rdr.GetOrdinal("enddate"));
            DateTime request_date = rdr.GetDateTime(rdr.GetOrdinal("request_date"));
            String trip_destination = rdr.GetString(rdr.GetOrdinal("trip_destination"));
            String purpose = rdr.GetString(rdr.GetOrdinal("purpose"));
            Label nl = new Label();
            nl.Text = "<br />" + "staff Member: " + staff_Member + "<br/>" + "startdate: " + startdate + "<br />" + "enddate: " + enddate + "<br />" +
                            "request date: " + request_date + "<br />"
                             + "total no of leaves: " + total_no_of_leaves + "<br />" + "replacement employee : " + replacement_employee +
                            "<br />" + "Reviewed By manager: " + review_by + "<br />" + "manager response: " + request_status_manager +
                            "<br/>" + "trip destination: " + trip_destination + "<br />" + "purpose: " + purpose + "<br />"+ "<br />";
            myControl.Controls.Add(nl);
            Button b1 = new Button();
            b1.Text = "Accept";
            b1.Click += accept_request;
            b1.CommandArgument = Convert.ToString(rid);
            myControl.Controls.Add(b1);
            Label n2 = new Label();
            n2.Text = "<br />" + "<br />";
            myControl.Controls.Add(n2);
            Button b2 = new Button();
            b2.Text = "Reject";
            b2.Click += reject_request;
            b2.CommandArgument = Convert.ToString(rid);
            myControl.Controls.Add(b2);
            TextBox t1 = new TextBox();
            t1.ID = Convert.ToString(rid);
            myControl.Controls.Add(t1);
            Label n3 = new Label();
            n3.Text = "<br />" + "<br />";
            myControl.Controls.Add(n3);
        }

        while (rdr2.Read())
        {
            int rid = rdr2.GetInt32(rdr2.GetOrdinal("rid"));
            int total_no_of_leaves = rdr2.GetInt32(rdr2.GetOrdinal("total_no_of_leaves"));
            String replacement_employee = rdr2.GetString(rdr2.GetOrdinal("replacement_employee"));
            String staff_Member = rdr2.GetString(rdr2.GetOrdinal("staff_Member"));
            String review_by = rdr2.GetString(rdr2.GetOrdinal("review_by"));
            String request_status_manager = rdr2.GetString(rdr2.GetOrdinal("request_status_manager"));
            DateTime startdate = rdr2.GetDateTime(rdr2.GetOrdinal("startdate"));
            DateTime enddate = rdr2.GetDateTime(rdr2.GetOrdinal("enddate"));
            DateTime request_date = rdr2.GetDateTime(rdr2.GetOrdinal("request_date"));
            String request_type = rdr2.GetString(rdr2.GetOrdinal("request_type"));
            Label nl = new Label();
            nl.Text = "<br />" + "staff Member: " + staff_Member + "<br/>" + "startdate: " + startdate + "<br />" + "enddate: " + enddate + "<br />" +
                            "request date: " + request_date + "<br />"
                            + "total no of leaves: " + total_no_of_leaves + "<br />" + "replacement employee : " + replacement_employee +
                            "<br />" + "Reviewed By manager: " + review_by + "<br />" + "manager response: " + request_status_manager +
                            "<br/>" + "request type: " + request_type + "<br />"+ "<br />";
            myControl2.Controls.Add(nl);
            Button b1 = new Button();
            b1.Text = "Accept";
            b1.Click += accept_request;
            b1.CommandArgument = Convert.ToString(rid);
            myControl2.Controls.Add(b1);
            Label n2 = new Label();
            n2.Text = "<br />" + "<br />";
            myControl2.Controls.Add(n2);
            Button b2 = new Button();
            b2.Text = "Reject";
            b2.Click += reject_request;
            b2.CommandArgument = Convert.ToString(rid);
            myControl2.Controls.Add(b2);
            TextBox t1 = new TextBox();
            t1.ID = Convert.ToString(rid);
            myControl2.Controls.Add(t1);
            Label n3 = new Label();
            n3.Text = "<br />" + "<br />";
            myControl2.Controls.Add(n3);
        }
        rdr.Close();
        rdr2.Close();
        conn.Close();
    }
    protected void accept_request(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        String rid = btn.CommandArgument;

        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("HR_checks_requests", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@hr_employee", (String)Session["username"]));
        cmd.Parameters.Add(new SqlParameter("@rid", rid));
        cmd.Parameters.Add(new SqlParameter("@hr_response", "accepted"));
        cmd.Parameters.Add(new SqlParameter("@reason", ""));
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Response.Redirect("view_check_requests.aspx", true);
    }
    protected void reject_request(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        String rid = btn.CommandArgument;

        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("HR_checks_requests", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        String reason = ((TextBox)FindControl(rid)).Text ;
        if (string.IsNullOrWhiteSpace(reason))
        {
            Response.Write("<script>alert('Incase of rejecting a request a reason should be provided')</script>");
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("@hr_employee", (String)Session["username"]));
            cmd.Parameters.Add(new SqlParameter("@rid", rid));
            cmd.Parameters.Add(new SqlParameter("@hr_response", "rejected"));
            cmd.Parameters.Add(new SqlParameter("@reason", reason)) ;
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            Response.Redirect("view_check_requests.aspx", true);
        }
    }

    protected void home_Click(object sender, EventArgs e)
    {
        Response.Redirect("HR.aspx", true);
    }


}