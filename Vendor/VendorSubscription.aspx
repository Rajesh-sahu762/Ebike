<%@ Page Title="Subscription Plan" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master" AutoEventWireup="true" CodeFile="VendorSubscription.aspx.cs" Inherits="Vendor_VendorSubscription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<style>
.vs-page{color:#263650}.vs-head{display:flex;justify-content:space-between;align-items:flex-start;gap:15px;flex-wrap:wrap;margin-bottom:24px}.vs-eyebrow{font-size:11px;letter-spacing:1.4px;text-transform:uppercase;color:#8190a7;font-weight:800;margin-bottom:6px}.vs-title{font:800 25px 'Manrope',sans-serif;color:#24334e;margin:0}.vs-subtitle{font-size:13px;color:#8290a6;margin:7px 0 0}.vs-note-pill{padding:10px 14px;border-radius:13px;background:#e8edf5;box-shadow:5px 5px 11px #cbd2dd,-5px -5px 11px #fff;color:#586985;font-size:12px;font-weight:700}.vs-alert{display:none;align-items:center;gap:10px;padding:13px 16px;border-radius:14px;margin-bottom:20px;font-size:13px;font-weight:700}.vs-alert.show{display:flex}.vs-alert.success{background:#e0f5eb;color:#18734f}.vs-alert.warning{background:#fff0d8;color:#98621d}.vs-alert.info{background:#e2edff;color:#285aa5}.vs-current{padding:22px;border-radius:20px;background:#e8edf5;box-shadow:7px 7px 16px #cbd2dd,-7px -7px 16px #fff;margin-bottom:28px}.vs-current-head{display:flex;justify-content:space-between;align-items:center;gap:10px;margin-bottom:17px}.vs-section-label{font-size:11px;letter-spacing:1.2px;text-transform:uppercase;color:#8794a9;font-weight:800}.vs-current-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:12px}.vs-current-item{padding:13px 15px;border-radius:13px;background:#e8edf5;box-shadow:inset 4px 4px 8px #cbd2dd,inset -4px -4px 8px #fff}.vs-current-label{font-size:10px;color:#8794a9;text-transform:uppercase;font-weight:800;letter-spacing:.7px;margin-bottom:7px}.vs-current-value{font:800 17px 'Manrope',sans-serif;color:#293954}.vs-status{display:inline-flex;align-items:center;gap:7px;padding:6px 10px;border-radius:20px;background:#dcefe7;color:#197650;font-size:11px;font-weight:800}.vs-status.inactive{background:#e1e6ee;color:#6f7d91}.vs-dot{width:7px;height:7px;border-radius:50%;background:currentColor}.vs-section-head{display:flex;justify-content:space-between;align-items:end;gap:12px;flex-wrap:wrap;margin-bottom:16px}.vs-section-title{font:800 17px 'Manrope',sans-serif;color:#2a3954;margin:0}.vs-section-caption{font-size:11px;color:#8996aa;margin:5px 0 0}.vs-plans{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:15px;margin-bottom:22px}.vs-plan{position:relative;display:flex;flex-direction:column;padding:21px 18px 18px;border-radius:19px;background:#e8edf5;box-shadow:7px 7px 15px #cbd2dd,-7px -7px 15px #fff;min-width:0;transition:transform .2s,box-shadow .2s}.vs-plan:hover{transform:translateY(-3px);box-shadow:9px 9px 18px #c6ceda,-9px -9px 18px #fff}.vs-plan-top{display:flex;align-items:center;gap:11px;margin-bottom:15px}.vs-plan-icon{width:42px;height:42px;display:flex;align-items:center;justify-content:center;border-radius:14px;color:#fff;background:linear-gradient(135deg,#8c75e9,#6954c4);box-shadow:0 6px 12px #bfc7d5;font-size:16px}.vs-plan.pro .vs-plan-icon{background:linear-gradient(135deg,#4d8bec,#285bb9)}.vs-plan.featured .vs-plan-icon{background:linear-gradient(135deg,#f5b85d,#df8b2d)}.vs-plan.combo .vs-plan-icon{background:linear-gradient(135deg,#ed7884,#cb435d)}.vs-plan-name{font:800 15px 'Manrope',sans-serif;color:#293954}.vs-plan-caption{font-size:10px;color:#8996aa;margin-top:3px}.vs-price{font:800 27px 'Manrope',sans-serif;color:#263650;margin:0 0 2px}.vs-period{font-size:11px;color:#8b97aa;margin-bottom:15px}.vs-divider{height:1px;background:#d5dce6;margin-bottom:14px}.vs-features{list-style:none;padding:0;margin:0 0 18px;display:grid;gap:10px;flex:1}.vs-features li{font-size:11px;color:#5c6b83;display:flex;gap:8px;align-items:center}.vs-features i{color:#23966b;font-size:11px}.vs-plan-btn{width:100%;border:0!important;border-radius:11px!important;padding:11px 12px!important;font-size:12px!important;font-weight:800!important;background:#dce5f3!important;color:#315b9e!important;box-shadow:4px 4px 8px #cbd2dd,-4px -4px 8px #fff!important;transition:all .2s}.vs-plan-btn:hover{background:#d4e1f4!important;transform:translateY(-1px)}.vs-plan.pro .vs-plan-btn{background:linear-gradient(135deg,#477fe5,#2859b7)!important;color:#fff!important;box-shadow:0 6px 13px rgba(44,96,185,.23)!important}.vs-plan.featured .vs-plan-btn{color:#98621d!important;background:#f5e8d0!important}.vs-plan.combo{outline:1px solid #e5b3bd}.vs-plan.combo .vs-plan-btn{background:linear-gradient(135deg,#e66f7c,#c94b61)!important;color:#fff!important;box-shadow:0 6px 13px rgba(201,75,97,.2)!important}.vs-ribbon{position:absolute;right:13px;top:13px;padding:5px 8px;border-radius:8px;background:#f7dfe3;color:#b13c52;font-size:9px;font-weight:900}.vs-payment{display:flex;align-items:flex-start;gap:12px;padding:16px 18px;border-radius:16px;background:#e8edf5;box-shadow:inset 4px 4px 8px #cbd2dd,inset -4px -4px 8px #fff;color:#697891;font-size:12px;line-height:1.7}.vs-payment i{color:#d18b36;font-size:17px;margin-top:2px}@media(max-width:1050px){.vs-plans{grid-template-columns:repeat(2,minmax(0,1fr))}}@media(max-width:700px){.vs-title{font-size:22px}.vs-current-grid{grid-template-columns:repeat(2,minmax(0,1fr))}.vs-current{padding:16px}.vs-plans{gap:12px}}@media(max-width:480px){.vs-plans{grid-template-columns:1fr}.vs-plan{padding:19px}.vs-current-grid{gap:9px}.vs-current-item{padding:11px}}
</style>

<div class="vs-page">
    <div class="vs-head">
        <div><div class="vs-eyebrow">Vendor workspace / Membership</div><h3 class="vs-title">Subscription Plans</h3><p class="vs-subtitle">Manage your current plan and choose the right package to grow your dealership.</p></div>
        <div class="vs-note-pill"><i class="fas fa-shield-alt"></i> Secure plan requests</div>
    </div>

    <div class="vs-alert" id="subAlert"><i id="alertIcon" class="fas fa-circle-info"></i><asp:Label ID="lblMsg" runat="server"></asp:Label></div>

    <section class="vs-current">
        <div class="vs-current-head"><span class="vs-section-label"><i class="fas fa-bolt"></i> Your current subscription</span><span class="vs-status" id="planStatusBadge"><span class="vs-dot"></span><asp:Label ID="lblPlan" runat="server">No Active Plan</asp:Label></span></div>
        <div class="vs-current-grid">
            <div class="vs-current-item"><div class="vs-current-label"><i class="fas fa-calendar-alt"></i> Expiry date</div><div class="vs-current-value"><asp:Label ID="lblExpiry" runat="server">—</asp:Label></div></div>
            <div class="vs-current-item"><div class="vs-current-label"><i class="fas fa-motorcycle"></i> Bike limit</div><div class="vs-current-value"><asp:Label ID="lblBikeLimit" runat="server">0</asp:Label> bikes</div></div>
            <div class="vs-current-item"><div class="vs-current-label"><i class="fas fa-star"></i> Featured slots</div><div class="vs-current-value"><asp:Label ID="lblFeaturedLimit" runat="server">0</asp:Label></div></div>
            <div class="vs-current-item"><div class="vs-current-label"><i class="fas fa-layer-group"></i> Plan type</div><div class="vs-current-value"><asp:Label ID="lblPlan" runat="server">No Active Plan</asp:Label></div></div>
        </div>
    </section>

    <div class="vs-section-head"><div><h4 class="vs-section-title">Choose a plan</h4><p class="vs-section-caption">Compare packages and submit a subscription request.</p></div><span class="vs-section-caption"><i class="fas fa-info-circle"></i> One pending request at a time</span></div>

    <div class="vs-plans">
        <div class="vs-plan basic">
            <div class="vs-plan-top"><div class="vs-plan-icon"><i class="fas fa-bolt"></i></div><div><div class="vs-plan-name">Basic</div><div class="vs-plan-caption">For getting started</div></div></div>
            <div class="vs-price">₹999</div><div class="vs-period">per month</div><div class="vs-divider"></div>
            <ul class="vs-features"><li><i class="fas fa-check-circle"></i> 10 bike listings</li><li><i class="fas fa-check-circle"></i> Dealer profile</li><li><i class="fas fa-check-circle"></i> Enquiry management</li><li><i class="fas fa-check-circle"></i> Standard listing visibility</li></ul>
            <asp:Button ID="Button1" runat="server" Text="Request Basic" CssClass="vs-plan-btn" OnClick="btnBasic_Click" />
        </div>
        <div class="vs-plan pro">
            <div class="vs-plan-top"><div class="vs-plan-icon"><i class="fas fa-layer-group"></i></div><div><div class="vs-plan-name">Pro</div><div class="vs-plan-caption">For growing dealerships</div></div></div>
            <div class="vs-price">₹1,999</div><div class="vs-period">per month</div><div class="vs-divider"></div>
            <ul class="vs-features"><li><i class="fas fa-check-circle"></i> 50 bike listings</li><li><i class="fas fa-check-circle"></i> Verified badge</li><li><i class="fas fa-check-circle"></i> Enquiry management</li><li><i class="fas fa-check-circle"></i> Analytics access</li></ul>
            <asp:Button ID="Button2" runat="server" Text="Request Pro" CssClass="vs-plan-btn" OnClick="btnPro_Click" />
        </div>
        <div class="vs-plan featured">
            <div class="vs-plan-top"><div class="vs-plan-icon"><i class="fas fa-star"></i></div><div><div class="vs-plan-name">Featured</div><div class="vs-plan-caption">Boost listing visibility</div></div></div>
            <div class="vs-price">₹499</div><div class="vs-period">per featured slot</div><div class="vs-divider"></div>
            <ul class="vs-features"><li><i class="fas fa-check-circle"></i> 1 featured slot</li><li><i class="fas fa-check-circle"></i> Homepage placement</li><li><i class="fas fa-check-circle"></i> Search priority</li><li><i class="fas fa-check-circle"></i> More listing exposure</li></ul>
            <asp:Button ID="Button3" runat="server" Text="Request Featured" CssClass="vs-plan-btn" OnClick="btnFeatured_Click" />
        </div>
        <div class="vs-plan combo">
            <span class="vs-ribbon"><i class="fas fa-crown"></i> BEST VALUE</span>
            <div class="vs-plan-top"><div class="vs-plan-icon"><i class="fas fa-crown"></i></div><div><div class="vs-plan-name">Combo</div><div class="vs-plan-caption">Complete growth package</div></div></div>
            <div class="vs-price">₹2,499</div><div class="vs-period">per month</div><div class="vs-divider"></div>
            <ul class="vs-features"><li><i class="fas fa-check-circle"></i> 50 bike listings</li><li><i class="fas fa-check-circle"></i> 3 featured slots</li><li><i class="fas fa-check-circle"></i> Verified badge</li><li><i class="fas fa-check-circle"></i> Analytics access</li><li><i class="fas fa-check-circle"></i> Priority support</li></ul>
            <asp:Button ID="Button4" runat="server" Text="Request Combo" CssClass="vs-plan-btn" OnClick="btnCombo_Click" />
        </div>
    </div>

    <div class="vs-payment"><i class="fas fa-circle-info"></i><div><strong>How activation works:</strong> Submit your plan request using the button above, then pay cash to the admin. As described by the existing process, activation is expected within 24 hours after payment. For assistance, contact <strong>+91-9001234567</strong>.</div></div>
</div>

<script>
(function () {
    var alertBox = document.getElementById('subAlert');
    var icon = document.getElementById('alertIcon');
    var message = document.getElementById('<%= lblMsg.ClientID %>');
    var badge = document.getElementById('planStatusBadge');
    var planLabel = document.getElementById('<%= lblPlan.ClientID %>');
    if (message && message.textContent.trim()) {
        var text = message.textContent.trim().toLowerCase();
        alertBox.classList.add('show');
        if (text.indexOf('submitted') >= 0 || text.indexOf('success') >= 0) {
            alertBox.classList.add('success'); icon.className = 'fas fa-circle-check';
        } else if (text.indexOf('pending') >= 0 || text.indexOf('already') >= 0) {
            alertBox.classList.add('warning'); icon.className = 'fas fa-triangle-exclamation';
        } else {
            alertBox.classList.add('info'); icon.className = 'fas fa-circle-info';
        }
    }
    if (badge && planLabel) {
        badge.className = (planLabel.textContent.trim() === '' || planLabel.textContent.trim() === 'No Active Plan') ? 'vs-status inactive' : 'vs-status';
    }
})();
</script>
</asp:Content>