<%@ Page Language="C#" AutoEventWireup="true" CodeFile="view_attendance.aspx.cs" Inherits="view_attendance" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<form id="form1" runat="server">
        <asp:Button ID="home" runat="server" Text="My Page" OnClick="home_Click" />
    <div style="height: 588px">
        <p>View attendance</p>
            <p>staff member username </p>
        <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
            <p>Enter Start date in the form day/month/year</p>
        <asp:TextBox ID="sday" runat="server"></asp:TextBox>
        <asp:TextBox ID="smonth" runat="server"></asp:TextBox>
        <asp:TextBox ID="syear" runat="server"></asp:TextBox>
        <br />
            <p>Enter End date in the form day/month/year</p>
        <asp:TextBox ID="eday" runat="server"  ></asp:TextBox>
        <asp:TextBox ID="emonth" runat="server" ></asp:TextBox>
        <asp:TextBox ID="eyear" runat="server"></asp:TextBox>
        <br />
         <br />
        <asp:Button ID="button1" runat="server" OnClick="attendance" Text="view attendance" />
      <div id="records" runat="server">
            
      </div>
    </div>
</form>
</body>
</html>
