<%@ Page Title="" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master" AutoEventWireup="true" CodeFile="VendorSubscription.aspx.cs" Inherits="Vendor_VendorSubscription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<style>
/* ═══════════════════════════════════════════════
   VendorSubscription — matches existing panel
   Uses Bootstrap base + small targeted overrides
   No dark theme — stays in panel's light scheme
═══════════════════════════════════════════════ */

/* page wrapper */
.sub-page {
    padding: 24px 0 48px;
}

/* ── PAGE HEADER ── */
.sub-header {
    margin-bottom: 24px;
}
.sub-header h3 {
    font-size: 22px;
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 4px;
}
.sub-header p {
    font-size: 14px;
    color: #64748b;
    margin: 0;
}

/* ── MESSAGE ALERT ── */
.sub-alert {
    display: none;
    align-items: center;
    gap: 10px;
    padding: 12px 16px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 500;
    margin-bottom: 20px;
    border: 1px solid transparent;
}
.sub-alert.show { display: flex; }
.sub-alert.success {
    background: #f0fdf4;
    border-color: #bbf7d0;
    color: #166534;
}
.sub-alert.warning {
    background: #fffbeb;
    border-color: #fde68a;
    color: #92400e;
}
.sub-alert.info {
    background: #eff6ff;
    border-color: #bfdbfe;
    color: #1e40af;
}
.sub-alert i { font-size: 15px; flex-shrink: 0; }

/* ── CURRENT PLAN CARD ── */
.current-plan-card {
    background: #fff;
    border: 1px solid #e2e8f0;
    border-radius: 10px;
    padding: 20px 22px;
    margin-bottom: 28px;
    position: relative;
    box-shadow: 0 1px 4px rgba(0,0,0,0.06);
}
/* left accent bar */
.current-plan-card::before {
    content: '';
    position: absolute;
    left: 0; top: 0; bottom: 0;
    width: 4px;
    background: linear-gradient(to bottom, #2563eb, #06b6d4);
    border-radius: 10px 0 0 10px;
}
.cp-title {
    font-size: 11px;
    font-weight: 700;
    letter-spacing: 1.5px;
    text-transform: uppercase;
    color: #94a3b8;
    margin-bottom: 14px;
    display: flex;
    align-items: center;
    gap: 6px;
}
.cp-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 0;
}
.cp-item {
    padding: 0 16px;
    border-right: 1px solid #f1f5f9;
}
.cp-item:first-child { padding-left: 0; }
.cp-item:last-child { border-right: none; }
.cp-label {
    font-size: 11.5px;
    font-weight: 600;
    color: #94a3b8;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    margin-bottom: 5px;
    display: flex;
    align-items: center;
    gap: 5px;
}
.cp-label i { font-size: 10px; }
.cp-value {
    font-size: 17px;
    font-weight: 700;
    color: #1e293b;
}
.plan-status {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    font-size: 13px;
    font-weight: 700;
    padding: 3px 10px;
    border-radius: 20px;
}
.plan-status.active {
    background: #dbeafe;
    color: #1d4ed8;
}
.plan-status.inactive {
    background: #f1f5f9;
    color: #64748b;
}
.plan-status .status-dot {
    width: 6px; height: 6px;
    border-radius: 50%;
    background: currentColor;
}

@media (max-width: 700px) {
    .cp-grid { grid-template-columns: 1fr 1fr; gap: 14px; }
    .cp-item { padding: 0; border-right: none; }
}

/* ── SECTION HEADING ── */
.plans-heading {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 16px;
    flex-wrap: wrap;
    gap: 8px;
}
.plans-heading h4 {
    font-size: 18px;
    font-weight: 700;
    color: #1e293b;
    margin: 0;
}
.plans-heading small {
    font-size: 13px;
    color: #94a3b8;
}

/* ── PLAN CARDS ROW ── */
.plans-row {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 14px;
    margin-bottom: 24px;
}
@media (max-width: 900px) { .plans-row { grid-template-columns: 1fr 1fr; } }
@media (max-width: 480px) { .plans-row { grid-template-columns: 1fr; } }

/* ── PLAN CARD ── */
.plan-card {
    background: #fff;
    border: 1px solid #e2e8f0;
    border-radius: 10px;
    padding: 22px 18px 18px;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    text-align: left;
    position: relative;
    transition: box-shadow 0.2s, transform 0.2s, border-color 0.2s;
    box-shadow: 0 1px 4px rgba(0,0,0,0.05);
}
.plan-card:hover {
    box-shadow: 0 8px 24px rgba(0,0,0,0.1);
    transform: translateY(-2px);
    border-color: #cbd5e1;
}

