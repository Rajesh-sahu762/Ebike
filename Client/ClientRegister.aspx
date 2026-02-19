<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="ClientRegister.aspx.cs"
    Inherits="Client_ClientRegister" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Client Register</title>

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

/* MAIN CONTAINER */
.auth-container{
    width:950px;
    height:600px;
    display:flex;
    border-radius:25px;
    overflow:hidden;
    box-shadow:0 30px 60px rgba(0,0,0,0.1);
    background:white;
}

/* LEFT PANEL */
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

.left-panel h2{
    font-weight:700;
    margin-bottom:15px;
}

.left-panel p{
    opacity:0.9;
    font-size:14px;
}

.left-panel .btn-outline{
    margin-top:25px;
    border:2px solid white;
    color:white;
    padding:10px 30px;
    border-radius:30px;
    text-decoration:none;
    transition:0.3s;
}

.left-panel .btn-outline:hover{
    background:white;
    color:#0ea5e9;
}

/* RIGHT PANEL */
.right-panel{
    flex:1.2;
    padding:50px;
    display:flex;
    flex-direction:column;
    justify-content:center;
}

.right-panel h3{
    font-weight:700;
    margin-bottom:20px;
}

/* INPUTS */
.form-control{
    border-radius:12px;
    height:45px;
    margin-bottom:15px;
}

.form-control:focus{
    box-shadow:0 0 0 3px rgba(45,212,191,0.2);
    border-color:#2dd4bf;
}

/* PASSWORD TOGGLE */
.password-wrapper{
    position:relative;
}

.password-wrapper i{
    position:absolute;
    right:15px;
    top:50%;
    transform:translateY(-50%);
    cursor:pointer;
    color:#6b7280;
}

/* GRADIENT BUTTON */
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

@media(max-width:992px){
    .auth-container{
        flex-direction:column;
        height:auto;
        width:95%;
    }
}

</style>
</head>

<body>

<form id="Form1" runat="server">

<div class="auth-container">

    <!-- LEFT SIDE -->
    <div class="left-panel">
        <h2>Welcome Back!</h2>
        <p>Already have an account?<br />
        Login to explore EV marketplace.</p>

        <a href="ClientLogin.aspx" class="btn-outline">
            SIGN IN
        </a>
    </div>

    <!-- RIGHT SIDE -->
    <div class="right-panel">

        <h3>Create Account</h3>

        <asp:TextBox ID="txtName" runat="server"
            CssClass="form-control"
            placeholder="Full Name"></asp:TextBox>

        <asp:TextBox ID="txtEmail" runat="server"
            CssClass="form-control"
            placeholder="Email"></asp:TextBox>

        <asp:TextBox ID="txtMobile" runat="server"
            CssClass="form-control"
            placeholder="Mobile"></asp:TextBox>

        <div class="password-wrapper">
            <asp:TextBox ID="txtPassword" runat="server"
                TextMode="Password"
                CssClass="form-control"
                placeholder="Password"></asp:TextBox>

            <i class="fa fa-eye"
               onclick="togglePassword('<%= txtPassword.ClientID %>',this)"></i>
        </div>

        <div class="password-wrapper">
            <asp:TextBox ID="txtConfirm" runat="server"
                TextMode="Password"
                CssClass="form-control"
                placeholder="Confirm Password"></asp:TextBox>

            <i class="fa fa-eye"
               onclick="togglePassword('<%= txtConfirm.ClientID %>',this)"></i>
        </div>

        <asp:Button ID="btnRegister"
            runat="server"
            Text="SIGN UP"
            CssClass="btn-gradient w-100"
            OnClick="btnRegister_Click" />

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
