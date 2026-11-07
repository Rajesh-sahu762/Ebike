<%@ Page Title="Add Bike" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="AddBike.aspx.cs"
    Inherits="Vendor_AddBike" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .ab-page { color: #263449; }
        .ab-heading { display:flex; align-items:flex-end; justify-content:space-between; gap:16px; margin:2px 2px 22px; }
        .ab-eyebrow { display:block; margin-bottom:5px; color:#8491a3; font-family:'Quicksand',sans-serif; font-size:10px; font-weight:800; letter-spacing:1.5px; text-transform:uppercase; }
        .ab-title { margin:0; color:#263449; font-family:'Manrope',sans-serif; font-size:clamp(24px,3vw,31px); font-weight:800; letter-spacing:-.8px; }
        .ab-subtitle { margin:6px 0 0; color:#8290a2; font-size:12px; }
        .ab-form-panel { padding:24px; border:1px solid rgba(255,255,255,.8); border-radius:19px; background:#e8edf5; box-shadow:7px 7px 16px rgba(163,177,198,.42),-7px -7px 16px rgba(255,255,255,.86); }
        .ab-section { margin-bottom:23px; }
        .ab-section:last-of-type { margin-bottom:0; }
        .ab-section-heading { display:flex; align-items:center; gap:11px; margin:0 0 16px; padding-bottom:12px; border-bottom:1px solid rgba(126,145,168,.18); }
        .ab-section-icon { display:grid; place-items:center; width:35px; height:35px; flex:0 0 35px; border-radius:11px; color:#1677d2; background:#e8edf5; box-shadow:4px 4px 8px rgba(163,177,198,.32),-4px -4px 8px rgba(255,255,255,.82); font-size:14px; }
        .ab-section-title { margin:0; color:#35455b; font-family:'Manrope',sans-serif; font-size:14px; font-weight:800; }
        .ab-section-caption { display:block; margin-top:3px; color:#8995a5; font-size:10px; }
        .ab-field { min-width:0; }
        .ab-label { display:block; margin:0 0 7px 2px; color:#586980; font-size:11px; font-weight:800; }
        .ab-label .required { color:#df5360; }
        .ab-input, .ab-select, .ab-textarea {
            display:block; width:100%; min-height:46px; padding:10px 13px; border:1px solid rgba(255,255,255,.75);
            border-radius:11px; outline:none; background:#e8edf5; color:#34445b; font-family:'Nunito Sans',sans-serif;
            font-size:12px; box-shadow:inset 3px 3px 6px rgba(163,177,198,.3),inset -3px -3px 6px rgba(255,255,255,.85);
            transition:border-color .2s,box-shadow .2s;
        }
        .ab-input::placeholder, .ab-textarea::placeholder { color:#9aa6b5; }
        .ab-input:focus, .ab-select:focus, .ab-textarea:focus { border-color:rgba(22,119,210,.48); box-shadow:inset 2px 2px 4px rgba(163,177,198,.2),inset -2px -2px 4px rgba(255,255,255,.8),0 0 0 3px rgba(22,119,210,.1); }
        .ab-select { appearance:auto; }
        .ab-textarea { min-height:104px; resize:vertical; }
        .ab-rental-box { display:flex; align-items:center; justify-content:space-between; gap:15px; padding:14px 16px; border:1px solid rgba(255,255,255,.75); border-radius:13px; background:#e8edf5; box-shadow:inset 3px 3px 6px rgba(163,177,198,.22),inset -3px -3px 6px rgba(255,255,255,.82); }
        .ab-rental-copy strong { display:block; color:#35455b; font-size:12px; font-weight:800; }
        .ab-rental-copy span { display:block; margin-top:3px; color:#8995a5; font-size:10px; }
        .ab-rental-box input[type=checkbox] { width:18px; height:18px; accent-color:#1677d2; cursor:pointer; }
        .ab-rental-box label { margin-left:7px; color:#35455b; font-size:12px; font-weight:800; cursor:pointer; }
        .ab-upload-card { height:100%; padding:14px; border:1px dashed rgba(103,129,160,.45); border-radius:13px; background:rgba(255,255,255,.22); }
        .ab-upload-card .ab-label { margin-bottom:9px; }
        .ab-file { display:block; width:100%; max-width:100%; color:#718096; font-family:'Nunito Sans',sans-serif; font-size:10px; }
        .ab-file::file-selector-button { margin-right:9px; padding:8px 10px; border:0; border-radius:8px; background:#e8edf5; color:#176fc3; box-shadow:3px 3px 6px rgba(163,177,198,.32),-3px -3px 6px rgba(255,255,255,.8); font-family:'Nunito Sans',sans-serif; font-size:10px; font-weight:800; cursor:pointer; }
        .ab-actions { display:flex; align-items:center; gap:15px; flex-wrap:wrap; margin-top:24px; padding-top:20px; border-top:1px solid rgba(126,145,168,.18); }
        .ab-submit { display:inline-flex; align-items:center; justify-content:center; gap:9px; min-width:210px; min-height:47px; padding:0 22px; border:0 !important; border-radius:12px !important; background:linear-gradient(135deg,#218fe0,#176fc3) !important; color:#fff !important; box-shadow:6px 6px 12px rgba(163,177,198,.42),-5px -5px 10px rgba(255,255,255,.8); font-family:'Manrope',sans-serif; font-size:11px !important; font-weight:800 !important; letter-spacing:.5px; transition:transform .2s,filter .2s,box-shadow .2s; }
        .ab-submit:hover { filter:brightness(1.06); transform:translateY(-1px); }
        .ab-submit:active { box-shadow:inset 3px 3px 6px rgba(8,55,105,.28); transform:translateY(0); }
        .ab-message { display:block; color:#159568; font-size:11px; font-weight:800; line-height:1.6; }
        @media(max-width:767px) {
            .ab-heading { align-items:flex-start; }
            .ab-form-panel { padding:17px; }
            .ab-section { margin-bottom:20px; }
            .ab-actions { align-items:stretch; }
            .ab-submit { width:100%; }
        }
        @media(max-width:420px) {
            .ab-form-panel { padding:14px; border-radius:15px; }
            .ab-section-heading { margin-bottom:13px; }
            .ab-rental-box { align-items:flex-start; flex-direction:column; }
        }
    </style>

    <div class="ab-page">
        <div class="ab-heading">
            <div>
                <span class="ab-eyebrow">Inventory management</span>
                <h1 class="ab-title">Add New Bike</h1>
                <p class="ab-subtitle">Enter bike specifications and images to submit your listing for approval.</p>
            </div>
        </div>

        <div class="ab-form-panel">
            <section class="ab-section">
                <div class="ab-section-heading">
                    <span class="ab-section-icon"><i class="fa-solid fa-motorcycle"></i></span>
                    <div>
                        <h2 class="ab-section-title">Basic information</h2>
                        <span class="ab-section-caption">Add the brand, model and pricing details.</span>
                    </div>
                </div>

                <div class="row g-3">
                    <div class="col-12 col-md-6 ab-field">
                        <label class="ab-label" for="<%= ddlBrand.ClientID %>">Brand <span class="required">*</span></label>
                        <asp:DropDownList ID="ddlBrand" runat="server" CssClass="form-control ab-select"></asp:DropDownList>
                    </div>
                    <div class="col-12 col-md-6 ab-field">
                        <label class="ab-label" for="<%= txtModel.ClientID %>">Model name <span class="required">*</span></label>
                        <asp:TextBox ID="txtModel" runat="server" CssClass="form-control ab-input" placeholder="e.g. Electric scooter model"></asp:TextBox>
                    </div>
                    <div class="col-12 col-md-6 ab-field">
                        <label class="ab-label" for="<%= txtPrice.ClientID %>">Selling price (₹)</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control ab-input" placeholder="Enter selling price"></asp:TextBox>
                    </div>
                </div>
            </section>

            <section class="ab-section">
                <div class="ab-section-heading">
                    <span class="ab-section-icon"><i class="fa-solid fa-calendar-days"></i></span>
                    <div>
                        <h2 class="ab-section-title">Rental options</h2>
                        <span class="ab-section-caption">Optionally make this bike available for rent.</span>
                    </div>
                </div>

                <div class="ab-rental-box mb-3">
                    <div class="ab-rental-copy">
                        <strong>Rental availability</strong>
                        <span>Enable this option if customers can rent this bike.</span>
                    </div>
                    <div><asp:CheckBox ID="chkIsForRent" runat="server" Text="Available for rental" AutoPostBack="false" /></div>
                </div>

                <div class="row g-3">
                    <div class="col-12 col-md-4 ab-field">
                        <label class="ab-label" for="<%= txtRentDay.ClientID %>">Rent per day (₹)</label>
                        <asp:TextBox ID="txtRentDay" runat="server" CssClass="form-control ab-input" placeholder="Daily rental amount"></asp:TextBox>
                    </div>
                    <div class="col-12 col-md-4 ab-field">
                        <label class="ab-label" for="<%= txtRentWeek.ClientID %>">Rent per week (₹)</label>
                        <asp:TextBox ID="txtRentWeek" runat="server" CssClass="form-control ab-input" placeholder="Weekly rental amount"></asp:TextBox>
                    </div>
                    <div class="col-12 col-md-4 ab-field">
                        <label class="ab-label" for="<%= txtRentMonth.ClientID %>">Rent per month (₹)</label>
                        <asp:TextBox ID="txtRentMonth" runat="server" CssClass="form-control ab-input" placeholder="Monthly rental amount"></asp:TextBox>
                    </div>
                </div>
            </section>

            <section class="ab-section">
                <div class="ab-section-heading">
                    <span class="ab-section-icon"><i class="fa-solid fa-gauge-high"></i></span>
                    <div>
                        <h2 class="ab-section-title">Technical specifications</h2>
                        <span class="ab-section-caption">Share the key performance and battery details.</span>
                    </div>
                </div>

                <div class="row g-3">
                    <div class="col-12 col-md-6 ab-field">
                        <label class="ab-label" for="<%= txtRange.ClientID %>">Range (KM)</label>
                        <asp:TextBox ID="txtRange" runat="server" CssClass="form-control ab-input" placeholder="e.g. 120"></asp:TextBox>
                    </div>
                    <div class="col-12 col-md-6 ab-field">
                        <label class="ab-label" for="<%= txtBattery.ClientID %>">Battery type</label>
                        <asp:TextBox ID="txtBattery" runat="server" CssClass="form-control ab-input" placeholder="e.g. Lithium-ion"></asp:TextBox>
                    </div>
                    <div class="col-12 col-md-6 ab-field">
                        <label class="ab-label" for="<%= txtMotor.ClientID %>">Motor power</label>
                        <asp:TextBox ID="txtMotor" runat="server" CssClass="form-control ab-input" placeholder="e.g. 3 kW"></asp:TextBox>
                    </div>
                    <div class="col-12 col-md-6 ab-field">
                        <label class="ab-label" for="<%= txtSpeed.ClientID %>">Top speed (KM/H)</label>
                        <asp:TextBox ID="txtSpeed" runat="server" CssClass="form-control ab-input" placeholder="e.g. 80"></asp:TextBox>
                    </div>
                    <div class="col-12 col-md-6 ab-field">
                        <label class="ab-label" for="<%= txtCharge.ClientID %>">Charging time</label>
                        <asp:TextBox ID="txtCharge" runat="server" CssClass="form-control ab-input" placeholder="e.g. 4 hours"></asp:TextBox>
                    </div>
                    <div class="col-12 ab-field">
                        <label class="ab-label" for="<%= txtDesc.ClientID %>">Description</label>
                        <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control ab-textarea" placeholder="Describe the bike, its features and condition..."></asp:TextBox>
                    </div>
                </div>
            </section>

            <section class="ab-section">
                <div class="ab-section-heading">
                    <span class="ab-section-icon"><i class="fa-regular fa-images"></i></span>
                    <div>
                        <h2 class="ab-section-title">Bike images</h2>
                        <span class="ab-section-caption">Upload up to three images for your listing.</span>
                    </div>
                </div>

                <div class="row g-3">
                    <div class="col-12 col-md-4">
                        <div class="ab-upload-card">
                            <label class="ab-label" for="<%= fu1.ClientID %>">Image 1</label>
                            <asp:FileUpload ID="fu1" runat="server" CssClass="ab-file" />
                        </div>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="ab-upload-card">
                            <label class="ab-label" for="<%= fu2.ClientID %>">Image 2</label>
                            <asp:FileUpload ID="fu2" runat="server" CssClass="ab-file" />
                        </div>
                    </div>
                    <div class="col-12 col-md-4">
                        <div class="ab-upload-card">
                            <label class="ab-label" for="<%= fu3.ClientID %>">Image 3</label>
                            <asp:FileUpload ID="fu3" runat="server" CssClass="ab-file" />
                        </div>
                    </div>
                </div>
            </section>

            <div class="ab-actions">
                <asp:Button ID="btnAddBike" runat="server" Text="Submit for Approval" CssClass="btn ab-submit" OnClick="btnAddBike_Click" />
                <asp:Label ID="lblMsg" runat="server" CssClass="ab-message"></asp:Label>
            </div>
        </div>
    </div>

</asp:Content>
