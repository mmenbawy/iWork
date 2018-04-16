using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Question_answer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void home_Click(object sender, EventArgs e)
    {
        Response.Redirect("view_edit_job.aspx", true);
    }

    protected void add_question_answer(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("HR_adds_interviewquestion", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        string question = ((TextBox)FindControl("txt_question")).Text;
        string answer = ((TextBox)FindControl("txt_answer")).Text;
        if (question == "" || answer == "")
            Response.Write("<script>alert('a question and its answer should be inserted')</script>");
        else
        {
            cmd.Parameters.Add(new SqlParameter("@question", question));
            cmd.Parameters.Add(new SqlParameter("@answer", answer));
            cmd.Parameters.Add(new SqlParameter("@job_id", (String)Session["jid"]));
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                ((TextBox)FindControl("txt_question")).Text = "";
                ((TextBox)FindControl("txt_answer")).Text = "";
                Response.Write("<script>alert('Question and answer added to the Job successfully')</script>");
            }
            catch (Exception)
            {
                Response.Write("A backend error has occured");
                conn.Close();
            }
        }
        
    }
}