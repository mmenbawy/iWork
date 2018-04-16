using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


public partial class view_questions : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("HR_question_answer", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        String job_id = (String)Session["jid"];
        cmd.Parameters.Add(new SqlParameter("@jid", job_id));
        conn.Open();

        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        Control myControl = FindControl("questions");
        while (rdr.Read())
        {
            String question = rdr.GetString(rdr.GetOrdinal("question"));
            String answer = rdr.GetString(rdr.GetOrdinal("answer"));
            Label nl = new Label();
            nl.Text = "<br/>" + "Question: " + question + "<br />" + "Answer: " + answer + "<br />" + "<br />";
            myControl.Controls.Add(nl);

        }
        rdr.Close();
        conn.Close();
    }

    protected void home_Click(object sender, EventArgs e)
    {
        Response.Redirect("view_edit_job.aspx");
    }
}