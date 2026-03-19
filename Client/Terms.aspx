<%@ Page Title="Terms & Conditions" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="Terms.aspx.cs"
    Inherits="Client_Terms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="terms-section">
    <div class="container">
        <div class="terms-card">
            <div class="terms-header text-center">
                <div class="terms-icon">
                    <i class="fa fa-file-contract"></i>
                </div>
                <h1>Terms & Conditions</h1>
                <p class="updated">Please read these terms carefully before using our platform.</p>
                <div class="header-divider"></div>
            </div>

            <div class="terms-body">
                <p class="intro-text">
                    By accessing <strong>EBikes Duniya</strong>, you agree to be bound by these terms. If you do not agree with any part of these terms, you may not use our services.
                </p>

                <div class="term-block">
                    <div class="term-number">01</div>
                    <div class="term-content">
                        <h2>Platform Usage & Scope</h2>
                        <p>
                            EBikes Duniya is a digital marketplace that connects customers with verified electric bike dealers. 
                            <strong>Please note:</strong> We are a facilitator and do not directly sell, manufacture, or ship electric bikes.
                        </p>
                    </div>
                </div>

                <div class="term-block">
                    <div class="term-number">02</div>
                    <div class="term-content">
                        <h2>User Responsibility</h2>
                        <p>
                            As a user, you agree to provide 100% accurate and truthful information when creating an account, 
                            submitting enquiries, or listing a used bike. Misuse of the platform may lead to account suspension.
                        </p>
                    </div>
                </div>

                <div class="term-block">
                    <div class="term-number">03</div>
                    <div class="term-content">
                        <h2>Dealer Responsibility</h2>
                        <p>
                            Dealers are solely responsible for the accuracy of their bike listings, including <strong>pricing, technical specifications, and real-time availability</strong>. Any discrepancy must be resolved between the buyer and the dealer directly.
                        </p>
                    </div>
                </div>

                <div class="term-block">
                    <div class="term-number">04</div>
                    <div class="term-content">
                        <h2>Limitation of Liability</h2>
                        <p>
                            EBikes Duniya shall not be held liable for any financial loss, physical damage, or disputes arising from 
                            transactions conducted between customers and dealers. Users are advised to verify all details physically before payment.
                        </p>
                    </div>
                </div>

                <div class="term-block">
                    <div class="term-number">05</div>
                    <div class="term-content">
                        <h2>Policy Updates</h2>
                        <p>
                            We reserve the right to modify these terms at any time. Changes will be effective immediately upon posting on this page. 
                            Continued use of the site signifies your acceptance of the updated terms.
                        </p>
                    </div>
                </div>

                <div class="legal-footer text-center mt-5">
                    <p>Last Modified: <strong><%= DateTime.Now.ToString("MMMM yyyy") %></strong></p>
                    <div class="d-flex justify-content-center gap-3 mt-3">
                        <a href="PrivacyPolicy.aspx" class="simple-link">Privacy Policy</a>
                        <span class="sep">|</span>
                        <a href="Contact.aspx" class="simple-link">Support Center</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    /* Premium Terms Styles */
    :root {
        --brand-orange: #ff6b35;
        --deep-dark: #0f172a;
        --slate-text: #475569;
        --soft-bg: #f8fafc;
    }

    .terms-section {
        background-color: var(--soft-bg);
        padding: 90px 0;
        min-height: 100vh;
        font-family: 'Outfit', sans-serif;
    }

    .terms-card {
        max-width: 900px;
        margin: 0 auto;
        background: #ffffff;
        padding: 60px;
        border-radius: 28px;
        box-shadow: 0 15px 50px rgba(15, 23, 42, 0.04);
        border: 1px solid #f1f5f9;
    }

    /* Header Styling */
    .terms-icon {
        width: 65px;
        height: 65px;
        background: linear-gradient(135deg, #ff6b35, #e84400);
        color: #fff;
        border-radius: 18px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 28px;
        margin: 0 auto 25px;
        box-shadow: 0 10px 20px rgba(255, 107, 53, 0.2);
    }

    .terms-header h1 {
        font-size: 36px;
        font-weight: 800;
        color: var(--deep-dark);
        margin-bottom: 10px;
        letter-spacing: -0.5px;
    }

    .updated {
        color: #94a3b8;
        font-size: 15px;
        margin-bottom: 30px;
    }

    .header-divider {
        width: 80px;
        height: 5px;
        background: var(--brand-orange);
        margin: 0 auto 50px;
        border-radius: 10px;
    }

    /* Content Body Styling */
    .intro-text {
        font-size: 18px;
        color: var(--slate-text);
        text-align: center;
        margin-bottom: 60px;
        line-height: 1.7;
    }

    .term-block {
        display: flex;
        gap: 25px;
        margin-bottom: 45px;
        padding-bottom: 30px;
        border-bottom: 1px dashed #e2e8f0;
    }

    .term-block:last-child {
        border-bottom: none;
    }

    .term-number {
        font-size: 24px;
        font-weight: 800;
        color: var(--brand-orange);
        opacity: 0.3;
        line-height: 1;
        font-family: 'Arial', sans-serif;
    }

    .term-content h2 {
        font-size: 20px;
        font-weight: 700;
        color: var(--deep-dark);
        margin-bottom: 12px;
    }

    .term-content p {
        color: var(--slate-text);
        line-height: 1.8;
        font-size: 15px;
        margin: 0;
    }

    .legal-footer p {
        font-size: 14px;
        color: #94a3b8;
    }

    .simple-link {
        color: var(--brand-orange);
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        transition: 0.2s;
    }

    .simple-link:hover {
        color: var(--deep-dark);
    }

    .sep { color: #e2e8f0; }

    /* Responsive */
    @media (max-width: 768px) {
        .terms-card { padding: 40px 20px; }
        .term-block { flex-direction: column; gap: 10px; }
        .terms-header h1 { font-size: 28px; }
    }
</style>

</asp:Content>