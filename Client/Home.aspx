
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
    
/* Reference-matched hero: strong left copy, cinematic bike visual on right */
.hero-v4{position:relative;isolation:isolate;overflow:hidden;padding:48px 0 0!important;background:linear-gradient(90deg,rgba(3,15,29,.96),rgba(5,27,48,.86) 43%,rgba(5,28,48,.44)),url('<%= ResolveUrl("~/Uploads/Banner/banner1.jpg") %>') center/cover no-repeat,#061A2F!important}
.hero-v4:after{content:"";position:absolute;inset:0;z-index:-1;background:radial-gradient(ellipse at 74% 55%,rgba(34,211,238,.25),transparent 35%),linear-gradient(0deg,rgba(34,211,238,.18),transparent 28%)}
.hero-v4 .container{max-width:1440px}
.hero-grid{display:grid;grid-template-columns:.92fr 1.08fr;align-items:center;gap:20px;min-height:390px}
.hero-copy{padding:12px 0 30px;text-align:left}
.hero-main-title{font-size:clamp(42px,5vw,68px);line-height:1.03;letter-spacing:-.055em;color:#F8FAFC}
.hero-subtitle{margin:0!important;color:#D7E5F0!important;max-width:560px;font-size:16px}
.hero-media{position:relative;min-height:370px;display:flex;align-items:center;justify-content:center}
.hero-image-frame{position:relative;width:min(100%,650px);padding:0;border:0;border-radius:0;background:transparent;box-shadow:none;transform:none;filter:drop-shadow(0 25px 24px rgba(0,0,0,.48))}
.hero-image-frame img{width:100%;height:370px;max-height:370px;object-fit:contain;mix-blend-mode:normal;border-radius:0}
.hero-media-orbit{position:absolute;width:min(85%,420px);aspect-ratio:1;border:1px solid rgba(34,211,238,.65);border-radius:50%;box-shadow:0 0 45px rgba(34,211,238,.2),0 0 0 24px rgba(34,211,238,.04)}
.hero-float-card{right:0;top:35px;min-width:175px;background:rgba(7,32,54,.78);border:1px solid rgba(125,211,252,.4)}
.hero-actions{margin-top:24px}
.hero-action-primary{background:#F97316!important;color:#fff!important}
.hero-action-secondary{border:1px solid rgba(226,242,255,.8)!important;background:rgba(5,23,42,.35)!important;color:#fff!important}
.search-glass-wrapper{margin:0!important;position:relative;z-index:4}
.search-glass-inner{max-width:1220px!important;border-radius:20px!important;padding:13px 20px 13px 26px!important;box-shadow:0 22px 52px rgba(7,26,47,.25)!important;gap:14px}
.btn-search-hero{background:#22D3EE!important;color:#071A2F!important;min-height:48px}
.hero-stats{max-width:1100px;margin:18px auto 0!important;background:#fff!important;border:1px solid #E2EAF1!important;border-radius:16px 16px 0 0!important;box-shadow:0 8px 24px rgba(7,26,47,.08)}
.hero-stat strong{color:#071A2F!important}.hero-stat span{color:#456078!important}.hero-stat i{color:#0891B2!important}
@media(max-width:991px){.hero-grid{grid-template-columns:1fr;gap:0}.hero-copy{text-align:center;padding:18px 0 8px}.hero-subtitle{margin:0 auto!important}.hero-actions,.hero-proof-points{justify-content:center}.hero-media{min-height:280px}.hero-image-frame img{height:285px}.hero-float-card{right:5%;top:15px}.hero-stats{grid-template-columns:repeat(2,1fr)}}
@media(max-width:575px){.hero-v4{padding:28px 0 0!important}.hero-main-title{font-size:clamp(37px,10vw,48px)}.hero-media{min-height:220px}.hero-image-frame img{height:220px}.hero-float-card{top:5px;right:0;min-width:126px;padding:9px}.hero-stats{margin:12px 8px 0!important}}
/* Make image slots show useful fallback artwork instead of broken-image icons */
.img-holder-v7 img,.brand-logo img,.part-img-v9 img,.mention-img img{max-width:100%;max-height:100%;object-fit:contain}
.footer-wordmark{font-size:clamp(78px,15vw,210px)!important;letter-spacing:-.075em!important;white-space:nowrap;line-height:.9;transform:none!important}

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
    <div class="hero-image-frame"><img src="<%= ResolveUrl("~/Uploads/Bikes/Ather450X.jpg") %>" alt="Ather electric scooter" fetchpriority="high" onerror="this.onerror=null;this.src='<%= ResolveUrl("~/Uploads/Bikes/Rizta.jpg") %>';" /></div>
    <div class="hero-float-card"><strong><i class="fa-solid fa-leaf"></i> 100% Electric</strong><span>Zero-emission mobility</span></div>
   </div>
  </div>
  <div class="search-glass-wrapper"><div class="search-glass-inner">
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

<section class="featured-ev-v7 py-5" style="background-color: #fcfdfe;">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center mb-5 px-2">
            <div>
                <h2 class="section-title-v7">Featured Rides</h2>
                <div class="heading-line-v7"></div>
            </div>
            
            <div class="slider-nav-wrapper d-none d-md-flex">
                <div class="nav-btn-v7 prev-v7"><i class="fa-solid fa-chevron-left"></i></div>
                <div class="nav-btn-v7 next-v7"><i class="fa-solid fa-chevron-right"></i></div>
            </div>
            
            <a href="Bikes.aspx" class="view-all-v7 d-md-none">View All</a>
        </div>

        <div class="swiper bikeSliderV7">
            <div class="swiper-wrapper">
                <asp:Repeater ID="rptFeatured" runat="server">
                    <ItemTemplate>
                        <div class="swiper-slide">
                            <div class="compact-card-v7">
                                <div class="img-holder-v7">
                                    <img src='<%# GetHomeAssetUrl(Eval("Image1"), "Bikes") %>' alt='<%# Eval("ModelName") %>' />
                                </div>
                                <div class="info-holder-v7">
                                    <h3 class="title-v7"><%# Eval("ModelName") %></h3>
                                    <div class="stats-row-v7">
                                        <span><i class="fa-solid fa-bolt mr-1"></i><%# Eval("RangeKM") %> km</span>
                                        <span><i class="fa-solid fa-gauge-high mr-1"></i>80 km/h</span>
                                    </div>
                                    <div class="footer-row-v7">
                                        <div class="price-v7">₹<%# Eval("Price", "{0:N0}") %> /-</div>
                                        <a href='BikeDetails.aspx?slug=<%# Eval("Slug") %>' class="go-btn-v7">
                                            <i class="fa-solid fa-arrow-right"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
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
            <div class="brand-card">
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
                <div class="brand-card">
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
        <a href="Bikes.aspx?budget=100000" class="brand-card">Under ₹1 Lakh</a>
        <a href="Bikes.aspx?budget=150000" class="brand-card">Under ₹1.5 Lakh</a>
        <a href="Bikes.aspx?budget=200000" class="brand-card">Under ₹2 Lakh</a>
        <a href="Bikes.aspx?budget=300000" class="brand-card">Under ₹3 Lakh</a>
    </div>
</div>

<!-- RANGE -->
<div id="rangeTab" class="tab-content">
    <div class="browse-grid">
        <a href="Bikes.aspx?range=80" class="brand-card">Under 80 KM</a>
        <a href="Bikes.aspx?range=120" class="brand-card">Under 120 KM</a>
        <a href="Bikes.aspx?range=200" class="brand-card">Under 200 KM</a>
    </div>
</div>

<!-- BODY STYLE -->
<div id="bodyTab" class="tab-content">
    <div class="browse-grid">

        <a href="Bikes.aspx?type=Sports" class="body-card">
            <div class="body-icon">🏍</div>
            Sports Bike
        </a>

        <a href="Bikes.aspx?type=Scooter" class="body-card">
            <div class="body-icon">🛵</div>
            Scooter
        </a>

        <a href="Bikes.aspx?type=Cruiser" class="body-card">
            <div class="body-icon">🏍</div>
            Cruiser
        </a>

        <a href="Bikes.aspx?type=Commuter" class="body-card">
            <div class="body-icon">🚲</div>
            Commuter
        </a>

        <a href="Bikes.aspx?type=Street" class="body-card">
            <div class="body-icon">🏍</div>
            Street Bike
        </a>

        <a href="Bikes.aspx?type=Super" class="body-card">
            <div class="body-icon">🏍</div>
            Super Bike
        </a>

        <a href="Bikes.aspx?type=Cafe" class="body-card">
            <div class="body-icon">🏍</div>
            Cafe Racer
        </a>

        <a href="Bikes.aspx?type=Adventure" class="body-card">
            <div class="body-icon">🏍</div>
            Adventure
        </a>

        <a href="Bikes.aspx?type=Moped" class="body-card">
            <div class="body-icon">🛵</div>
            Moped
        </a>

        <a href="Bikes.aspx?type=Tourer" class="body-card">
            <div class="body-icon">🏍</div>
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

           // remove active class from all tabs
           document.querySelectorAll(".tab").forEach(t =>
               t.classList.remove("active-tab"));

           // activate clicked tab
           evt.currentTarget.classList.add("active-tab");

           // hide all content
           document.querySelectorAll(".tab-content").forEach(c =>
               c.classList.remove("active-content"));

           // show selected tab
           document.getElementById(tabName + "Tab")
               .classList.add("active-content");
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