/* top color bar */
.plan-card::before {
    content: '';
    position: absolute;
    top: 0; left: 0; right: 0;
    height: 3px;
    border-radius: 10px 10px 0 0;
}
.pc-basic::before    { background: #7c3aed; }
.pc-pro::before      { background: linear-gradient(90deg, #2563eb, #06b6d4); }
.pc-featured::before { background: #d97706; }
.pc-combo::before    { background: linear-gradient(90deg, #dc2626, #db2777); }

/* combo special */
.pc-combo {
    border-color: #fecaca;
}
.pc-combo:hover {
    border-color: #f87171;
    box-shadow: 0 8px 24px rgba(220,38,38,0.1);
}

/* best offer ribbon */
.ribbon {
    position: absolute;
    top: 12px; right: -2px;
    background: #dc2626;
    color: white;
    font-size: 10px;
    font-weight: 700;
    padding: 3px 10px 3px 8px;
    border-radius: 4px 0 0 4px;
    letter-spacing: 0.3px;
}
.ribbon::after {
    content: '';
    position: absolute;
    right: -6px; top: 0;
    width: 0; height: 0;
    border-top: 12px solid transparent;
    border-bottom: 12px solid transparent;
    border-left: 6px solid #dc2626;
}

/* icon badge */
.pc-icon {
    width: 40px; height: 40px;
    border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-size: 17px;
    margin-bottom: 12px;
}
.pc-basic    .pc-icon { background: #ede9fe; color: #7c3aed; }
.pc-pro      .pc-icon { background: #dbeafe; color: #2563eb; }
.pc-featured .pc-icon { background: #fef3c7; color: #d97706; }
.pc-combo    .pc-icon { background: #fee2e2; color: #dc2626; }

/* card name */
.pc-name {
    font-size: 15px;
    font-weight: 700;
    color: #1e293b;
    margin-bottom: 2px;
}

/* price */
.pc-price {
    font-size: 28px;
    font-weight: 800;
    color: #1e293b;
    line-height: 1;
    margin: 8px 0 2px;
}
.pc-period {
    font-size: 12px;
    color: #94a3b8;
    margin-bottom: 14px;
}

/* divider */
.pc-div {
    width: 100%;
    height: 1px;
    background: #f1f5f9;
    margin-bottom: 12px;
}

/* features */
.pc-feats {
    list-style: none;
    padding: 0; margin: 0 0 16px;
    width: 100%;
    display: flex; flex-direction: column; gap: 7px;
}
.pc-feats li {
    display: flex; align-items: center; gap: 7px;
    font-size: 13px; color: #475569;
}
.pc-feats li.off { color: #cbd5e1; }
.fi-check {
    width: 16px; height: 16px; border-radius: 50%;
    background: #dcfce7; color: #16a34a;
    display: flex; align-items: center; justify-content: center;
    font-size: 8px; flex-shrink: 0;
}
.fi-cross {
    width: 16px; height: 16px; border-radius: 50%;
    background: #f1f5f9; color: #cbd5e1;
    display: flex; align-items: center; justify-content: center;
    font-size: 8px; flex-shrink: 0;
}

/* ── PLAN BUTTONS — override bootstrap styles ── */
.plan-card .pc-btn {
    display: inline-flex !important;
    align-items: center !important;
    justify-content: center !important;
    gap: 6px !important;
    width: 100% !important;
    padding: 9px 14px !important;
    border-radius: 7px !important;
    font-size: 13.5px !important;
    font-weight: 700 !important;
    cursor: pointer !important;
    transition: all 0.18s !important;
    border: none !important;
    margin-top: auto;
    line-height: 1.4 !important;
    outline: none !important;
    box-shadow: none !important;
}
.plan-card .pc-btn:active {
    transform: scale(0.98) !important;
}

/* Basic — purple outline */
.btn-basic {
    background: #ede9fe !important;
    color: #7c3aed !important;
    border: 1px solid #ddd6fe !important;
}
.btn-basic:hover {
    background: #ddd6fe !important;
    color: #6d28d9 !important;
}

/* Pro — blue solid */
.btn-pro {
    background: #2563eb !important;
    color: #fff !important;
}
.btn-pro:hover {
    background: #1d4ed8 !important;
    transform: translateY(-1px) !important;
    box-shadow: 0 4px 12px rgba(37,99,235,0.3) !important;
}

/* Featured — amber outline */
.btn-featured {
    background: #fef3c7 !important;
    color: #92400e !important;
    border: 1px solid #fde68a !important;
}
.btn-featured:hover {
    background: #fde68a !important;
    color: #78350f !important;
}

/* Combo — red solid */
.btn-combo {
    background: #dc2626 !important;
    color: #fff !important;
}
.btn-combo:hover {
    background: #b91c1c !important;
    transform: translateY(-1px) !important;
    box-shadow: 0 4px 12px rgba(220,38,38,0.3) !important;
}

/* ── PAYMENT NOTICE ── */
.pay-note {
    background: #fffbeb;
    border: 1px solid #fde68a;
    border-radius: 8px;
    padding: 13px 16px;
    display: flex;
    align-items: flex-start;
    gap: 10px;
    font-size: 13.5px;
    color: #78350f;
    line-height: 1.6;
}
.pay-note i {
    font-size: 15px;
    color: #d97706;
    flex-shrink: 0;
    margin-top: 1px;
}
</style>

<div class="container-fluid sub-page">

    <%-- PAGE HEADER --%>
    <div class="sub-header">
        <h3><i class="fa fa-credit-card me-2 text-primary"></i>Dealer Subscription</h3>
        <p>Manage your plan and request an upgrade to list more bikes.</p>
    </div>

    <%-- MESSAGE ALERT — JS reads lblMsg and shows this --%>
    <div class="sub-alert" id="subAlert">
        <i id="alertIcon" class="fa fa-circle-info"></i>
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
    </div>

    <%-- CURRENT PLAN ─────────────────────────────── --%>
    <div class="current-plan-card mb-4">
        <div class="cp-title">
            <i class="fa fa-bolt text-primary"></i> Current Active Plan
        </div>
        <div class="cp-grid">
            <div class="cp-item">
                <div class="cp-label"><i class="fa fa-tag"></i> Plan</div>
                <div>
                    <span class="plan-status active" id="planStatusBadge">
                        <span class="status-dot"></span>
                        <asp:Label ID="lblPlan" runat="server">No Active Plan</asp:Label>
                    </span>
                </div>
            </div>
            <div class="cp-item">
                <div class="cp-label"><i class="fa fa-calendar"></i> Expiry</div>
                <div class="cp-value">
                    <asp:Label ID="lblExpiry" runat="server">—</asp:Label>
                </div>
            </div>
            <div class="cp-item">
                <div class="cp-label"><i class="fa fa-motorcycle"></i> Bike Limit</div>
                <div class="cp-value">
                    <asp:Label ID="lblBikeLimit" runat="server">0</asp:Label>
                    <small class="text-muted ms-1">bikes</small>
                </div>
            </div>
            <div class="cp-item">
                <div class="cp-label"><i class="fa fa-star"></i> Featured</div>
                <div class="cp-value">
                    <asp:Label ID="lblFeaturedLimit" runat="server">0</asp:Label>
                    <small class="text-muted ms-1">slots</small>
                </div>
            </div>
        </div>
    </div>

    <%-- AVAILABLE PLANS ──────────────────────────── --%>
    <div class="plans-heading">
        <h4>Available Plans</h4>
        <small><i class="fa fa-info-circle me-1"></i>Pay cash to admin after requesting</small>
    </div>

    <div class="plans-row">

        <%-- BASIC ─────────────────────────────────── --%>
        <div class="plan-card pc-basic">
            <div class="pc-icon"><i class="fa fa-bolt"></i></div>
            <div class="pc-name">Basic</div>
            <div class="pc-price">₹999</div>
            <div class="pc-period">per month</div>
            <div class="pc-div"></div>
            <ul class="pc-feats">
                <li><span class="fi-check"><i class="fa fa-check"></i></span>10 bike listings</li>
                <li><span class="fi-check"><i class="fa fa-check"></i></span>Dealer profile</li>
                <li><span class="fi-check"><i class="fa fa-check"></i></span>Enquiry management</li>
                <li class="off"><span class="fi-cross"><i class="fa fa-xmark"></i></span>Featured slots</li>
                <li class="off"><span class="fi-cross"><i class="fa fa-xmark"></i></span>Analytics</li>
            </ul>
            <asp:Button ID="Button1" runat="server"
                Text="Request Basic"
                CssClass="pc-btn btn-basic"
                OnClick="btnBasic_Click" />
        </div>

        <%-- PRO ────────────────────────────────────── --%>
        <div class="plan-card pc-pro">
            <div class="pc-icon"><i class="fa fa-layer-group"></i></div>
            <div class="pc-name">Pro</div>
            <div class="pc-price">₹1,999</div>
            <div class="pc-period">per month</div>
            <div class="pc-div"></div>
            <ul class="pc-feats">
                <li><span class="fi-check"><i class="fa fa-check"></i></span>50 bike listings</li>
                <li><span class="fi-check"><i class="fa fa-check"></i></span>Verified badge</li>
                <li><span class="fi-check"><i class="fa fa-check"></i></span>Enquiry management</li>
                <li><span class="fi-check"><i class="fa fa-check"></i></span>Analytics</li>
                <li class="off"><span class="fi-cross"><i class="fa fa-xmark"></i></span>Featured slots</li>
            </ul>
            <asp:Button ID="Button2" runat="server"
                Text="Request Pro"
                CssClass="pc-btn btn-pro"
                OnClick="btnPro_Click" />
        </div>

        <%-- FEATURED ────────────────────────────────── --%>
        <div class="plan-card pc-featured">
            <div class="pc-icon"><i class="fa fa-star"></i></div>
            <div class="pc-name">Featured</div>
            <div class="pc-price">₹499</div>
            <div class="pc-period">per featured slot</div>
            <div class="pc-div"></div>
            <ul class="pc-feats">
                <li><span class="fi-check"><i class="fa fa-check"></i></span>1 featured slot</li>
                <li><span class="fi-check"><i class="fa fa-check"></i></span>Homepage placement</li>
                <li><span class="fi-check"><i class="fa fa-check"></i></span>Search priority</li>
                <li class="off"><span class="fi-cross"><i class="fa fa-xmark"></i></span>Extra listings</li>
                <li class="off"><span class="fi-cross"><i class="fa fa-xmark"></i></span>Analytics</li>
            </ul>
            <asp:Button ID="Button3" runat="server"
                Text="Request Featured"
                CssClass="pc-btn btn-featured"
                OnClick="btnFeatured_Click" />
        </div>

        <%-- COMBO ──────────────────────────────────── --%>
        <div class="plan-card pc-combo">
            <span class="ribbon">⚡ Best Offer</span>
            <div class="pc-icon"><i class="fa fa-crown"></i></div>
            <div class="pc-name">Combo</div>
            <div class="pc-price">₹2,499</div>
            <div class="pc-period">per month</div>
            <div class="pc-div"></div>
            <ul class="pc-feats">
                <li><span class="fi-check"><i class="fa fa-check"></i></span>50 bike listings</li>
                <li><span class="fi-check"><i class="fa fa-check"></i></span>3 featured slots</li>
                <li><span class="fi-check"><i class="fa fa-check"></i></span>Verified badge</li>
                <li><span class="fi-check"><i class="fa fa-check"></i></span>Analytics</li>
                <li><span class="fi-check"><i class="fa fa-check"></i></span>Priority support</li>
            </ul>
            <asp:Button ID="Button4" runat="server"
                Text="Request Combo"
                CssClass="pc-btn btn-combo"
                OnClick="btnCombo_Click" />
        </div>

    </div><%-- /plans-row --%>

    <%-- PAYMENT NOTICE --%>
    <div class="pay-note">
        <i class="fa fa-circle-info"></i>
        <span>
            <strong>How it works:</strong> Click Request to submit your plan.
            Pay <strong>cash to admin</strong> to activate.
            Your plan will be live within <strong>24 hours</strong> of payment.
            &nbsp; Contact: <strong>+91-9001234567</strong>
        </span>
    </div>

</div><%-- /sub-page --%>

<script>
    (function () {
        var alert = document.getElementById('subAlert');
        var icon = document.getElementById('alertIcon');
        var lbl = document.getElementById('<%= lblMsg.ClientID %>');
    var badge = document.getElementById('planStatusBadge');
    var planLbl = document.getElementById('<%= lblPlan.ClientID %>');

    /* ── Message styling ── */
    if (lbl) {
        var txt = lbl.textContent.trim();
        if (txt) {
            alert.classList.add('show');
            if (txt.indexOf('submitted') > -1 || txt.indexOf('Pay cash') > -1) {
                alert.classList.add('success');
                icon.className = 'fa fa-circle-check';
            } else if (txt.indexOf('pending') > -1 || txt.indexOf('already') > -1) {
                alert.classList.add('warning');
                icon.className = 'fa fa-triangle-exclamation';
            } else {
                alert.classList.add('info');
                icon.className = 'fa fa-circle-info';
            }
            alert.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }
    }

    /* ── Plan badge ── */
    if (badge && planLbl) {
        var plan = planLbl.textContent.trim();
        badge.className = (plan === '' || plan === 'No Active Plan')
            ? 'plan-status inactive'
            : 'plan-status active';
    }
})();
</script>
</asp:Content>

