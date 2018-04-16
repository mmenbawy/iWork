<%@ Page Language="C#" AutoEventWireup="true" CodeFile="post_announcement.aspx.cs" Inherits="post_announcement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="home" runat="server" Text="My Page" OnClick="home_Click" />
        <div style="height: 432px">
        <p>Announcement Title</p>
        <asp:TextBox ID="title" runat="server"></asp:TextBox>
        <br />
        <p>Announcement Type</p>
        <asp:TextBox ID="announcement_type" runat="server"></asp:TextBox>
        <br />
        <p>Description</p>
        <asp:TextBox ID="announcement_description" runat="server" Height="160px" Width="1156px"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="post" runat="server" OnClick="post_announ" Text="Post The Announcement" />
        
    </div>
        
    </form>
</body>
</html>
