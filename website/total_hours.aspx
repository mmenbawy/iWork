<%@ Page Language="C#" AutoEventWireup="true" CodeFile="total_hours.aspx.cs" Inherits="total_hours" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<form id="form1" runat="server">
        <asp:Button ID="home" runat="server" Text="My Page" OnClick="home_Click" />
    <div style="height: 588px">
        <p>View total hours for a staff member</p>
            <p>Staff member username </p>
        <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
        <br />
        Select
        Year<br />
        <asp:DropDownList ID="year" runat="server">
            <asp:ListItem>2018</asp:ListItem>
            <asp:ListItem>2017</asp:ListItem>
            <asp:ListItem>2016</asp:ListItem>
            <asp:ListItem>2015</asp:ListItem>
            <asp:ListItem>2014</asp:ListItem>
            <asp:ListItem>2013</asp:ListItem>
            <asp:ListItem>2012</asp:ListItem>
            <asp:ListItem>2011</asp:ListItem>
            <asp:ListItem>2010</asp:ListItem>
            <asp:ListItem>2009</asp:ListItem>
            <asp:ListItem>2008</asp:ListItem>
            <asp:ListItem>2007</asp:ListItem>
            <asp:ListItem>2006</asp:ListItem>
            <asp:ListItem>2005</asp:ListItem>
            <asp:ListItem>2004</asp:ListItem>
            <asp:ListItem>2003</asp:ListItem>
            <asp:ListItem>2002</asp:ListItem>
            <asp:ListItem>2001</asp:ListItem>
            <asp:ListItem>2000</asp:ListItem>
            <asp:ListItem></asp:ListItem>
        </asp:DropDownList>
            <br />
        <br />
         <br />
        <asp:Button ID="button1" runat="server" OnClick="view_hours" Text="view total hours" />
      <div id="hours" runat="server">
            
      </div>
    </div>
</form>
</body>
</html>
