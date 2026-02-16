<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VendorVerifyOTP.aspx.cs" Inherits="Vendor_VendorVerifyOTP" %>


<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Verify OTP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

<style>
body{
    background:linear-gradient(135deg,#0f172a,#1e3a8a);
    height:100vh;
    display:flex;
    align-items:center;
    justify-content:center;
}

.otp-card{
    width:420px;
    background:white;
    border-radius:18px;
    padding:40px;
    box-shadow:0 20px 50px rgba(0,0,0,0.25);
}

.otp-input{
    text-align:center;
    font-size:22px;
    letter-spacing:6px;
    font-weight:600;
}

.timer{
    font-size:14px;
    color:#6b7280;
}

.success{
    color:green;
    font-weight:600;
}

.error{
    color:red;
    font-weight:600;
}
</style>
</head>

<body>

<form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

<div class="otp-card text-center">

    <h4 class="mb-2">Email Verification</h4>
    <asp:Label ID="lblEmail" runat="server" CssClass="text-muted small"></asp:Label>

    <asp:TextBox ID="txtOTP" runat="server"
        CssClass="form-control otp-input mt-4"
        MaxLength="6"
        placeholder="------"></asp:TextBox>

    <asp:Button ID="btnVerify" runat="server"
        Text="Verify OTP"
        CssClass="btn btn-primary mt-3 w-100"
        OnClick="btnVerify_Click" />

    <div class="mt-3">
        <asp:Button ID="btnResend" runat="server"
            Text="Resend OTP"
            CssClass="btn btn-outline-secondary w-100"
            OnClick="btnResend_Click"
            OnClientClick="return checkTimer();" />
    </div>

    <div class="timer mt-2">
        Resend available in <span id="countdown">60</span> sec
    </div>

    <asp:Label ID="lblMessage" runat="server" CssClass="mt-3 d-block"></asp:Label>

</div>

</form>

<script>
    var seconds = 60;
    var countdownEl = document.getElementById("countdown");
    var resendBtn = document.getElementById("<%= btnResend.ClientID %>");

    resendBtn.disabled = true;

    var timer = setInterval(function () {
        seconds--;
        countdownEl.innerText = seconds;

        if (seconds <= 0) {
            clearInterval(timer);
            resendBtn.disabled = false;
            countdownEl.innerText = "0";
            document.querySelector(".timer").innerHTML = "You can resend OTP now.";
        }
    }, 1000);

    function checkTimer() {
        if (seconds > 0) {
            return false;
        }
        return true;
    }


function startRedirect() {
    var count = 3;
    var msg = document.getElementById("<%= lblMessage.ClientID %>");

    var interval = setInterval(function () {
        count--;
        if (count <= 0) {
            clearInterval(interval);
            window.location.href = "VendorLogin.aspx";
        }
    }, 1000);
}

</script>

</body>
</html>