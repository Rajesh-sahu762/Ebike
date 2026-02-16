<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VendorLogin.aspx.cs" Inherits="Vendor_VendorLogin" %>


<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Vendor Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

<style>
body{
    margin:0;
    background:#f3f6fb;
    font-family:'Segoe UI',sans-serif;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.auth-container{
    width:950px;
    height:600px;
    background:#fff;
    border-radius:20px;
    overflow:hidden;
    display:flex;
    box-shadow:0 25px 60px rgba(0,0,0,0.1);
}

.auth-left{
    flex:1;
    background:linear-gradient(135deg,#0f172a,#1e3a8a);
    color:white;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    padding:50px;
    text-align:center;
}

.auth-left h2{
    font-weight:700;
}

.btn-outline-light-custom{
    border:2px solid white;
    color:white;
    padding:10px 30px;
    border-radius:30px;
    background:transparent;
    margin-top:20px;
}

.auth-right{
    flex:1.2;
    padding:50px;
    display:flex;
    flex-direction:column;
    justify-content:center;
}

.form-control{
    height:45px;
    border-radius:10px;
    margin-bottom:15px;
}

.password-wrapper{
    position:relative;
}

.password-wrapper i{
    position:absolute;
    top:50%;
    right:15px;
    transform:translateY(-50%);
    cursor:pointer;
    color:#6b7280;
}

.btn-primary-custom{
    background:#2563eb;
    border:none;
    border-radius:25px;
    padding:10px;
    font-weight:600;
}

.message{
    font-size:14px;
    font-weight:600;
}
</style>
</head>

<body>

<form id="form1" runat="server">

<div class="auth-container">

    <!-- LEFT -->
    <div class="auth-left">
        <h2>Welcome Back!</h2>
        <p>New Vendor?</p>
        <a href="VendorRegister.aspx" class="btn btn-outline-light-custom">
            CREATE ACCOUNT
        </a>
    </div>

    <!-- RIGHT -->
    <div class="auth-right">

        <h3>Vendor Login</h3>

        <asp:TextBox ID="txtEmail" runat="server"
            CssClass="form-control"
            placeholder="Email"></asp:TextBox>

        <div class="password-wrapper">
            <asp:TextBox ID="txtPassword" runat="server"
                TextMode="Password"
                CssClass="form-control"
                placeholder="Password"></asp:TextBox>

            <i class="fa fa-eye"
               onclick="togglePassword('<%= txtPassword.ClientID %>',this)"></i>
        </div>

        <asp:Button ID="btnLogin" runat="server"
            Text="LOGIN"
            CssClass="btn btn-primary-custom w-100"
            OnClick="btnLogin_Click" />

        <a href="VendorForgotPassword.aspx" class="mt-3 text-decoration-none">
            Forgot Password?
        </a>

        <asp:Label ID="lblMessage" runat="server"
            CssClass="message mt-3 d-block text-danger"></asp:Label>

    </div>

</div>

</form>

<script>
    function togglePassword(id, icon) {
        var input = document.getElementById(id);
        if (input.type === "password") {
            input.type = "text";
            icon.classList.replace("fa-eye", "fa-eye-slash");
        } else {
            input.type = "password";
            icon.classList.replace("fa-eye-slash", "fa-eye");
        }
    }
</script>

</body>
</html>
