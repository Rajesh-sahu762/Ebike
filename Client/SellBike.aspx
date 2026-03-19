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
    :root {
        --primary-ev: #ff6b35;
        --dark-ev: #0f172a;
        --text-ev: #64748b;
    }

    .sell-container {
        padding: 100px 15px;
        background: #f8fafc;
        min-height: 100vh;
        font-family: 'Outfit', sans-serif;
    }

    .sell-glass-card {
        max-width: 900px;
        margin: 0 auto;
        background: #ffffff;
        border-radius: 30px;
        padding: 50px;
        box-shadow: 0 20px 50px rgba(0,0,0,0.05);
        border: 1px solid #f1f5f9;
    }

    .icon-box {
        width: 70px; height: 70px; background: rgba(255,107,53,0.1);
        color: var(--primary-ev); border-radius: 20px;
        display: flex; align-items: center; justify-content: center;
        font-size: 30px; margin: 0 auto 20px;
    }

    .sell-title { font-size: 32px; font-weight: 800; color: var(--dark-ev); margin-bottom: 10px; }
    .sell-sub { color: var(--text-ev); font-size: 16px; margin-bottom: 40px; }

    .form-section-title {
        font-size: 14px; text-transform: uppercase; letter-spacing: 1px;
        font-weight: 700; color: var(--primary-ev);
        margin: 30px 0 20px; display: flex; align-items: center; gap: 10px;
    }

    .form-label { font-size: 14px; font-weight: 600; color: #334155; margin-bottom: 8px; }

    /* Custom Inputs */
    .form-control, .form-select {
        border: 1.5px solid #e2e8f0; border-radius: 12px;
        padding: 12px 15px; font-size: 15px; transition: 0.3s;
    }

    .form-control:focus {
        border-color: var(--primary-ev); box-shadow: 0 0 0 4px rgba(255,107,53,0.1);
    }

    .input-group-custom { position: relative; }
    .input-group-custom i {
        position: absolute; left: 15px; top: 50%; transform: translateY(-50%);
        color: #94a3b8;
    }
    .input-group-custom .form-control { padding-left: 45px; }

    .price-input .currency-symbol {
        position: absolute; left: 15px; top: 50%; transform: translateY(-50%);
        font-weight: 700; color: var(--dark-ev);
    }

    /* Upload Cards */
    .upload-card {
        border: 2px dashed #e2e8f0; border-radius: 15px;
        padding: 25px 15px; text-align: center; cursor: pointer;
        transition: 0.3s; position: relative; overflow: hidden;
    }
    .upload-card:hover { border-color: var(--primary-ev); background: rgba(255,107,53,0.02); }
    .upload-card i { font-size: 24px; color: #94a3b8; display: block; margin-bottom: 8px; }
    .upload-card span { font-size: 12px; font-weight: 600; color: #64748b; }
    .fu-hidden { position: absolute; left: 0; top: 0; opacity: 0; width: 100%; height: 100%; cursor: pointer; }

    .upload-hint { font-size: 13px; color: #94a3b8; margin-bottom: 15px; }

    /* Button */
    .btn-premium-sell {
        width: 100%; padding: 16px; background: var(--dark-ev);
        color: #fff; border: none; border-radius: 15px;
        font-size: 16px; font-weight: 700; margin-top: 30px;
        transition: 0.3s; cursor: pointer;
    }
    .btn-premium-sell:hover { background: var(--primary-ev); transform: translateY(-3px); box-shadow: 0 10px 20px rgba(255,107,53,0.3); }

    .status-msg { font-weight: 600; font-size: 14px; }

    @media (max-width: 768px) {
        .sell-glass-card { padding: 30px 20px; }
        .sell-title { font-size: 24px; }
    }
</style>

<script>
    // Just a small UI helper for image preview names
    function previewImg(input, boxId) {
        if (input.files && input.files[0]) {
            let name = input.files[0].name;
            document.getElementById(boxId).innerHTML = "<div style='font-size:11px; color:#ff6b35; margin-top:5px;'>Selected: " + name + "</div>";
        }
    }
</script>

</asp:Content>