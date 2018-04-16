<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="home" runat="server" Text="Home Page" OnClick="home_Click" />
        <div style="height: 588px">
        <p>Enter your information</p>
            <p>username</p>
            <p>
        <asp:TextBox ID="username" runat="server" required="true"></asp:TextBox>
            </p>
            <p>personel e-mail</p>
        <asp:TextBox ID="personal_email" runat="server" required="true"></asp:TextBox>
            <br />
            First name
            <br />
        <asp:TextBox ID="first_name" runat="server" Height="41px" Width="317px" required="true"></asp:TextBox>
            <br />
            middle name<br />
        <asp:TextBox ID="middle_name" runat="server" Height="20px" Width="328px" ></asp:TextBox>
            <br />
            last name<br />
        <asp:TextBox ID="last_name" runat="server" Width="320px" ></asp:TextBox>
        &nbsp;<br />
            password<br />
        <asp:TextBox ID="password" runat="server" Height="20px" Width="328px" type="password" required="true"></asp:TextBox>
            <br />
            <p>Birth date in the form day/month/year</p>
        <asp:TextBox ID="day" runat="server"></asp:TextBox>
        <asp:TextBox ID="month" runat="server"></asp:TextBox>
        <asp:TextBox ID="year" runat="server"></asp:TextBox>
        <br />
            <br />
            experience years<br />
        <asp:TextBox ID="experience_years" runat="server" ></asp:TextBox>
        &nbsp;<br />
        <br />
        <asp:Button ID="add" runat="server" OnClick="create" Text="Create Profile" />
        
    </div>


    </form>
</body>
</html>
