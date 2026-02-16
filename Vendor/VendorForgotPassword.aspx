<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VendorForgotPassword.aspx.cs" Inherits="Vendor_VendorForgotPassword" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Forgot Password</title>

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
    width:900px;
    height:580px;
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
    padding:40px;
    text-align:center;
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
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


<div class="auth-container">

<div class="auth-left">
    <h3>Reset Your Password</h3>
    <p>Enter your registered email to receive OTP</p>
    <a href="VendorLogin.aspx" class="btn btn-outline-light mt-3">Back to Login</a>
</div>

<div class="auth-right">

    <h4>Forgot Password</h4>

    <!-- Email Panel -->
    <asp:Panel ID="pnlEmail" runat="server">

        <asp:TextBox ID="txtEmail" runat="server"
            CssClass="form-control"
            placeholder="Enter Registered Email"></asp:TextBox>

        <asp:Button ID="btnSendOTP" runat="server"
            Text="Send OTP"
            CssClass="btn btn-primary-custom w-100"
            OnClick="btnSendOTP_Click" />

    </asp:Panel>

    <!-- Reset Panel -->
    <asp:Panel ID="pnlReset" runat="server" Visible="false">

        <asp:TextBox ID="txtOTP" runat="server"
            CssClass="form-control"
            placeholder="Enter OTP"></asp:TextBox>

        <div class="password-wrapper">
            <asp:TextBox ID="txtNewPassword" runat="server"
                TextMode="Password"
                CssClass="form-control"
                placeholder="New Password"></asp:TextBox>
            <i class="fa fa-eye"
               onclick="togglePassword('<%= txtNewPassword.ClientID %>',this)"></i>
        </div>

        <div class="password-wrapper">
            <asp:TextBox ID="txtConfirmPassword" runat="server"
                TextMode="Password"
                CssClass="form-control"
                placeholder="Confirm Password"></asp:TextBox>
            <i class="fa fa-eye"
               onclick="togglePassword('<%= txtConfirmPassword.ClientID %>',this)"></i>
        </div>

        <asp:Button ID="btnReset" runat="server"
            Text="Reset Password"
            CssClass="btn btn-primary-custom w-100"
            OnClick="btnReset_Click" />

        <asp:Button ID="btnResendOTP" runat="server"
    Text="Resend OTP"
    CssClass="btn btn-outline-secondary w-100 mt-2"
    OnClick="btnResendOTP_Click"
    OnClientClick="return checkTimer();" />

<div class="text-center mt-2">
    <small id="timerText">Resend available in <span id="countdown">60</span> sec</small>
</div>


    </asp:Panel>

    <asp:Label ID="lblMessage" runat="server"
        CssClass="message mt-3 d-block text-danger"></asp:Label>

</div>

</div>

</form>

    <script>
var seconds = 60;
    var countdownEl = document.getElementById("countdown");
    var resendBtn = document.getElementById("<%= btnResendOTP.ClientID %>");

if(resendBtn){
    resendBtn.disabled = true;
}

var timer = setInterval(function () {
    seconds--;
    if(countdownEl) countdownEl.innerText = seconds;

    if (seconds <= 0) {
        clearInterval(timer);
        if(resendBtn) resendBtn.disabled = false;
        if(document.getElementById("timerText"))
            document.getElementById("timerText").innerHTML = "You can resend OTP now.";
    }
}, 1000);

function checkTimer() {
    if (seconds > 0) {
        return false;
    }
    return true;
}


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