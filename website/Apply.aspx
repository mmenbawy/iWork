<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Apply.aspx.cs" Inherits="Apply" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
         <asp:GridView ID="Question" runat="server" AutoGenerateColumns="false">    
             <Columns>    
                 <asp:BoundField DataField="question" HeaderText="Question" ItemStyle-Width="150" />
             </Columns>    
         </asp:GridView>
        </div><br><br>
     <asp:Panel ID="contentArea" runat="server"></asp:Panel>
    
    </form>
</body>
</html>
