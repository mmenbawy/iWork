<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HR.aspx.cs" Inherits="HR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #form1 {
            height: 316px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="information" runat="server">

        </div>
        <br />
        <br />
    <div  id ="div1" style="width:374px; height:450px">
     &nbsp;
     <asp:Button ID="Button1" runat="server" OnClick="add_job" Text="Add a new Job" />
        <br />
        <br />
&nbsp;&nbsp;<asp:Button ID="Button2" runat="server" OnClick="view_edit_job" Text="View and Edit a Job" Width="177px" />
        <br />
        <br />
&nbsp;
      <asp:Button ID="Button4" runat="server" OnClick="post_announcement" Text="Post announcements" Width="178px" Height="30px" />
        <br />
        <br />
&nbsp;
    <asp:Button ID="Button5" runat="server" OnClick="view_check_requests" Text="View and check Requests" Width="202px" Height="30px" />
        <br />
        <br />
&nbsp;&nbsp;
    <asp:Button ID="Button6" runat="server" OnClick="view_attendance" Text="View Attendance records" Width="198px" Height="30px" />
        <br />
        <br />
&nbsp;
     <asp:Button ID="Button8" runat="server" OnClick="total_hours" Text="View employee total hours" Width="213px" Height="30px" />
        <br />
        <br />
&nbsp;
    <asp:Button ID="Button9" runat="server" OnClick="view_high_achievers" Text="View High Achievers" Width="178px" Height="30px" />
        <br />
        <br />
        <asp:Button ID="Button3" runat="server" OnClick="staffm" Text="Be a staffmember" Width="177px" />
        <br />
        <br />
&nbsp;&nbsp;
    <asp:Button ID="Button7" runat="server" OnClick="Logout" Text="Log out" Width="178px" Height="30px" />
    </div>
       
    </form>
</body>
</html>
