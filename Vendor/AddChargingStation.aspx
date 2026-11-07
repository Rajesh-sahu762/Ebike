<%@ Page Title="Add Charging Station" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
AutoEventWireup="true" CodeFile="AddChargingStation.aspx.cs"
Inherits="Vendor_AddChargingStation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.station-page{padding:28px 0 44px;color:#26344a}
.station-heading{margin-bottom:23px}
.station-kicker{font-family:'Quicksand',sans-serif;font-size:11px;font-weight:700;letter-spacing:1.3px;text-transform:uppercase;color:#1686a5;margin-bottom:8px}
.station-heading h2{font-family:'Manrope',sans-serif;font-size:27px;font-weight:800;color:#26344a;margin:0}
.station-heading p{font-size:14px;color:#7b8798;margin:7px 0 0}
.station-layout{display:grid;grid-template-columns:minmax(0,1.2fr) minmax(230px,.8fr);gap:22px;align-items:stretch}
.station-form,.station-aside{background:#edf1f7;border-radius:22px;padding:26px;box-shadow:9px 9px 20px #d3d9e2,-9px -9px 20px #fff}
.station-form-title{font-family:'Manrope',sans-serif;font-size:19px;font-weight:800;margin:0 0 5px;color:#26344a}
.station-form-subtitle{font-size:13px;color:#8490a1;margin:0 0 22px}
.station-field{margin-bottom:16px}
.station-field label{display:block;font-family:'Quicksand',sans-serif;font-size:12px;font-weight:700;color:#59677c;margin:0 0 7px}
.station-control{width:100%;min-height:45px;border:0!important;border-radius:12px!important;background:#edf1f7!important;color:#334155!important;padding:11px 13px!important;box-shadow:inset 4px 4px 8px #d5dbe4,inset -4px -4px 8px #fff!important;outline:none}
.station-control:focus{box-shadow:inset 3px 3px 6px #d5dbe4,inset -3px -3px 6px #fff,0 0 0 2px rgba(22,134,165,.18)!important}
.station-control::placeholder{color:#9aa5b4}
.station-save{border:0;border-radius:12px;padding:13px 18px;background:linear-gradient(135deg,#147f9e,#2365a7);color:#fff;font-weight:700;box-shadow:5px 5px 12px #cbd3df,-4px -4px 10px #fff;transition:transform .2s}
.station-save:hover{color:#fff;transform:translateY(-1px)}
.station-message{display:block;margin-top:13px;font-size:13px;font-weight:600}
.station-aside{display:flex;flex-direction:column;justify-content:center;position:relative;overflow:hidden}
.station-icon{width:58px;height:58px;border-radius:18px;display:flex;align-items:center;justify-content:center;background:#edf1f7;box-shadow:5px 5px 11px #d3d9e2,-5px -5px 11px #fff;color:#1686a5;font-size:26px;margin-bottom:20px}
.station-aside h3{font-family:'Manrope',sans-serif;font-size:18px;font-weight:800;color:#26344a;margin:0 0 10px}
.station-aside p{font-size:13px;line-height:1.7;color:#7b8798;margin:0 0 17px}
.station-tip{display:flex;gap:10px;align-items:flex-start;padding:12px;border-radius:12px;background:#e7edf5;color:#65748a;font-size:12px;line-height:1.6}
.station-tip strong{color:#334155}
@media(max-width:767px){.station-layout{grid-template-columns:1fr}.station-page{padding:18px 0 30px}.station-form,.station-aside{padding:20px;border-radius:17px}.station-heading h2{font-size:23px}}
</style>

<div class="container-fluid station-page">
    <div class="station-heading">
        <div class="station-kicker">Charging network</div>
        <h2>Add Charging Station</h2>
        <p>Register your charging location and make it discoverable to EV riders.</p>
    </div>

    <div class="station-layout">
        <section class="station-form">
            <div class="station-kicker">Station details</div>
            <h3 class="station-form-title">Register a Location</h3>
            <p class="station-form-subtitle">Share accurate contact and location information.</p>

            <div class="station-field">
                <label for="<%= txtName.ClientID %>">Station name</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control station-control" placeholder="Enter station name"></asp:TextBox>
            </div>
            <div class="row">
                <div class="col-md-6 station-field">
                    <label for="<%= txtPhone.ClientID %>">Contact phone</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control station-control" placeholder="Enter phone number"></asp:TextBox>
                </div>
                <div class="col-md-6 station-field">
                    <label for="<%= txtCity.ClientID %>">City</label>
                    <asp:TextBox ID="txtCity" runat="server" CssClass="form-control station-control" placeholder="Enter city"></asp:TextBox>
                </div>
            </div>
            <div class="station-field">
                <label for="<%= txtAddress.ClientID %>">Full address</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control station-control" placeholder="Building, street, area and landmark"></asp:TextBox>
            </div>
            <div class="station-field">
                <label for="<%= txtConnector.ClientID %>">Connector type</label>
                <asp:TextBox ID="txtConnector" runat="server" CssClass="form-control station-control" placeholder="e.g. Fast / DC / Type 2"></asp:TextBox>
            </div>

            <asp:Button ID="btnSave" runat="server" Text="Add Charging Station"
                CssClass="btn station-save w-100"
                OnClick="btnSave_Click" />
            <asp:Label ID="lblMsg" runat="server" CssClass="station-message"></asp:Label>
        </section>

        <aside class="station-aside">
            <div class="station-icon">&#9889;</div>
            <div class="station-kicker">Grow your reach</div>
            <h3>Join the charging network</h3>
            <p>Keep your station details clear and up to date so EV riders can identify the right charging location.</p>
            <div class="station-tip">
                <span>&#9432;</span>
                <span><strong>Approval note</strong><br/>New stations are submitted for admin approval before they become publicly available.</span>
            </div>
        </aside>
    </div>
</div>

</asp:Content>