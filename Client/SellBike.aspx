<%@ Page Title="Sell Your Bike"
    Language="C#"
    MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true"
    CodeFile="SellBike.aspx.cs"
    Inherits="Client_SellBike" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="sell-container">
    <div class="sell-glass-card">
        <div class="sell-header text-center">
            <div class="icon-box">
                <i class="fa fa-motorcycle"></i>
            </div>
            <h1 class="sell-title">Sell Your Electric Bike</h1>
            <p class="sell-sub">Fill in the details below to list your bike on India's #1 EV Marketplace.</p>
        </div>

        <div class="sell-form-body">
            <div class="form-section-title"><i class="fa fa-info-circle"></i> Basic Details</div>
            <div class="row">
                <div class="col-md-6 mb-4">
                    <label class="form-label">Bike Brand</label>
                    <div class="input-group-custom">
                        <i class="fa fa-tag"></i>
                        <asp:TextBox ID="txtBrand" runat="server" CssClass="form-control" placeholder="e.g. Ola, Ather, TVS"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <label class="form-label">Model Name</label>
                    <div class="input-group-custom">
                        <i class="fa fa-cube"></i>
                        <asp:TextBox ID="txtModel" runat="server" CssClass="form-control" placeholder="e.g. S1 Pro, 450X"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-4 mb-4">
                    <label class="form-label">Manufacture Year</label>
                    <asp:TextBox ID="txtYear" runat="server" CssClass="form-control" placeholder="YYYY"></asp:TextBox>
                </div>
                <div class="col-md-4 mb-4">
                    <label class="form-label">KM Driven</label>
                    <asp:TextBox ID="txtKM" runat="server" CssClass="form-control" placeholder="e.g. 5000"></asp:TextBox>
                </div>
                <div class="col-md-4 mb-4">
                    <label class="form-label">Owner</label>
                    <asp:DropDownList ID="ddlOwner" runat="server" CssClass="form-select">
                        <asp:ListItem Value="1">First Owner</asp:ListItem>
                        <asp:ListItem Value="2">Second Owner</asp:ListItem>
                        <asp:ListItem Value="3">Third Owner</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="form-section-title"><i class="fa fa-heartbeat"></i> Health & Pricing</div>
            <div class="row">
                <div class="col-md-6 mb-4">
                    <label class="form-label">Bike Condition</label>
                    <asp:DropDownList ID="ddlCondition" runat="server" CssClass="form-select">
                        <asp:ListItem>Excellent</asp:ListItem>
                        <asp:ListItem>Good</asp:ListItem>
                        <asp:ListItem>Average</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-6 mb-4">
                    <label class="form-label">Battery Health</label>
                    <asp:DropDownList ID="ddlBattery" runat="server" CssClass="form-select">
                        <asp:ListItem>90%+</asp:ListItem>
                        <asp:ListItem>80%+</asp:ListItem>
                        <asp:ListItem>70%+</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-12 mb-4">
                    <label class="form-label">Expected Price (₹)</label>
                    <div class="input-group-custom price-input">
                        <span class="currency-symbol">₹</span>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="0.00"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-12 mb-4">
                    <label class="form-label">Description (Optional)</label>
                    <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" placeholder="Tell buyers about your bike's features, insurance, or extra accessories..."></asp:TextBox>
                </div>
            </div>

            <div class="form-section-title"><i class="fa fa-camera"></i> Upload Photos</div>
            <p class="upload-hint">Add clear photos from different angles for faster sales.</p>
            <div class="row mb-4">
                <div class="col-md-4 mb-3">
                    <div class="upload-card">
                        <i class="fa fa-cloud-upload-alt"></i>
                        <span>Main Photo *</span>
                        <asp:FileUpload ID="fu1" runat="server" CssClass="fu-hidden" onchange="previewImg(this, 'p1')"/>
                        <div id="p1" class="preview-box"></div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="upload-card">
                        <i class="fa fa-image"></i>
                        <span>Side View</span>
                        <asp:FileUpload ID="fu2" runat="server" CssClass="fu-hidden" onchange="previewImg(this, 'p2')"/>
                        <div id="p2" class="preview-box"></div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="upload-card">
                        <i class="fa fa-image"></i>
                        <span>Dashboard/KM</span>
                        <asp:FileUpload ID="fu3" runat="server" CssClass="fu-hidden" onchange="previewImg(this, 'p3')"/>
                        <div id="p3" class="preview-box"></div>
                    </div>
                </div>
            </div>

            <asp:Button ID="btnSubmit" runat="server" Text="Publish My Listing" CssClass="btn-premium-sell" OnClick="btnSubmit_Click"/>
            
            <div class="text-center mt-3">
                <asp:Label ID="lblMsg" runat="server" CssClass="status-msg"></asp:Label>
            </div>
        </div>
    </div>
</div>

