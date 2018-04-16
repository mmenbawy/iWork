<%@ Page Language="C#" AutoEventWireup="true" CodeFile="REmployee.aspx.cs" Inherits="REmployee" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Button runat="server" Text ="Projects" OnClick="ViewProjects" />
            <asp:GridView ID="Projects" runat="server" AutoGenerateColumns="false">    
             <Columns>    
                 <asp:BoundField DataField="project_name" HeaderText="Name" ItemStyle-Width="150" />    
                 <asp:BoundField DataField="p_start_date" HeaderText="Start Date" ItemStyle-Width="150" />
                 <asp:BoundField DataField="p_end_date" HeaderText="End Date" ItemStyle-Width="150" />
                 <asp:BoundField DataField="defining_manager" HeaderText="Defining Manager" ItemStyle-Width="150" />
             </Columns>    
         </asp:GridView><br><br>
        </div>
         <div>
             <asp:label runat="server" Text="View Tasks For A Project"/>
             <asp:TextBox runat="server" Placeholder="Enter The Project Name.." ID="txt_projectname" /><br>
             <asp:Button runat="server" Text ="Tasks" OnClick="ViewTasks" /><br>
            <asp:GridView ID="Tasks" runat="server" AutoGenerateColumns="false">    
             <Columns>    
                 <asp:BoundField DataField="task_name" HeaderText="Name" ItemStyle-Width="150" />    
                 <asp:BoundField DataField="desription" HeaderText="Description" ItemStyle-Width="150" />
                 <asp:BoundField DataField="deadline" HeaderText="Deadline" ItemStyle-Width="150" />
                 <asp:BoundField DataField="task_status" HeaderText="Status" ItemStyle-Width="150" />
                 <asp:BoundField DataField="comment" HeaderText="Comment" ItemStyle-Width="150" />
                 <asp:BoundField DataField="defining_Manager" HeaderText="Defining Manager" ItemStyle-Width="150" />
             </Columns>    
         </asp:GridView>
        </div><br><br>
        <div>
            <asp:label runat="server" Text="Finalizing A Task"/>
            <asp:TextBox runat="server" Placeholder="Enter The Project Name.." ID="txt_pnameFinalize" />
            <asp:TextBox runat="server" Placeholder="Enter The Task Name.." ID="txt_taskname" /><br>
            <asp:Button runat="server" Text ="Finalize" OnClick="FinalizeATask" /><br>
            <asp:label runat="server" Visible="false" id="resFinalizing"/>
        </div><br><br>
         <div>
            <asp:label runat="server" Text="Work On A Task Again"/>
            <asp:TextBox runat="server" Placeholder="Enter The Project Name.." ID="txt_ptagain" />
            <asp:TextBox runat="server" Placeholder="Enter The Task Name.." ID="txt_tt_again" /><br>
            <asp:Button runat="server" Text ="Assign Task" OnClick="WorkOnATaskAgain" /><br>
            <asp:label runat="server" Visible="false" id="WorkOnATaskAgainLabel"/>
        <br />
        <br />
        <asp:Button ID="Button3" runat="server" OnClick="staffm" Text="Be a staffmember" Width="177px" />
        </div><br><br>
        <asp:Button ID="logout" runat="server" OnClick="Logout" Text="Logout" />
    </form>
</body>
</html>
