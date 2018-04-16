<%@ Page Language="C#" AutoEventWireup="true" CodeFile="view_high_achievers.aspx.cs" Inherits="view_high_achievers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="achievers" runat="server">
    
        <asp:Button ID="home" runat="server" Text="My Page" OnClick="home_Click" />
        <br />
    <br />
        Select Month<br />
        <br />
        <asp:DropDownList ID="month" runat="server" Height="26px" Width="57px">
            <asp:ListItem>12</asp:ListItem>
            <asp:ListItem>11</asp:ListItem>
            <asp:ListItem>10</asp:ListItem>
            <asp:ListItem>9</asp:ListItem>
            <asp:ListItem>8</asp:ListItem>
            <asp:ListItem>7</asp:ListItem>
            <asp:ListItem>6</asp:ListItem>
            <asp:ListItem>5</asp:ListItem>
            <asp:ListItem>4</asp:ListItem>
            <asp:ListItem>3</asp:ListItem>
            <asp:ListItem>2</asp:ListItem>
            <asp:ListItem>1</asp:ListItem>
            <asp:ListItem></asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        <br />
        <asp:Button ID="Button1" runat="server" Text="view achievers" OnClick="view_top" />

    </div>
         
        </form>
</body>
</html>
