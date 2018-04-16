<%@ Page Language="C#" AutoEventWireup="true" CodeFile="view_check_requests.aspx.cs" Inherits="view_check_requests" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form" runat="server">
        <asp:Button ID="home" runat="server" Text="My Page" OnClick="home_Click" />
        <div id="business" runat="server">
            <p align="center">Business Trip Requests</p>
        </div>
        <div id="leave" runat="server">
             <p align="center">Leave Requests</p>
        </div>
    </form>

</body>
</html>
