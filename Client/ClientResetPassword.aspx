<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="ClientResetPassword.aspx.cs"
    Inherits="Client_ClientResetPassword" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
<title>Reset Password</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap');
*{box-sizing:border-box}
body{min-height:100vh;margin:0;padding:20px;display:flex;align-items:center;justify-content:center;background:radial-gradient(circle at 12% 12%,rgba(34,211,238,.14),transparent 28%),radial-gradient(circle at 90% 88%,rgba(249,115,22,.08),transparent 25%),#F4F8FC;font-family:Inter,sans-serif;color:#0F172A}
form#Form1{width:min(100%,480px)}
.box{width:100%;padding:clamp(26px,5vw,46px);background:#fff;border:1px solid #E2E8F0;border-radius:24px;box-shadow:0 28px 80px rgba(7,26,47,.14);animation:authIn .5s ease both}
.box h4{font:800 27px/1.2 'Plus Jakarta Sans',sans-serif;color:#0F172A;letter-spacing:-1px;margin:0 0 24px}
.box h4:after{content:"";display:block;width:42px;height:4px;margin:14px auto 0;border-radius:9px;background:linear-gradient(90deg,#0891B2,#22D3EE)}
.box .form-control{height:52px;margin:0 0 16px;padding:0 16px;border:1px solid #E2E8F0;border-radius:12px;background:#FBFDFF;color:#0F172A;font:500 14px Inter,sans-serif;box-shadow:none}
.box .form-control:focus{border-color:#0891B2;box-shadow:0 0 0 4px rgba(8,145,178,.12)}
.box .btn-primary{width:100%;min-height:50px;border:0;border-radius:12px;background:linear-gradient(100deg,#0891B2,#22D3EE);color:#071A2F;font:800 14px 'Plus Jakarta Sans',sans-serif;box-shadow:0 9px 22px rgba(8,145,178,.2)}
.box .btn-primary:hover{background:linear-gradient(100deg,#0E7490,#06B6D4);transform:translateY(-2px)}
.box span[style*="color:Red"]{display:block;margin-top:12px;font-size:13px}
@keyframes authIn{from{opacity:0;transform:translateY(14px)}to{opacity:1;transform:translateY(0)}}
@media(max-width:520px){body{padding:12px}.box{padding:28px 22px;border-radius:20px}}
@media(prefers-reduced-motion:reduce){*,*:before,*:after{animation:none!important;transition:none!important}}
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
