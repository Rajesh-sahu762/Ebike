<%@ Page Title="Vendor Dashboard" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="VendorDashboard.aspx.cs"
    Inherits="Vendor_VendorDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .vd-dashboard { color: #263449; }
        .vd-page-heading {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            gap: 16px;
            margin: 2px 2px 22px;
        }
        .vd-eyebrow {
            display: block;
            margin-bottom: 5px;
            color: #8491a3;
            font-size: 10px;
            font-weight: 800;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }
        .vd-title {
            margin: 0;
            color: #263449;
            font-size: clamp(24px, 3vw, 31px);
            font-weight: 800;
            letter-spacing: -.8px;
        }
        .vd-subtitle { margin: 6px 0 0; color: #8290a2; font-size: 12px; }
        .vd-section-label {
            display: flex;
            align-items: center;
            gap: 9px;
            margin: 0 0 14px 2px;
            color: #53647b;
            font-size: 12px;
            font-weight: 800;
            letter-spacing: .7px;
            text-transform: uppercase;
        }
        .vd-section-label i { color: #1683d3; font-size: 13px; }

        .vd-stat-card {
            position: relative;
            display: flex;
            align-items: center;
            gap: 15px;
            min-height: 112px;
            height: 100%;
            padding: 19px;
            overflow: hidden;
            border: 1px solid rgba(255,255,255,.78);
            border-radius: 17px;
            background: #e8edf5;
            box-shadow: 7px 7px 15px rgba(163,177,198,.43), -7px -7px 15px rgba(255,255,255,.86);
            transition: transform .2s ease, box-shadow .2s ease;
        }
        .vd-stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 9px 10px 19px rgba(163,177,198,.48), -8px -8px 17px rgba(255,255,255,.9);
        }
        .vd-stat-icon {
            display: grid;
            place-items: center;
            width: 48px;
            height: 48px;
            flex: 0 0 48px;
            border-radius: 15px;
            background: #e8edf5;
            box-shadow: inset 3px 3px 6px rgba(163,177,198,.25), inset -3px -3px 6px rgba(255,255,255,.85);
            font-size: 17px;
        }
        .vd-stat-copy { min-width: 0; }
        .vd-stat-name { display: block; margin-bottom: 7px; color: #7d899a; font-size: 11px; font-weight: 700; }
        .vd-stat-value { display: block; color: #263449; font-size: 27px; font-weight: 800; line-height: 1; letter-spacing: -.8px; }
        .vd-stat-card.blue .vd-stat-icon, .vd-stat-card.blue .vd-stat-value { color: #1677d2; }
        .vd-stat-card.green .vd-stat-icon, .vd-stat-card.green .vd-stat-value { color: #159568; }
        .vd-stat-card.amber .vd-stat-icon, .vd-stat-card.amber .vd-stat-value { color: #d99a16; }
        .vd-stat-card.rose .vd-stat-icon, .vd-stat-card.rose .vd-stat-value { color: #df5360; }
        .vd-stat-card.cyan .vd-stat-icon, .vd-stat-card.cyan .vd-stat-value { color: #159bb4; }
        .vd-stat-card.violet .vd-stat-icon, .vd-stat-card.violet .vd-stat-value { color: #8066c9; }

        .vd-panel {
            padding: 21px;
            border: 1px solid rgba(255,255,255,.8);
            border-radius: 18px;
            background: #e8edf5;
            box-shadow: 7px 7px 16px rgba(163,177,198,.42), -7px -7px 16px rgba(255,255,255,.86);
        }
        .vd-panel-heading {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 18px;
        }
        .vd-panel-title { margin: 0; color: #2b3a50; font-size: 16px; font-weight: 800; }
        .vd-panel-caption { margin: 5px 0 0; color: #8793a3; font-size: 11px; }
        .vd-panel-heading-icon {
            display: grid;
            place-items: center;
            width: 39px;
            height: 39px;
            flex: 0 0 39px;
            border-radius: 12px;
            color: #1677d2;
            background: #e8edf5;
            box-shadow: 4px 4px 8px rgba(163,177,198,.34), -4px -4px 8px rgba(255,255,255,.82);
        }
        .vd-plan-grid { display: grid; grid-template-columns: repeat(3, minmax(0,1fr)); gap: 13px; }
        .vd-plan-item {
            min-width: 0;
            padding: 14px 15px;
            border-radius: 13px;
            background: #e8edf5;
            box-shadow: inset 3px 3px 6px rgba(163,177,198,.27), inset -3px -3px 6px rgba(255,255,255,.82);
        }
        .vd-plan-label { display: block; margin-bottom: 7px; color: #8793a3; font-size: 10px; font-weight: 800; letter-spacing: .6px; text-transform: uppercase; }
        .vd-plan-value { display: block; overflow-wrap: anywhere; color: #34445b; font-size: 13px; font-weight: 800; }
        .vd-upgrade-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            min-height: 44px;
            margin-top: 17px;
            border: 0 !important;
            border-radius: 12px !important;
            background: linear-gradient(135deg, #218fe0, #176fc3) !important;
            color: #fff !important;
            box-shadow: 5px 5px 10px rgba(163,177,198,.4), -4px -4px 9px rgba(255,255,255,.8);
            font-size: 12px !important;
            font-weight: 800 !important;
            transition: transform .2s ease, filter .2s ease, box-shadow .2s ease;
        }
        .vd-upgrade-button:hover { filter: brightness(1.06); transform: translateY(-1px); }
        .vd-upgrade-button:active { box-shadow: inset 3px 3px 6px rgba(8,55,105,.28); transform: translateY(0); }

        .vd-table-wrap { width: 100%; overflow-x: auto; }
        .vd-leads-grid { width: 100%; min-width: 480px; margin: 0 !important; border-collapse: separate !important; border-spacing: 0 7px !important; color: #53647b; font-size: 12px; }
        .vd-leads-grid th {
            padding: 11px 14px !important;
            border: 0 !important;
            background: transparent !important;
            color: #8995a5 !important;
            font-size: 10px !important;
            font-weight: 800 !important;
            letter-spacing: .7px;
            text-transform: uppercase;
            white-space: nowrap;
        }
        .vd-leads-grid td {
            padding: 13px 14px !important;
            border: 0 !important;
            background: #e8edf5 !important;
            color: #526278 !important;
            font-weight: 600;
            vertical-align: middle;
        }
        .vd-leads-grid tr td:first-child { border-radius: 10px 0 0 10px; }
        .vd-leads-grid tr td:last-child { border-radius: 0 10px 10px 0; }
        .vd-leads-grid tr:hover td { background: #edf2f8 !important; }
        .vd-leads-grid th a, .vd-leads-grid td a { color: #1677d2; }

        @media (max-width: 767px) {
            .vd-page-heading { align-items: flex-start; margin-bottom: 18px; }
            .vd-stat-card { min-height: 98px; padding: 15px; }
            .vd-stat-icon { width: 43px; height: 43px; flex-basis: 43px; }
            .vd-stat-value { font-size: 24px; }
            .vd-panel { padding: 17px; }
            .vd-plan-grid { grid-template-columns: 1fr; gap: 9px; }
            .vd-plan-item { padding: 12px 13px; }
        }
        @media (max-width: 420px) {
            .vd-stat-card { gap: 11px; padding: 13px; }
            .vd-stat-icon { width: 38px; height: 38px; flex-basis: 38px; font-size: 15px; }
            .vd-stat-name { font-size: 10px; }
            .vd-stat-value { font-size: 22px; }
        }
    </style>

    <div class="vd-dashboard">
        <div class="vd-page-heading">
            <div>
                <span class="vd-eyebrow">Overview</span>
                <h1 class="vd-title">Dashboard</h1>
                <p class="vd-subtitle">Track your inventory, rentals and customer enquiries.</p>
            </div>
        </div>

        <div class="vd-section-label"><i class="fa-solid fa-chart-simple"></i> Rental overview</div>
        <div class="row g-3 g-xl-4 mb-4">
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="vd-stat-card cyan">
                    <span class="vd-stat-icon"><i class="fa-solid fa-calendar-check"></i></span>
                    <div class="vd-stat-copy">
                        <span class="vd-stat-name">Total Rentals</span>
                        <span class="vd-stat-value"><asp:Label ID="lblTotalRentals" runat="server"></asp:Label></span>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="vd-stat-card green">
                    <span class="vd-stat-icon"><i class="fa-solid fa-motorcycle"></i></span>
                    <div class="vd-stat-copy">
                        <span class="vd-stat-name">Active Rentals</span>
                        <span class="vd-stat-value"><asp:Label ID="lblActiveRentals" runat="server"></asp:Label></span>
                    </div>
                </div>
            </div>
        </div>

        <div class="vd-section-label"><i class="fa-solid fa-boxes-stacked"></i> Inventory & enquiries</div>
        <div class="row g-3 g-xl-4 mb-4">
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="vd-stat-card blue">
                    <span class="vd-stat-icon"><i class="fa-solid fa-motorcycle"></i></span>
                    <div class="vd-stat-copy">
                        <span class="vd-stat-name">Total Bikes</span>
                        <span class="vd-stat-value"><asp:Label ID="lblTotalBikes" runat="server"></asp:Label></span>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="vd-stat-card green">
                    <span class="vd-stat-icon"><i class="fa-solid fa-circle-check"></i></span>
                    <div class="vd-stat-copy">
                        <span class="vd-stat-name">Approved Bikes</span>
                        <span class="vd-stat-value"><asp:Label ID="lblApprovedBikes" runat="server"></asp:Label></span>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="vd-stat-card amber">
                    <span class="vd-stat-icon"><i class="fa-solid fa-clock"></i></span>
                    <div class="vd-stat-copy">
                        <span class="vd-stat-name">Pending Bikes</span>
                        <span class="vd-stat-value"><asp:Label ID="lblPendingBikes" runat="server"></asp:Label></span>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="vd-stat-card rose">
                    <span class="vd-stat-icon"><i class="fa-solid fa-envelope-open-text"></i></span>
                    <div class="vd-stat-copy">
                        <span class="vd-stat-name">Total Leads</span>
                        <span class="vd-stat-value"><asp:Label ID="lblTotalLeads" runat="server"></asp:Label></span>
                    </div>
                </div>
            </div>
        </div>

        <section class="vd-panel mb-4">
            <div class="vd-panel-heading">
                <div>
                    <h2 class="vd-panel-title">Subscription Plan</h2>
                    <p class="vd-panel-caption">Your current vendor membership details.</p>
                </div>
                <span class="vd-panel-heading-icon"><i class="fa-solid fa-crown"></i></span>
            </div>

            <div class="vd-plan-grid">
                <div class="vd-plan-item">
                    <span class="vd-plan-label">Current plan</span>
                    <span class="vd-plan-value"><asp:Label ID="lblPlanName" runat="server"></asp:Label></span>
                </div>
                <div class="vd-plan-item">
                    <span class="vd-plan-label">Expiry date</span>
                    <span class="vd-plan-value"><asp:Label ID="lblExpiry" runat="server"></asp:Label></span>
                </div>
                <div class="vd-plan-item">
                    <span class="vd-plan-label">Bike limit</span>
                    <span class="vd-plan-value"><asp:Label ID="lblBikeLimit" runat="server"></asp:Label></span>
                </div>
            </div>

            <asp:Button ID="btnUpgradePlan" runat="server" Text="Upgrade Plan" CssClass="btn vd-upgrade-button" />
        </section>

        <section class="vd-panel">
            <div class="vd-panel-heading">
                <div>
                    <h2 class="vd-panel-title">Recent Leads</h2>
                    <p class="vd-panel-caption">Latest customer enquiries for your listed bikes.</p>
                </div>
                <span class="vd-panel-heading-icon"><i class="fa-solid fa-users"></i></span>
            </div>

            <div class="vd-table-wrap">
                <asp:GridView ID="gvRecentLeads" runat="server"
                    CssClass="table vd-leads-grid"
                    AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField DataField="FullName" HeaderText="Customer" />
                        <asp:BoundField DataField="ModelName" HeaderText="Bike" />
                        <asp:BoundField DataField="CreatedAt" HeaderText="Date" />
                    </Columns>
                </asp:GridView>
            </div>
        </section>
    </div>

</asp:Content>
