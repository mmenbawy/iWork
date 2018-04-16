using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class total_hours : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void home_Click(object sender, EventArgs e)
    {
        Response.Redirect("HR.aspx", true);
    }

    protected void view_hours(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("HR_checks_total_hours_staffm", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        
        string staffm_username = ((TextBox)FindControl("username")).Text;
        string year = ((DropDownList)FindControl("year")).Text;
        cmd.Parameters.Add(new SqlParameter("@hr_employee", (String)Session["username"]));
        cmd.Parameters.Add(new SqlParameter("@staff_member", staffm_username));
        cmd.Parameters.Add(new SqlParameter("@target_year", year));
        try
        {
            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            if (!rdr.HasRows)  
                Response.Write("<script>alert('Either there is no records for this year or access is denied for the specified staff member')</script>");
            Control myControl = FindControl("hours");
            while (rdr.Read())
            {
                int month = rdr.GetInt32(rdr.GetOrdinal("MONTH"));
                int hours = rdr.GetInt32(rdr.GetOrdinal("Month working hours"));   
                Label nl = new Label();
                nl.Text = "<br/>" + "Month: " + month + "<br />" + "Month working hours: " + hours + "<br />" + "<br />";
                myControl.Controls.Add(nl);
            }

            ((DropDownList)FindControl("year")).Text = "";
            ((TextBox)FindControl("username")).Text = "";
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