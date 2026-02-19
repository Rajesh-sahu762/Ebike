<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="ClientLogin.aspx.cs"
    Inherits="Client_ClientLogin" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Client Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

<style>
body{
    margin:0;
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(120deg,#dbeafe,#ccfbf1);
    font-family:'Segoe UI';
}

.auth-container{
    width:950px;
    height:600px;
    display:flex;
    border-radius:25px;
    overflow:hidden;
    box-shadow:0 30px 60px rgba(0,0,0,0.1);
    background:white;
}

.left-panel{
    flex:1;
    background:linear-gradient(135deg,#2dd4bf,#0ea5e9);
    color:white;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    padding:50px;
    text-align:center;
}

.left-panel h2{font-weight:700;margin-bottom:15px;}

.btn-outline{
    margin-top:25px;
    border:2px solid white;
    color:white;
    padding:10px 30px;
    border-radius:30px;
    text-decoration:none;
    transition:0.3s;
}

.btn-outline:hover{
    background:white;
    color:#0ea5e9;
}

.right-panel{
    flex:1.2;
    padding:50px;
    display:flex;
    flex-direction:column;
    justify-content:center;
}

.form-control{
    border-radius:12px;
    height:45px;
    margin-bottom:15px;
}

.password-wrapper{position:relative;}
.password-wrapper i{
    position:absolute;
    right:15px;
    top:50%;
    transform:translateY(-50%);
    cursor:pointer;
}

.btn-gradient{
    background:linear-gradient(45deg,#2dd4bf,#0ea5e9);
    border:none;
    border-radius:30px;
    padding:10px;
    color:white;
    font-weight:600;
    transition:0.4s;
}

.btn-gradient:hover{
    transform:translateY(-3px);
    box-shadow:0 15px 30px rgba(0,0,0,0.15);
}
</style>
</head>

<body>

<form id="Form1" runat="server">

<div class="auth-container">

    <!-- LEFT -->
    <div class="left-panel">
        <h2>Hello Rider!</h2>
        <p>Don't have an account?</p>

        <a href="ClientRegister.aspx" class="btn-outline">
            SIGN UP
        </a>
    </div>

    <!-- RIGHT -->
    <div class="right-panel">

        <h3>Login</h3>

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

        <asp:Button ID="btnLogin"
            runat="server"
            Text="LOGIN"
            CssClass="btn-gradient w-100"
            OnClick="btnLogin_Click" />


        <div class="d-flex justify-content-between align-items-center mt-2">

    <div>
        <asp:CheckBox ID="chkRemember"
            runat="server"
            Text=" Remember me"
            CssClass="form-check-input" />
    </div>

    <a href="ClientForgotPassword.aspx"
       style="font-size:14px; text-decoration:none;
              background:linear-gradient(45deg,#00b4d8,#0077b6);
              -webkit-background-clip:text;
              -webkit-text-fill-color:transparent;
              font-weight:600;">
        Forgot Password?
    </a>

</div>


        <asp:Label ID="lblMsg"
            runat="server"
            ForeColor="Red"></asp:Label>

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
