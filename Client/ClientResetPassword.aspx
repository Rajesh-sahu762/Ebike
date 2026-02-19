<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="ClientResetPassword.aspx.cs"
    Inherits="Client_ClientResetPassword" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<title>Reset Password</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

<style>
body{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#caf0f8,#ade8f4);
    font-family:'Segoe UI';
}

.box{
    width:450px;
    padding:40px;
    background:white;
    border-radius:20px;
    box-shadow:0 20px 50px rgba(0,0,0,0.1);
}
</style>
</head>

<body>

<form id="Form1" runat="server">

<div class="box">

<h4 class="mb-4 text-center">Reset Password</h4>

<asp:TextBox ID="txtOTP"
    runat="server"
    CssClass="form-control mb-3"
    placeholder="Enter OTP"></asp:TextBox>

<asp:TextBox ID="txtNewPass"
    runat="server"
    TextMode="Password"
    CssClass="form-control mb-3"
    placeholder="New Password"></asp:TextBox>

<asp:Button ID="btnReset"
    runat="server"
    Text="Reset Password"
    CssClass="btn btn-primary w-100"
    OnClick="btnReset_Click" />

<asp:Label ID="lblMsg"
    runat="server"
    ForeColor="Red"></asp:Label>

</div>

</form>

</body>
</html>
