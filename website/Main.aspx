<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="Button1" runat="server" Text="Register" onclick="register"/>    
        <br />
        <br />
      <div>
        <asp:Label ID="Label2" runat="server" Text="Username: "></asp:Label>
        <asp:TextBox ID="txt_username" runat="server"></asp:TextBox>
        <br />
        <asp:Label ID="lbl_password" runat="server" Text="Password: "></asp:Label>
        <asp:TextBox ID="txt_password" runat="server" TextMode="Password"></asp:TextBox>
        <br />
        <asp:Button ID="btn_login" runat="server" Text="Login" onclick="login"/>    
    </div>

        <div>
            <asp:Button ID="logout" runat="server" Text="Logout" />
            <br><br>
            <asp:TextBox ID="SearchBox" runat="server" placeholder="Search"></asp:TextBox>
            <asp:Button ID="btn_SearchByName" runat="server" Text="Search By Name" onclick="SearchByName"/>
            <asp:Button ID="btn_SearchByAddress" runat="server" Text="Search By Address" onclick="SearchByAddress"/>
            <asp:Button ID="btn_SearchByType" runat="server" Text="Search By Type" onclick="SearchByType"/>
        </div>
        <div>
            <asp:GridView ID="SCResults" runat="server" AutoGenerateColumns="false">    
             <Columns>    
                 <asp:BoundField DataField="email" HeaderText="Company Email" ItemStyle-Width="150" />
                 <asp:BoundField DataField="company_name" HeaderText="Company Name" ItemStyle-Width="150" /> 
                 <asp:BoundField DataField="company_address" HeaderText="Company Address" ItemStyle-Width="150" /> 
                 <asp:BoundField DataField="domain_name" HeaderText="Domain Name" ItemStyle-Width="150" /> 
                 <asp:BoundField DataField="company_type" HeaderText="Company Type" ItemStyle-Width="150" /> 
                 <asp:BoundField DataField="vision" HeaderText="Vision" ItemStyle-Width="150" /> 
                 <asp:BoundField DataField="field_of_spec" HeaderText="Field Of Specialization" ItemStyle-Width="150" />
             </Columns>    
         </asp:GridView>  
        </div>
        <div>
            <asp:Label ID="lbl_username" runat="server" Text="International Companies"></asp:Label>
            <asp:GridView ID="international" runat="server" AutoGenerateColumns="false">    
             <Columns>
                 <asp:BoundField DataField="company_name" HeaderText="Company Name" ItemStyle-Width="150" /> 
             </Columns>    
         </asp:GridView>  
        </div>
         <div>
            <asp:Label ID="Label1" runat="server" Text="National Companies"></asp:Label>
            <asp:GridView ID="national" runat="server" AutoGenerateColumns="false">    
             <Columns>
                 <asp:BoundField DataField="company_name" HeaderText="Company Name" ItemStyle-Width="150" /> 
             </Columns>    
         </asp:GridView>  
        </div>
        <div>
            <asp:Label runat="server" Text="Apply For A Job"></asp:Label> <br>
            <asp:TextBox ID="ApplyJID" runat="server" placeholder="Please Enter The ID Of The Job You Wish To Apply For.."></asp:TextBox>
            <asp:Button ID="btn_Apply" runat="server" Text="Apply" onclick="ApplyForAJob"/>
            <asp:Label ID="Apply_Err" Visible="false" runat="server"></asp:Label> <br>
        </div>
    </form>
</body>
</html>