<style>
    /* ===== Electric Pulse - Sell Bike ===== */
    .sell-container {
        padding: 50px 15px 90px;
        background: var(--ep-bg, #F4F8FC);
        min-height: 100vh;
        font-family: var(--font-body, 'Inter', sans-serif);
    }

    .sell-glass-card {
        max-width: 860px;
        margin: 0 auto;
        background: #FFFFFF;
        border-radius: 24px;
        padding: 48px;
        box-shadow: 0 4px 24px rgba(7, 26, 47, 0.05);
        border: 1px solid var(--ep-border, #E2E8F0);
    }

    .icon-box {
        width: 68px;
        height: 68px;
        background: #ECFEFF;
        color: var(--ep-secondary-cyan, #0891B2);
        border: 1px solid rgba(34, 211, 238, 0.35);
        border-radius: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 28px;
        margin: 0 auto 20px;
    }

    .sell-title {
        font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
        font-size: 30px;
        font-weight: 800;
        color: var(--ep-heading, #0F172A);
        margin-bottom: 8px;
    }

    .sell-sub {
        color: var(--ep-text-muted, #64748B);
        font-size: 15px;
        margin-bottom: 36px;
    }

    .form-section-title {
        font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
        font-size: 13px;
        text-transform: uppercase;
        letter-spacing: 0.8px;
        font-weight: 800;
        color: var(--ep-secondary-cyan, #0891B2);
        margin: 28px 0 18px;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .form-label {
        font-size: 13px;
        font-weight: 700;
        color: var(--ep-text, #334155);
        margin-bottom: 6px;
        display: block;
    }

    /* Custom Inputs */
    .form-control, .form-select {
        border: 1.5px solid var(--ep-border, #E2E8F0);
        border-radius: 12px;
        padding: 11px 16px;
        font-size: 14px;
        font-family: var(--font-body, 'Inter', sans-serif);
        color: var(--ep-text, #334155);
        transition: all 0.2s ease;
        background: #FFFFFF;
    }

    .form-control:focus, .form-select:focus {
        border-color: var(--ep-secondary-cyan, #0891B2);
        box-shadow: 0 0 0 3px rgba(8, 145, 178, 0.15);
        outline: none;
    }

    .input-group-custom {
        position: relative;
    }

    .input-group-custom i {
        position: absolute;
        left: 16px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--ep-text-muted, #64748B);
        font-size: 14px;
    }

    .input-group-custom .form-control {
        padding-left: 44px;
    }

    .price-input .currency-symbol {
        position: absolute;
        left: 16px;
        top: 50%;
        transform: translateY(-50%);
        font-weight: 700;
        color: var(--ep-primary-navy, #071A2F);
        font-size: 16px;
    }

    /* Upload Cards */
    .upload-card {
        border: 2px dashed #CBD5E1;
        border-radius: 16px;
        padding: 24px 16px;
        text-align: center;
        cursor: pointer;
        transition: all 0.25s ease;
        position: relative;
        overflow: hidden;
        background: #F8FAFC;
    }

    .upload-card:hover {
        border-color: var(--ep-secondary-cyan, #0891B2);
        background: #ECFEFF;
    }

    .upload-card i {
        font-size: 26px;
        color: var(--ep-secondary-cyan, #0891B2);
        display: block;
        margin-bottom: 8px;
    }

    .upload-card span {
        font-size: 12px;
        font-weight: 700;
        color: var(--ep-text, #334155);
    }

    .fu-hidden {
        position: absolute;
        left: 0;
        top: 0;
        opacity: 0;
        width: 100%;
        height: 100%;
        cursor: pointer;
    }

    .upload-hint {
        font-size: 13px;
        color: var(--ep-text-muted, #64748B);
        margin-bottom: 16px;
    }

    /* Button */
    .btn-premium-sell {
        width: 100%;
        padding: 15px;
        background: linear-gradient(135deg, var(--ep-brand-orange, #F97316), #EA580C);
        color: #FFFFFF;
        border: none;
        border-radius: 12px;
        font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
        font-size: 16px;
        font-weight: 700;
        margin-top: 24px;
        transition: all 0.25s ease;
        cursor: pointer;
        box-shadow: 0 6px 18px rgba(249, 115, 22, 0.35);
    }

    .btn-premium-sell:hover {
        background: linear-gradient(135deg, #FB923C, var(--ep-brand-orange, #F97316));
        transform: translateY(-2px);
        box-shadow: 0 10px 24px rgba(249, 115, 22, 0.45);
    }

    .status-msg {
        font-weight: 600;
        font-size: 14px;
    }

    @media (max-width: 768px) {
        .sell-glass-card { padding: 28px 18px; }
        .sell-title { font-size: 24px; }
    }
</style>

<script>
    function previewImg(input, boxId) {
        if (input.files && input.files[0]) {
            let name = input.files[0].name;
            let box = document.getElementById(boxId);
            if (box) {
                box.innerHTML = "";
                let div = document.createElement("div");
                div.style.fontSize = "12px";
                div.style.fontWeight = "600";
                div.style.color = "#0891B2";
                div.style.marginTop = "6px";
                div.textContent = "Selected: " + name;
                box.appendChild(div);
            }
        }
    }
</script>

</asp:Content>