<%@ Page Title="Privacy Policy" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="PrivacyPolicy.aspx.cs"
    Inherits="Client_PrivacyPolicy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="policy-section">
    <div class="container">
        <div class="policy-card">
            <div class="policy-header text-center">
                <div class="policy-icon">
                    <i class="fa fa-shield-alt"></i>
                </div>
                <h1>Privacy Policy</h1>
                <p class="updated">Last Updated: <span class="date-highlight"><%= DateTime.Now.ToString("dd MMM yyyy") %></span></p>
                <div class="header-divider"></div>
            </div>

            <div class="policy-body">
                <p class="intro-text">
                    Welcome to <strong>EBikes Duniya</strong>. Your privacy is critically important to us. This policy outlines how we handle your data when you use our marketplace.
                </p>

                <div class="section-block">
                    <h2><i class="fa fa-info-circle"></i> 1. Information We Collect</h2>
                    <p>
                        We collect personal information such as your <strong>name, email address, mobile number,</strong> and <strong>location</strong> when you register an account, list a bike, or submit an enquiry to a dealer.
                    </p>
                </div>

                <div class="section-block">
                    <h2><i class="fa fa-cog"></i> 2. How We Use Your Information</h2>
                    <p>We use the data collected for the following purposes:</p>
                    <ul class="policy-list">
                        <li>To facilitate connections between potential <strong>buyers and verified dealers</strong>.</li>
                        <li>To enhance and personalize your browsing experience on our platform.</li>
                        <li>To respond accurately to your service or bike enquiries.</li>
                        <li>To send security alerts, administrative messages, and platform updates.</li>
                    </ul>
                </div>

                <div class="section-block">
                    <h2><i class="fa fa-lock"></i> 3. Data Protection & Security</h2>
                    <p>
                        We implement industry-standard security measures to protect your personal data from unauthorized access. <strong>Important:</strong> We do not sell, rent, or trade your personal information to third-party marketing agencies.
                    </p>
                </div>

                <div class="section-block">
                    <h2><i class="fa fa-cookie-bite"></i> 4. Cookies & Analytics</h2>
                    <p>
                        Our platform uses cookies to analyze website traffic, remember your preferences, and provide a seamless login experience. You can disable cookies in your browser settings, though some features may stop functioning.
                    </p>
                </div>

                <div class="section-block last">
                    <h2><i class="fa fa-envelope-open-text"></i> 5. Contact Us</h2>
                    <p>
                        If you have any questions or concerns regarding this Privacy Policy or how your data is handled, please feel free to reach out to our support team.
                    </p>
                    
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    /* Professional Policy Styles */
    :root {
        --primary-color: #ff6b35; /* Your Theme Orange */
        --heading-color: #111827;
        --text-color: #4b5563;
        --bg-color: #f9fafb;
    }

    .policy-section {
        background-color: var(--bg-color);
        padding: 80px 0;
        min-height: 100vh;
        font-family: 'Outfit', sans-serif;
    }

    .policy-card {
        max-width: 850px;
        margin: 0 auto;
        background: #ffffff;
        padding: 60px;
        border-radius: 24px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.04);
        border: 1px solid #f1f5f9;
    }

    /* Header Styling */
    .policy-icon {
        width: 60px;
        height: 60px;
        background: rgba(255, 107, 53, 0.1);
        color: var(--primary-color);
        border-radius: 16px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 28px;
        margin: 0 auto 20px;
    }

    .policy-header h1 {
        font-size: 32px;
        font-weight: 800;
        color: var(--heading-color);
        margin-bottom: 8px;
    }

    .updated {
        color: #9ca3af;
        font-size: 14px;
        margin-bottom: 30px;
    }

    .date-highlight {
        color: var(--heading-color);
        font-weight: 600;
    }

    .header-divider {
        width: 60px;
        height: 4px;
        background: var(--primary-color);
        margin: 0 auto 40px;
        border-radius: 10px;
    }

    /* Content Body Styling */
    .intro-text {
        font-size: 17px;
        color: var(--text-color);
        text-align: center;
        margin-bottom: 50px;
        line-height: 1.6;
    }

    .section-block {
        margin-bottom: 40px;
    }

    .section-block h2 {
        font-size: 19px;
        font-weight: 700;
        color: var(--heading-color);
        margin-bottom: 15px;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .section-block h2 i {
        font-size: 17px;
        color: var(--primary-color);
        opacity: 0.8;
    }

    .section-block p {
        color: var(--text-color);
        line-height: 1.8;
        font-size: 15px;
    }

    .policy-list {
        list-style: none;
        padding-left: 5px;
        margin-top: 15px;
    }

    .policy-list li {
        position: relative;
        padding-left: 25px;
        margin-bottom: 12px;
        color: var(--text-color);
        font-size: 15px;
        line-height: 1.6;
    }

    .policy-list li::before {
        content: "\f058";
        font-family: "Font Awesome 5 Free";
        font-weight: 900;
        position: absolute;
        left: 0;
        color: var(--primary-color);
        font-size: 14px;
    }

    .contact-btn {
        display: inline-block;
        margin-top: 20px;
        padding: 12px 28px;
        background: var(--heading-color);
        color: #fff;
        text-decoration: none !important;
        border-radius: 12px;
        font-weight: 600;
        font-size: 14px;
        transition: 0.3s;
    }

    .contact-btn:hover {
        background: var(--primary-color);
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(255, 107, 53, 0.2);
    }

    /* Responsive adjustments */
    @media (max-width: 768px) {
        .policy-card {
            padding: 30px 20px;
        }
        .policy-header h1 {
            font-size: 26px;
        }
    }
</style>

</asp:Content>