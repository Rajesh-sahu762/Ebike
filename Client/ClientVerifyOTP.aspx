<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="ClientVerifyOTP.aspx.cs"
    Inherits="Client_ClientVerifyOTP" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>Verify OTP</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap');
:root{--navy:#071A2F;--cyan:#0891B2;--electric:#22D3EE;--orange:#F97316;--bg:#F4F8FC;--ink:#0F172A;--muted:#64748B;--line:#E2E8F0}
*{box-sizing:border-box}html,body{min-height:100%;margin:0}body{font-family:Inter,sans-serif;color:var(--ink);background:radial-gradient(circle at 12% 12%,rgba(34,211,238,.13),transparent 28%),radial-gradient(circle at 90% 88%,rgba(249,115,22,.09),transparent 25%),var(--bg);display:flex;align-items:center;justify-content:center;padding:28px;overflow-x:hidden}
body:before{content:"";position:fixed;inset:0;pointer-events:none;background:linear-gradient(125deg,transparent 0 68%,rgba(8,145,178,.035) 68% 69%,transparent 69%);opacity:.8}
form#Form1,form#form1{width:min(100%,1040px);position:relative;z-index:1}
.auth-container{width:100%;min-height:610px;display:grid;grid-template-columns:.92fr 1.08fr;background:#fff;border:1px solid rgba(226,232,240,.9);border-radius:28px;overflow:hidden;box-shadow:0 28px 80px rgba(7,26,47,.13);animation:authIn .55s ease both}
.left-panel{position:relative;isolation:isolate;overflow:hidden;background:linear-gradient(145deg,#071A2F 0%,#0b3552 58%,#087c99 100%);color:white;display:flex;flex-direction:column;justify-content:center;align-items:flex-start;padding:clamp(32px,5vw,64px);text-align:left}
.left-panel:before,.left-panel:after{content:"";position:absolute;border:1px solid rgba(34,211,238,.22);border-radius:50%;z-index:-1}
.left-panel:before{width:440px;height:440px;right:-215px;top:-110px;box-shadow:0 0 0 35px rgba(34,211,238,.035),0 0 0 75px rgba(34,211,238,.025)}
.left-panel:after{width:260px;height:260px;right:-105px;bottom:-125px;background:radial-gradient(circle,rgba(34,211,238,.2),transparent 70%)}
.left-panel h2{font:800 clamp(28px,3.4vw,42px)/1.12 'Plus Jakarta Sans',sans-serif;color:#fff;margin:0 0 16px;letter-spacing:-1.5px}
.left-panel p{font-size:15px;line-height:1.8;color:#c5d7e7;max-width:340px;margin:0}
.left-panel .btn-outline{display:inline-flex;align-items:center;justify-content:center;gap:9px;margin-top:28px;border:1px solid rgba(255,255,255,.55);color:white;padding:12px 22px;border-radius:12px;text-decoration:none;font-weight:700;transition:all .22s ease}
.left-panel .btn-outline:hover{background:#fff;color:var(--navy);transform:translateY(-2px)}
.right-panel{padding:clamp(30px,5vw,64px);display:flex;flex-direction:column;justify-content:center;min-width:0}
.right-panel h3{font:800 clamp(27px,3vw,36px)/1.2 'Plus Jakarta Sans',sans-serif;color:var(--ink);letter-spacing:-1.2px;margin:0 0 8px}
.right-panel h3:after{content:"";display:block;width:44px;height:4px;border-radius:8px;background:linear-gradient(90deg,var(--cyan),var(--electric));margin-top:13px}
.right-panel:before{content:"ELECTRIC • FREEDOM";display:block;order:-1;color:var(--cyan);font:700 10px Inter,sans-serif;letter-spacing:2.4px;margin-bottom:14px}
.right-panel .form-control{height:50px;margin:0 0 15px;padding:0 16px;border-radius:12px;border:1px solid var(--line);background:#fbfdff;color:var(--ink);font:500 14px Inter,sans-serif;box-shadow:none;transition:border-color .2s,box-shadow .2s,background .2s}
.right-panel .form-control:focus{border-color:var(--cyan);background:#fff;box-shadow:0 0 0 4px rgba(8,145,178,.12)}
.right-panel .form-control::placeholder{color:#94a3b8}
.password-wrapper{position:relative}.password-wrapper .form-control{padding-right:48px}
.password-wrapper i{position:absolute;right:16px;top:17px;cursor:pointer;color:var(--muted);transition:color .2s}.password-wrapper i:hover{color:var(--cyan)}
.btn-gradient{min-height:50px!important;background:linear-gradient(100deg,var(--cyan),var(--electric));border:0;border-radius:12px;padding:12px 20px;color:var(--navy);font:800 14px 'Plus Jakarta Sans',sans-serif;letter-spacing:.2px;box-shadow:0 9px 22px rgba(8,145,178,.2);transition:transform .2s,box-shadow .2s}
.btn-gradient:hover{transform:translateY(-2px);box-shadow:0 13px 28px rgba(8,145,178,.28)}
.right-panel .text-danger,.right-panel span[style*="color:Red"],.verify-card .text-danger{display:block;margin-top:12px;font-size:13px}
.right-panel .d-flex{margin-top:8px!important;font-size:13px;color:var(--muted)}
.right-panel a{color:var(--cyan);font-weight:700;text-decoration:none}.right-panel a:hover{color:var(--navy)}
.form-check-input{accent-color:var(--cyan);margin-right:6px}
@keyframes authIn{from{opacity:0;transform:translateY(14px)}to{opacity:1;transform:translateY(0)}}
@media(max-width:760px){body{padding:14px;align-items:flex-start}.auth-container{grid-template-columns:1fr;min-height:0;border-radius:22px}.left-panel{padding:28px 26px;min-height:190px}.left-panel h2{font-size:27px}.left-panel p{font-size:13px}.left-panel .btn-outline{margin-top:16px;padding:9px 16px}.right-panel{padding:30px 24px 34px}.right-panel h3{font-size:27px}}
@media(max-width:420px){body{padding:10px}.right-panel{padding:26px 18px}.auth-container{border-radius:18px}}
@media(prefers-reduced-motion:reduce){*,*:before,*:after{animation:none!important;transition:none!important;scroll-behavior:auto!important}}
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
