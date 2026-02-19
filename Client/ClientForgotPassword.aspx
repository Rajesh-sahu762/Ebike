<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="ClientForgotPassword.aspx.cs"
    Inherits="Client_ClientForgotPassword" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<title>Forgot Password</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

<style>
body{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#c7f9cc,#90dbf4);
    font-family:'Segoe UI';
}

.box{
    width:450px;
    padding:40px;
    background:white;
    border-radius:20px;
    box-shadow:0 20px 50px rgba(0,0,0,0.1);
}

.btn-gradient{
    background:linear-gradient(45deg,#00b4d8,#0077b6);
    border:none;
    color:white;
    border-radius:30px;
    padding:10px;
}
</style>
</head>

<body>

<form id="Form1" runat="server">

<div class="box">

<h4 class="mb-4 text-center">Forgot Password</h4>

<asp:TextBox ID="txtEmail"
    runat="server"
    CssClass="form-control mb-3"
    placeholder="Enter your email"></asp:TextBox>

<asp:Button ID="btnSendOTP"
    runat="server"
    Text="Send OTP"
    CssClass="btn-gradient w-100"
    OnClick="btnSendOTP_Click" />

<asp:Label ID="lblMsg"
    runat="server"
    ForeColor="Red"></asp:Label>

</div>

</form>

</body>
</html>
