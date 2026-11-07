<%@ Page Title="" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="BikeDetails.aspx.cs" Inherits="Client_BikeDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <style>
/* ===============================
   ELECTRIC PULSE - BIKE DETAILS
================================ */

body {
    background: var(--ep-bg, #F4F8FC);
    font-family: var(--font-body, 'Inter', sans-serif);
    color: var(--ep-text, #334155);
    margin: 0;
}

h1,h2,h3,h4,p {
    margin: 0;
}

/* ===============================
   HERO SECTION
================================ */

.bike-hero {
    max-width: 1200px;
    margin: 40px auto;
    display: flex;
    gap: 48px;
    padding: 36px;
    background: #FFFFFF;
    border-radius: 20px;
    border: 1px solid var(--ep-border, #E2E8F0);
    box-shadow: 0 4px 20px rgba(7, 26, 47, 0.04);
    align-items: flex-start;
}

/* LEFT SIDE - GALLERY */

.bike-gallery {
    flex: 1;
    min-width: 0;
}

.bike-main {
    height: 380px;
    background: #F8FAFC;
    border: 1px solid var(--ep-border, #E2E8F0);
    border-radius: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 24px;
    overflow: hidden;
    position: relative;
}

.bike-main img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    transition: transform 0.4s ease;
}

.bike-main:hover img {
    transform: scale(1.05);
}

.bike-thumbs {
    display: flex;
    gap: 12px;
    margin-top: 16px;
    flex-wrap: wrap;
}

.bike-thumbs img {
    width: 80px;
    height: 64px;
    object-fit: cover;
    border-radius: 10px;
    cursor: pointer;
    border: 2px solid var(--ep-border, #E2E8F0);
    transition: all 0.2s ease;
    background: #F8FAFC;
}

.bike-thumbs img:hover, .bike-thumbs img.active {
    border-color: var(--ep-secondary-cyan, #0891B2);
    box-shadow: 0 2px 8px rgba(8, 145, 178, 0.25);
    transform: translateY(-2px);
}

/* RIGHT SIDE - INFO */

.bike-info {
    flex: 1;
    display: flex;
    flex-direction: column;
    min-width: 0;
}

.bike-title {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-size: 28px;
    font-weight: 800;
    color: var(--ep-heading, #0F172A);
    margin-bottom: 8px;
    line-height: 1.3;
}

.bike-meta {
    display: flex;
    align-items: center;
    gap: 14px;
    font-size: 14px;
    color: var(--ep-text-muted, #64748B);
    margin-bottom: 12px;
    flex-wrap: wrap;
}

.bike-meta .brand {
    font-weight: 600;
    color: var(--ep-primary-navy, #071A2F);
}

.rating {
    background: #FEF3C7;
    color: #D97706;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 700;
    display: inline-flex;
    align-items: center;
    gap: 4px;
}

.bike-price {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-size: 32px;
    font-weight: 800;
    color: var(--ep-primary-navy, #071A2F);
    margin: 8px 0;
}

.bike-emi {
    background: #ECFEFF;
    border: 1px solid rgba(34, 211, 238, 0.35);
    color: var(--ep-secondary-cyan, #0891B2);
    padding: 6px 14px;
    border-radius: 8px;
    font-size: 13px;
    font-weight: 600;
    margin-bottom: 20px;
    display: inline-block;
    width: fit-content;
}

.divider {
    border: none;
    border-top: 1px solid var(--ep-border, #E2E8F0);
    margin: 16px 0;
}

.quick-specs {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 12px 24px;
    font-size: 14px;
}

.quick-specs div {
    display: flex;
    justify-content: space-between;
    padding: 8px 12px;
    background: #F8FAFC;
    border-radius: 8px;
    border: 1px solid var(--ep-border, #E2E8F0);
    color: var(--ep-text, #334155);
}

.quick-specs div strong {
    color: var(--ep-heading, #0F172A);
}

.bike-actions {
    margin-top: 24px;
    display: flex;
    flex-direction: column;
    gap: 14px;
}

.btn-primary {
    width: 100%;
    padding: 15px;
    border-radius: 12px;
    background: linear-gradient(135deg, var(--ep-brand-orange, #F97316), #EA580C);
    color: #FFFFFF;
    border: none;
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-size: 15px;
    font-weight: 700;
    cursor: pointer;
    box-shadow: 0 6px 18px rgba(249, 115, 22, 0.35);
    transition: all 0.25s ease;
}

.btn-primary:hover {
    background: linear-gradient(135deg, #FB923C, var(--ep-brand-orange, #F97316));
    transform: translateY(-2px);
    box-shadow: 0 10px 24px rgba(249, 115, 22, 0.45);
}

.secondary-actions {
    font-size: 14px;
    display: flex;
    gap: 14px;
    align-items: center;
    color: var(--ep-text-muted, #64748B);
    justify-content: center;
}

.secondary-actions a {
    text-decoration: none;
    color: var(--ep-text, #334155);
    font-weight: 600;
    transition: color 0.2s ease;
    display: inline-flex;
    align-items: center;
    gap: 4px;
}

.secondary-actions a:hover {
    color: var(--ep-secondary-cyan, #0891B2);
}

#wishlistBtn.active {
    color: #EF4444;
    font-weight: 700;
}

/* ===============================
   HIGHLIGHTS
================================ */

.highlights-section {
    max-width: 1200px;
    margin: 0 auto 50px auto;
    padding: 0 20px;
}

.highlights-card {
    background: #FFFFFF;
    border-radius: 18px;
    border: 1px solid var(--ep-border, #E2E8F0);
    padding: 24px 32px;
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 24px;
    box-shadow: 0 4px 16px rgba(7, 26, 47, 0.04);
}

.highlight-item {
    display: flex;
    gap: 14px;
    align-items: center;
}

.highlight-icon {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    background: #ECFEFF;
    border: 1px solid rgba(34, 211, 238, 0.25);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 22px;
    flex-shrink: 0;
}

.highlight-text h4 {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-size: 16px;
    font-weight: 800;
    color: var(--ep-heading, #0F172A);
}

.highlight-text p {
    font-size: 12px;
    font-weight: 600;
    color: var(--ep-text-muted, #64748B);
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-top: 2px;
}

/* ===============================
   TABS
================================ */

.tabs-section {
    max-width: 1200px;
    margin: 50px auto;
    padding: 0 20px;
}

.tabs-card {
    background: #FFFFFF;
    border-radius: 18px;
    border: 1px solid var(--ep-border, #E2E8F0);
    box-shadow: 0 4px 16px rgba(7, 26, 47, 0.04);
    overflow: hidden;
}

.tabs-header {
    display: flex;
    border-bottom: 1.5px solid var(--ep-border, #E2E8F0);
    background: #F8FAFC;
}

.tab-btn {
    flex: 1;
    padding: 18px 24px;
    text-align: center;
    cursor: pointer;
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-weight: 700;
    font-size: 15px;
    color: var(--ep-text-muted, #64748B);
    transition: all 0.2s ease;
    border-bottom: 3px solid transparent;
}

.tab-btn:hover {
    color: var(--ep-secondary-cyan, #0891B2);
    background: rgba(8, 145, 178, 0.03);
}

.tab-btn.active {
    color: var(--ep-secondary-cyan, #0891B2);
    border-bottom: 3px solid var(--ep-secondary-cyan, #0891B2);
    background: #FFFFFF;
}

.tab-content {
    display: none;
    padding: 32px;
    font-size: 14px;
    line-height: 1.7;
    color: var(--ep-text, #334155);
}

.tab-content.active {
    display: block;
}

.spec-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
}

.spec-table td {
    padding: 12px 16px;
    border-bottom: 1px solid var(--ep-border, #E2E8F0);
}

.spec-table tr:last-child td {
    border-bottom: none;
}

.spec-table tr:nth-child(even) {
    background: #F8FAFC;
}

.features-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 16px;
}

.feature-item {
    background: #F8FAFC;
    border: 1px solid var(--ep-border, #E2E8F0);
    padding: 16px;
    border-radius: 12px;
    font-size: 14px;
    font-weight: 500;
    color: var(--ep-text, #334155);
    display: flex;
    align-items: center;
    gap: 10px;
}

/* ===============================
   STICKY BAR
================================ */

.sticky-buy-bar {
    position: fixed;
    bottom: 0;
    left: 0;
    width: 100%;
    background: var(--ep-primary-navy, #071A2F);
    border-top: 1px solid rgba(34, 211, 238, 0.3);
    box-shadow: 0 -8px 24px rgba(7, 26, 47, 0.25);
    padding: 14px 28px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    z-index: 999;
    transform: translateY(100%);
    transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1);
    box-sizing: border-box;
}

.sticky-buy-bar.active {
    transform: translateY(0);
}

.sticky-buy-bar h4 {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    color: #FFFFFF;
    font-size: 16px;
    font-weight: 700;
}

.sticky-buy-bar p {
    color: var(--ep-accent-cyan, #22D3EE);
    font-weight: 800;
    font-size: 18px;
}

.sticky-actions {
    display: flex;
    gap: 12px;
}

.sticky-btn-primary {
    background: linear-gradient(135deg, var(--ep-brand-orange, #F97316), #EA580C);
    color: #FFFFFF;
    border: none;
    padding: 10px 22px;
    border-radius: 8px;
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-weight: 700;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.2s ease;
}

.sticky-btn-primary:hover {
    background: linear-gradient(135deg, #FB923C, var(--ep-brand-orange, #F97316));
}

.sticky-btn-outline {
    border: 1.5px solid rgba(255, 255, 255, 0.4);
    background: transparent;
    color: #FFFFFF;
    padding: 10px 20px;
    border-radius: 8px;
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-weight: 600;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.2s ease;
}

.sticky-btn-outline:hover {
    border-color: #FFFFFF;
    background: rgba(255, 255, 255, 0.1);
}

/* ===============================
   SIMILAR BIKES SLIDER
================================ */

.similar-section {
    max-width: 1200px;
    margin: 50px auto 100px auto;
    padding: 0 20px;
}

.similar-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 24px;
}

.similar-header h3 {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-size: 22px;
    font-weight: 800;
    color: var(--ep-heading, #0F172A);
}

.slider-controls button {
    border: none;
    background: var(--ep-primary-navy, #071A2F);
    color: #FFFFFF;
    width: 38px;
    height: 38px;
    border-radius: 10px;
    cursor: pointer;
    margin-left: 6px;
    transition: all 0.2s ease;
}

.slider-controls button:hover {
    background: var(--ep-secondary-cyan, #0891B2);
}

.similar-slider-wrapper {
    overflow: hidden;
}

.similar-slider {
    display: flex;
    gap: 20px;
    overflow-x: auto;
    scroll-behavior: smooth;
    padding-bottom: 12px;
}

.similar-slider::-webkit-scrollbar {
    display: none;
}

.similar-card {
    min-width: 250px;
    background: #FFFFFF;
    border-radius: 16px;
    border: 1px solid var(--ep-border, #E2E8F0);
    box-shadow: 0 4px 14px rgba(7, 26, 47, 0.04);
    overflow: hidden;
    flex-shrink: 0;
    transition: all 0.3s ease;
}

.similar-card:hover {
    transform: translateY(-5px);
    border-color: var(--ep-accent-cyan, #22D3EE);
    box-shadow: 0 14px 28px rgba(7, 26, 47, 0.1);
}

.similar-img {
    height: 160px;
    background: #F8FAFC;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 16px;
}

.similar-img img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
}

.similar-body {
    padding: 16px;
}

.similar-name {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-weight: 700;
    font-size: 15px;
    color: var(--ep-heading, #0F172A);
    margin-bottom: 6px;
}

.similar-price {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-weight: 800;
    font-size: 16px;
    color: var(--ep-primary-navy, #071A2F);
    margin-bottom: 12px;
}

.similar-btn {
    display: block;
    text-align: center;
    padding: 8px 14px;
    background: var(--ep-primary-navy, #071A2F);
    color: #FFFFFF !important;
    border-radius: 8px;
    text-decoration: none;
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-weight: 700;
    font-size: 13px;
    transition: all 0.2s ease;
}

.similar-btn:hover {
    background: var(--ep-secondary-cyan, #0891B2);
}

/* ===============================
   REVIEWS SECTION
================================ */

.reviews-section {
    max-width: 1200px;
    margin: 60px auto;
    padding: 0 20px;
}

.reviews-container {
    background: #FFFFFF;
    border-radius: 20px;
    border: 1px solid var(--ep-border, #E2E8F0);
    padding: 36px;
    box-shadow: 0 4px 16px rgba(7, 26, 47, 0.04);
}

.reviews-top {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    gap: 60px;
    margin-bottom: 36px;
    flex-wrap: wrap;
}

.reviews-rating {
    width: 320px;
}

.rating-number {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-size: 52px;
    font-weight: 800;
    color: var(--ep-heading, #0F172A);
    line-height: 1;
    margin-bottom: 8px;
}

.rating-stars {
    color: #F59E0B;
    font-size: 20px;
    margin-bottom: 8px;
}

.rating-count {
    font-size: 13px;
    color: var(--ep-text-muted, #64748B);
    margin-bottom: 16px;
}

.breakdown-row {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 8px;
    font-size: 13px;
    color: var(--ep-text, #334155);
}

.breakdown-bar {
    flex: 1;
    height: 7px;
    background: #E2E8F0;
    border-radius: 4px;
    overflow: hidden;
}

.breakdown-fill {
    height: 100%;
    background: #F59E0B;
    border-radius: 4px;
}

.review-form-mini {
    width: 440px;
    display: flex;
    flex-direction: column;
    gap: 14px;
}

.review-form-mini h4 {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-size: 20px;
    font-weight: 800;
    color: var(--ep-heading, #0F172A);
    margin-bottom: 4px;
}

.review-form-mini select,
.review-form-mini input,
.review-form-mini textarea {
    width: 100%;
    padding: 11px 14px;
    border-radius: 10px;
    border: 1.5px solid var(--ep-border, #E2E8F0);
    font-size: 14px;
    font-family: var(--font-body, 'Inter', sans-serif);
    box-sizing: border-box;
    outline: none;
    transition: all 0.2s ease;
}

.review-form-mini select:focus,
.review-form-mini input:focus,
.review-form-mini textarea:focus {
    border-color: var(--ep-secondary-cyan, #0891B2);
    box-shadow: 0 0 0 3px rgba(8, 145, 178, 0.15);
}

.review-form-mini textarea {
    height: 100px;
    resize: none;
}

.review-form-mini button {
    background: var(--ep-primary-navy, #071A2F);
    color: #FFFFFF;
    border: none;
    padding: 13px;
    border-radius: 10px;
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-weight: 700;
    font-size: 14px;
    cursor: pointer;
    transition: all 0.25s ease;
}

.review-form-mini button:hover {
    background: var(--ep-secondary-cyan, #0891B2);
}

.reviews-slider-wrapper {
    position: relative;
    margin-top: 24px;
}

.reviews-slider {
    display: flex;
    gap: 20px;
    overflow-x: auto;
    scroll-behavior: smooth;
    padding-bottom: 12px;
}

.reviews-slider::-webkit-scrollbar {
    display: none;
}

.review-card {
    min-width: 320px;
    background: #F8FAFC;
    border-radius: 14px;
    border: 1px solid var(--ep-border, #E2E8F0);
    padding: 20px;
}

.review-user {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 10px;
}

.user-avatar {
    width: 40px;
    height: 40px;
    background: #E2E8F0;
    color: var(--ep-primary-navy, #071A2F);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 700;
    font-size: 14px;
}

.review-stars {
    color: #F59E0B;
    font-size: 14px;
}

.review-title {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-weight: 700;
    font-size: 14px;
    color: var(--ep-heading, #0F172A);
}

.review-text {
    font-size: 13px;
    color: var(--ep-text-muted, #64748B);
    margin-top: 8px;
    line-height: 1.6;
}

/* ===============================
   DEALER SECTION
================================ */

.dealer-section {
    max-width: 1200px;
    margin: 50px auto;
    padding: 0 20px;
}

.dealer-card {
    background: #FFFFFF;
    border-radius: 18px;
    border: 1px solid var(--ep-border, #E2E8F0);
    box-shadow: 0 4px 16px rgba(7, 26, 47, 0.04);
    padding: 28px 32px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 20px;
}

.dealer-left {
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.dealer-title {
    font-size: 12px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    color: var(--ep-secondary-cyan, #0891B2);
}

.dealer-name {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-size: 22px;
    font-weight: 800;
    color: var(--ep-heading, #0F172A);
}

.dealer-meta {
    font-size: 14px;
    color: var(--ep-text-muted, #64748B);
}

.dealer-actions {
    display: flex;
    gap: 12px;
}

.dealer-btn {
    padding: 11px 20px;
    border-radius: 10px;
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
    border: none;
    transition: all 0.2s ease;
}

.btn-contact {
    background: linear-gradient(135deg, var(--ep-brand-orange, #F97316), #EA580C);
    color: #FFFFFF;
    box-shadow: 0 4px 12px rgba(249, 115, 22, 0.3);
}

.btn-contact:hover {
    background: linear-gradient(135deg, #FB923C, var(--ep-brand-orange, #F97316));
    transform: translateY(-2px);
}

.btn-view {
    background: var(--ep-primary-navy, #071A2F);
    color: #FFFFFF;
}

.btn-view:hover {
    background: var(--ep-secondary-cyan, #0891B2);
    transform: translateY(-2px);
}

/* ===============================
   RESPONSIVE BREAKPOINTS
================================ */

@media(max-width: 992px) {
    .bike-hero {
        flex-direction: column;
        gap: 30px;
        padding: 24px;
    }
    .bike-main {
        height: 320px;
    }
    .highlights-card {
        grid-template-columns: repeat(2, 1fr);
    }
    .features-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media(max-width: 768px) {
    .reviews-top {
        flex-direction: column;
        gap: 30px;
    }
    .reviews-rating, .review-form-mini {
        width: 100%;
    }
    .dealer-card {
        flex-direction: column;
        align-items: flex-start;
    }
    .dealer-actions {
        width: 100%;
    }
    .dealer-btn {
        flex: 1;
        text-align: center;
    }
}

@media(max-width: 600px) {
    .bike-title {
        font-size: 22px;
    }
    .bike-price {
        font-size: 26px;
    }
    .quick-specs {
        grid-template-columns: 1fr;
    }
    .highlights-card, .features-grid {
        grid-template-columns: 1fr;
    }
    .tabs-header {
        flex-direction: column;
    }
}
    </style>




<section class="bike-hero">

<!-- LEFT IMAGE -->
<div class="bike-gallery">

<div class="bike-main">
<asp:Image ID="imgMain" runat="server" />
</div>

<div class="bike-thumbs">
<asp:Literal ID="litThumbs" runat="server"></asp:Literal>
</div>

</div>


<!-- RIGHT INFO -->
<div class="bike-info">

<div class="bike-title">
<asp:Literal ID="litBikeName" runat="server"></asp:Literal>
</div>

<div class="bike-meta">
<span class="brand">By <asp:Literal ID="litBrand" runat="server"></asp:Literal></span>
<span class="rating"><asp:Literal ID="litRating" runat="server"></asp:Literal></span>
</div>

<div class="bike-price">
₹ <asp:Literal ID="litPrice" runat="server"></asp:Literal> /-
</div>

<div class="bike-emi">
EMI starting from ₹ <span id="emiAmount"></span> / month
</div>

<hr class="divider"/>

<div class="quick-specs">
<div><strong>Range:</strong> 120 km/charge</div>
<div><strong>Top Speed:</strong> 85 km/h</div>
<div><strong>Battery:</strong> 3.2 kWh</div>
<div><strong>Warranty:</strong> 3 Years</div>
</div>

<hr class="divider"/>

<div class="bike-actions">

<button type="button" class="btn-primary"
onclick="goEnquiry()">
Enquire Now
</button>

<div class="secondary-actions">
<a href="Compare.aspx?b1=<%= ViewState["BikeID"] %>">Compare</a>
<span>|</span>
<a href="javascript:void(0)"
   id="wishlistBtn"
   onclick="toggleWishlistHero()">
♡ Wishlist
</a>
    <a href="javascript:void(0)"
onclick="shareBike()">

Share

</a>

</div>

</div>

</div>



</section>


    <section class="highlights-section">

<div class="highlights-card">

<div class="highlight-item">
<div class="highlight-icon">🔋</div>
<div class="highlight-text">
<h4><asp:Literal ID="litRange" runat="server"></asp:Literal></h4>
<p>Range</p>
</div>
</div>

<div class="highlight-item">
<div class="highlight-icon">⚡</div>
<div class="highlight-text">
<h4><asp:Literal ID="litSpeed" runat="server"></asp:Literal></h4>
<p>Top Speed</p>
</div>
</div>

<div class="highlight-item">
<div class="highlight-icon">🔌</div>
<div class="highlight-text">
<h4><asp:Literal ID="litCharge" runat="server"></asp:Literal></h4>
<p>Charging Time</p>
</div>
</div>

<div class="highlight-item">
<div class="highlight-icon">🛵</div>
<div class="highlight-text">
<h4><asp:Literal ID="litMotor" runat="server"></asp:Literal></h4>
<p>Motor Power</p>
</div>
</div>

</div>

</section>

<section class="tabs-section">

<div class="tabs-card">

<div class="tabs-header">
<div class="tab-btn active" onclick="openTab(event,'overview')">Overview</div>
<div class="tab-btn" onclick="openTab(event,'specs')">Specifications</div>
<div class="tab-btn" onclick="openTab(event,'features')">Features</div>
</div>

<!-- OVERVIEW -->
<div id="overview" class="tab-content active">
<div class="overview-text">
<asp:Literal ID="litOverview" runat="server"></asp:Literal>
</div>
</div>

<!-- SPECIFICATIONS -->
<div id="specs" class="tab-content">
<table class="spec-table">
<asp:Literal ID="litSpecsTable" runat="server"></asp:Literal>
</table>
</div>

<!-- FEATURES -->
<div id="features" class="tab-content">
<div class="features-grid">
<asp:Literal ID="litFeatures" runat="server"></asp:Literal>
</div>
</div>

</div>

</section>

    <section class="dealer-section">

<h2 style="margin-bottom:20px;">Sold By Dealer</h2>

<div class="dealer-card">

<div class="dealer-left">

<div class="dealer-title">
Authorized Electric Bike Dealer
</div>

<div class="dealer-name">
<asp:Literal ID="litDealerName" runat="server"></asp:Literal>
</div>

<div class="dealer-meta">
📞 <asp:Literal ID="litDealerPhone" runat="server"></asp:Literal>
</div>

<div class="dealer-meta">
✉ <asp:Literal ID="litDealerEmail" runat="server"></asp:Literal>
</div>
    <div class="dealer-meta">
📍 <asp:Literal ID="litDealerCity" runat="server"></asp:Literal>
</div>

</div>

<div class="dealer-actions">

<button class="dealer-btn btn-contact"
onclick="contactDealer()">
Contact Dealer
</button>

<button type="button" class="dealer-btn btn-view"
onclick="viewDealerBikes()">
View Dealer Bikes
</button>

</div>

</div>

</section>

       <!-- Review section -->

    <section class="reviews-section">

<div class="reviews-container">

<!-- HEADER -->

<div class="reviews-top">

    <div class="review-form-mini">

<h4>Write a Review</h4>

<select id="rating">
<option value="5">★★★★★ (5)</option>
<option value="4">★★★★ (4)</option>
<option value="3">★★★ (3)</option>
<option value="2">★★ (2)</option>
<option value="1">★ (1)</option>
</select>

<input type="text" id="reviewTitle" placeholder="Review title">

<textarea id="reviewText" placeholder="Write your review"></textarea>

<button onclick="submitReview()">Submit Review</button>

<div id="reviewMsg"></div>

</div>

<div class="reviews-rating">

<div class="rating-number">
<asp:Literal ID="litAvgRating" runat="server"></asp:Literal>
</div>

<div class="rating-stars">
<asp:Literal ID="litAvgStars" runat="server"></asp:Literal>
</div>

<div class="rating-count">
Based on <asp:Literal ID="litReviewCount" runat="server"></asp:Literal>
</div>
    <div class="rating-breakdown">
<asp:Literal ID="litBreakdown" runat="server"></asp:Literal>
</div>

</div>



</div>


<!-- CAROUSEL -->

<div class="reviews-slider-wrapper">

<button type="button" class="review-nav left" onclick="slideReviews(-1)">‹</button>

<div class="reviews-slider" id="reviewsSlider">

<asp:Literal ID="litRecentReviews" runat="server"></asp:Literal>

</div>

<button type="button" class="review-nav right" onclick="slideReviews(1)">›</button>

</div>

</div>

</section>

     <!-- similar section -->

    <section class="similar-section">

<div class="similar-header">
<h2>Similar Electric Bikes</h2>

<div class="slider-controls">
<button type="button" onclick="return slideLeft(event)">‹</button>
<button type="button" onclick="return slideRight(event)">›</button>
</div>
</div>

<div class="similar-slider-wrapper">

<div class="similar-slider" id="similarSlider">
<asp:Literal ID="litSimilarBikes" runat="server"></asp:Literal>
</div>

</div>

</section>




<div class="sticky-buy-bar" id="stickyBar">

<div class="sticky-left">
<div class="sticky-title">
<asp:Literal ID="litStickyName" runat="server"></asp:Literal>
</div>
<div class="sticky-price">
₹ <asp:Literal ID="litStickyPrice" runat="server"></asp:Literal> /-
</div>
</div>

<div class="sticky-actions">

<button type="button"
class="sticky-btn-outline"
onclick="goCompare()">
Compare
</button>

<button class="sticky-btn-primary"
onclick="location.href='Enquiry.aspx?slug=<%= Request.QueryString["slug"] %>'">
Enquire Now
</button>

</div>

</div>








    <script>
        
        function goCompare(){

            var bikeId = "<%= ViewState["BikeID"] %>";

            if(bikeId != ""){
                window.location.href = "Compare.aspx?b1=" + bikeId;
            }

        }
        function shareBike(){

            navigator.clipboard.writeText(window.location.href);

            alert("Bike link copied");

        }
        function viewDealerBikes(){

            var dealerId = "<%= ViewState["DealerID"] %>";

            if(dealerId != ""){
                window.location.href = "Bikes.aspx?dealer=" + dealerId;
            }

        }
        function contactDealer(){

            var phone = "<%= litDealerPhone.Text %>";

            if(phone!=""){
                window.location.href="tel:"+phone;
            }

        }

        document.addEventListener("DOMContentLoaded", function () {
            checkWishlist();

            var price = parseFloat('<%= ViewState["Price"] ?? "0" %>');

    var interest = 9.5 / 100 / 12;
    var tenure = 36;

    var emi = (price * interest * Math.pow(1 + interest, tenure)) /
              (Math.pow(1 + interest, tenure) - 1);

    if (!isNaN(emi)) {
        document.getElementById("emiAmount").innerText =
        Math.round(emi).toLocaleString();
    }

});

        function changeImage(src) {
            var mainImg = document.querySelector(".bike-main img");
            mainImg.src = src;

            var thumbs = document.querySelectorAll(".bike-thumbs img");
            thumbs.forEach(function (img) {
                img.style.border = "2px solid transparent";
            });

            event.target.style.border = "2px solid #ff4d4d";
        }

</script>


    <script>

        document.addEventListener("DOMContentLoaded", function(){

        const stickyBar = document.getElementById("stickyBar");

            window.addEventListener("scroll", function(){

                if(window.scrollY > 500){
                    stickyBar.classList.add("active");
                }else{
                    stickyBar.classList.remove("active");
                }

            });

        });

</script>

    <script>

        function openTab(evt, tabName){

            var contents = document.querySelectorAll(".tab-content");
            var buttons = document.querySelectorAll(".tab-btn");

            contents.forEach(function(c){
                c.classList.remove("active");
            });

            buttons.forEach(function(b){
                b.classList.remove("active");
            });

            document.getElementById(tabName).classList.add("active");
            evt.currentTarget.classList.add("active");

        }

        function slideReviews(dir){

            var slider = document.getElementById("reviewsSlider");

            slider.scrollBy({
                left: dir * 320,
                behavior: 'smooth'
            });

        }

</script>

    <script>
        function slideLeft(e){

            if(e) e.preventDefault();

            var slider = document.getElementById("similarSlider");
            slider.scrollLeft -= 260;

            return false;
        }

        function slideRight(e){

            if(e) e.preventDefault();

            var slider = document.getElementById("similarSlider");
            slider.scrollLeft += 260;

            return false;
        }

        slider.scrollBy({
            left:260,
            behavior:'smooth'
        });
</script>


    <script>function submitReview(){

    var rating = document.getElementById("rating").value;
    var title = document.getElementById("reviewTitle").value;
    var text = document.getElementById("reviewText").value;

    if(text.trim()===""){
        alert("Please write review");
        return;
    }

    $.ajax({
        type:"POST",
        url:"BikeDetails.aspx/SubmitReview",
        data: JSON.stringify({
            rating: rating,
            title: title,
            review: text
        }),
        contentType:"application/json; charset=utf-8",
        dataType:"json",
        success:function(res){

            if(res.d==="login"){
                alert("Please login first");
                return;
            }

            if(res.d==="exists"){
                alert("You already reviewed this bike");
                return;
            }

            document.getElementById("reviewMsg").innerHTML =
            "Review submitted. Waiting for admin approval.";

            document.getElementById("reviewTitle").value="";
            document.getElementById("reviewText").value="";
        }
    });
}
        function toggleWishlistHero(){

            var bikeId = "<%= ViewState["BikeID"] %>";

            $.ajax({
                type:"POST",
                url:"/Client/BikeDetails.aspx/ToggleWishlist",
                data: JSON.stringify({ bikeId: bikeId }),
                contentType:"application/json; charset=utf-8",
                dataType:"json",

                success:function(res){

                    if(res.d==="added"){
                        $("#wishlistBtn").addClass("active").text("❤ Wishlisted");
                    }

                    if(res.d==="removed"){
                        $("#wishlistBtn").removeClass("active").text("♡ Wishlist");
                    }

                    if(res.d==="login"){
                        alert("Please login first");
                    }

                    // navbar wishlist count update
                    if (window.updateWishCount) {
                        window.updateWishCount();
                    }

                }

            });

        }
        function checkWishlist(){

            var bikeId = "<%= ViewState["BikeID"] %>";

            $.ajax({
                type:"POST",
                url:"/Client/BikeDetails.aspx/CheckWishlist",
                data: JSON.stringify({ bikeId: bikeId }),
                contentType:"application/json; charset=utf-8",
                dataType:"json",

                success:function(res){

                    if(res.d==="yes"){
                        $("#wishlistBtn").addClass("active").text("❤ Wishlisted");
                    }

                }

            });

        }

        function goEnquiry(){

            var slug = "<%= Request.QueryString["slug"] %>";

            window.location.href = "Enquiry.aspx?slug=" + slug;

        }


    </script>

</asp:Content>

