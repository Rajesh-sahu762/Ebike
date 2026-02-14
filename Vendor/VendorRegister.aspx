<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VendorRegister.aspx.cs" Inherits="Vendor_VendorRegister" %>


<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Vendor Register</title>

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

/* Main Container */
.auth-container{
    width:950px;
    height:600px;
    background:#fff;
    border-radius:20px;
    overflow:hidden;
    display:flex;
    box-shadow:0 25px 60px rgba(0,0,0,0.1);
}

/* LEFT PANEL */
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
    margin-bottom:15px;
}

.auth-left p{
    opacity:0.85;
    font-size:14px;
    margin-bottom:30px;
}

.btn-outline-light-custom{
    border:2px solid white;
    color:white;
    padding:10px 30px;
    border-radius:30px;
    background:transparent;
    transition:0.3s;
}

.btn-outline-light-custom:hover{
    background:white;
    color:#1e3a8a;
}

/* RIGHT PANEL */
.auth-right{
    flex:1.2;
    padding:50px;
    display:flex;
    flex-direction:column;
    justify-content:center;
}

.auth-right h3{
    font-weight:700;
    margin-bottom:25px;
    color:#1e293b;
}

/* Inputs */
.form-control{
    height:45px;
    border-radius:10px;
    border:1px solid #e5e7eb;
    margin-bottom:15px;
    font-size:14px;
}

.form-control:focus{
    border-color:#2563eb;
    box-shadow:0 0 0 3px rgba(37,99,235,0.15);
}

/* Password */
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

/* Button */
.btn-primary-custom{
    background:#2563eb;
    border:none;
    border-radius:25px;
    padding:10px;
    font-weight:600;
    margin-top:10px;
}

.btn-primary-custom:hover{
    background:#1e40af;
}

@media(max-width:992px){
    .auth-container{
        flex-direction:column;
        width:95%;
        height:auto;
    }
    .auth-left, .auth-right{
        padding:30px;
    }
}

</style>

</head>

<body>

<form id="form1" runat="server">

<div class="auth-container">

    <!-- LEFT SIDE -->
    <div class="auth-left">
        <h2>Welcome Vendor!</h2>
        <p>Already registered?  
        Login to manage your bikes and leads.</p>

        <a href="VendorLogin.aspx" class="btn btn-outline-light-custom">
            SIGN IN
        </a>
    </div>

    <!-- RIGHT SIDE -->
    <div class="auth-right">

        <h3>Create Account</h3>

        <asp:TextBox ID="txtFullName" runat="server"
            CssClass="form-control"
            placeholder="Full Name"></asp:TextBox>

        <asp:TextBox ID="txtEmail" runat="server"
            CssClass="form-control"
            placeholder="Email"></asp:TextBox>

        <asp:TextBox ID="txtMobile" runat="server"
            CssClass="form-control"
            placeholder="Mobile"></asp:TextBox>

        <asp:TextBox ID="txtShop" runat="server"
            CssClass="form-control"
            placeholder="Shop Name"></asp:TextBox>

        <asp:TextBox ID="txtCity" runat="server"
            CssClass="form-control"
            placeholder="City"></asp:TextBox>

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

        <asp:Button ID="btnRegister" runat="server"
            Text="SIGN UP"
            CssClass="btn btn-primary-custom w-100"
            OnClick="btnRegister_Click" />

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