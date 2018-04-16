<%@ Page Language="C#" AutoEventWireup="true" CodeFile="edit_job.aspx.cs" Inherits="edit_job" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 701px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="home" runat="server" Text="My Page" OnClick="home_Click" />
        <div style="height: 588px">
        <p>Edit a job</p>
            <p>Title</p>
        <asp:TextBox ID="title" runat="server"></asp:TextBox>
            <br />
            short description
            <br />
        <asp:TextBox ID="short_description" runat="server" Height="41px" Width="317px"></asp:TextBox>
            <br />
            detailed description<br />
        <asp:TextBox ID="detailed_description" runat="server" Height="80px" Width="328px"></asp:TextBox>
            <br />
            number_of_vacancies<br />
        <asp:TextBox ID="number_of_vacancies" runat="server"></asp:TextBox>
        &nbsp;<br />
            <p>Enter application deadline in the form day/month/year</p>
        <asp:TextBox ID="day" runat="server"></asp:TextBox>
        <asp:TextBox ID="month" runat="server"></asp:TextBox>
        <asp:TextBox ID="year" runat="server"></asp:TextBox>
        <br />
            <br />
            salary <br />
        <asp:TextBox ID="salary" runat="server"></asp:TextBox>
            <br />
            working_hours<br />
        <asp:TextBox ID="working_hours" runat="server"></asp:TextBox>
        &nbsp;<br />
            minimum_experience_years
            <br />
        <asp:TextBox ID="minimum_experience_years" runat="server"></asp:TextBox>
            <br />
        <br />

        <asp:Button ID="add" runat="server" OnClick="edit" Text="Edit Job" />
        
    </div>
        <br />
        <br />
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
