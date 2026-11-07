<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminLogin.aspx.cs" Inherits="AdminLogin" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="theme-color" content="#061522" />
    <title>Admin Sign In | EBikes Duniya</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        :root {
            --admin-bg: #061522;
            --admin-panel: rgba(12, 34, 49, .72);
            --admin-cyan: #22d3ee;
            --admin-cyan-bright: #67e8f9;
            --admin-text: #effbff;
            --admin-muted: #91aab8;
            --admin-line: rgba(148, 210, 226, .15);
        }

        * { box-sizing: border-box; }

        html, body { min-height: 100%; }

        body {
            margin: 0;
            min-height: 100vh;
            padding: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow-x: hidden;
            color: var(--admin-text);
            background:
                radial-gradient(ellipse at 12% 12%, rgba(8, 145, 178, .23), transparent 34%),
                radial-gradient(ellipse at 88% 82%, rgba(34, 211, 238, .13), transparent 32%),
                linear-gradient(135deg, #04111d 0%, #082033 52%, #061522 100%);
            font-family: 'DM Sans', sans-serif;
        }

        body::before, body::after {
            content: "";
            position: fixed;
            z-index: 0;
            pointer-events: none;
            border-radius: 50%;
            filter: blur(2px);
        }

        body::before {
            width: 360px; height: 360px; top: -170px; right: 12%;
            background: rgba(34, 211, 238, .10);
            box-shadow: 0 0 100px 45px rgba(8, 145, 178, .08);
        }

        body::after {
            width: 300px; height: 300px; bottom: -170px; left: 9%;
            background: rgba(6, 182, 212, .10);
            box-shadow: 0 0 100px 35px rgba(34, 211, 238, .07);
        }

        #Form1 { position: relative; z-index: 1; width: 100%; max-width: 1080px; }

        .login-shell {
            display: grid;
            grid-template-columns: 1.02fr .98fr;
            min-height: 650px;
            overflow: hidden;
            border: 1px solid rgba(165, 230, 242, .19);
            border-radius: 30px;
            background: rgba(8, 27, 41, .66);
            box-shadow: 0 35px 100px rgba(0, 0, 0, .42), inset 0 1px 0 rgba(255,255,255,.08);
            backdrop-filter: blur(28px);
            -webkit-backdrop-filter: blur(28px);
        }

        .brand-panel {
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 48px;
            overflow: hidden;
            background:
                radial-gradient(circle at 75% 42%, rgba(34, 211, 238, .18), transparent 34%),
                linear-gradient(145deg, rgba(10, 67, 86, .72), rgba(6, 26, 42, .72));
            border-right: 1px solid var(--admin-line);
        }

        .brand-panel::before {
            content: "";
            position: absolute;
            width: 440px; height: 440px;
            top: 24%; left: 14%;
            border: 1px solid rgba(103, 232, 249, .10);
            border-radius: 50%;
            box-shadow: 0 0 0 38px rgba(103,232,249,.025), 0 0 0 78px rgba(103,232,249,.02);
        }

        .brand-panel::after {
            content: "";
            position: absolute;
            width: 210px; height: 210px;
            right: -95px; bottom: -90px;
            border-radius: 50%;
            background: rgba(34, 211, 238, .12);
            filter: blur(30px);
        }

        .brand-content, .brand-footer { position: relative; z-index: 1; }

        .brand-lockup { display: flex; align-items: center; gap: 13px; }

        .brand-mark {
            display: grid; place-items: center;
            width: 48px; height: 48px;
            border: 1px solid rgba(103, 232, 249, .48);
            border-radius: 15px;
            color: #06212d;
            background: linear-gradient(145deg, #a5f3fc, #22d3ee 68%, #0891b2);
            box-shadow: 0 8px 30px rgba(34, 211, 238, .2);
        }

        .brand-name {
            margin: 0;
            font: 800 19px/1.2 'Manrope', sans-serif;
            letter-spacing: -.6px;
        }

        .brand-caption {
            display: block; margin-top: 4px;
            color: #9bc5d1; font-size: 10px; font-weight: 700;
            letter-spacing: 2px; text-transform: uppercase;
        }

        .brand-copy { max-width: 390px; margin-top: 72px; }

        .eyebrow {
            display: inline-flex; align-items: center; gap: 9px;
            padding: 8px 12px;
            border: 1px solid rgba(103,232,249,.22);
            border-radius: 999px;
            color: #a5f3fc;
            background: rgba(34,211,238,.07);
            font-size: 10px; font-weight: 700; letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        .eyebrow-dot {
            width: 7px; height: 7px; border-radius: 50%;
            background: var(--admin-cyan);
            box-shadow: 0 0 12px var(--admin-cyan);
        }

        .brand-copy h1 {
            margin: 24px 0 16px;
            font: 800 clamp(32px, 4vw, 48px)/1.12 'Manrope', sans-serif;
            letter-spacing: -2px;
        }

        .brand-copy h1 span {
            color: var(--admin-cyan-bright);
            text-shadow: 0 0 30px rgba(34,211,238,.22);
        }

        .brand-copy p {
            max-width: 360px; margin: 0;
            color: #9bb3c1; font-size: 14px; line-height: 1.85;
        }

        .security-visual {
            position: relative;
            display: grid;
            place-items: center;
            width: 190px; height: 190px;
            margin: 42px auto 0;
        }

        .security-ring {
            position: absolute; inset: 0;
            border: 1px solid rgba(103,232,249,.20);
            border-radius: 50%;
            box-shadow: inset 0 0 35px rgba(34,211,238,.05), 0 0 45px rgba(34,211,238,.06);
        }

        .security-ring::before, .security-ring::after {
            content: ""; position: absolute; border: 1px solid rgba(103,232,249,.13); border-radius: 50%;
        }

        .security-ring::before { inset: 15px; }
        .security-ring::after { inset: 31px; }

        .security-core {
            display: grid; place-items: center;
            width: 92px; height: 92px;
            border: 1px solid rgba(165,243,252,.42);
            border-radius: 28px;
            color: #a5f3fc;
            background: linear-gradient(145deg, rgba(34,211,238,.20), rgba(8,145,178,.08));
            box-shadow: 0 0 45px rgba(34,211,238,.16), inset 0 1px 0 rgba(255,255,255,.12);
            transform: rotate(-8deg);
        }

        .security-core svg { transform: rotate(8deg); }

        .brand-footer {
            display: flex; align-items: center; justify-content: space-between; gap: 12px;
            color: #7394a4; font-size: 11px;
        }

        .brand-footer .status { display: inline-flex; align-items: center; gap: 8px; }
        .status-indicator { width: 7px; height: 7px; border-radius: 50%; background: #34d399; box-shadow: 0 0 10px rgba(52,211,153,.7); }

        .form-panel {
            display: flex; align-items: center; justify-content: center;
            padding: 58px 56px;
            background: linear-gradient(145deg, rgba(13,36,52,.58), rgba(7,23,36,.76));
        }

        .form-inner { width: 100%; max-width: 365px; }

        .mobile-brand { display: none; }

        .form-kicker {
            margin-bottom: 13px;
            color: var(--admin-cyan);
            font-size: 10px; font-weight: 700; letter-spacing: 2px;
            text-transform: uppercase;
        }

        .form-inner h2 {
            margin: 0 0 10px;
            color: #f2fbff;
            font: 800 32px/1.2 'Manrope', sans-serif;
            letter-spacing: -1.2px;
        }

        .form-subtitle { margin: 0 0 34px; color: var(--admin-muted); font-size: 13px; line-height: 1.7; }

        .field-group { margin-bottom: 22px; }

        .field-label {
            display: block; margin-bottom: 9px;
            color: #c6dbe4; font-size: 12px; font-weight: 600;
        }

        .input-wrap { position: relative; }

        .input-icon {
            position: absolute; top: 50%; left: 16px;
            display: grid; place-items: center;
            width: 18px; height: 18px;
            color: #78a6b8; transform: translateY(-50%);
            pointer-events: none;
        }

        .admin-input {
            display: block; width: 100%; height: 54px;
            padding: 0 48px 0 47px;
            border: 1px solid rgba(145,190,207,.18);
            border-radius: 13px;
            outline: none;
            color: #effbff;
            background: rgba(3,17,28,.48);
            font: 500 13px 'DM Sans', sans-serif;
            transition: border-color .2s ease, box-shadow .2s ease, background .2s ease;
        }

        .admin-input::placeholder { color: #607d8d; }

        .admin-input:focus {
            border-color: rgba(34,211,238,.72);
            background: rgba(5,25,38,.82);
            box-shadow: 0 0 0 4px rgba(34,211,238,.10), 0 8px 25px rgba(0,0,0,.12);
        }

        .password-toggle {
            position: absolute; top: 50%; right: 13px;
            display: grid; place-items: center;
            width: 30px; height: 30px;
            padding: 0; border: 0; border-radius: 8px;
            color: #83a9b9; background: transparent;
            transform: translateY(-50%);
            cursor: pointer; transition: color .2s, background .2s;
        }

        .password-toggle:hover { color: var(--admin-cyan-bright); background: rgba(34,211,238,.08); }

        .message-wrap { min-height: 0; margin: -4px 0 12px; }
        .message-wrap:empty { display: none; }

        .message-wrap span {
            display: block; padding: 10px 12px;
            border: 1px solid rgba(248,113,113,.24);
            border-radius: 10px;
            color: #fca5a5 !important;
            background: rgba(127,29,29,.16);
            font-size: 12px;
        }

        .btn-admin {
            display: flex; align-items: center; justify-content: center; gap: 10px;
            width: 100%; min-height: 54px; margin-top: 9px;
            border: 1px solid rgba(165,243,252,.42);
            border-radius: 13px;
            color: #03202a;
            background: linear-gradient(110deg, #a5f3fc 0%, #22d3ee 48%, #06b6d4 100%);
            box-shadow: 0 10px 28px rgba(6,182,212,.20), inset 0 1px 0 rgba(255,255,255,.55);
            font: 800 13px 'Manrope', sans-serif;
            letter-spacing: .2px;
            transition: transform .2s ease, box-shadow .2s ease, filter .2s ease;
        }

        .btn-admin:hover {
            color: #03202a; filter: brightness(1.06);
            transform: translateY(-2px);
            box-shadow: 0 15px 34px rgba(6,182,212,.28), inset 0 1px 0 rgba(255,255,255,.6);
        }

        .btn-admin:active { transform: translateY(0); }

        .form-divider {
            display: flex; align-items: center; gap: 12px;
            margin: 27px 0 19px; color: #668696;
            font-size: 10px; font-weight: 600; letter-spacing: 1px; text-transform: uppercase;
        }

        .form-divider::before, .form-divider::after { content: ""; height: 1px; flex: 1; background: var(--admin-line); }

        .secure-note {
            display: flex; align-items: flex-start; gap: 11px;
            padding: 14px;
            border: 1px solid rgba(103,232,249,.12);
            border-radius: 12px;
            color: #8eacba;
            background: rgba(34,211,238,.045);
            font-size: 11px; line-height: 1.6;
        }

        .secure-note svg { flex: 0 0 auto; margin-top: 1px; color: #67e8f9; }
        .secure-note strong { display: block; margin-bottom: 2px; color: #c4e5ed; font-size: 11px; }

        .form-bottom { margin-top: 34px; color: #688695; text-align: center; font-size: 10px; }
        .form-bottom span { color: #9ab8c5; }

        @media (max-width: 900px) {
            body { padding: 22px; }
            .login-shell { grid-template-columns: .9fr 1.1fr; min-height: 610px; }
            .brand-panel { padding: 36px; }
            .form-panel { padding: 42px 36px; }
            .security-visual { width: 155px; height: 155px; margin-top: 30px; }
        }

        @media (max-width: 680px) {
            body { padding: 14px; align-items: flex-start; }
            #Form1 { margin: auto 0; }
            .login-shell { display: block; min-height: auto; border-radius: 23px; }
            .brand-panel { display: none; }
            .form-panel { padding: 34px 25px 28px; }
            .form-inner { max-width: 420px; }
            .mobile-brand { display: flex; align-items: center; gap: 11px; margin-bottom: 38px; }
            .mobile-brand .brand-mark { width: 42px; height: 42px; border-radius: 13px; }
            .mobile-brand .brand-name { font-size: 17px; }
            .form-inner h2 { font-size: 29px; }
            .form-subtitle { margin-bottom: 28px; }
            .form-bottom { margin-top: 27px; }
        }

        @media (prefers-reduced-motion: reduce) {
            *, *::before, *::after { scroll-behavior: auto !important; transition-duration: .01ms !important; animation-duration: .01ms !important; }
        }
    </style>
</head>
<body>
    <form id="Form1" runat="server">
        <main class="login-shell">
            <section class="brand-panel" aria-label="EBikes Duniya admin portal">
                <div class="brand-content">
                    <div class="brand-lockup">
                        <div class="brand-mark" aria-hidden="true">
                            <svg width="27" height="27" viewBox="0 0 24 24" fill="none">
                                <path d="M13.2 2.8 5.7 13h5l-.9 8.2L18.3 10h-5.1l0-7.2Z" fill="currentColor"/>
                            </svg>
                        </div>
                        <div>
                            <p class="brand-name">EBikes Duniya</p>
                            <span class="brand-caption">Control Center</span>
                        </div>
                    </div>

                    <div class="brand-copy">
                        <span class="eyebrow"><span class="eyebrow-dot"></span> ADMINISTRATOR ACCESS</span>
                        <h1>One place to<br /><span>manage it all.</span></h1>
                        <p>Your central workspace to oversee the marketplace, manage operations and keep everything moving.</p>
                        <div class="security-visual" aria-hidden="true">
                            <div class="security-ring"></div>
                            <div class="security-core">
                                <svg width="45" height="45" viewBox="0 0 48 48" fill="none">
                                    <path d="M24 5 39 11v11c0 10-6.4 16.8-15 21-8.6-4.2-15-11-15-21V11L24 5Z" stroke="currentColor" stroke-width="2.2" stroke-linejoin="round"/>
                                    <path d="m17 24 4.5 4.5L31.5 18" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                                </svg>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="brand-footer">
                    <span>© <%= DateTime.Now.Year %> EBikes Duniya</span>
                    <span class="status"><span class="status-indicator"></span> Admin portal</span>
                </div>
            </section>

            <section class="form-panel" aria-label="Admin sign in form">
                <div class="form-inner">
                    <div class="mobile-brand">
                        <div class="brand-mark" aria-hidden="true">
                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none"><path d="M13.2 2.8 5.7 13h5l-.9 8.2L18.3 10h-5.1l0-7.2Z" fill="currentColor"/></svg>
                        </div>
                        <div><p class="brand-name">EBikes Duniya</p><span class="brand-caption">Control Center</span></div>
                    </div>

                    <div class="form-kicker">Welcome back</div>
                    <h2>Admin sign in</h2>
                    <p class="form-subtitle">Enter your administrator credentials to access the control center.</p>

                    <div class="field-group">
                        <label class="field-label" for="txtEmail">Email address</label>
                        <div class="input-wrap">
                            <span class="input-icon" aria-hidden="true">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none"><rect x="3" y="5" width="18" height="14" rx="3" stroke="currentColor" stroke-width="1.7"/><path d="m4 7 8 6 8-6" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/></svg>
                            </span>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="admin-input" placeholder="admin@ebikesduniya.com" autocomplete="username" inputmode="email"></asp:TextBox>
                        </div>
                    </div>

                    <div class="field-group">
                        <label class="field-label" for="txtPassword">Password</label>
                        <div class="input-wrap">
                            <span class="input-icon" aria-hidden="true">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none"><rect x="4" y="10" width="16" height="11" rx="2.5" stroke="currentColor" stroke-width="1.7"/><path d="M8 10V7a4 4 0 1 1 8 0v3" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"/><circle cx="12" cy="15.5" r="1.2" fill="currentColor"/></svg>
                            </span>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="admin-input" placeholder="Enter your password" autocomplete="current-password"></asp:TextBox>
                            <button type="button" class="password-toggle" id="togglePassword" aria-label="Show password" aria-pressed="false">
                                <svg id="eyeIcon" width="18" height="18" viewBox="0 0 24 24" fill="none"><path d="M2.5 12s3.4-6 9.5-6 9.5 6 9.5 6-3.4 6-9.5 6-9.5-6-9.5-6Z" stroke="currentColor" stroke-width="1.7"/><circle cx="12" cy="12" r="2.7" stroke="currentColor" stroke-width="1.7"/></svg>
                            </button>
                        </div>
                    </div>

                    <div class="message-wrap" role="alert" aria-live="polite">
                        <asp:Label ID="lblMsg" runat="server" CssClass="text-danger"></asp:Label>
                    </div>

                    <asp:Button ID="btnLogin" runat="server" Text="Sign in to dashboard" CssClass="btn-admin" OnClick="btnLogin_Click" />

                    <div class="form-divider">Protected access</div>

                    <div class="secure-note">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" aria-hidden="true"><path d="M12 3 20 6v5.5c0 5.1-3.3 8.2-8 10.5-4.7-2.3-8-5.4-8-10.5V6l8-3Z" stroke="currentColor" stroke-width="1.7" stroke-linejoin="round"/><path d="m9 12 2 2 4-4" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/></svg>
                        <div><strong>Secure administrator area</strong>Access is restricted to authorized, active administrator accounts.</div>
                    </div>

                    <div class="form-bottom">Need access assistance? <span>Contact your system administrator.</span></div>
                </div>
            </section>
        </main>
    </form>

    <script>
        (function () {
            var toggle = document.getElementById('togglePassword');
            var password = document.getElementById('<%= txtPassword.ClientID %>');
            var icon = document.getElementById('eyeIcon');

            if (!toggle || !password) return;

            toggle.addEventListener('click', function () {
                var reveal = password.type === 'password';
                password.type = reveal ? 'text' : 'password';
                toggle.setAttribute('aria-pressed', reveal ? 'true' : 'false');
                toggle.setAttribute('aria-label', reveal ? 'Hide password' : 'Show password');
                icon.innerHTML = reveal
                    ? '<path d="M3 3 21 21" stroke="currentColor" stroke-width="1.7" stroke-linecap="round"/><path d="M10.6 6.2A10.8 10.8 0 0 1 12 6c6.1 0 9.5 6 9.5 6a16 16 0 0 1-3.1 3.6M6.2 6.3C3.8 8 2.5 12 2.5 12s3.4 6 9.5 6c1.2 0 2.3-.2 3.3-.6" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>'
                    : '<path d="M2.5 12s3.4-6 9.5-6 9.5 6 9.5 6-3.4 6-9.5 6-9.5-6-9.5-6Z" stroke="currentColor" stroke-width="1.7"/><circle cx="12" cy="12" r="2.7" stroke="currentColor" stroke-width="1.7"/>';
            });
        })();
    </script>
</body>
</html>
