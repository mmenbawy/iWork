<%@ Page Language="C#" AutoEventWireup="true" CodeFile="edit_profile.aspx.cs" Inherits="edit_profile" %>



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
        <p>Edit a personel information</p>
            <p>personel e-mail</p>
        <asp:TextBox ID="personal_email" runat="server"></asp:TextBox>
            <br />
            First name
            <br />
        <asp:TextBox ID="first_name" runat="server" Height="41px" Width="317px"></asp:TextBox>
            <br />
            middle name<br />
        <asp:TextBox ID="middle_name" runat="server" Height="20px" Width="328px"></asp:TextBox>
            <br />
            last name<br />
        <asp:TextBox ID="last_name" runat="server" Width="320px"></asp:TextBox>
        &nbsp;<br />
            password<br />
        <asp:TextBox ID="password" runat="server" Height="20px" Width="328px" type="password"></asp:TextBox>
            <br />
            <p>Birth date in the form day/month/year</p>
        <asp:TextBox ID="day" runat="server"></asp:TextBox>
        <asp:TextBox ID="month" runat="server"></asp:TextBox>
        <asp:TextBox ID="year" runat="server"></asp:TextBox>
        <br />
            <br />
            salary <br />
        <asp:TextBox ID="salary" runat="server"></asp:TextBox>
            <br />
            experience years<br />
        <asp:TextBox ID="experience_years" runat="server"></asp:TextBox>
        &nbsp;<br />
            company_email
            <br />
        <asp:TextBox ID="company_email" runat="server"></asp:TextBox>
            <br />
        <br />
            day off
            <br />
        <asp:TextBox ID="day_off" runat="server"></asp:TextBox>
        <br />
            <br />
            total number of leaves
            <br />
        <asp:TextBox ID="total_no_of_leaves" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="add" runat="server" OnClick="edit" Text="Edit profile" />
        
    </div>


    </form>
</body>
</html>
