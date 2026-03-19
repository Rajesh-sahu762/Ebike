
<%@ OutputCache Duration="120" VaryByParam="none" %>


<%@ Page Title="Home" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="Home.aspx.cs"
    Inherits="Client_Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <style>
    /* Premium Hero CSS */
    .hero-v4 {
        background: radial-gradient(circle at 80% 20%, rgba(6, 182, 212, 0.15) 0%, transparent 40%),
                    radial-gradient(circle at 20% 80%, rgba(59, 130, 246, 0.1) 0%, transparent 40%);
        padding: 60px 0 100px;
        position: relative;
    }

    .hero-badge {
        background: rgba(6, 182, 212, 0.1);
        color: #0891b2;
        padding: 10px 20px;
        border-radius: 100px;
        font-weight: 700;
        font-size: 14px;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .hero-main-title {
        font-size: clamp(40px, 6vw, 75px);
        font-weight: 800;
        color: #0f172a;
        line-height: 1.1;
        letter-spacing: -2px;
    }

    .text-gradient {
        background: linear-gradient(90deg, #06b6d4, #3b82f6);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .hero-subtitle {
        font-size: 1.1rem;
        color: #64748b;
        max-width: 600px;
        margin-top: 20px;
        line-height: 1.6;
    }

    /* Search Glass Design */
    .search-glass-wrapper {
        margin-top: 50px;
        padding: 0 15px;
    }

    .search-glass-inner {
        background: rgba(255, 255, 255, 0.8);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.5);
        border-radius: 35px;
        padding: 15px 40px;
        display: flex;
        align-items: center;
        max-width: 950px;
        margin: 0 auto;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1);
    }

    .search-item {
        flex: 1;
        text-align: left;
        padding: 10px 0;
    }

    .search-item label {
        display: block;
        font-size: 12px;
        font-weight: 800;
        color: #94a3b8;
        text-transform: uppercase;
        margin-bottom: 5px;
        margin-left: 5px;
    }

    .search-select {
        border: none;
        background: transparent;
        width: 100%;
        font-size: 16px;
        font-weight: 700;
        color: #1e293b;
        outline: none;
        cursor: pointer;
    }

    .search-divider {
        width: 1px;
        height: 40px;
        background: #e2e8f0;
        margin: 0 30px;
    }

    .btn-search-hero {
        background: #0f172a;
        color: white;
        padding: 18px 45px;
        border-radius: 25px;
        font-weight: 700;
        text-decoration: none !important;
        transition: 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        display: inline-block;
    }

    .btn-search-hero:hover {
        background: #06b6d4;
        color: white;
        transform: scale(1.05) translateY(-3px);
        box-shadow: 0 15px 30px rgba(6, 182, 212, 0.3);
    }

    @media (max-width: 991px) {
        .search-glass-inner {
            flex-direction: column;
            border-radius: 30px;
            padding: 30px;
        }
        .search-divider { display: none; }
        .search-item { width: 100%; margin-bottom: 20px; }
        .btn-search-hero { width: 100%; text-align: center; }
    }

   /* Section & Heading */
    .section-title-v7 { font-weight: 800; color: #0f172a; font-size: 28px; margin: 0; }
    .heading-line-v7 { width: 40px; height: 4px; background: #06b6d4; margin-top: 6px; border-radius: 10px; }

    /* Navigation Buttons Styling */
    .slider-nav-wrapper { gap: 10px; display: flex; align-items: center; }
    .nav-btn-v7 {
        width: 44px; height: 44px; background: #fff; border: 1.5px solid #e2e8f0;
        border-radius: 12px; display: flex; align-items: center; justify-content: center;
        cursor: pointer; color: #0f172a; transition: 0.3s; z-index: 10;
    }
    .nav-btn-v7:hover { background: #06b6d4; color: #fff; border-color: #06b6d4; transform: translateY(-2px); }
    .nav-btn-v7.swiper-button-disabled { opacity: 0.4; cursor: not-allowed; }

    /* Compact Card UI */
    .compact-card-v7 {
        background: #fff; border: 1px solid #f1f5f9; border-radius: 28px;
        overflow: hidden; transition: 0.3s; margin: 10px 5px; height: 100%;
    }
    .compact-card-v7:hover { border-color: #06b6d4; box-shadow: 0 20px 30px -10px rgba(0,0,0,0.05); }

    .img-holder-v7 { height: 170px; background: #f8fafc; display: flex; align-items: center; justify-content: center; padding: 20px; }
    .img-holder-v7 img { max-width: 100%; max-height: 100%; object-fit: contain; }

    .info-holder-v7 { padding: 20px; }
    .title-v7 { font-size: 19px; font-weight: 700; color: #1e293b; margin-bottom: 8px; }
    
    .stats-row-v7 { display: flex; gap: 10px; margin-bottom: 15px; }
    .stats-row-v7 span { font-size: 11px; color: #64748b; font-weight: 700; background: #f1f5f9; padding: 4px 10px; border-radius: 8px; }

    .footer-row-v7 { display: flex; justify-content: space-between; align-items: center; padding-top: 15px; border-top: 1px solid #f8fafc; }
    .price-v7 { font-size: 20px; font-weight: 800; color: #0f172a; }

    .go-btn-v7 { 
        width: 40px; height: 40px; background: #0f172a; color: #fff; 
        border-radius: 12px; display: flex; align-items: center; justify-content: center; 
        transition: 0.3s; text-decoration: none !important;
    }
    .go-btn-v7:hover { background: #06b6d4; transform: scale(1.1); }

    .view-all-v7 { font-weight: 700; color: #06b6d4; font-size: 14px; text-decoration: none; }

    /* Swiper Dots */
    .v7-pagination .swiper-pagination-bullet-active { background: #06b6d4 !important; width: 22px !important; border-radius: 4px !important; }

    /* ===== BROWSE SECTION PREMIUM ===== */

.browse-section {
    background: #0b1120;
    padding: 90px 0;
    color: #f1f5f9;
}

.browse-title {
    font-size: 30px;
    font-weight: 600;
    margin-bottom: 30px;
}

.browse-tabs {
    margin-bottom: 35px;
}

.browse-tabs .tab {
    margin-right: 30px;
    cursor: pointer;
    font-weight: 500;
    color: #94a3b8;
    transition: 0.3s;
}

.browse-tabs .tab:hover {
    color: #06b6d4;
}

.browse-tabs .active-tab {
    color: #06b6d4;
    border-bottom: 2px solid #06b6d4;
    padding-bottom: 6px;
}

.tab-content {
    display: none;
}

.active-content {
    display: block;
}

/* GRID */
.browse-grid {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 25px;
}

/* BRAND CARD */
.brand-card {
    background: #111827;
    border-radius: 16px;
    padding: 30px 20px;
    text-align: center;
    border: 1px solid #1f2937;
    transition: 0.3s;
    text-decoration: none;
    color: #e5e7eb;
}

.brand-card:hover {
    border-color: #06b6d4;
    transform: translateY(-6px);
    box-shadow: 0 10px 25px rgba(6,182,212,0.2);
}

.brand-logo img {
    height: 50px;
    object-fit: contain;
    margin-bottom: 15px;
}

.brand-name {
    font-weight: 500;
    font-size: 15px;
}

/* BODY STYLE SPECIAL */
.body-card {
    background: #111827;
    border-radius: 16px;
    padding: 35px 20px;
    text-align: center;
    border: 1px solid #1f2937;
    transition: 0.3s;
    text-decoration: none;
    color: #f8fafc;
}

.body-card:hover {
    border-color: #06b6d4;
    transform: translateY(-6px);
    box-shadow: 0 10px 25px rgba(6,182,212,0.2);
}

.body-icon {
    font-size: 40px;
    margin-bottom: 12px;
}

.view-more {
    color: #06b6d4;
    text-decoration: none;
    font-weight: 500;
}


.brand-card {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;

    background: #111827;
    border-radius: 18px;
    padding: 35px 20px;
    text-align: center;
    border: 1px solid #1f2937;
    transition: 0.3s ease;
    text-decoration: none;
    color: #f8fafc;
    position: relative;
    overflow: hidden;
}

.brand-card:hover {
    border-color: #06b6d4;
    box-shadow: 0 0 25px rgba(6,182,212,0.25);
    transform: translateY(-6px);
}

.brand-logo img {
    height: 50px;
    object-fit: contain;
    margin-bottom: 15px;
}

.brand-name {
    font-weight: 500;
    font-size: 15px;
    letter-spacing: 0.5px;
}


  /* Section Styles */
    .btn-explore-store {
        background: #0f172a;
        color: #fff;
        padding: 10px 22px;
        border-radius: 14px;
        font-weight: 700;
        font-size: 14px;
        transition: 0.3s;
        text-decoration: none !important;
    }
    .btn-explore-store:hover { background: #06b6d4; transform: translateY(-3px); box-shadow: 0 10px 20px rgba(6, 182, 212, 0.2); }

    /* Part Card Premium UI */
    .part-card-v9 {
        background: #fff;
        border: 1px solid #f1f5f9;
        border-radius: 24px;
        overflow: hidden;
        transition: 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        height: 100%;
        position: relative;
    }

    .part-card-v9:hover {
        border-color: #06b6d4;
        box-shadow: 0 25px 50px -15px rgba(0,0,0,0.08);
        transform: translateY(-8px);
    }

    .part-cat-tag {
        position: absolute;
        top: 15px;
        left: 15px;
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(5px);
        padding: 4px 12px;
        border-radius: 8px;
        font-size: 10px;
        font-weight: 800;
        color: #64748b;
        z-index: 2;
        border: 1px solid #f1f5f9;
    }

    .part-img-v9 {
        height: 180px;
        background: #f8fafc;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 25px;
        position: relative;
        overflow: hidden;
    }

    .part-img-v9 img {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
        transition: 0.5s;
    }

    .part-overlay-v9 {
        position: absolute;
        top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(6, 182, 212, 0.1);
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0;
        transition: 0.3s;
    }

    .part-card-v9:hover .part-overlay-v9 { opacity: 1; }
    .part-card-v9:hover .part-img-v9 img { transform: scale(1.1); }

    .quick-add-btn {
        width: 45px; height: 45px; background: #fff; color: #0f172a;
        border-radius: 50%; display: flex; align-items: center; justify-content: center;
        box-shadow: 0 10px 20px rgba(0,0,0,0.1); text-decoration: none !important;
        transition: 0.3s;
    }
    .quick-add-btn:hover { background: #0f172a; color: #fff; transform: scale(1.1); }

    .part-info-v9 { padding: 20px; }
    .part-title-v9 { font-size: 16px; font-weight: 700; color: #1e293b; margin-bottom: 12px; height: 40px; overflow: hidden; }
    
    .part-price-row-v9 { display: flex; justify-content: space-between; align-items: center; }
    .part-price-v9 { font-size: 19px; font-weight: 800; color: #06b6d4; }
    .stock-status { font-size: 10px; color: #22c55e; font-weight: 700; text-transform: uppercase; }

    /* Mobile Responsive */
    @media (max-width: 768px) {
        .part-img-v9 { height: 140px; padding: 15px; }
        .part-title-v9 { font-size: 14px; }
        .part-price-v9 { font-size: 16px; }
    }


     .battery-guide-v10 { background: #fcfdfe; overflow: hidden; }

    /* Left Side: Image & Animation */
    .battery-image-wrapper { position: relative; display: flex; align-items: center; justify-content: center; }
    
    .blob-bg {
        position: absolute; width: 100%; height: 100%;
        background: radial-gradient(circle, rgba(6, 182, 212, 0.1) 0%, transparent 70%);
        z-index: 1; transform: scale(1.2);
    }

    .main-battery-img { 
        position: relative; z-index: 2; 
        filter: drop-shadow(0 20px 30px rgba(0,0,0,0.1));
        animation: floatImg 4s ease-in-out infinite;
    }

    @keyframes floatImg {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-15px); }
    }

    .floating-info-card {
        position: absolute; bottom: 20px; right: 0;
        background: #fff; padding: 12px 20px; border-radius: 18px;
        box-shadow: 0 15px 30px rgba(0,0,0,0.08);
        display: flex; align-items: center; gap: 10px; z-index: 3;
        border: 1px solid #f1f5f9;
    }
    .floating-info-card span { font-weight: 800; font-size: 13px; color: #1e293b; }

    /* Right Side: Typography */
    .guide-badge { 
        background: #06b6d4; color: #fff; padding: 5px 15px; 
        border-radius: 30px; font-size: 11px; font-weight: 800; 
        text-transform: uppercase; letter-spacing: 1px;
    }

    .guide-title { font-size: 34px; font-weight: 800; color: #0f172a; margin: 15px 0; line-height: 1.2; }
    
    /* Maintenance List UI */
    .maintenance-steps { margin-top: 35px; }
    
    .m-step-item { 
        display: flex; gap: 20px; margin-bottom: 30px; 
        transition: 0.3s; padding: 15px; border-radius: 20px;
    }
    .m-step-item:hover { background: #fff; box-shadow: 0 10px 25px rgba(0,0,0,0.04); }

    .m-step-icon { 
        flex-shrink: 0; width: 55px; height: 55px; 
        background: #f1f5f9; border-radius: 16px; 
        display: flex; align-items: center; justify-content: center;
        font-size: 22px; color: #06b6d4; transition: 0.3s;
    }
    .m-step-item:hover .m-step-icon { background: #06b6d4; color: #fff; transform: scale(1.1) rotate(-5deg); }

    .m-step-text h5 { font-size: 17px; font-weight: 700; color: #1e293b; margin-bottom: 8px; }
    .m-step-text p { font-size: 14px; color: #64748b; line-height: 1.6; margin: 0; }

    /* Mobile Responsive */
    @media (max-width: 768px) {
        .guide-title { font-size: 26px; }
        .m-step-item { flex-direction: column; gap: 15px; }
        .m-step-icon { width: 45px; height: 45px; font-size: 18px; }
    }

      :root { --main-color: #06b6d4; --dark-slate: #0f172a; }

    .why-choose-v11 { background: linear-gradient(to bottom, #fff, #f8fafc); padding: 80px 0; }
    
    .trust-badge { 
        background: rgba(6, 182, 212, 0.1); color: var(--main-color); 
        padding: 8px 20px; border-radius: 50px; font-size: 13px; font-weight: 800;
        text-transform: uppercase; letter-spacing: 1px;
    }

    .why-title { font-size: 36px; font-weight: 800; color: var(--dark-slate); }
    .text-main { color: var(--main-color); }
    .why-subtitle { max-width: 600px; color: #64748b; font-size: 16px; margin-top: 15px; }

    /* Feature Cards UI */
    .feature-card-v11 {
        background: #ffffff;
        padding: 40px 30px;
        border-radius: 30px;
        border: 1px solid #f1f5f9;
        height: 100%;
        transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        position: relative;
        overflow: hidden;
    }

    .feature-card-v11:hover {
        transform: translateY(-12px);
        box-shadow: 0 30px 60px -15px rgba(15, 23, 42, 0.1);
        border-color: var(--main-color);
    }

    /* Active Card Highlight */
    .card-active { border-color: rgba(6, 182, 212, 0.3); background: #fcfdfe; }

    /* Icon Box Styles */
    .f-icon-box {
        width: 65px; height: 65px; border-radius: 20px;
        display: flex; align-items: center; justify-content: center;
        font-size: 26px; margin-bottom: 25px; transition: 0.4s;
    }

    .bg-soft-cyan { background: #ecfeff; color: #0891b2; }
    .bg-main { background: var(--main-color); color: #fff; }
    .bg-soft-purple { background: #faf5ff; color: #9333ea; }
    .bg-soft-orange { background: #fff7ed; color: #ea580c; }
    .bg-soft-green { background: #f0fdf4; color: #16a34a; }
    .bg-soft-blue { background: #eff6ff; color: #2563eb; }

    .feature-card-v11:hover .f-icon-box {
        transform: scale(1.1) rotate(10deg);
        border-radius: 50%;
    }

    .f-content h4 { font-size: 20px; font-weight: 700; color: var(--dark-slate); margin-bottom: 15px; }
    .f-content p { font-size: 14px; color: #64748b; line-height: 1.6; margin: 0; }

    /* Responsive */
    @media (max-width: 768px) {
        .why-title { font-size: 28px; }
        .feature-card-v11 { padding: 30px 20px; }
    }


        .compare-cta-v12 { background-color: #fff; }

    .compare-gradient-card {
        background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
        border-radius: 40px;
        overflow: hidden;
        position: relative;
        box-shadow: 0 30px 60px -15px rgba(15, 23, 42, 0.3);
    }

    /* Background Glow Effects */
    .compare-gradient-card::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -10%;
        width: 400px;
        height: 400px;
        background: radial-gradient(circle, rgba(6, 182, 212, 0.2) 0%, transparent 70%);
        z-index: 1;
    }

    .cta-badge {
        display: inline-block;
        background: rgba(255, 255, 255, 0.1);
        color: #06b6d4;
        padding: 6px 16px;
        border-radius: 100px;
        font-size: 12px;
        font-weight: 800;
        text-transform: uppercase;
        letter-spacing: 1px;
        border: 1px solid rgba(255, 255, 255, 0.1);
    }

    .cta-heading { font-size: clamp(28px, 4vw, 42px); font-weight: 800; line-height: 1.2; }
    .text-highlight { color: #06b6d4; }
    .cta-desc { font-size: 16px; line-height: 1.7; max-width: 500px; }

    /* Button Styling */
    .btn-compare-v12 {
        background: #06b6d4;
        color: #fff;
        padding: 16px 35px;
        border-radius: 18px;
        font-weight: 700;
        display: inline-block;
        text-decoration: none !important;
        transition: all 0.4s ease;
        box-shadow: 0 10px 20px rgba(6, 182, 212, 0.3);
    }

    .btn-compare-v12:hover {
        background: #fff;
        color: #0f172a;
        transform: translateY(-5px);
        box-shadow: 0 15px 30px rgba(255, 255, 255, 0.2);
    }

    /* Visual Element Styling */
    .compare-visual-wrapper {
        position: relative;
        height: 300px;
        display: flex;
        align-items: center;
        justify-content: center;
        padding-right: 50px;
    }

    .vs-circle {
        width: 70px; height: 70px;
        background: rgba(255, 255, 255, 0.05);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        color: #06b6d4; font-weight: 900; font-size: 24px;
        z-index: 5;
    }

    .bike-placeholder {
        position: absolute;
        width: 140px; height: 140px;
        background: rgba(255, 255, 255, 0.03);
        border-radius: 30px;
        display: flex; align-items: center; justify-content: center;
        border: 1px solid rgba(255, 255, 255, 0.1);
        transition: 0.5s;
    }

    .left-bike { left: 10%; transform: rotate(-10deg); }
    .right-bike { right: 15%; transform: rotate(10deg); }

    .compare-gradient-card:hover .left-bike { transform: rotate(0deg) translateX(-10px); background: rgba(6, 182, 212, 0.1); }
    .compare-gradient-card:hover .right-bike { transform: rotate(0deg) translateX(10px); background: rgba(6, 182, 212, 0.1); }

    /* Mobile Responsive */
    @media (max-width: 991px) {
        .compare-gradient-card { border-radius: 30px; text-align: center; }
        .cta-desc { margin: 0 auto; }
        .btn-compare-v12 { width: 100%; }
    }

        .badge-soft-primary { background: rgba(6, 182, 212, 0.1); color: #06b6d4; font-weight: 800; padding: 6px 14px; border-radius: 8px; font-size: 11px; }

    /* Nav Buttons */
    .nav-circle { width: 45px; height: 45px; background: #fff; border: 1.5px solid #f1f5f9; border-radius: 50%; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: 0.3s; margin-left: 10px; }
    .nav-circle:hover { background: #0f172a; color: #fff; border-color: #0f172a; }

    /* Card Design */
    .review-card-v14 { 
        background: #fff; border-radius: 30px; border: 1px solid #f1f5f9; 
        padding: 30px; transition: 0.4s; height: 100%; display: flex; flex-direction: column;
    }
    .review-card-v14:hover { transform: translateY(-10px); box-shadow: 0 30px 60px -15px rgba(0,0,0,0.1); border-color: #06b6d4; }

    /* User Row */
    .review-user-row { display: flex; align-items: center; gap: 15px; margin-bottom: 25px; }
    .user-profile-v14 { position: relative; width: 55px; height: 55px; }
    .user-profile-v14 img { width: 100%; height: 100%; border-radius: 50%; object-fit: cover; border: 2px solid #f1f5f9; }
    .verified-check { position: absolute; bottom: 0; right: 0; background: #22c55e; color: #fff; font-size: 8px; width: 18px; height: 18px; border-radius: 50%; display: flex; align-items: center; justify-content: center; border: 2px solid #fff; }
    
    .user-details-v14 h5 { font-size: 16px; font-weight: 700; color: #1e293b; }
    .review-date { font-size: 12px; color: #94a3b8; font-weight: 600; }
    .stars-v14 { color: #fbbf24; font-size: 11px; }

    /* Bike Mention Box */
    .bike-mentions-v14 { 
        background: #f8fafc; border-radius: 20px; padding: 12px 18px; 
        display: flex; align-items: center; gap: 12px; margin-bottom: 20px;
    }
    .mention-img { width: 45px; height: 45px; background: #fff; border-radius: 12px; padding: 5px; }
    .mention-img img { width: 100%; height: 100%; object-fit: contain; }
    .mention-text small { font-size: 10px; color: #94a3b8; font-weight: 700; text-transform: uppercase; }
    .mention-text h6 { font-size: 13px; font-weight: 700; color: #1e293b; margin: 0; }

    /* Content */
    .review-content-v14 p { font-size: 14px; color: #475569; line-height: 1.6; font-style: italic; margin-bottom: 20px; }
    
    .review-footer-v14 { margin-top: auto; }
    .read-full-link { font-size: 13px; font-weight: 800; color: #06b6d4; text-decoration: none !important; transition: 0.3s; }
    .read-full-link:hover { color: #0f172a; letter-spacing: 0.5px; }

    /* Pagination */
    .v14-dots .swiper-pagination-bullet-active { background: #06b6d4 !important; width: 25px !important; border-radius: 4px !important; }


        .ultimate-cta-v15 { background: #fff; padding: 60px 0; overflow: hidden; }

    /* Main Card UI */
    .ultimate-card-v15 {
        background: #0f172a;
        border-radius: 50px;
        padding: 80px 40px;
        position: relative;
        overflow: hidden;
        box-shadow: 0 40px 80px -20px rgba(15, 23, 42, 0.4);
    }

    /* Glow Effects */
    .glow-circle {
        position: absolute;
        width: 300px;
        height: 300px;
        background: radial-gradient(circle, rgba(6, 182, 212, 0.15) 0%, transparent 70%);
        border-radius: 50%;
        z-index: 1;
    }
    .top-left { top: -100px; left: -100px; }
    .bottom-right { bottom: -100px; right: -100px; }

    /* Typography */
    .cta-sub-badge {
        color: #06b6d4;
        font-weight: 800;
        font-size: 12px;
        letter-spacing: 2px;
        display: block;
        margin-bottom: 20px;
    }

    .cta-main-title {
        font-size: clamp(32px, 5vw, 48px);
        font-weight: 900;
        color: #fff;
        line-height: 1.1;
        margin-bottom: 25px;
    }
    .text-cyan { color: #06b6d4; }

    .cta-description {
        font-size: 18px;
        color: #94a3b8;
        max-width: 650px;
        line-height: 1.6;
        margin-bottom: 45px;
    }

    /* Button Group Styles */
    .cta-button-group {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 20px;
        position: relative;
        z-index: 2;
    }

    .cta-btn-v15 {
        padding: 16px 32px;
        border-radius: 20px;
        font-weight: 700;
        font-size: 15px;
        text-decoration: none !important;
        transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        display: flex;
        align-items: center;
        justify-content: center;
    }

    /* Button Variants */
    .btn-main {
        background: #06b6d4;
        color: #fff;
        box-shadow: 0 10px 25px rgba(6, 182, 212, 0.3);
    }
    .btn-main:hover {
        background: #fff;
        color: #0f172a;
        transform: translateY(-5px) scale(1.05);
    }

    .btn-glass {
        background: rgba(255, 255, 255, 0.05);
        color: #fff;
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.1);
    }
    .btn-glass:hover {
        background: rgba(255, 255, 255, 0.1);
        transform: translateY(-5px);
    }

    .btn-border {
        background: transparent;
        color: #fff;
        border: 1.5px solid #06b6d4;
    }
    .btn-border:hover {
        background: #06b6d4;
        transform: translateY(-5px);
    }

    /* Mobile Fixes */
    @media (max-width: 768px) {
        .ultimate-card-v15 { padding: 50px 25px; border-radius: 30px; }
        .cta-btn-v15 { width: 100%; }
        .cta-button-group { flex-direction: column; }
    }


</style>

<section class="hero-v4">
    <div class="container">
        <div class="row align-items-center min-vh-75">
            <div class="col-lg-12 text-center mt-5">
                <div class="hero-badge-wrapper mb-4">
                    <span class="hero-badge">
                        <i class="fa-solid fa-bolt-lightning mr-2"></i>
                        Next-Gen Electric Mobility
                    </span>
                </div>
                
                <h1 class="hero-main-title">
                    Ride the Future. <br />
                    <span class="text-gradient">Pure Electric.</span>
                </h1>
                
                <p class="hero-subtitle mx-auto">
                    India's most trusted marketplace for Electric Bikes, Scooters & Genuine Spares.
                </p>

                <div class="search-glass-wrapper">
                    <div class="search-glass-inner">
                        <div class="search-item">
                            <label><i class="fa-solid fa-wallet text-info mr-2"></i>Your Budget</label>
                            <asp:DropDownList ID="ddlBudget" runat="server" CssClass="search-select">
                                <asp:ListItem Value="">Select Max Budget</asp:ListItem>
                                <asp:ListItem Value="80000">Under ₹80,000</asp:ListItem>
                                <asp:ListItem Value="120000">Under ₹1.2 Lakh</asp:ListItem>
                                <asp:ListItem Value="180000">Under ₹1.8 Lakh</asp:ListItem>
                                <asp:ListItem Value="500000">Premium EVs</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="search-divider"></div>

                        <div class="search-item">
                            <label><i class="fa-solid fa-charging-station text-info mr-2"></i>Preferred Brand</label>
                            <asp:DropDownList ID="ddlBrand" runat="server" CssClass="search-select"></asp:DropDownList>
                        </div>

                        <div class="search-action">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn-search-hero" OnClick="btnSearch_Click">
                                <i class="fa-solid fa-magnifying-glass mr-2"></i> Explore
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
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
                                    <img src='/Uploads/Bikes/<%# Eval("Image1") %>' alt='<%# Eval("ModelName") %>' />
                                </div>
                                <div class="info-holder-v7">
                                    <h3 class="title-v7"><%# Eval("ModelName") %></h3>
                                    <div class="stats-row-v7">
                                        <span><i class="fa-solid fa-bolt mr-1"></i><%# Eval("RangeKM") %> km</span>
                                        <span><i class="fa-solid fa-gauge-high mr-1"></i>80 km/h</span>
                                    </div>
                                    <div class="footer-row-v7">
                                        <div class="price-v7">₹<%# Eval("Price", "{0:N0}") %></div>
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
        <img src='/Uploads/Brands/<%# Eval("LogoPath") %>' loading="lazy"
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
                            <img src='/Uploads/Brands/<%# Eval("LogoPath") %>' loading="lazy"
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
                                <img src='/Uploads/Parts/<%# Eval("Image1") %>' alt='<%# Eval("PartName") %>' />
                                <div class="part-overlay-v9">
                                    <a href="Parts.aspx" class="quick-add-btn">
                                        <i class="fa-solid fa-plus"></i>
                                    </a>
                                </div>
                            </div>

                            <div class="part-info-v9">
                                <h3 class="part-title-v9"><%# Eval("PartName") %></h3>
                                <div class="part-price-row-v9">
                                    <div class="part-price-v9">₹<%# Eval("Price", "{0:N0}") %></div>
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
                    <img src="../Uploads/Banner/maintain.png" class="img-fluid main-battery-img" alt="Battery Maintenance" loading="lazy" />
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
                                        <img src='<%# Eval("ProfileImage") == DBNull.Value ? "../Uploads/user.jpg" : "/Uploads/Profile/" + Eval("ProfileImage") %>' alt='<%# Eval("FullName") %>' />
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
                                        <img src='/Uploads/Bikes/<%# Eval("Image1") %>' alt='bike' />
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

