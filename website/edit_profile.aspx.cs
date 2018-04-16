﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;


public partial class edit_profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void home_Click(object sender, EventArgs e)
    {
        Response.Redirect("HR.aspx", true);
    }

    protected void edit(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["iwork"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        SqlCommand cmd = new SqlCommand("UpdateInfo_StaffMember", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        string Date = ((TextBox)FindControl("day")).Text + "/" + ((TextBox)FindControl("month")).Text + "/" + ((TextBox)FindControl("year")).Text + " 11:59";
        try
        {
            DateTime birthdate = DateTime.Parse(Date);
            string personal_email = ((TextBox)FindControl("personal_email")).Text;
            string first_name = ((TextBox)FindControl("first_name")).Text;
            string middle_name = ((TextBox)FindControl("middle_name")).Text;
            string last_name = ((TextBox)FindControl("last_name")).Text;
            string password = ((TextBox)FindControl("password")).Text;
            string experience_years = ((TextBox)FindControl("experience_years")).Text;
            string salary = ((TextBox)FindControl("salary")).Text;
            string company_email = ((TextBox)FindControl("company_email")).Text;
            string day_off = ((TextBox)FindControl("day_off")).Text;
            string total_no_of_leaves = ((TextBox)FindControl("total_no_of_leaves")).Text;

            cmd.Parameters.Add(new SqlParameter("@username", (string)Session["username"]));
            cmd.Parameters.Add(new SqlParameter("@personal_email", personal_email));
            cmd.Parameters.Add(new SqlParameter("@first_name", first_name));
            cmd.Parameters.Add(new SqlParameter("@middle_name", middle_name));
            cmd.Parameters.Add(new SqlParameter("@last_name", last_name));
            cmd.Parameters.Add(new SqlParameter("@password", password));
            cmd.Parameters.Add(new SqlParameter("@birth_date", birthdate));
            cmd.Parameters.Add(new SqlParameter("@experience_years", experience_years));
            cmd.Parameters.Add(new SqlParameter("@salary", salary));
            cmd.Parameters.Add(new SqlParameter("@company_email", company_email));
            cmd.Parameters.Add(new SqlParameter("@day_off", day_off));
            cmd.Parameters.Add(new SqlParameter("@total_no_of_leaves", total_no_of_leaves));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                ((TextBox)FindControl("personal_email")).Text = "";
                ((TextBox)FindControl("first_name")).Text = "";
                ((TextBox)FindControl("middle_name")).Text = "";
                ((TextBox)FindControl("last_name")).Text = "";
                ((TextBox)FindControl("password")).Text = "";
                ((TextBox)FindControl("experience_years")).Text = "";
                ((TextBox)FindControl("salary")).Text = "";
                ((TextBox)FindControl("day_off")).Text = "";
                ((TextBox)FindControl("total_no_of_leaves")).Text = "";
                ((TextBox)FindControl("day")).Text = "";
                ((TextBox)FindControl("month")).Text = "";
                ((TextBox)FindControl("year")).Text = "";


                Response.Write("<script>alert('profile edited successfully')</script>");
            }
            catch (SqlException sq)
            {
                Response.Write(sq.Message);
                conn.Close();
            }

        }
        catch
        {
            string personal_email = ((TextBox)FindControl("personal_email")).Text;
            string password = ((TextBox)FindControl("password")).Text;
            string first_name = ((TextBox)FindControl("first_name")).Text;
            string middle_name = ((TextBox)FindControl("middle_name")).Text;
            string last_name = ((TextBox)FindControl("last_name")).Text;
            string experience_years = ((TextBox)FindControl("experience_years")).Text;
            string salary = ((TextBox)FindControl("salary")).Text;
            string company_email = ((TextBox)FindControl("company_email")).Text;
            string day_off = ((TextBox)FindControl("day_off")).Text;
            string total_no_of_leaves = ((TextBox)FindControl("total_no_of_leaves")).Text;

            cmd.Parameters.Add(new SqlParameter("@username", (string)Session["username"]));
            cmd.Parameters.Add(new SqlParameter("@personal_email", personal_email));
            cmd.Parameters.Add(new SqlParameter("@password", password));
            cmd.Parameters.Add(new SqlParameter("@first_name", first_name));
            cmd.Parameters.Add(new SqlParameter("@middle_name", middle_name));
            cmd.Parameters.Add(new SqlParameter("@last_name", last_name));
            cmd.Parameters.Add(new SqlParameter("@experience_years", experience_years));
            cmd.Parameters.Add(new SqlParameter("@birth_date", ""));
            cmd.Parameters.Add(new SqlParameter("@salary", salary));
            cmd.Parameters.Add(new SqlParameter("@company_email", company_email));
            cmd.Parameters.Add(new SqlParameter("@day_off", day_off));
            cmd.Parameters.Add(new SqlParameter("@total_no_of_leaves", total_no_of_leaves));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                ((TextBox)FindControl("personal_email")).Text = "";
                ((TextBox)FindControl("first_name")).Text = "";
                ((TextBox)FindControl("middle_name")).Text = "";
                ((TextBox)FindControl("last_name")).Text = "";
                ((TextBox)FindControl("experience_years")).Text = "";
                ((TextBox)FindControl("salary")).Text = "";
                ((TextBox)FindControl("day_off")).Text = "";
                ((TextBox)FindControl("password")).Text = "";
                ((TextBox)FindControl("total_no_of_leaves")).Text = "";
                ((TextBox)FindControl("day")).Text = "";
                ((TextBox)FindControl("month")).Text = "";
                ((TextBox)FindControl("year")).Text = "";


                Response.Write("<script>alert('profile edited successfully')</script>");
            }
            catch (SqlException sq)
            {
                Response.Write(sq.Message);
                conn.Close();
            }


        }

        

    }



}