<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SMember.aspx.cs" Inherits="SMember" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <asp:Button runat="server" OnClick="home_click" Text="My Page" /> 

             <br><br> <asp:Button runat="server" OnClick="Logout" Text="Logout" />
        </div>
    </form>
</body>
</html>
