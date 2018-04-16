<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Question_answer.aspx.cs" Inherits="Question_answer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
<form id="form1" runat="server">
    <div>
        <asp:Button ID="home" runat="server" Text="My Page" OnClick="home_Click" />
        <br/>
        <br />
        <br />    
        <asp:Label ID="question" runat="server" Text="Question: "></asp:Label>
        <asp:TextBox ID="txt_question" runat="server" Height="109px" Width="348px"></asp:TextBox>
        <br />
        <br />
        <asp:Label ID="answer" runat="server" Text="Answer: "></asp:Label>
        <asp:TextBox ID="txt_answer" runat="server" Height="25px" Width="155px"></asp:TextBox>
    
        <br />
        <asp:Button ID="btn" runat="server" Text="Add" onclick="add_question_answer"/>
    
    </div>
    </form>
</body>
</html>
