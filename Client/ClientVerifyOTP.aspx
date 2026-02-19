<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="ClientVerifyOTP.aspx.cs"
    Inherits="Client_ClientVerifyOTP" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Verify OTP</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

<style>
body{
    background:linear-gradient(135deg,#0f172a,#1e3a8a);
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    font-family:'Segoe UI',sans-serif;
}

.verify-card{
    width:420px;
    background:white;
    padding:40px;
    border-radius:20px;
    box-shadow:0 25px 60px rgba(0,0,0,0.2);
    text-align:center;
}

.verify-card h3{
    font-weight:700;
    margin-bottom:15px;
}

.form-control{
    height:45px;
    border-radius:10px;
    text-align:center;
    font-size:20px;
    letter-spacing:5px;
}

.btn-gradient{
    background:linear-gradient(45deg,#00b4d8,#0077b6);
    border:none;
    color:white;
    border-radius:30px;
    padding:10px;
    font-weight:600;
}

.timer{
    font-size:14px;
    margin-top:10px;
    color:#555;
}
</style>
</head>

<body>

<form id="form1" runat="server">

<div class="verify-card">

    <h3>Email Verification</h3>
    <p>Enter the OTP sent to your email</p>

    <asp:Label ID="lblMsg" runat="server" CssClass="text-danger"></asp:Label>

    <asp:TextBox ID="txtOTP" runat="server"
        CssClass="form-control mb-3"
        MaxLength="6"
        placeholder="------"></asp:TextBox>

    <asp:Button ID="btnVerify" runat="server"
        Text="Verify OTP"
        CssClass="btn btn-gradient w-100"
        OnClick="btnVerify_Click" />

    <div class="timer">
        Resend OTP in <span id="countdown">60</span> sec
    </div>

    <asp:Button ID="btnResend" runat="server"
        Text="Resend OTP"
        CssClass="btn btn-link"
        OnClick="btnResend_Click"
        Enabled="false" />

</div>

</form>

<script>
    let timeLeft = 60;
    let timer = setInterval(function(){
        if(timeLeft <= 0){
            clearInterval(timer);
            document.getElementById("countdown").innerHTML = "0";
            document.getElementById("<%= btnResend.ClientID %>").disabled = false;
    } else {
        document.getElementById("countdown").innerHTML = timeLeft;
    }
    timeLeft--;
},1000);
</script>

</body>
</html>
