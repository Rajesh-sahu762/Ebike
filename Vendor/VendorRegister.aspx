<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VendorRegister.aspx.cs" Inherits="Vendor_VendorRegister" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="theme-color" content="#e8edf5" />
    <title>Vendor Registration | EBikes Duniya</title>

    <link rel="icon" type="image/png" sizes="32x32" href="<%= ResolveUrl("~/Uploads/favicon/favicon-32x32.png") %>" />
    <link rel="icon" type="image/png" sizes="16x16" href="<%= ResolveUrl("~/Uploads/favicon/favicon-16x16.png") %>" />
    <link rel="icon" type="image/png" sizes="192x192" href="<%= ResolveUrl("~/Uploads/favicon/android-chrome-192x192.png") %>" />
    <link rel="icon" type="image/png" sizes="512x512" href="<%= ResolveUrl("~/Uploads/favicon/android-chrome-512x512.png") %>" />
    <link rel="apple-touch-icon" sizes="180x180" href="<%= ResolveUrl("~/Uploads/favicon/apple-touch-icon.png") %>" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />

    <style>
        :root {
            --auth-bg: #e8edf5;
            --auth-text: #263449;
            --auth-muted: #8290a2;
            --auth-blue: #1677d2;
            --auth-shadow: 9px 9px 20px rgba(163,177,198,.48), -9px -9px 20px rgba(255,255,255,.9);
            --auth-inset: inset 4px 4px 8px rgba(163,177,198,.36), inset -4px -4px 8px rgba(255,255,255,.9);
        }
        *, *::before, *::after { box-sizing: border-box; }
        body {
            min-height: 100vh;
            margin: 0;
            padding: 28px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--auth-bg);
            color: var(--auth-text);
            font-family: 'Inter', 'Segoe UI', sans-serif;
            -webkit-font-smoothing: antialiased;
        }
        #form1 { width: 100%; display: flex; justify-content: center; }
        .auth-shell {
            display: grid;
            grid-template-columns: .82fr 1.18fr;
            width: min(100%, 1080px);
            min-height: 680px;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,.85);
            border-radius: 26px;
            background: var(--auth-bg);
            box-shadow: 16px 16px 34px rgba(155,170,191,.42), -14px -14px 32px rgba(255,255,255,.9);
        }
        .auth-aside {
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 38px;
            overflow: hidden;
            background: linear-gradient(150deg, #17243a 0%, #1b3555 58%, #155b88 100%);
            color: #fff;
        }
        .auth-aside::before, .auth-aside::after {
            position: absolute; content: ''; border: 1px solid rgba(255,255,255,.1); border-radius: 50%; pointer-events: none;
        }
        .auth-aside::before { width: 330px; height: 330px; right: -165px; top: 18%; }
        .auth-aside::after { width: 230px; height: 230px; right: -115px; top: 27%; }
        .auth-brand { position: relative; z-index: 1; display: flex; align-items: center; gap: 11px; }
        .auth-brand-mark {
            display: grid; place-items: center; width: 42px; height: 42px; flex: 0 0 42px;
            border-radius: 14px; background: linear-gradient(145deg,#27bce9,#1475ca);
            box-shadow: 4px 4px 10px rgba(0,0,0,.2), -2px -2px 7px rgba(255,255,255,.1);
            color: #fff; font-size: 18px;
        }
        .auth-brand-name { margin: 0; color: #fff; font-size: 15px; font-weight: 800; letter-spacing: -.3px; }
        .auth-brand-caption { display: block; margin-top: 3px; color: #9db6d1; font-size: 9px; font-weight: 700; letter-spacing: 1.5px; text-transform: uppercase; }
        .auth-aside-copy { position: relative; z-index: 1; max-width: 330px; margin: 40px auto; }
        .auth-aside-icon {
            display: grid; place-items: center; width: 62px; height: 62px; margin-bottom: 25px;
            border: 1px solid rgba(255,255,255,.13); border-radius: 19px; background: rgba(255,255,255,.08);
            color: #6bd5f4; font-size: 25px; box-shadow: 6px 6px 14px rgba(0,0,0,.16), -3px -3px 9px rgba(255,255,255,.06);
        }
        .auth-aside-copy h1 { margin: 0 0 14px; color: #fff; font-size: clamp(27px,3vw,36px); font-weight: 800; line-height: 1.13; letter-spacing: -1px; }
        .auth-aside-copy p { margin: 0; color: #bdcde0; font-size: 13px; line-height: 1.8; }
        .auth-aside-footer { position: relative; z-index: 1; color: #8ea7c2; font-size: 10px; letter-spacing: .5px; }
        .auth-main { display: flex; flex-direction: column; justify-content: center; padding: 42px clamp(28px,4vw,54px); }
        .auth-kicker { display: block; margin-bottom: 8px; color: var(--auth-blue); font-size: 10px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; }
        .auth-title { margin: 0; color: var(--auth-text); font-size: 28px; font-weight: 800; letter-spacing: -.8px; }
        .auth-description { margin: 8px 0 23px; color: var(--auth-muted); font-size: 12px; line-height: 1.7; }
        .auth-fields { display: grid; grid-template-columns: 1fr 1fr; column-gap: 16px; }
        .auth-field { min-width: 0; }
        .auth-field-label { display: block; margin: 0 0 7px 2px; color: #56667c; font-size: 10px; font-weight: 700; }
        .auth-input {
            width: 100%; height: 46px; margin-bottom: 15px; padding: 0 13px;
            border: 1px solid rgba(255,255,255,.7); border-radius: 11px; outline: none;
            background: var(--auth-bg); color: var(--auth-text); font-family: inherit; font-size: 11px;
            box-shadow: var(--auth-inset); transition: border-color .2s, box-shadow .2s;
        }
        .auth-input::placeholder { color: #9aa6b5; }
        .auth-input:focus { border-color: rgba(22,119,210,.48); box-shadow: inset 3px 3px 6px rgba(163,177,198,.24), inset -3px -3px 6px rgba(255,255,255,.8), 0 0 0 3px rgba(22,119,210,.1); }
        .password-wrapper { position: relative; }
        .password-wrapper .auth-input { padding-right: 44px; }
        .password-toggle {
            position: absolute; top: 0; right: 5px; display: grid; place-items: center;
            width: 36px; height: 46px; border: 0; background: transparent; color: #8492a5; cursor: pointer;
        }
        .password-toggle:hover { color: var(--auth-blue); }
        .auth-submit {
            width: 100%; min-height: 47px; margin-top: 5px; border: 0; border-radius: 12px;
            background: linear-gradient(135deg,#218fe0,#176fc3); color: #fff;
            box-shadow: 6px 6px 12px rgba(163,177,198,.42), -5px -5px 10px rgba(255,255,255,.8);
            font-family: inherit; font-size: 12px; font-weight: 800; letter-spacing: .8px;
            transition: transform .2s, filter .2s, box-shadow .2s;
        }
        .auth-submit:hover { color: #fff; filter: brightness(1.06); transform: translateY(-1px); }
        .auth-submit:active { box-shadow: var(--auth-inset); transform: translateY(0); }
        .auth-footer-link { margin: 18px 0 0; color: #7c899a; font-size: 11px; text-align: center; }
        .auth-link { color: #176fc3; font-weight: 800; text-decoration: none; }
        .auth-link:hover { color: #0d5eae; text-decoration: underline; }
        @media (max-width: 820px) {
            body { padding: 16px; align-items: flex-start; }
            #form1 { margin: auto 0; }
            .auth-shell { grid-template-columns: 1fr; max-width: 560px; min-height: 0; margin: auto; }
            .auth-aside { min-height: 215px; padding: 25px 28px; }
            .auth-aside-copy { margin: 25px 0 10px; }
            .auth-aside-copy h1 { font-size: 27px; }
            .auth-aside-icon { width: 46px; height: 46px; margin-bottom: 14px; border-radius: 14px; font-size: 19px; }
            .auth-aside-footer { display: none; }
            .auth-main { padding: 30px 28px 34px; }
        }
        @media (max-width: 520px) {
            body { padding: 10px; }
            .auth-aside, .auth-main { padding-right: 21px; padding-left: 21px; }
            .auth-fields { grid-template-columns: 1fr; }
            .auth-input { margin-bottom: 13px; }
            .auth-title { font-size: 25px; }
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <main class="auth-shell">
        <aside class="auth-aside">
            <div class="auth-brand">
                <span class="auth-brand-mark"><i class="fa-solid fa-bolt"></i></span>
                <div>
                    <p class="auth-brand-name">EBikes Duniya</p>
                    <span class="auth-brand-caption">Vendor workspace</span>
                </div>
            </div>

            <div class="auth-aside-copy">
                <span class="auth-aside-icon"><i class="fa-solid fa-store"></i></span>
                <h1>Grow your business with us.</h1>
                <p>Create your vendor account to list electric bikes, manage enquiries and reach more customers.</p>
                <a href="VendorLogin.aspx" class="btn auth-submit mt-4 px-4" style="display:inline-flex;width:auto;min-width:150px;align-items:center;justify-content:center;text-decoration:none;">SIGN IN</a>
            </div>

            <div class="auth-aside-footer">POWERING YOUR ELECTRIC BUSINESS</div>
        </aside>

        <section class="auth-main">
            <span class="auth-kicker">Join our network</span>
            <h2 class="auth-title">Create vendor account</h2>
            <p class="auth-description">Enter your business and contact details to get started.</p>

            <div class="auth-fields">
                <div class="auth-field">
                    <label class="auth-field-label" for="<%= txtFullName.ClientID %>">Full name</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="auth-input" placeholder="Your full name"></asp:TextBox>
                </div>
                <div class="auth-field">
                    <label class="auth-field-label" for="<%= txtMobile.ClientID %>">Mobile number</label>
                    <asp:TextBox ID="txtMobile" runat="server" CssClass="auth-input" placeholder="Your mobile number" TextMode="Phone"></asp:TextBox>
                </div>
                <div class="auth-field">
                    <label class="auth-field-label" for="<%= txtEmail.ClientID %>">Email address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="auth-input" placeholder="Your email address" TextMode="Email"></asp:TextBox>
                </div>
                <div class="auth-field">
                    <label class="auth-field-label" for="<%= txtShop.ClientID %>">Shop / business name</label>
                    <asp:TextBox ID="txtShop" runat="server" CssClass="auth-input" placeholder="Business name"></asp:TextBox>
                </div>
                <div class="auth-field">
                    <label class="auth-field-label" for="<%= txtCity.ClientID %>">City</label>
                    <asp:TextBox ID="txtCity" runat="server" CssClass="auth-input" placeholder="Your city"></asp:TextBox>
                </div>
                <div class="auth-field">
                    <label class="auth-field-label" for="<%= txtPassword.ClientID %>">Password</label>
                    <div class="password-wrapper">
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="auth-input" placeholder="Create password"></asp:TextBox>
                        <button type="button" class="password-toggle" aria-label="Show password" onclick="togglePassword('<%= txtPassword.ClientID %>',this)"><i class="fa-regular fa-eye"></i></button>
                    </div>
                </div>
                <div class="auth-field">
                    <label class="auth-field-label" for="<%= txtConfirm.ClientID %>">Confirm password</label>
                    <div class="password-wrapper">
                        <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" CssClass="auth-input" placeholder="Confirm password"></asp:TextBox>
                        <button type="button" class="password-toggle" aria-label="Show password" onclick="togglePassword('<%= txtConfirm.ClientID %>',this)"><i class="fa-regular fa-eye"></i></button>
                    </div>
                </div>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="CREATE ACCOUNT" CssClass="btn auth-submit" OnClick="btnRegister_Click" />

            <p class="auth-footer-link">Already have a vendor account? <a href="VendorLogin.aspx" class="auth-link">Sign in</a></p>
        </section>
    </main>
</form>

<script>
    function togglePassword(id, button) {
        var input = document.getElementById(id);
        var icon = button.querySelector("i");
        if (!input || !icon) return;
        var show = input.type === "password";
        input.type = show ? "text" : "password";
        icon.classList.toggle("fa-eye", !show);
        icon.classList.toggle("fa-eye-slash", show);
        button.setAttribute("aria-label", show ? "Hide password" : "Show password");
    }
</script>
</body>
</html>
