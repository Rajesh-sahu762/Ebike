
<%@ OutputCache Duration="120" VaryByParam="none" %>


<%@ Page Title="Home" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="Home.aspx.cs"
    Inherits="Client_Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <style>
    /* ═══════════════════════════════════════════════
       HOME PAGE — ELECTRIC PULSE THEME
    ═══════════════════════════════════════════════ */

    /* Hero Section */
    .hero-v4 {
        background: radial-gradient(circle at 80% 20%, rgba(8, 145, 178, 0.12) 0%, transparent 45%),
                    radial-gradient(circle at 15% 85%, rgba(249, 115, 22, 0.08) 0%, transparent 40%),
                    var(--ep-bg);
        padding: 70px 0 110px;
        position: relative;
    }

    .hero-badge-wrapper {
        margin-bottom: 24px;
    }

    .hero-badge {
        background: var(--ep-secondary-cyan-subtle);
        color: var(--ep-secondary-cyan);
        padding: 8px 20px;
        border-radius: var(--ep-radius-full);
        font-family: var(--ep-font-heading);
        font-weight: 700;
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: 1px;
        border: 1px solid rgba(8, 145, 178, 0.2);
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .hero-main-title {
        font-family: var(--ep-font-heading);
        font-size: clamp(38px, 5.5vw, 68px);
        font-weight: 800;
        color: var(--ep-heading);
        line-height: 1.12;
        letter-spacing: -0.03em;
        margin-bottom: 18px;
    }

    .text-gradient {
        background: linear-gradient(135deg, var(--ep-secondary-cyan), var(--ep-accent-cyan));
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .hero-subtitle {
        font-size: 1.125rem;
        color: var(--ep-muted);
        max-width: 620px;
        margin: 0 auto;
        line-height: 1.6;
    }

    /* Search Glass Design */
    .search-glass-wrapper {
        margin-top: 48px;
        padding: 0 15px;
    }

    .search-glass-inner {
        background: #ffffff;
        border: 1.5px solid var(--ep-border);
        border-radius: var(--ep-radius-2xl);
        padding: 12px 28px;
        display: flex;
        align-items: center;
        max-width: 920px;
        margin: 0 auto;
        box-shadow: var(--ep-shadow-lg);
        gap: 16px;
    }

    .search-item {
        flex: 1;
        text-align: left;
        padding: 8px 4px;
    }

    .search-item label {
        display: flex;
        align-items: center;
        gap: 6px;
        font-family: var(--ep-font-heading);
        font-size: 11.5px;
        font-weight: 700;
        color: var(--ep-muted);
        text-transform: uppercase;
        letter-spacing: 0.05em;
        margin-bottom: 6px;
    }

    .search-item label i {
        color: var(--ep-secondary-cyan);
    }

    .search-select {
        border: none;
        background: transparent;
        width: 100%;
        font-family: var(--ep-font-body);
        font-size: 15px;
        font-weight: 600;
        color: var(--ep-heading);
        outline: none;
        cursor: pointer;
    }

    .search-divider {
        width: 1px;
        height: 38px;
        background: var(--ep-border);
    }

    .btn-search-hero {
        background: var(--ep-brand-orange);
        color: #ffffff !important;
        padding: 14px 34px;
        border-radius: var(--ep-radius-xl);
        font-family: var(--ep-font-heading);
        font-weight: 700;
        font-size: 14.5px;
        text-decoration: none !important;
        transition: var(--ep-transition);
        display: inline-flex;
        align-items: center;
        gap: 8px;
        box-shadow: var(--ep-shadow-orange);
    }

    .btn-search-hero:hover {
        background: var(--ep-brand-orange-hover);
        transform: translateY(-2px);
        box-shadow: 0 10px 24px rgba(249, 115, 22, 0.35);
        color: #ffffff !important;
    }

    @media (max-width: 991px) {
        .search-glass-inner {
            flex-direction: column;
            border-radius: var(--ep-radius-xl);
            padding: 24px 20px;
            gap: 14px;
        }
        .search-divider { display: none; }
        .search-item { width: 100%; padding: 4px 0; }
        .search-action { width: 100%; }
        .btn-search-hero { width: 100%; justify-content: center; }
    }

    /* Featured Section */
    .featured-ev-v7 {
        background: var(--ep-surface);
        padding: 80px 0;
    }

    .section-title-v7 {
        font-family: var(--ep-font-heading);
        font-weight: 800;
        color: var(--ep-heading);
        font-size: 30px;
        margin: 0;
        letter-spacing: -0.02em;
    }

    .heading-line-v7 {
        width: 44px;
        height: 3px;
        background: var(--ep-secondary-cyan);
        margin-top: 8px;
        border-radius: var(--ep-radius-full);
    }

    .slider-nav-wrapper {
        gap: 10px;
        display: flex;
        align-items: center;
    }

    .nav-btn-v7 {
        width: 42px;
        height: 42px;
        background: var(--ep-surface);
        border: 1.5px solid var(--ep-border);
        border-radius: var(--ep-radius-md);
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        color: var(--ep-heading);
        transition: var(--ep-transition-fast);
        z-index: 10;
    }

    .nav-btn-v7:hover {
        background: var(--ep-primary-navy);
        color: #ffffff;
        border-color: var(--ep-primary-navy);
        transform: translateY(-2px);
    }

    .nav-btn-v7.swiper-button-disabled {
        opacity: 0.35;
        cursor: not-allowed;
        transform: none !important;
    }

    .compact-card-v7 {
        background: var(--ep-surface);
        border: 1px solid var(--ep-border);
        border-radius: var(--ep-radius-xl);
        overflow: hidden;
        transition: var(--ep-transition);
        margin: 8px 4px;
        height: 100%;
        box-shadow: var(--ep-shadow-xs);
    }

    .compact-card-v7:hover {
        border-color: rgba(8, 145, 178, 0.4);
        box-shadow: var(--ep-shadow-lg);
        transform: translateY(-5px);
    }

    .img-holder-v7 {
        height: 180px;
        background: linear-gradient(180deg, #F8FAFC 0%, #EEF4F8 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
    }

    .img-holder-v7 img {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
        transition: transform 0.35s ease;
    }

    .compact-card-v7:hover .img-holder-v7 img {
        transform: scale(1.08);
    }

    .info-holder-v7 {
        padding: 20px;
    }

    .title-v7 {
        font-family: var(--ep-font-heading);
        font-size: 18px;
        font-weight: 700;
        color: var(--ep-heading);
        margin-bottom: 10px;
    }

    .stats-row-v7 {
        display: flex;
        gap: 8px;
        margin-bottom: 16px;
    }

    .stats-row-v7 span {
        font-size: 11.5px;
        color: var(--ep-body);
        font-weight: 600;
        background: var(--ep-surface-subtle);
        border: 1px solid var(--ep-border);
        padding: 4px 10px;
        border-radius: var(--ep-radius-sm);
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }

    .stats-row-v7 span i {
        color: var(--ep-secondary-cyan);
    }

    .footer-row-v7 {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-top: 14px;
        border-top: 1px solid var(--ep-border-light);
    }

    .price-v7 {
        font-family: var(--ep-font-heading);
        font-size: 20px;
        font-weight: 800;
        color: var(--ep-heading);
    }

    .go-btn-v7 {
        width: 38px;
        height: 38px;
        background: var(--ep-primary-navy);
        color: #ffffff;
        border-radius: var(--ep-radius-md);
        display: flex;
        align-items: center;
        justify-content: center;
        transition: var(--ep-transition-fast);
        text-decoration: none !important;
    }

    .go-btn-v7:hover {
        background: var(--ep-secondary-cyan);
        transform: scale(1.08);
        color: #ffffff;
    }

    .view-all-v7 {
        font-weight: 700;
        color: var(--ep-secondary-cyan);
        font-size: 14px;
        text-decoration: none;
    }

    .v7-pagination .swiper-pagination-bullet-active {
        background: var(--ep-secondary-cyan) !important;
        width: 22px !important;
        border-radius: 4px !important;
    }

    /* Browse Section */
    .browse-section {
        background: var(--ep-primary-navy);
        padding: 90px 0;
        color: #f1f5f9;
        position: relative;
    }

    .browse-title {
        font-family: var(--ep-font-heading);
        font-size: 32px;
        font-weight: 800;
        color: #ffffff;
        margin-bottom: 24px;
        letter-spacing: -0.02em;
    }

    .browse-tabs {
        margin-bottom: 35px;
        display: flex;
        gap: 12px;
        flex-wrap: wrap;
    }

    .browse-tabs .tab {
        cursor: pointer;
        font-family: var(--ep-font-heading);
        font-weight: 600;
        font-size: 14px;
        color: #94a3b8;
        padding: 8px 18px;
        border-radius: var(--ep-radius-full);
        background: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(255, 255, 255, 0.08);
        transition: var(--ep-transition-fast);
    }

    .browse-tabs .tab:hover {
        color: #ffffff;
        background: rgba(255, 255, 255, 0.1);
    }

    .browse-tabs .active-tab {
        color: #071A2F !important;
        background: var(--ep-accent-cyan) !important;
        border-color: var(--ep-accent-cyan) !important;
        font-weight: 700;
        box-shadow: 0 4px 14px rgba(34, 211, 238, 0.35);
    }

    .tab-content { display: none; }
    .active-content { display: block; }

    .browse-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
        gap: 18px;
    }

    .brand-card {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        background: rgba(255, 255, 255, 0.04);
        border-radius: var(--ep-radius-lg);
        padding: 26px 16px;
        text-align: center;
        border: 1px solid rgba(255, 255, 255, 0.08);
        transition: var(--ep-transition);
        text-decoration: none !important;
        color: #f8fafc;
    }

    .brand-card:hover {
        border-color: var(--ep-accent-cyan);
        background: rgba(34, 211, 238, 0.06);
        box-shadow: 0 10px 24px rgba(0, 0, 0, 0.35);
        transform: translateY(-4px);
        color: #ffffff;
    }

    .brand-logo img {
        height: 44px;
        max-width: 100px;
        object-fit: contain;
        margin-bottom: 12px;
        filter: brightness(0.95);
    }

    .brand-name {
        font-family: var(--ep-font-heading);
        font-weight: 600;
        font-size: 14.5px;
        color: #e2e8f0;
    }

    .body-card {
        background: rgba(255, 255, 255, 0.04);
        border-radius: var(--ep-radius-lg);
        padding: 28px 16px;
        text-align: center;
        border: 1px solid rgba(255, 255, 255, 0.08);
        transition: var(--ep-transition);
        text-decoration: none !important;
        color: #f8fafc;
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .body-card:hover {
        border-color: var(--ep-accent-cyan);
        background: rgba(34, 211, 238, 0.06);
        transform: translateY(-4px);
        color: #ffffff;
    }

    .body-icon {
        font-size: 34px;
        margin-bottom: 10px;
    }

    .view-more {
        color: var(--ep-accent-cyan);
        text-decoration: none;
        font-weight: 600;
        font-size: 14px;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .view-more:hover {
        text-decoration: underline;
        color: #67e8f9;
    }

    /* Spare Parts Section */
    .spare-parts-v9 {
        background: var(--ep-bg);
        padding: 80px 0;
    }

    .btn-explore-store {
        background: var(--ep-primary-navy);
        color: #fff;
        padding: 10px 22px;
        border-radius: var(--ep-radius-md);
        font-family: var(--ep-font-heading);
        font-weight: 700;
        font-size: 14px;
        transition: var(--ep-transition);
        text-decoration: none !important;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .btn-explore-store:hover {
        background: var(--ep-secondary-cyan);
        transform: translateY(-2px);
        box-shadow: var(--ep-shadow-cyan);
        color: #ffffff;
    }

    .part-card-v9 {
        background: var(--ep-surface);
        border: 1px solid var(--ep-border);
        border-radius: var(--ep-radius-xl);
        overflow: hidden;
        transition: var(--ep-transition);
        height: 100%;
        position: relative;
        box-shadow: var(--ep-shadow-xs);
    }

    .part-card-v9:hover {
        border-color: var(--ep-secondary-cyan);
        box-shadow: var(--ep-shadow-lg);
        transform: translateY(-6px);
    }

    .part-cat-tag {
        position: absolute;
        top: 14px;
        left: 14px;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(6px);
        padding: 3px 10px;
        border-radius: var(--ep-radius-full);
        font-size: 10.5px;
        font-weight: 700;
        color: var(--ep-secondary-cyan);
        z-index: 2;
        border: 1px solid var(--ep-border);
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }

    .part-img-v9 {
        height: 170px;
        background: linear-gradient(180deg, #F8FAFC 0%, #EEF4F8 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        position: relative;
        overflow: hidden;
    }

    .part-img-v9 img {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
        transition: transform 0.4s ease;
    }

    .part-overlay-v9 {
        position: absolute;
        top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(8, 145, 178, 0.12);
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0;
        transition: 0.25s ease;
    }

    .part-card-v9:hover .part-overlay-v9 { opacity: 1; }
    .part-card-v9:hover .part-img-v9 img { transform: scale(1.08); }

    .quick-add-btn {
        width: 42px;
        height: 42px;
        background: #ffffff;
        color: var(--ep-primary-navy);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        text-decoration: none !important;
        transition: var(--ep-transition-fast);
    }

    .quick-add-btn:hover {
        background: var(--ep-secondary-cyan);
        color: #ffffff;
        transform: scale(1.1);
    }

    .part-info-v9 { padding: 18px; }
    .part-title-v9 {
        font-size: 15px;
        font-weight: 700;
        color: var(--ep-heading);
        margin-bottom: 10px;
        height: 38px;
        overflow: hidden;
        line-height: 1.3;
    }

    .part-price-row-v9 {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-top: 10px;
        border-top: 1px solid var(--ep-border-light);
    }

    .part-price-v9 {
        font-family: var(--ep-font-heading);
        font-size: 18px;
        font-weight: 800;
        color: var(--ep-heading);
    }

    .stock-status {
        font-size: 11px;
        color: var(--ep-success);
        font-weight: 700;
        text-transform: uppercase;
        display: inline-flex;
        align-items: center;
        gap: 4px;
    }

    /* Battery Guide Section */
    .battery-guide-v10 {
        background: var(--ep-surface);
        padding: 90px 0;
        overflow: hidden;
    }

    .battery-image-wrapper {
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .blob-bg {
        position: absolute;
        width: 100%;
        height: 100%;
        background: radial-gradient(circle, rgba(8, 145, 178, 0.1) 0%, transparent 70%);
        z-index: 1;
        transform: scale(1.2);
    }

    .main-battery-img {
        position: relative;
        z-index: 2;
        filter: drop-shadow(0 20px 30px rgba(0,0,0,0.08));
    }

    .floating-info-card {
        position: absolute;
        bottom: 20px;
        right: 0;
        background: #ffffff;
        padding: 12px 20px;
        border-radius: var(--ep-radius-lg);
        box-shadow: var(--ep-shadow-lg);
        display: flex;
        align-items: center;
        gap: 10px;
        z-index: 3;
        border: 1px solid var(--ep-border);
    }

    .floating-info-card span {
        font-family: var(--ep-font-heading);
        font-weight: 700;
        font-size: 13px;
        color: var(--ep-heading);
    }

    .guide-badge {
        background: var(--ep-secondary-cyan-subtle);
        color: var(--ep-secondary-cyan);
        padding: 6px 14px;
        border-radius: var(--ep-radius-full);
        font-size: 11.5px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.08em;
        border: 1px solid rgba(8, 145, 178, 0.2);
    }

    .guide-title {
        font-family: var(--ep-font-heading);
        font-size: clamp(28px, 4vw, 36px);
        font-weight: 800;
        color: var(--ep-heading);
        margin: 16px 0;
        line-height: 1.2;
        letter-spacing: -0.02em;
    }

    .guide-intro {
        font-size: 16px;
        color: var(--ep-muted);
        line-height: 1.6;
    }

    .maintenance-steps { margin-top: 32px; }

    .m-step-item {
        display: flex;
        gap: 18px;
        margin-bottom: 24px;
        transition: var(--ep-transition-fast);
        padding: 14px;
        border-radius: var(--ep-radius-lg);
        border: 1px solid transparent;
    }

    .m-step-item:hover {
        background: var(--ep-surface-subtle);
        border-color: var(--ep-border);
        box-shadow: var(--ep-shadow-xs);
    }

    .m-step-icon {
        flex-shrink: 0;
        width: 50px;
        height: 50px;
        background: var(--ep-secondary-cyan-subtle);
        border-radius: var(--ep-radius-md);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
        color: var(--ep-secondary-cyan);
        transition: var(--ep-transition-fast);
    }

    .m-step-item:hover .m-step-icon {
        background: var(--ep-secondary-cyan);
        color: #ffffff;
        transform: scale(1.08);
    }

    .m-step-text h5 {
        font-size: 16px;
        font-weight: 700;
        color: var(--ep-heading);
        margin-bottom: 6px;
    }

    .m-step-text p {
        font-size: 14px;
        color: var(--ep-body);
        line-height: 1.6;
        margin: 0;
    }

    /* Why Choose Section */
    .why-choose-v11 {
        background: var(--ep-bg);
        padding: 90px 0;
    }

    .trust-badge {
        background: var(--ep-secondary-cyan-subtle);
        color: var(--ep-secondary-cyan);
        padding: 8px 18px;
        border-radius: var(--ep-radius-full);
        font-size: 12px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.08em;
        border: 1px solid rgba(8, 145, 178, 0.2);
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .why-title {
        font-family: var(--ep-font-heading);
        font-size: clamp(28px, 4vw, 38px);
        font-weight: 800;
        color: var(--ep-heading);
        letter-spacing: -0.02em;
    }

    .text-main { color: var(--ep-secondary-cyan); }

    .why-subtitle {
        max-width: 620px;
        color: var(--ep-muted);
        font-size: 16px;
        margin-top: 14px;
        line-height: 1.6;
    }

    .feature-card-v11 {
        background: var(--ep-surface);
        padding: 34px 26px;
        border-radius: var(--ep-radius-xl);
        border: 1px solid var(--ep-border);
        height: 100%;
        transition: var(--ep-transition);
        position: relative;
        overflow: hidden;
        box-shadow: var(--ep-shadow-xs);
    }

    .feature-card-v11:hover {
        transform: translateY(-6px);
        box-shadow: var(--ep-shadow-lg);
        border-color: var(--ep-secondary-cyan);
    }

    .f-icon-box {
        width: 58px;
        height: 58px;
        border-radius: var(--ep-radius-lg);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 24px;
        margin-bottom: 22px;
        transition: var(--ep-transition-fast);
    }

    .bg-soft-cyan { background: var(--ep-secondary-cyan-subtle); color: var(--ep-secondary-cyan); }
    .bg-main { background: var(--ep-primary-navy); color: #ffffff; }
    .bg-soft-purple { background: rgba(147, 51, 234, 0.08); color: #9333ea; }
    .bg-soft-orange { background: var(--ep-brand-orange-subtle); color: var(--ep-brand-orange); }
    .bg-soft-green { background: var(--ep-success-subtle); color: var(--ep-success); }
    .bg-soft-blue { background: rgba(37, 99, 235, 0.08); color: #2563eb; }

    .feature-card-v11:hover .f-icon-box {
        transform: scale(1.08) rotate(5deg);
    }

    .f-content h4 {
        font-size: 18px;
        font-weight: 700;
        color: var(--ep-heading);
        margin-bottom: 10px;
    }

    .f-content p {
        font-size: 14px;
        color: var(--ep-body);
        line-height: 1.6;
        margin: 0;
    }

    /* Compare CTA */
    .compare-cta-v12 {
        background-color: var(--ep-surface);
        padding: 80px 0;
    }

    .compare-gradient-card {
        background: linear-gradient(135deg, var(--ep-primary-navy) 0%, #0c2748 100%);
        border-radius: var(--ep-radius-2xl);
        overflow: hidden;
        position: relative;
        box-shadow: var(--ep-shadow-xl);
        border: 1px solid rgba(34, 211, 238, 0.2);
    }

    .compare-gradient-card::before {
        content: '';
        position: absolute;
        top: -40%;
        right: -10%;
        width: 380px;
        height: 380px;
        background: radial-gradient(circle, rgba(34, 211, 238, 0.15) 0%, transparent 70%);
        pointer-events: none;
    }

    .cta-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        background: rgba(255, 255, 255, 0.08);
        color: var(--ep-accent-cyan);
        padding: 6px 16px;
        border-radius: var(--ep-radius-full);
        font-size: 11.5px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.08em;
        border: 1px solid rgba(255, 255, 255, 0.12);
    }

    .cta-heading {
        font-family: var(--ep-font-heading);
        font-size: clamp(28px, 3.8vw, 40px);
        font-weight: 800;
        line-height: 1.2;
        letter-spacing: -0.02em;
    }

    .text-highlight { color: var(--ep-accent-cyan); }
    .cta-desc { font-size: 16px; line-height: 1.65; max-width: 520px; color: #94a3b8; }

    .btn-compare-v12 {
        background: var(--ep-brand-orange);
        color: #fff !important;
        padding: 14px 32px;
        border-radius: var(--ep-radius-xl);
        font-family: var(--ep-font-heading);
        font-weight: 700;
        font-size: 14.5px;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        text-decoration: none !important;
        transition: var(--ep-transition);
        box-shadow: var(--ep-shadow-orange);
    }

    .btn-compare-v12:hover {
        background: var(--ep-brand-orange-hover);
        transform: translateY(-2px);
        box-shadow: 0 10px 24px rgba(249, 115, 22, 0.4);
        color: #fff !important;
    }

    .compare-visual-wrapper {
        position: relative;
        height: 280px;
        display: flex;
        align-items: center;
        justify-content: center;
        padding-right: 40px;
    }

    .vs-circle {
        width: 64px;
        height: 64px;
        background: rgba(255, 255, 255, 0.08);
        backdrop-filter: blur(10px);
        border: 1.5px solid rgba(34, 211, 238, 0.4);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--ep-accent-cyan);
        font-family: var(--ep-font-heading);
        font-weight: 800;
        font-size: 20px;
        z-index: 5;
    }

    .bike-placeholder {
        position: absolute;
        width: 130px;
        height: 130px;
        background: rgba(255, 255, 255, 0.04);
        border-radius: var(--ep-radius-2xl);
        display: flex;
        align-items: center;
        justify-content: center;
        border: 1px solid rgba(255, 255, 255, 0.1);
        transition: 0.4s ease;
    }

    .left-bike { left: 12%; transform: rotate(-8deg); }
    .right-bike { right: 16%; transform: rotate(8deg); }

    .compare-gradient-card:hover .left-bike { transform: rotate(0deg) translateX(-8px); background: rgba(34, 211, 238, 0.08); }
    .compare-gradient-card:hover .right-bike { transform: rotate(0deg) translateX(8px); background: rgba(34, 211, 238, 0.08); }

    /* User Reviews */
    .user-reviews-v14 {
        background: var(--ep-bg);
        padding: 90px 0;
    }

    .badge-soft-primary {
        background: var(--ep-secondary-cyan-subtle);
        color: var(--ep-secondary-cyan);
        font-family: var(--ep-font-heading);
        font-weight: 700;
        padding: 6px 14px;
        border-radius: var(--ep-radius-full);
        font-size: 11px;
        letter-spacing: 0.06em;
        border: 1px solid rgba(8, 145, 178, 0.2);
    }

    .nav-circle {
        width: 42px;
        height: 42px;
        background: #fff;
        border: 1.5px solid var(--ep-border);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        transition: var(--ep-transition-fast);
        color: var(--ep-heading);
    }

    .nav-circle:hover {
        background: var(--ep-primary-navy);
        color: #fff;
        border-color: var(--ep-primary-navy);
    }

    .review-card-v14 {
        background: var(--ep-surface);
        border-radius: var(--ep-radius-xl);
        border: 1px solid var(--ep-border);
        padding: 28px;
        transition: var(--ep-transition);
        height: 100%;
        display: flex;
        flex-direction: column;
        box-shadow: var(--ep-shadow-xs);
    }

    .review-card-v14:hover {
        transform: translateY(-6px);
        box-shadow: var(--ep-shadow-lg);
        border-color: var(--ep-secondary-cyan);
    }

    .review-user-row {
        display: flex;
        align-items: center;
        gap: 14px;
        margin-bottom: 20px;
    }

    .user-profile-v14 {
        position: relative;
        width: 50px;
        height: 50px;
    }

    .user-profile-v14 img {
        width: 100%;
        height: 100%;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid var(--ep-border);
    }

    .verified-check {
        position: absolute;
        bottom: 0;
        right: 0;
        background: var(--ep-success);
        color: #fff;
        font-size: 8px;
        width: 18px;
        height: 18px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 2px solid #fff;
    }

    .user-details-v14 h5 {
        font-size: 15px;
        font-weight: 700;
        color: var(--ep-heading);
        margin: 0;
    }

    .review-date {
        font-size: 12px;
        color: var(--ep-muted);
    }

    .stars-v14 {
        color: #f59e0b;
        font-size: 12px;
    }

    .bike-mentions-v14 {
        background: var(--ep-surface-subtle);
        border-radius: var(--ep-radius-md);
        padding: 10px 14px;
        display: flex;
        align-items: center;
        gap: 12px;
        margin-bottom: 18px;
        border: 1px solid var(--ep-border-light);
    }

    .mention-img {
        width: 40px;
        height: 40px;
        background: #fff;
        border-radius: var(--ep-radius-sm);
        padding: 4px;
        border: 1px solid var(--ep-border);
    }

    .mention-img img { width: 100%; height: 100%; object-fit: contain; }
    .mention-text small { font-size: 10px; color: var(--ep-muted); font-weight: 700; text-transform: uppercase; }
    .mention-text h6 { font-size: 13px; font-weight: 700; color: var(--ep-heading); margin: 0; }

    .review-content-v14 p {
        font-size: 14px;
        color: var(--ep-body);
        line-height: 1.6;
        font-style: italic;
        margin-bottom: 18px;
    }

    .review-footer-v14 { margin-top: auto; }

    .read-full-link {
        font-family: var(--ep-font-heading);
        font-size: 13px;
        font-weight: 700;
        color: var(--ep-secondary-cyan);
        text-decoration: none !important;
        transition: var(--ep-transition-fast);
        display: inline-flex;
        align-items: center;
        gap: 5px;
    }

    .read-full-link:hover { color: var(--ep-primary-navy); }

    .v14-dots .swiper-pagination-bullet-active {
        background: var(--ep-secondary-cyan) !important;
        width: 24px !important;
        border-radius: 4px !important;
    }

    /* Ultimate CTA */
    .ultimate-cta-v15 {
        background: var(--ep-surface);
        padding: 80px 0;
        overflow: hidden;
    }

    .ultimate-card-v15 {
        background: linear-gradient(135deg, var(--ep-primary-navy) 0%, #0d2746 100%);
        border-radius: var(--ep-radius-2xl);
        padding: 70px 40px;
        position: relative;
        overflow: hidden;
        box-shadow: var(--ep-shadow-xl);
        border: 1px solid rgba(34, 211, 238, 0.2);
    }

    .glow-circle {
        position: absolute;
        width: 320px;
        height: 320px;
        background: radial-gradient(circle, rgba(34, 211, 238, 0.12) 0%, transparent 70%);
        border-radius: 50%;
        pointer-events: none;
    }
    .top-left { top: -100px; left: -100px; }
    .bottom-right { bottom: -100px; right: -100px; }

    .cta-sub-badge {
        color: var(--ep-accent-cyan);
        font-family: var(--ep-font-heading);
        font-weight: 700;
        font-size: 12px;
        letter-spacing: 2px;
        display: inline-block;
        margin-bottom: 16px;
    }

    .cta-main-title {
        font-family: var(--ep-font-heading);
        font-size: clamp(30px, 4.5vw, 44px);
        font-weight: 800;
        color: #fff;
        line-height: 1.2;
        margin-bottom: 18px;
        letter-spacing: -0.02em;
    }

    .text-cyan { color: var(--ep-accent-cyan); }

    .cta-description {
        font-size: 16.5px;
        color: #94a3b8;
        max-width: 620px;
        line-height: 1.6;
        margin-bottom: 40px;
    }

    .cta-button-group {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 16px;
        position: relative;
        z-index: 2;
    }

    .cta-btn-v15 {
        padding: 14px 28px;
        border-radius: var(--ep-radius-xl);
        font-family: var(--ep-font-heading);
        font-weight: 700;
        font-size: 14.5px;
        text-decoration: none !important;
        transition: var(--ep-transition);
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .btn-main {
        background: var(--ep-brand-orange);
        color: #fff !important;
        box-shadow: var(--ep-shadow-orange);
    }
    .btn-main:hover {
        background: var(--ep-brand-orange-hover);
        transform: translateY(-2px);
        box-shadow: 0 10px 24px rgba(249, 115, 22, 0.4);
        color: #fff !important;
    }

    .btn-glass {
        background: rgba(255, 255, 255, 0.08);
        color: #fff !important;
        border: 1px solid rgba(255, 255, 255, 0.15);
        backdrop-filter: blur(10px);
    }
    .btn-glass:hover {
        background: rgba(255, 255, 255, 0.15);
        transform: translateY(-2px);
        color: #fff !important;
    }

    .btn-border {
        background: transparent;
        color: #fff !important;
        border: 1.5px solid var(--ep-accent-cyan);
    }
    .btn-border:hover {
        background: var(--ep-accent-cyan);
        color: var(--ep-primary-navy) !important;
        transform: translateY(-2px);
    }

    @media (max-width: 768px) {
        .ultimate-card-v15 { padding: 44px 20px; border-radius: var(--ep-radius-xl); }
        .cta-btn-v15 { width: 100%; }
        .cta-button-group { flex-direction: column; }
    }
    

/* ===== EBikes Duniya | Reference-led responsive hero ===== */
.hero-v4{
 position:relative;isolation:isolate;overflow:hidden;
 padding:42px 0 0!important;
 background:
  radial-gradient(ellipse at 73% 58%,rgba(8,145,178,.32),transparent 34%),
  radial-gradient(ellipse at 98% 25%,rgba(249,115,22,.10),transparent 30%),
  linear-gradient(112deg,#041426 0%,#08243D 52%,#061A2E 100%)!important;
}
.hero-v4:before{
 content:"";position:absolute;inset:0;z-index:-1;pointer-events:none;
 background:
  linear-gradient(180deg,transparent 72%,rgba(34,211,238,.12) 85%,transparent 100%),
  linear-gradient(166deg,transparent 54%,rgba(77,208,225,.10) 54.2%,transparent 54.8%),
  radial-gradient(ellipse at 50% 100%,rgba(34,211,238,.12),transparent 45%);
}
.hero-v4:after{
 content:"";position:absolute;left:0;right:0;bottom:0;height:88px;z-index:-1;
 background:linear-gradient(0deg,rgba(34,211,238,.18),transparent);
}
.hero-v4>.container{width:min(100% - 40px,1440px);max-width:1440px}
.hero-grid{
 display:grid;grid-template-columns:minmax(0,.94fr) minmax(0,1.06fr);
 align-items:center;gap:12px;min-height:360px;
}
.hero-copy{position:relative;z-index:2;text-align:left;padding:14px 0 28px;max-width:610px}
.hero-badge-wrapper{margin-bottom:22px}
.hero-badge{
 display:inline-flex;align-items:center;gap:9px;padding:9px 17px;
 color:#67E8F9!important;background:rgba(8,145,178,.18)!important;
 border:1px solid rgba(34,211,238,.35)!important;border-radius:999px;
 font-size:12px;font-weight:800;letter-spacing:.075em;
}
.hero-main-title{
 margin:0 0 17px!important;color:#F8FAFC!important;
 font-size:clamp(44px,5vw,70px)!important;line-height:1.02!important;
 font-weight:800!important;letter-spacing:-.058em!important;
}
.hero-main-title .text-gradient{
 background:linear-gradient(95deg,#06B6D4 0%,#22D3EE 52%,#60A5FA 100%);
 -webkit-background-clip:text;background-clip:text;
 -webkit-text-fill-color:transparent;
}
.hero-subtitle{
 max-width:540px;margin:0!important;color:#D5E4EF!important;
 font-size:16px!important;line-height:1.65!important;font-weight:450;
}
.hero-actions{display:flex;align-items:center;gap:14px;flex-wrap:wrap;margin-top:24px}
.hero-action{
 min-height:46px;padding:0 23px;display:inline-flex;align-items:center;
 justify-content:center;gap:10px;border-radius:999px;text-decoration:none!important;
 font-size:14px;font-weight:800;transition:transform .2s,box-shadow .2s,background .2s;
}
.hero-action:hover{transform:translateY(-3px)}
.hero-action-primary{
 color:#fff!important;background:linear-gradient(135deg,#FB8500,#F97316)!important;
 box-shadow:0 10px 25px rgba(249,115,22,.25);
}
.hero-action-primary:hover{box-shadow:0 14px 30px rgba(249,115,22,.36)}
.hero-action-secondary{
 color:#F8FAFC!important;background:rgba(7,27,46,.45)!important;
 border:1px solid rgba(226,242,255,.78)!important;
}
.hero-action-secondary i{color:#22D3EE}
.hero-proof-points{display:flex;align-items:center;gap:22px;flex-wrap:wrap;margin-top:22px}
.hero-proof-item{display:flex;align-items:center;gap:8px;color:#D7E5F0;font-size:12px;font-weight:650}
.hero-proof-item i{color:#22D3EE;font-size:14px}
.hero-media{
 position:relative;min-width:0;min-height:370px;display:flex;
 align-items:center;justify-content:center;padding:0 120px 0 0;
}
.hero-media-orbit{
 position:absolute;left:50%;top:50%;width:min(78%,410px);aspect-ratio:1;
 transform:translate(-50%,-50%);border-radius:50%;
 border:1.5px solid rgba(34,211,238,.72);
 box-shadow:0 0 34px rgba(34,211,238,.18),0 0 0 22px rgba(34,211,238,.045),
  inset 0 0 34px rgba(34,211,238,.08);
}
.hero-image-frame{
 position:relative;z-index:1;width:100%;max-width:650px;
 display:flex;align-items:center;justify-content:center;
 background:transparent!important;border:0!important;border-radius:0!important;
 box-shadow:none!important;padding:0!important;filter:drop-shadow(0 24px 28px rgba(0,0,0,.48));
}
.hero-image-frame img{
 display:block;width:100%;height:360px;max-height:360px;
 object-fit:contain;object-position:center;background:transparent;
 border:0;border-radius:0;mix-blend-mode:normal;
}
.hero-info-stack{
 position:absolute;z-index:3;right:0;top:50%;transform:translateY(-50%);
 display:flex;flex-direction:column;gap:11px;width:190px;
}
.hero-float-card{
 display:flex;align-items:center;gap:12px;min-height:66px;padding:11px 13px;
 color:#F8FAFC;background:rgba(8,35,58,.78);backdrop-filter:blur(12px);
 -webkit-backdrop-filter:blur(12px);border:1px solid rgba(148,210,235,.34);
 border-radius:16px;box-shadow:0 12px 28px rgba(0,0,0,.16);
}
.hero-float-icon{
 width:37px;height:37px;flex:0 0 37px;border-radius:12px;
 display:grid;place-items:center;background:rgba(34,211,238,.12);
 color:#22D3EE;font-size:17px;
}
.hero-float-card:nth-child(3) .hero-float-icon{color:#FB923C;background:rgba(249,115,22,.13)}
.hero-float-copy{display:flex;flex-direction:column;gap:3px;min-width:0}
.hero-float-copy strong{font-size:12px;line-height:1.2;font-weight:800;color:#fff}
.hero-float-copy span{font-size:10px;line-height:1.3;color:#C3D7E5}
.search-glass-wrapper{position:relative;z-index:5;margin:0 auto!important;padding:0 0 0}
.search-glass-inner{
 display:flex;align-items:center;gap:14px;max-width:1220px!important;
 margin:0 auto!important;padding:13px 20px 13px 25px!important;
 background:#fff!important;border:1px solid rgba(226,234,241,.95)!important;
 border-radius:20px!important;box-shadow:0 20px 48px rgba(1,15,30,.25)!important;
}
.search-item{flex:1;min-width:0;padding:8px 12px!important}
.search-item label{color:#64748B!important;font-size:11px!important;font-weight:800!important;letter-spacing:.045em}
.search-item label i{color:#0891B2!important}
.search-select{color:#14243A!important;font-size:14px!important;font-weight:700!important}
.search-divider{height:48px;width:1px;background:#DCE6EF;flex:0 0 1px}
.search-action{flex:0 0 180px}
.btn-search-hero{
 width:100%;min-height:49px;display:flex!important;align-items:center;justify-content:center;
 gap:9px;background:#22D3EE!important;color:#062238!important;
 border:0!important;border-radius:999px!important;font-weight:800!important;
 box-shadow:0 8px 18px rgba(34,211,238,.18);transition:transform .2s,background .2s;
}
.btn-search-hero:hover{background:#67E8F9!important;color:#062238!important;transform:translateY(-2px)}
.hero-stats{
 display:grid!important;grid-template-columns:repeat(4,minmax(0,1fr));
 max-width:1120px;margin:18px auto 0!important;padding:15px 10px 18px;
 background:rgba(255,255,255,.96)!important;border:1px solid #E2EAF1!important;
 border-bottom:0!important;border-radius:18px 18px 0 0!important;
 box-shadow:0 10px 30px rgba(0,0,0,.10)!important;
}
.hero-stat{
 display:flex;align-items:center;justify-content:center;gap:13px;
 min-width:0;padding:5px 12px;border-right:1px solid #DCE8F0;
}
.hero-stat:last-child{border-right:0}
.hero-stat>i{font-size:25px;color:#0891B2!important;flex:0 0 auto}
.hero-stat>div{display:flex;flex-direction:column;gap:2px}
.hero-stat strong{color:#0B1B32!important;font-size:18px;line-height:1.15;font-weight:850}
.hero-stat span{color:#526B80!important;font-size:11px;line-height:1.3}
@media(min-width:1400px){
 .hero-v4{padding-top:48px!important}
 .hero-grid{min-height:390px}
 .hero-image-frame img{height:390px;max-height:390px}
}
@media(max-width:1100px){
 .hero-grid{grid-template-columns:minmax(0,1fr) minmax(0,1fr)}
 .hero-media{padding-right:105px;min-height:330px}
 .hero-image-frame img{height:320px;max-height:320px}
 .hero-info-stack{width:165px}
 .hero-float-card{min-height:60px;padding:9px}
 .hero-float-icon{width:32px;height:32px;flex-basis:32px}
}
@media(max-width:850px){
 .hero-v4{padding-top:34px!important}
 .hero-grid{grid-template-columns:1fr;gap:0;min-height:0}
 .hero-copy{text-align:center;margin:0 auto;padding:8px 0 18px}
 .hero-subtitle{margin:0 auto!important}
 .hero-actions,.hero-proof-points{justify-content:center}
 .hero-media{min-height:310px;padding:0 150px 0 0;max-width:680px;width:100%;margin:0 auto}
 .hero-image-frame img{height:310px;max-height:310px}
 .hero-media-orbit{width:min(66%,330px)}
 .hero-info-stack{right:0;width:160px}
 .hero-stats{max-width:720px}
}
@media(max-width:600px){
 .hero-v4{padding:28px 0 0!important}
 .hero-v4>.container{width:calc(100% - 28px)}
 .hero-badge-wrapper{margin-bottom:17px}
 .hero-badge{font-size:10px;padding:8px 13px}
 .hero-main-title{font-size:clamp(37px,10vw,48px)!important;line-height:1.04!important;margin-bottom:13px!important}
 .hero-subtitle{font-size:13px!important;line-height:1.55!important;max-width:390px}
 .hero-actions{gap:9px;margin-top:18px}
 .hero-action{min-height:43px;padding:0 16px;font-size:12px}
 .hero-proof-points{gap:12px;margin-top:16px}
 .hero-proof-item{font-size:10px;gap:5px}
 .hero-media{min-height:260px;padding:0 0 75px;margin-top:4px}
 .hero-image-frame{width:100%;max-width:440px}
 .hero-image-frame img{height:250px;max-height:250px}
 .hero-media-orbit{width:min(72%,270px);top:45%}
 .hero-info-stack{
  position:absolute;left:50%;right:auto;top:auto;bottom:0;transform:translateX(-50%);
  width:100%;max-width:440px;display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:6px;
 }
 .hero-float-card{min-height:57px;padding:7px 6px;gap:5px;border-radius:11px;justify-content:center}
 .hero-float-icon{width:25px;height:25px;flex-basis:25px;border-radius:8px;font-size:12px}
 .hero-float-copy strong{font-size:9px}
 .hero-float-copy span{font-size:8px}
 .search-glass-wrapper{padding-top:15px}
 .search-glass-inner{display:grid;grid-template-columns:1fr;gap:4px;padding:12px!important;border-radius:16px!important}
 .search-item{padding:8px 6px!important}
 .search-divider{width:100%;height:1px;flex:auto}
 .search-action{width:100%;flex:auto;padding:4px 0 0}
 .btn-search-hero{min-height:46px}
 .hero-stats{grid-template-columns:repeat(2,minmax(0,1fr));margin:13px 0 0!important;padding:9px 4px;border-radius:14px 14px 0 0!important}
 .hero-stat{justify-content:flex-start;gap:8px;padding:9px 7px;border-right:0}
 .hero-stat:nth-child(odd){border-right:1px solid #DCE8F0}
 .hero-stat:nth-child(-n+2){border-bottom:1px solid #DCE8F0}
 .hero-stat>i{font-size:19px}
 .hero-stat strong{font-size:15px}
 .hero-stat span{font-size:9px}
}
@media(prefers-reduced-motion:no-preference){
 .hero-image-frame{animation:heroBikeFloat 6s ease-in-out infinite}
 @keyframes heroBikeFloat{0%,100%{transform:translateY(0)}50%{transform:translateY(-7px)}}
}


/* Explore by category — blended bridge from hero stats into featured rides */
.home-category-section{
 position:relative;z-index:2;isolation:isolate;
 padding:30px 0 38px;
 background:linear-gradient(180deg,#E8F5F7 0%,#EDF7F9 38%,#F2F8FA 76%,#F4F8FC 100%);
 border:0;
}
.home-category-section:before{
 content:"";position:absolute;inset:0;z-index:-1;pointer-events:none;
 background:radial-gradient(ellipse at 50% 0%,rgba(34,211,238,.10),transparent 62%);
}
.home-category-heading{display:flex;align-items:flex-end;justify-content:space-between;gap:16px;margin:0 0 17px}
.home-category-heading h2{margin:0;color:#0B1B32;font:400 27px/1.05 var(--ep-font-heading);letter-spacing:.025em}
.home-category-heading p{margin:5px 0 0;color:#526B80;font:400 11px/1.5 var(--ep-font-body)}
.home-category-heading .view-all-v7{font:600 11px/1.2 var(--ep-font-body);color:#0789A6;text-decoration:none}
.home-category-track{display:grid;grid-template-columns:repeat(6,minmax(0,1fr));gap:12px}
.home-category-card{
 min-width:0;min-height:82px;display:flex;align-items:center;justify-content:center;gap:11px;
 padding:13px 11px;border:1px solid rgba(190,216,226,.72);border-radius:15px;
 background:rgba(255,255,255,.68);backdrop-filter:blur(8px);
 color:#24364B!important;text-decoration:none!important;
 box-shadow:0 5px 16px rgba(15,45,65,.045);
 transition:transform .2s ease,border-color .2s ease,box-shadow .2s ease,background .2s ease;
}
.home-category-card:hover,.home-category-card:focus-visible{
 transform:translateY(-3px);border-color:rgba(8,145,178,.42);
 background:rgba(255,255,255,.92);box-shadow:0 10px 24px rgba(8,145,178,.10);
 color:#071A2F!important;
}
.home-category-icon{
 width:39px;height:39px;flex:0 0 39px;display:inline-flex;align-items:center;justify-content:center;
 border-radius:12px;background:linear-gradient(145deg,#DDF8FB,#C9F1F6);color:#078EAA;font-size:16px;
}
.home-category-copy{min-width:0;text-align:left}
.home-category-name{display:block;color:#102A43;font:500 11px/1.35 var(--ep-font-body);white-space:nowrap}
.home-category-count{display:block;margin-top:4px;color:#60798D;font:400 9px/1.3 var(--ep-font-body)}
.featured-ev-v7{
 background:linear-gradient(180deg,#F4F8FC 0%,#EDF6F9 100%)!important;
 padding-top:58px!important;
}
@media(max-width:991px){
 .home-category-track{grid-template-columns:repeat(3,minmax(0,1fr));}
}
@media(max-width:767px){
 .home-category-section{padding:22px 0 27px}
 .home-category-heading{margin-bottom:13px}
 .home-category-heading h2{font-size:24px}
 .home-category-track{
  display:flex;gap:10px;overflow-x:auto;overflow-y:hidden;
  padding:2px 2px 11px;margin:0 -2px;
  scroll-snap-type:x mandatory;-webkit-overflow-scrolling:touch;
  scrollbar-width:thin;scrollbar-color:#B8DCE4 transparent;
 }
 .home-category-card{flex:0 0 166px;min-height:74px;justify-content:flex-start;scroll-snap-align:start;padding:10px}
 .home-category-icon{width:36px;height:36px;flex-basis:36px;font-size:15px}
 .home-category-name{font-size:10px}
 .home-category-count{font-size:9px}
 .featured-ev-v7{padding-top:42px!important}
}
@media(prefers-reduced-motion:reduce){.home-category-card{transition:none}}


/* Latest electric bike cards — image-led premium cards */
.featured-ev-v7{background:linear-gradient(180deg,#F4F8FC 0%,#EEF6FA 100%)!important;padding:52px 0 66px!important}
.featured-heading-v8{display:flex;align-items:flex-end;justify-content:space-between;gap:22px;margin:0 0 22px;padding:0 2px}
.featured-heading-v8 .section-title-v7{font-size:28px;line-height:1.1;letter-spacing:.015em;font-weight:400}
.featured-heading-v8 .section-title-v7 span{color:#078DAA}
.featured-section-subtitle{margin:5px 0 0;color:#60758A;font:400 10px/1.5 var(--ep-font-body)}
.featured-heading-actions{display:flex;align-items:center;gap:22px}
.featured-view-all{display:inline-flex;align-items:center;gap:8px;color:#0796B5!important;font:600 10px/1.2 var(--ep-font-body);text-decoration:none!important;white-space:nowrap}
.featured-view-all:hover{color:#05677E!important;gap:11px}
.featured-heading-v8 .slider-nav-wrapper{display:flex;gap:9px}
.featured-heading-v8 .nav-btn-v7{width:38px;height:38px;border-radius:12px;background:rgba(255,255,255,.8);border:1px solid #DCE7EF;color:#19334B}
.featured-heading-v8 .nav-btn-v7:hover{background:#071A2F;border-color:#071A2F;color:#fff}
.bikeSliderV7 .swiper-slide{height:auto}
.compact-card-v7{height:100%;margin:5px 2px 10px;background:#fff;border:1px solid #E1EAF1;border-radius:17px;overflow:hidden;box-shadow:0 5px 16px rgba(15,45,65,.055);transition:transform .24s ease,border-color .24s ease,box-shadow .24s ease}
.compact-card-v7:hover{transform:translateY(-4px);border-color:#B7E5EC;box-shadow:0 13px 28px rgba(15,45,65,.11)}
.featured-bike-image-link{display:block;text-decoration:none!important}
.img-holder-v7{position:relative;height:142px;padding:0;overflow:hidden;background:linear-gradient(135deg,#E9F1F7,#DCEAF1)}
.img-holder-v7:after{content:"";position:absolute;inset:45% 0 0;background:linear-gradient(180deg,transparent,rgba(6,20,34,.15));pointer-events:none}
.img-holder-v7 img{width:100%;height:100%;max-width:none;max-height:none;object-fit:cover;object-position:center;transition:transform .45s ease}
.compact-card-v7:hover .img-holder-v7 img{transform:scale(1.045)}
.featured-bike-badge{position:absolute;z-index:1;top:10px;left:10px;padding:5px 10px;border-radius:999px;background:#16A34A;color:#fff;font:600 9px/1 var(--ep-font-body);box-shadow:0 3px 9px rgba(0,0,0,.12)}
.info-holder-v7{padding:12px 13px 11px}
.title-v7{margin:0 0 3px;font:600 12px/1.35 var(--ep-font-body);letter-spacing:0;color:#10243A;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.title-v7 a{color:inherit;text-decoration:none}.title-v7 a:hover{color:#078DAA}
.price-v7{margin:0 0 8px;color:#07834D;font:700 14px/1.2 var(--ep-font-body);letter-spacing:-.025em}
.price-v7 .price-note{font-size:10px;color:#07834D;vertical-align:top;margin-left:1px}
.stats-row-v7{display:flex;align-items:center;gap:7px;margin:0 0 9px;flex-wrap:wrap}
.stats-row-v7 span{display:inline-flex;align-items:center;gap:5px;padding:5px 8px;border-radius:7px;background:#F5F8FB;border:1px solid #E5ECF2;color:#344B62;font:500 9px/1 var(--ep-font-body);white-space:nowrap}
.stats-row-v7 span i{color:#078DAA;font-size:10px}
.footer-row-v7{display:flex;align-items:center;justify-content:space-between;padding-top:8px;border-top:1px solid #EDF1F5}
.featured-bike-meta{font:400 8px/1.3 var(--ep-font-body);color:#8293A3}
.go-btn-v7{width:29px;height:29px;border-radius:9px;background:#071A2F;color:#fff;font-size:11px}
.go-btn-v7:hover{background:#079DB9;color:#fff}
.v7-pagination{position:relative!important;margin-top:8px!important}
.v7-pagination .swiper-pagination-bullet{width:6px;height:6px;background:#B7C4CE;opacity:1}
.v7-pagination .swiper-pagination-bullet-active{width:19px!important;background:#078DAA!important;border-radius:5px!important}
@media(max-width:767px){.featured-ev-v7{padding:35px 0 45px!important}.featured-heading-v8{align-items:flex-end;margin-bottom:15px;gap:10px}.featured-heading-v8 .section-title-v7{font-size:23px}.featured-section-subtitle{font-size:9px;max-width:230px}.featured-heading-actions{gap:0}.featured-heading-actions .slider-nav-wrapper{display:none}.featured-view-all{font-size:9px}.img-holder-v7{height:126px}.info-holder-v7{padding:10px}.title-v7{font-size:11px}.price-v7{font-size:13px}.stats-row-v7{gap:5px}.stats-row-v7 span{font-size:8px;padding:5px 6px}}
@media(prefers-reduced-motion:reduce){.compact-card-v7,.img-holder-v7 img{transition:none}}


.browse-section .brand-card-wrap{min-width:0;display:block}
/* Browse Bikes By — Electric Pulse gradient and contrast */
.browse-section{position:relative;isolation:isolate;overflow:hidden;padding:68px 0 74px!important;color:#f7fbff!important;background:radial-gradient(ellipse at 12% 0%,rgba(34,211,238,.16),transparent 38%),radial-gradient(ellipse at 92% 100%,rgba(8,145,178,.22),transparent 42%),linear-gradient(135deg,#0b2942 0%,#071d32 52%,#06283b 100%)!important}
.browse-section:before,.browse-section:after{content:"";position:absolute;z-index:-1;pointer-events:none;border-radius:50%}
.browse-section:before{width:420px;height:420px;top:-300px;right:-100px;border:1px solid rgba(34,211,238,.16);box-shadow:0 0 0 38px rgba(34,211,238,.025),0 0 0 82px rgba(34,211,238,.018)}
.browse-section:after{width:340px;height:340px;bottom:-270px;left:-110px;border:1px solid rgba(34,211,238,.13);box-shadow:0 0 0 34px rgba(34,211,238,.025)}
.browse-section>.container{position:relative;z-index:1}
.browse-section .browse-title{color:#f8fcff!important;font-size:clamp(25px,3vw,32px);font-weight:750;letter-spacing:-.035em;margin:0 0 22px!important}
.browse-section .browse-tabs{display:flex;gap:10px;flex-wrap:wrap;margin:0 0 26px!important}
.browse-section .browse-tabs .tab{display:inline-flex;align-items:center;justify-content:center;min-height:39px;padding:9px 19px!important;border-radius:999px!important;background:rgba(255,255,255,.075)!important;border:1px solid rgba(255,255,255,.13)!important;color:#c6d7e5!important;font:600 12px/1.2 var(--ep-font-body)!important;transition:all .2s ease}
.browse-section .browse-tabs .tab:hover{background:rgba(34,211,238,.13)!important;border-color:rgba(34,211,238,.45)!important;color:#fff!important;transform:translateY(-1px)}
.browse-section .browse-tabs .tab.active-tab{background:linear-gradient(135deg,#22d3ee,#06b6d4)!important;border-color:#22d3ee!important;color:#062238!important;font-weight:750!important;box-shadow:0 6px 18px rgba(6,182,212,.25)!important}
.browse-section .tab-content{display:none}.browse-section .tab-content.active-content{display:block;animation:browseTabIn .22s ease both}
@keyframes browseTabIn{from{opacity:0;transform:translateY(5px)}to{opacity:1;transform:translateY(0)}}
.browse-section .browse-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(150px,1fr));gap:14px}
.browse-section .brand-card{box-sizing:border-box;min-width:0;min-height:142px;padding:17px 14px!important;gap:9px;display:flex;flex-direction:column;align-items:center;justify-content:center;background:linear-gradient(145deg,#fff 0%,#f4fafd 100%)!important;border:1px solid #d3e5ef!important;border-radius:16px!important;color:#102a40!important;text-decoration:none!important;text-align:center;box-shadow:0 7px 20px rgba(0,12,28,.12)!important;transition:transform .22s ease,box-shadow .22s ease,border-color .22s ease}
.browse-section .brand-card:hover{background:#fff!important;border-color:#22c7df!important;color:#08243a!important;transform:translateY(-4px);box-shadow:0 14px 28px rgba(0,12,28,.2),0 0 0 3px rgba(34,211,238,.1)!important}
.browse-section .brand-logo{width:100%;height:62px;display:flex;align-items:center;justify-content:center}
.browse-section .brand-logo img{display:block;width:auto;height:auto;max-width:112px;max-height:48px;object-fit:contain;margin:0!important;filter:none!important;opacity:1!important}
.browse-section .brand-name{color:#18364e!important;font:650 13px/1.3 var(--ep-font-body)!important}
.browse-section .brand-card:hover .brand-name{color:#078daa!important}
.browse-section .browse-filter-card{min-height:94px;box-sizing:border-box;display:flex;align-items:center;gap:13px;padding:17px 16px;border-radius:15px;border:1px solid #d3e5ef;background:linear-gradient(145deg,#fff 0%,#f3f9fc 100%);color:#122d43!important;text-decoration:none!important;box-shadow:0 7px 20px rgba(0,12,28,.12);transition:all .22s ease}
.browse-section .browse-filter-card:hover{transform:translateY(-3px);border-color:#22c7df;box-shadow:0 13px 25px rgba(0,12,28,.18);color:#102a40!important}
.browse-section .browse-filter-icon{width:42px;height:42px;flex:0 0 42px;display:grid;place-items:center;border-radius:12px;background:#ddf8fc;color:#078daa;font-size:17px}
.browse-section .browse-filter-copy{display:flex;flex:1;min-width:0;flex-direction:column;gap:5px;text-align:left}
.browse-section .browse-filter-copy strong{font:700 13px/1.25 var(--ep-font-body)!important;color:#102a40!important}
.browse-section .browse-filter-copy small{font:400 10px/1.3 var(--ep-font-body)!important;color:#667d90!important}
.browse-section .browse-filter-arrow{font-size:12px;color:#079bb7;transition:transform .2s ease}
.browse-section .browse-filter-card:hover .browse-filter-arrow{transform:translateX(3px)}
.browse-section .body-card{min-height:130px;box-sizing:border-box;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:10px;padding:20px 14px!important;border-radius:16px!important;background:linear-gradient(145deg,#fff 0%,#f4fafd 100%)!important;border:1px solid #d3e5ef!important;color:#17334b!important;font:650 13px/1.3 var(--ep-font-body)!important;text-decoration:none!important;text-align:center;box-shadow:0 7px 20px rgba(0,12,28,.12)!important;transition:all .22s ease}
.browse-section .body-card:hover{transform:translateY(-4px);border-color:#22c7df!important;color:#078daa!important;box-shadow:0 14px 26px rgba(0,12,28,.18)!important}
.browse-section .body-icon{width:48px;height:48px;margin:0!important;display:grid;place-items:center;border-radius:14px;background:#ddf8fc;color:#078daa;font-size:22px}
.browse-section .body-card:hover .body-icon{background:#c5f4fa;color:#057f9a}
.browse-section .view-more{margin-top:2px;color:#39d9f0!important;font:650 12px/1.3 var(--ep-font-body)!important;text-decoration:none!important}
.browse-section .view-more:hover{color:#a5f3fc!important;text-decoration:underline!important}
@media(max-width:767px){.browse-section{padding:44px 0 50px!important}.browse-section .browse-title{font-size:24px;margin-bottom:18px!important}.browse-section .browse-tabs{gap:7px;margin-bottom:20px!important}.browse-section .browse-tabs .tab{min-height:36px;padding:8px 14px!important;font-size:11px!important}.browse-section .browse-grid{grid-template-columns:repeat(2,minmax(0,1fr));gap:10px}.browse-section .brand-card{min-height:116px;padding:13px 10px!important;border-radius:13px!important}.browse-section .brand-logo{height:49px}.browse-section .brand-logo img{max-width:100px;max-height:40px}.browse-section .brand-name{font-size:11px!important}.browse-section .browse-filter-card{min-height:78px;padding:12px 10px;gap:9px;border-radius:12px}.browse-section .browse-filter-icon{width:35px;height:35px;flex-basis:35px;font-size:14px;border-radius:10px}.browse-section .browse-filter-copy strong{font-size:11px!important}.browse-section .browse-filter-copy small{font-size:9px!important}.browse-section .body-card{min-height:108px;padding:14px 9px!important;font-size:11px!important;border-radius:13px!important}.browse-section .body-icon{width:40px;height:40px;font-size:19px;border-radius:11px}}
@media(max-width:380px){.browse-section .browse-grid{gap:8px}.browse-section .browse-filter-card{gap:7px;padding:10px 8px}.browse-section .browse-filter-copy strong{font-size:10px!important}}
@media(prefers-reduced-motion:reduce){.browse-section *{animation:none!important;transition:none!important}}

</style>

<section class="hero-v4">
 <div class="container">
  <div class="hero-grid">
   <div class="hero-copy">
    <div class="hero-badge-wrapper"><span class="hero-badge"><i class="fa-solid fa-bolt-lightning"></i> NEXT-GEN ELECTRIC MOBILITY</span></div>
    <h1 class="hero-main-title">Ride the Future.<br/><span class="text-gradient">Pure Electric.</span></h1>
    <p class="hero-subtitle">India's most trusted marketplace for Electric Bikes, Scooters &amp; Genuine Spares.</p>
    <div class="hero-actions">
     <a href="Bikes.aspx" class="hero-action hero-action-primary">Explore Bikes <i class="fa-solid fa-arrow-right"></i></a>
     <a href="Compare.aspx" class="hero-action hero-action-secondary"><i class="fa-regular fa-circle-play"></i> Compare Models</a>
    </div>
    <div class="hero-proof-points">
     <div class="hero-proof-item"><i class="fa-solid fa-shield-halved"></i><span>Verified Dealers</span></div>
     <div class="hero-proof-item"><i class="fa-solid fa-bolt"></i><span>100% Electric</span></div>
     <div class="hero-proof-item"><i class="fa-solid fa-scale-balanced"></i><span>Easy Compare</span></div>
    </div>
   </div>
   <div class="hero-media">
    <div class="hero-media-orbit"></div>
    <div class="hero-image-frame">
     <img src="<%= ResolveUrl("~/Uploads/Banner/hero-electric-bike.png") %>" alt="Premium electric motorcycle" fetchpriority="high" decoding="async" />
    </div>
    <div class="hero-info-stack">
     <div class="hero-float-card"><span class="hero-float-icon"><i class="fa-solid fa-leaf"></i></span><span class="hero-float-copy"><strong>100% Electric</strong><span>Zero-emission mobility</span></span></div>
     <div class="hero-float-card"><span class="hero-float-icon"><i class="fa-solid fa-location-dot"></i></span><span class="hero-float-copy"><strong>Verified Dealers</strong><span>Across India</span></span></div>
     <div class="hero-float-card"><span class="hero-float-icon"><i class="fa-solid fa-bolt"></i></span><span class="hero-float-copy"><strong>Wide Selection</strong><span>Bikes, Scooters &amp; More</span></span></div>
    </div>
   </div>
  </div>
  <div class="search-glass-wrapper"><div class="search-glass-inner">
   <div class="search-heading"><i class="fa-solid fa-sliders"></i><strong>Find Your Electric Bike</strong></div>
   <div class="search-divider"></div>
   <div class="search-item"><label><i class="fa-solid fa-wallet"></i>Your Budget</label><asp:DropDownList ID="ddlBudget" runat="server" CssClass="search-select"><asp:ListItem Value="">Select Max Budget</asp:ListItem><asp:ListItem Value="80000">Under ₹80,000</asp:ListItem><asp:ListItem Value="120000">Under ₹1.2 Lakh</asp:ListItem><asp:ListItem Value="180000">Under ₹1.8 Lakh</asp:ListItem><asp:ListItem Value="500000">Premium EVs</asp:ListItem></asp:DropDownList></div>
   <div class="search-divider"></div>
   <div class="search-item"><label><i class="fa-solid fa-tag"></i>Preferred Brand</label><asp:DropDownList ID="ddlBrand" runat="server" CssClass="search-select"></asp:DropDownList></div>
   <div class="search-action"><asp:LinkButton ID="btnSearch" runat="server" CssClass="btn-search-hero" OnClick="btnSearch_Click"><i class="fa-solid fa-magnifying-glass"></i> Search Bikes</asp:LinkButton></div>
  </div></div>
  <div class="hero-stats">
   <div class="hero-stat"><i class="fa-solid fa-users"></i><div><strong>10K+</strong><span>Happy Buyers</span></div></div>
   <div class="hero-stat"><i class="fa-solid fa-store"></i><div><strong>200+</strong><span>Verified Dealers</span></div></div>
   <div class="hero-stat"><i class="fa-solid fa-motorcycle"></i><div><strong>500+</strong><span>Electric Bikes</span></div></div>
   <div class="hero-stat"><i class="fa-solid fa-shield-halved"></i><div><strong>100%</strong><span>Genuine &amp; Trusted</span></div></div>
  </div>
 </div>
</section>


<section class="home-category-section" aria-labelledby="homeCategoryTitle">
 <div class="container">
  <div class="home-category-heading">
   <div><h2 id="homeCategoryTitle">Explore by Category</h2><p>Find the right electric ride for you</p></div>
   <a href="Bikes.aspx" class="view-all-v7">View All <i class="fa-solid fa-arrow-right-long ml-1"></i></a>
  </div>
  <div class="home-category-track">
   <asp:Repeater ID="rptHomeCategories" runat="server"><ItemTemplate>
    <a class="home-category-card" href='Bikes.aspx?category=<%# Eval("CategorySlug") %>' aria-label='<%# Eval("CategoryName") %> - <%# Eval("BikeCount") %> bikes'>
     <span class="home-category-icon"><i class='<%# Eval("CategoryIcon") %>' aria-hidden="true"></i></span>
     <span class="home-category-copy"><span class="home-category-name"><%# Eval("CategoryName") %></span><span class="home-category-count"><%# Eval("BikeCount") %> available rides</span></span>
    </a>
   </ItemTemplate></asp:Repeater>
  </div>
 </div>
</section>

<section class="featured-ev-v7 py-5" style="background-color: #fcfdfe;">
    <div class="container">
        <div class="featured-heading-v8">
            <div>
                <h2 class="section-title-v7">Latest <span>Electric Bikes</span></h2>
                <p class="featured-section-subtitle">Discover newly launched and trending electric bikes.</p>
                <div class="heading-line-v7"></div>
            </div>
            <div class="featured-heading-actions">
                <a href="Bikes.aspx" class="featured-view-all">View All Bikes <i class="fa-solid fa-arrow-right-long"></i></a>
                <div class="slider-nav-wrapper">
                    <button type="button" class="nav-btn-v7 prev-v7" aria-label="Previous bikes"><i class="fa-solid fa-chevron-left"></i></button>
                    <button type="button" class="nav-btn-v7 next-v7" aria-label="Next bikes"><i class="fa-solid fa-chevron-right"></i></button>
                </div>
            </div>
        </div>

        <div class="swiper bikeSliderV7">
            <div class="swiper-wrapper">
                <asp:Repeater ID="rptFeatured" runat="server">
                    <ItemTemplate>
                        <div class="swiper-slide">
                            <article class="compact-card-v7">
                                <a class="featured-bike-image-link" href='BikeDetails.aspx?slug=<%# Eval("Slug") %>' aria-label='View <%# Eval("ModelName") %> details'>
                                    <div class="img-holder-v7">
                                        <img src='<%# GetHomeAssetUrl(Eval("Image1"), "Bikes") %>' alt='<%# Eval("ModelName") %>' loading="lazy" decoding="async" />
                                        <span class="featured-bike-badge">Latest Arrival</span>
                                    </div>
                                </a>
                                <div class="info-holder-v7">
                                    <h3 class="title-v7"><a href='BikeDetails.aspx?slug=<%# Eval("Slug") %>'><%# Eval("ModelName") %></a></h3>
                                    <div class="price-v7">₹<%# Eval("Price", "{0:N0}") %><span class="price-note">*</span></div>
                                    <div class="stats-row-v7">
                                        <span><i class="fa-solid fa-bolt"></i><%# Eval("RangeKM") %> km</span>
                                        <span><i class="fa-solid fa-gauge-high"></i>80 km/h</span>
                                    </div>
                                    <div class="footer-row-v7">
                                        <span class="featured-bike-meta">Electric • Verified listing</span>
                                        <a href='BikeDetails.aspx?slug=<%# Eval("Slug") %>' class="go-btn-v7" aria-label='Explore <%# Eval("ModelName") %>'>
                                            <i class="fa-solid fa-arrow-right"></i>
                                        </a>
                                    </div>
                                </div>
                            </article>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            
            <div class="swiper-pagination v7-pagination mt-4"></div>
        </div>
    </div>
</section>

<!-- BROWSE BIKES BY -->
<section class="browse-section fade-section">
<div class="container">

<h3 class="browse-title">Browse Bikes By</h3>

<div class="browse-tabs">
    <span class="tab active-tab" onclick="showTab(event,'brand')">Brand</span>
    <span class="tab" onclick="showTab(event,'budget')">Budget</span>
    <span class="tab" onclick="showTab(event,'range')">Range</span>
    <span class="tab" onclick="showTab(event,'body')">Body Style</span>
</div>

<!-- BRAND TAB -->
<div id="brandTab" class="tab-content active-content">

    <div class="browse-grid">

        <asp:Repeater ID="rptBrandsTop" runat="server">
        <ItemTemplate>
            <div class="brand-card-wrap">
             <a href='Bikes.aspx?brand=<%# Eval("BrandID") %>' class="brand-card">
    <div class="brand-logo">
        <img src='<%# GetHomeAssetUrl(Eval("LogoPath"), "Brands") %>' loading="lazy"
 />
    </div>
    <div class="brand-name">
        <%# Eval("BrandName") %>
    </div>
</a>

            </div>
        </ItemTemplate>
        </asp:Repeater>

    </div>

    <div id="moreBrands" style="display:none;">
        <div class="browse-grid mt-4">

            <asp:Repeater ID="rptBrandsAll" runat="server">
            <ItemTemplate>
                <div class="brand-card-wrap">
                    <a href='Bikes.aspx?brand=<%# Eval("BrandID") %>' class="brand-card">
                        <div class="brand-logo">
                            <img src='<%# GetHomeAssetUrl(Eval("LogoPath"), "Brands") %>' loading="lazy"
 />
                        </div>
                        <div class="brand-name">
                            <%# Eval("BrandName") %>
                        </div>
                    </a>
                </div>
            </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>

    <div class="text-center mt-4">
        <a href="javascript:void(0);" onclick="toggleBrands()" class="view-more">
            View More Brands
        </a>
    </div>

</div>

<!-- BUDGET -->
<div id="budgetTab" class="tab-content">
    <div class="browse-grid">
        <a href="Bikes.aspx?budget=100000" class="browse-filter-card"><span class="browse-filter-icon"><i class="fa-solid fa-wallet"></i></span><span class="browse-filter-copy"><strong>Under ₹1 Lakh</strong><small>Budget-friendly rides</small></span><i class="fa-solid fa-arrow-right browse-filter-arrow"></i></a>
        <a href="Bikes.aspx?budget=150000" class="browse-filter-card"><span class="browse-filter-icon"><i class="fa-solid fa-indian-rupee-sign"></i></span><span class="browse-filter-copy"><strong>Under ₹1.5 Lakh</strong><small>More choices to explore</small></span><i class="fa-solid fa-arrow-right browse-filter-arrow"></i></a>
        <a href="Bikes.aspx?budget=200000" class="browse-filter-card"><span class="browse-filter-icon"><i class="fa-solid fa-tags"></i></span><span class="browse-filter-copy"><strong>Under ₹2 Lakh</strong><small>Performance and value</small></span><i class="fa-solid fa-arrow-right browse-filter-arrow"></i></a>
        <a href="Bikes.aspx?budget=300000" class="browse-filter-card"><span class="browse-filter-icon"><i class="fa-solid fa-gem"></i></span><span class="browse-filter-copy"><strong>Under ₹3 Lakh</strong><small>Premium electric rides</small></span><i class="fa-solid fa-arrow-right browse-filter-arrow"></i></a>
    </div>
</div>

<!-- RANGE -->
<div id="rangeTab" class="tab-content">
    <div class="browse-grid">
        <a href="Bikes.aspx?range=80" class="browse-filter-card"><span class="browse-filter-icon"><i class="fa-solid fa-bolt"></i></span><span class="browse-filter-copy"><strong>Under 80 KM</strong><small>Everyday city rides</small></span><i class="fa-solid fa-arrow-right browse-filter-arrow"></i></a>
        <a href="Bikes.aspx?range=120" class="browse-filter-card"><span class="browse-filter-icon"><i class="fa-solid fa-route"></i></span><span class="browse-filter-copy"><strong>Under 120 KM</strong><small>Balanced daily range</small></span><i class="fa-solid fa-arrow-right browse-filter-arrow"></i></a>
        <a href="Bikes.aspx?range=200" class="browse-filter-card"><span class="browse-filter-icon"><i class="fa-solid fa-mountain-sun"></i></span><span class="browse-filter-copy"><strong>Under 200 KM</strong><small>Long-distance freedom</small></span><i class="fa-solid fa-arrow-right browse-filter-arrow"></i></a>
    </div>
</div>

<!-- BODY STYLE -->
<div id="bodyTab" class="tab-content">
    <div class="browse-grid">

        <a href="Bikes.aspx?type=Sports" class="body-card">
            <div class="body-icon"><i class="fa-solid fa-motorcycle"></i></div>
            Sports Bike
        </a>

        <a href="Bikes.aspx?type=Scooter" class="body-card">
            <div class="body-icon"><i class="fa-solid fa-motorcycle"></i></div>
            Scooter
        </a>

        <a href="Bikes.aspx?type=Cruiser" class="body-card">
            <div class="body-icon"><i class="fa-solid fa-motorcycle"></i></div>
            Cruiser
        </a>

        <a href="Bikes.aspx?type=Commuter" class="body-card">
            <div class="body-icon"><i class="fa-solid fa-bicycle"></i></div>
            Commuter
        </a>

        <a href="Bikes.aspx?type=Street" class="body-card">
            <div class="body-icon"><i class="fa-solid fa-motorcycle"></i></div>
            Street Bike
        </a>

        <a href="Bikes.aspx?type=Super" class="body-card">
            <div class="body-icon"><i class="fa-solid fa-motorcycle"></i></div>
            Super Bike
        </a>

        <a href="Bikes.aspx?type=Cafe" class="body-card">
            <div class="body-icon"><i class="fa-solid fa-motorcycle"></i></div>
            Cafe Racer
        </a>

        <a href="Bikes.aspx?type=Adventure" class="body-card">
            <div class="body-icon"><i class="fa-solid fa-motorcycle"></i></div>
            Adventure
        </a>

        <a href="Bikes.aspx?type=Moped" class="body-card">
            <div class="body-icon"><i class="fa-solid fa-motorcycle"></i></div>
            Moped
        </a>

        <a href="Bikes.aspx?type=Tourer" class="body-card">
            <div class="body-icon"><i class="fa-solid fa-motorcycle"></i></div>
            Tourer
        </a>

    </div>
</div>


</div>
</section>


    <section class="spare-parts-v9 py-5" style="background: #ffffff;">
    <div class="container">
        <div class="d-flex justify-content-between align-items-end mb-5 px-2">
            <div>
                <span class="text-primary font-weight-bold small text-uppercase" style="letter-spacing: 2px;">Genuine Spares</span>
                <h2 class="font-weight-bold" style="color: #0f172a; font-size: 28px; margin-top: 5px;">Essential Spare Parts</h2>
            </div>
            <a href="Parts.aspx" class="btn-explore-store">
                Explore Store <i class="fa-solid fa-basket-shopping ml-2"></i>
            </a>
        </div>

        <div class="row">
            <asp:Repeater ID="rptSpareParts" runat="server">
                <ItemTemplate>
                    <div class="col-6 col-lg-3 mb-4">
                        <div class="part-card-v9">
                            <div class="part-cat-tag"><%# Eval("Category") %></div>
                            
                            <div class="part-img-v9">
                                <img src='<%# GetHomeAssetUrl(Eval("Image1"), "Parts") %>' alt='<%# Eval("PartName") %>' />
                                <div class="part-overlay-v9">
                                    <a href="Parts.aspx" class="quick-add-btn">
                                        <i class="fa-solid fa-plus"></i>
                                    </a>
                                </div>
                            </div>

                            <div class="part-info-v9">
                                <h3 class="part-title-v9"><%# Eval("PartName") %></h3>
                                <div class="part-price-row-v9">
                                    <div class="part-price-v9">₹<%# Eval("Price", "{0:N0}") %> /-</div>
                                    <span class="stock-status"><i class="fa-solid fa-circle-check mr-1"></i> In Stock</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</section>


    <section class="battery-guide-v10 py-5">
    <div class="container">
        <div class="row align-items-center">

            <div class="col-lg-5 mb-5 mb-lg-0">
                <div class="battery-image-wrapper">
                    <div class="blob-bg"></div>
                    <img src="<%= ResolveUrl("~/Uploads/Banner/maintain.png") %>" class="img-fluid main-battery-img" alt="Battery Maintenance" loading="lazy" />
                    <div class="floating-info-card">
                        <i class="fa-solid fa-heart-pulse text-danger"></i>
                        <span>Longer Battery Life</span>
                    </div>
                </div>
            </div>

            <div class="col-lg-7 pl-lg-5">
                <div class="battery-text-content">
                    <span class="guide-badge">Expert Tips</span>
                    <h2 class="guide-title">
                        How To Maintain Your Electric <br />
                        <span class="text-info">Vehicle's Battery</span>
                    </h2>
                    <p class="guide-intro text-muted mb-4">Follow these simple steps to ensure your EV stays powerful for years to come.</p>

                    <div class="maintenance-steps">
                        
                        <div class="m-step-item">
                            <div class="m-step-icon">
                                <i class="fa-solid fa-sun-plant-wilt"></i>
                            </div>
                            <div class="m-step-text">
                                <h5>Minimise Exposure To Extreme Environment</h5>
                                <p>Avoid parking under the harsh sun or extreme cold. Protecting batteries from extreme temperatures preserves their internal chemistry and lifespan.</p>
                            </div>
                        </div>

                        <div class="m-step-item">
                            <div class="m-step-icon">
                                <i class="fa-solid fa-battery-half"></i>
                            </div>
                            <div class="m-step-text">
                                <h5>Smart Charging Habits</h5>
                                <p>Keep your battery between 20% and 80%. Frequent 100% charging or deep discharging puts unnecessary stress on the battery electrodes.</p>
                            </div>
                        </div>

                        <div class="m-step-item">
                            <div class="m-step-icon">
                                <i class="fa-solid fa-plug-circle-bolt"></i>
                            </div>
                            <div class="m-step-text">
                                <h5>Prefer Conventional Charging</h5>
                                <p>While fast charging is convenient, slow charging puts far less load on the cells, keeping the battery cool and healthy in the long run.</p>
                            </div>
                        </div>

                        <div class="m-step-item">
                            <div class="m-step-icon">
                                <i class="fa-solid fa-gauge-simple-high"></i>
                            </div>
                            <div class="m-step-text">
                                <h5>Avoid Idle Discharging</h5>
                                <p>If you're not riding for days, ensure the battery isn't left empty. Background trickle discharge can damage inactive battery cells.</p>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </div>
</section>


   <section class="why-choose-v11 py-5">
    <div class="container">
        <div class="text-center mb-5">
            <span class="trust-badge"><i class="fa-solid fa-shield-check mr-2"></i>100% Secure & Trusted</span>
            <h2 class="why-title mt-3">Why Choose <span class="text-main">EBikes Duniya?</span></h2>
            <p class="why-subtitle mx-auto">We are redefining the electric mobility experience with transparency, quality, and care.</p>
        </div>

        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="feature-card-v11">
                    <div class="f-icon-box bg-soft-cyan">
                        <i class="fa-solid fa-user-check"></i>
                    </div>
                    <div class="f-content">
                        <h4>Verified Sellers</h4>
                        <p>Every dealer and individual seller on our platform goes through a strict verification process for your peace of mind.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="feature-card-v11 card-active">
                    <div class="f-icon-box bg-main">
                        <i class="fa-solid fa-tags"></i>
                    </div>
                    <div class="f-content">
                        <h4>Best Price Guarantee</h4>
                        <p>Get the most competitive prices on new and pre-owned EVs with transparent breakdowns and no hidden charges.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="feature-card-v11">
                    <div class="f-icon-box bg-soft-purple">
                        <i class="fa-solid fa-gears"></i>
                    </div>
                    <div class="f-content">
                        <h4>Genuine Spare Parts</h4>
                        <p>Access a dedicated store for 100% authentic batteries, motors, and accessories compatible with all major EV brands.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="feature-card-v11">
                    <div class="f-icon-box bg-soft-orange">
                        <i class="fa-solid fa-headset"></i>
                    </div>
                    <div class="f-content">
                        <h4>Expert Support</h4>
                        <p>Our EV experts are available 24/7 to help you choose the right bike based on your range requirements and budget.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="feature-card-v11">
                    <div class="f-icon-box bg-soft-green">
                        <i class="fa-solid fa-code-compare"></i>
                    </div>
                    <div class="f-content">
                        <h4>Easy Comparisons</h4>
                        <p>Compare specs, range, and charging times across multiple brands side-by-side to make an informed decision.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="feature-card-v11">
                    <div class="f-icon-box bg-soft-blue">
                        <i class="fa-solid fa-truck-fast"></i>
                    </div>
                    <div class="f-content">
                        <h4>Quick Delivery</h4>
                        <p>Experience seamless paperwork and lightning-fast delivery of your favorite EV right to your doorstep.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

  <section class="compare-cta-v12 py-5">
    <div class="container">
        <div class="compare-gradient-card">
            <div class="row align-items-center">
                
                <div class="col-lg-7">
                    <div class="cta-text-content p-md-5 p-4">
                        <div class="cta-badge mb-3">
                            <i class="fa-solid fa-code-compare mr-2"></i> Smart Comparison Tool
                        </div>
                        <h2 class="cta-heading text-white">
                            Confused Between <br />
                            <span class="text-highlight">Two EV Bikes?</span>
                        </h2>
                        <p class="cta-desc text-white-50">
                            Don't guess, compare! Analyze specifications, real-world range, charging speed, 
                            and total cost of ownership side-by-side to make a smarter decision.
                        </p>
                        
                        <div class="cta-actions mt-4">
                            <a href="Compare.aspx" class="btn-compare-v12">
                                Start Comparing Now <i class="fa-solid fa-arrow-right-long ml-2"></i>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="col-lg-5 d-none d-lg-block">
                    <div class="compare-visual-wrapper">
                        <div class="vs-circle">VS</div>
                        <div class="bike-placeholder left-bike">
                             <div class="fa-solid fa-3x text-white-50">🛵</div>

                        </div>
                        <div class="bike-placeholder right-bike">
                             <i class="fa-solid fa-motorcycle fa-3x text-white-50"></i>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</section>


    <section class="user-reviews-v14 py-5" style="background: #f8fafc;">
    <div class="container">
        <div class="d-flex justify-content-between align-items-end mb-5 px-2">
            <div>
                <span class="badge badge-soft-primary mb-2">COMMUNITY FEEDBACK</span>
                <h2 class="font-weight-bold text-dark" style="font-size: 30px;">Real Stories from Real Riders</h2>
            </div>
            <div class="d-none d-md-flex gap-2">
                <div class="review-prev-v14 nav-circle"><i class="fa-solid fa-arrow-left"></i></div>
                <div class="review-next-v14 nav-circle"><i class="fa-solid fa-arrow-right"></i></div>
            </div>
        </div>

        <div class="swiper reviewSwiperV14">
            <div class="swiper-wrapper">
                <asp:Repeater ID="rptReviews" runat="server">
                    <ItemTemplate>
                        <div class="swiper-slide">
                            <div class="review-card-v14">
                                <div class="review-user-row">
                                    <div class="user-profile-v14">
                                        <img src='<%# GetHomeAssetUrl(Eval("ProfileImage") == DBNull.Value ? "user.jpg" : Eval("ProfileImage"), "Profile") %>' alt='<%# Eval("FullName") %>' />
                                        <%# (bool)Eval("IsVerified") ? "<div class='verified-check'><i class='fa-solid fa-check'></i></div>" : "" %>
                                    </div>
                                    <div class="user-details-v14">
                                        <h5 class="m-0"><%# Eval("FullName") %></h5>
                                        <span class="review-date"><%# Eval("CreatedAt","{0:dd MMM yyyy}") %></span>
                                    </div>
                                    <div class="stars-v14 ml-auto">
                                        <%# GenerateStars(Convert.ToInt32(Eval("Rating"))) %>
                                    </div>
                                </div>

                                <div class="bike-mentions-v14">
                                    <div class="mention-img">
                                        <img src='<%# GetHomeAssetUrl(Eval("Image1"), "Bikes") %>' alt='bike' />
                                    </div>
                                    <div class="mention-text">
                                        <small>Reviewed on</small>
                                        <h6><%# Eval("ModelName") %></h6>
                                    </div>
                                </div>

                                <div class="review-content-v14">
                                    <p>"<%# Eval("ReviewText").ToString().Length > 120 ? Eval("ReviewText").ToString().Substring(0,120) + "..." : Eval("ReviewText") %>"</p>
                                </div>

                                <div class="review-footer-v14">
                                    <a href='BikeDetails.aspx?slug=<%# Eval("Slug") %>' class="read-full-link">
                                        Read Full Story <i class="fa-solid fa-arrow-right-long ml-1"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div class="swiper-pagination v14-dots d-md-none"></div>
        </div>
    </div>
</section>



    <section class="ultimate-cta-v15 py-5">
    <div class="container">
        <div class="ultimate-card-v15 text-center">
            <div class="glow-circle top-left"></div>
            <div class="glow-circle bottom-right"></div>

            <div class="cta-content-v15 position-relative">
                <span class="cta-sub-badge">JOIN THE REVOLUTION</span>
                <h2 class="cta-main-title">Ready to Switch to <span class="text-cyan">Electric?</span></h2>
                <p class="cta-description mx-auto">
                    Discover verified EV bikes, compare smartly, and connect with 
                    trusted dealers across India. Your green journey starts here.
                </p>

                <div class="cta-button-group">
                    <a href="Bikes.aspx" class="cta-btn-v15 btn-main">
                        <i class="fa-solid fa-bicycle mr-2"></i> Browse All Bikes
                    </a>
                    
                    <a href="SellBike.aspx" class="cta-btn-v15 btn-glass">
                        <i class="fa-solid fa-hand-holding-dollar mr-2"></i> Sell Your Bike
                    </a>
                    
                    <a href="../Vendor/VendorRegister.aspx" class="cta-btn-v15 btn-border">
                        <i class="fa-solid fa-store mr-2"></i> Become a Dealer
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>



<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
  <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script>
    function loadBikeSlider() {
        const swiper = new Swiper(".bikeSliderV7", {
            slidesPerView: 1.2,
            spaceBetween: 15,
            grabCursor: true,
            // Navigation Buttons Fix
            navigation: {
                nextEl: ".next-v7",
                prevEl: ".prev-v7",
            },
            pagination: {
                el: ".v7-pagination",
                clickable: true,
            },
            breakpoints: {
                640: { slidesPerView: 2, spaceBetween: 20 },
                1024: { slidesPerView: 3.5, spaceBetween: 25 }
            }
        });
    }

    // Initialize on load
    document.addEventListener("DOMContentLoaded", loadBikeSlider);

    // UpdatePanel support
    if (typeof Sys !== 'undefined') {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(loadBikeSlider);
    }
</script>

   <script>

       function showTab(evt, tabName) {
           var section = evt.currentTarget.closest(".browse-section");
           if (!section) return;
           section.querySelectorAll(".browse-tabs .tab").forEach(function (tab) { tab.classList.remove("active-tab"); });
           evt.currentTarget.classList.add("active-tab");
           section.querySelectorAll(".tab-content").forEach(function (content) { content.classList.remove("active-content"); });
           var selected = section.querySelector("#" + tabName + "Tab");
           if (selected) selected.classList.add("active-content");
       }

       function toggleBrands() {
           var more = document.getElementById("moreBrands");

           if (more.style.display === "none" || more.style.display === "") {
               more.style.display = "block";
           } else {
               more.style.display = "none";
           }
       }

</script>

    
<script>
    function initReviewSlider() {
        new Swiper(".reviewSwiperV14", {
            slidesPerView: 1.1,
            spaceBetween: 20,
            grabCursor: true,
            navigation: { nextEl: ".review-next-v14", prevEl: ".review-prev-v14" },
            pagination: { el: ".v14-dots", clickable: true },
            breakpoints: {
                768: { slidesPerView: 2, spaceBetween: 25 },
                1024: { slidesPerView: 3, spaceBetween: 30 }
            }
        });
    }

    document.addEventListener("DOMContentLoaded", initReviewSlider);

    // UpdatePanel Support
    if (typeof Sys !== 'undefined') {
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(initReviewSlider);
    }
</script>

</asp:Content>

