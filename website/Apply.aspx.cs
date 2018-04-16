using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.HtmlControls;

public partial class Apply : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Request.QueryString["jid"]) == null || Session["Username"] == null)
            return;
        int jid = Int32.Parse((Request.QueryString["jid"]));

        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("getInterviewQuestionsForAJob", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@jid", jid));

        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        int numOfQuestions = dt.Select().Length;
        Question.DataSource = dt;
        Question.DataBind();
        
        for(int i = 0; i<numOfQuestions; i++)
        {
            Label l = new Label();
            l.ID = "l" + i;
            l.Text = "Answer For Question " + (i+1);
            TextBox t = new TextBox();
            t.ID = "t" + i;
            contentArea.Controls.Add(l);
            contentArea.Controls.Add(t);

            HtmlGenericControl html = new HtmlGenericControl();
            html.InnerHtml = "<br>";

            contentArea.Controls.Add(html);

        }
        Button b = new Button();
        b.ID = "btn_submit";
        b.Text = "Submit";
        b.Click += new EventHandler(this.Submit);
        contentArea.Controls.Add(b);
    }
    public void Submit(object sender, EventArgs e)
    {
        int jid = Int32.Parse((Request.QueryString["jid"]));

        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("getInterviewQuestionsForAJob", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@jid", jid));

        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);

        int numOfQuestions = dt.Select().Length;
        if (numOfQuestions == 0) return;
        int score = 0;
        int percentage = 100 / numOfQuestions;
        for(int i = 0 ; i < numOfQuestions ; i++)
        {
            String id = "t" + i;
            TextBox t = (TextBox)(contentArea.FindControl(id));
            if ((t.Text.ToLower()).Equals((dt.Rows[i][2]).ToString().ToLower()))
            {
                score += percentage;
            }
        }

        SqlCommand cmd2 = new SqlCommand("saveScore", conn);
        cmd2.CommandType = CommandType.StoredProcedure;

        cmd2.Parameters.Add(new SqlParameter("@jid", jid));
        cmd2.Parameters.Add(new SqlParameter("@username", Session["Username"].ToString()));
        cmd2.Parameters.Add(new SqlParameter("@score", score));

        conn.Open();
        cmd2.ExecuteNonQuery();
        conn.Close();

        Response.Redirect("JSeeker", true);
    }
}