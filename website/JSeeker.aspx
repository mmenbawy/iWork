<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JSeeker.aspx.cs" Inherits="JSeeker" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="information" runat="server">

        </div>
        <div>
            <asp:button ID="viewApplications" runat="server" Text="View Applications" OnClick ="getApplications"></asp:button>
            <asp:GridView ID="Applications" runat="server" AutoGenerateColumns="false">    
             <Columns>    
                 <asp:BoundField DataField="a_id" HeaderText="Application ID" ItemStyle-Width="150" />    
                 <asp:BoundField DataField="score" HeaderText="Score" ItemStyle-Width="150" />
                 <asp:BoundField DataField="applicant_status" HeaderText="Applicant Status" ItemStyle-Width="150" />
                 <asp:BoundField DataField="job" HeaderText="Job ID" ItemStyle-Width="150" />
             </Columns>    
         </asp:GridView>
        </div><br><br>
        <div>
            <asp:Label Text ="Delete Applications" runat="server" /> <br>
            <asp:TextBox ID="txt_Applicationid" runat="server" placeholder ="Enter The ID Of The Application" />
            <asp:button runat="server" ID="btn_deleteApplication" OnClick="DeleteApplication" text ="Delete Application" /><br>
            <asp:label ID="DelResLabel" runat="server" Visible="false" />
        </div> <br><br>
        <div>
            <asp:Label Text ="Start Your New Job !" runat="server" /> <br>
            <asp:TextBox ID="txt_accApp" runat="server" placeholder ="Enter The ID Of The Application" />
            <asp:TextBox ID="txt_dayOff" runat="server" placeholder ="Enter A Day Of Other Than Friday" />
            <asp:button runat="server" ID="AcceptingApplication" OnClick="AcceptingApplications" text ="Start Your Job" /><br>
            <asp:label ID="AccResLabel" runat="server" Visible="false" />
        </div>
        <br>
        <asp:Button ID="Button7" runat="server" OnClick="Logout" Text="Log out"  />
    </form>
</body>
</html>
