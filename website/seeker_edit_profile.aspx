<%@ Page Language="C#" AutoEventWireup="true" CodeFile="seeker_edit_profile.aspx.cs" Inherits="seeker_edit_profile" %>



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
        <asp:TextBox ID="middle_name" runat="server" Height="37px" Width="328px"></asp:TextBox>
            <br />
            last name<br />
        <asp:TextBox ID="last_name" runat="server"></asp:TextBox>
        &nbsp;<br />
            password<br />
        <asp:TextBox ID="password" runat="server" type="password" ></asp:TextBox>
            <br />
            <p>Birth date in the form day/month/year</p>
        <asp:TextBox ID="day" runat="server"></asp:TextBox>
        <asp:TextBox ID="month" runat="server"></asp:TextBox>
        <asp:TextBox ID="year" runat="server"></asp:TextBox>
        <br />
            &nbsp;<br />
            experience years<br />
        <asp:TextBox ID="experience_years" runat="server"></asp:TextBox>
        &nbsp;<br />
        <br />
        <asp:Button ID="add" runat="server" OnClick="edit" Text="Edit profile" />
        
    </div>


    </form>
</body>
</html>
