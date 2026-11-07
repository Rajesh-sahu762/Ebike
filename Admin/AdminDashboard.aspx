<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="AdminDashboard.aspx.cs"
    Inherits="Admin_AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
    /* Dashboard-only typography and alignment */
    .dashboard-page { width: 100%; color: #eaf7fc; }
    .dashboard-page .row { --bs-gutter-x: 1rem; }
    .dashboard-page .stat-box {
        min-height: 104px;
        height: 100%;
        padding: 17px 19px;
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        justify-content: center;
        gap: 8px;
        text-align: left;
    }
    .dashboard-page .stat-box h6 {
        margin: 0;
        color: #a9c5d1;
        font-family: 'DM Sans', sans-serif;
        font-size: 13px;
        font-weight: 650;
        line-height: 1.4;
        letter-spacing: .01em;
        text-align: left;
    }
    .dashboard-page .stat-box span {
        display: block;
        margin: 0;
        color: #f2fbff;
        font-family: 'Manrope', sans-serif;
        font-size: 27px !important;
        font-weight: 750;
        line-height: 1.15;
        text-align: left;
        font-variant-numeric: tabular-nums;
    }
    .dashboard-page .card-custom {
        overflow: hidden;
        padding: 0;
    }
    .dashboard-page .card-custom h5 {
        margin: 0;
        padding: 17px 19px 13px;
        color: #effaff;
        font-family: 'Manrope', sans-serif;
        font-size: 18px;
        font-weight: 750;
        line-height: 1.35;
        text-align: left;
    }
    .dashboard-page .table {
        width: 100%;
        margin: 0;
        border-collapse: separate;
        border-spacing: 0;
    }
    .dashboard-page .table > :not(caption) > * > * {
        padding: 12px 16px;
        vertical-align: middle;
        text-align: left;
        line-height: 1.5;
        white-space: normal;
    }
    .dashboard-page .table thead th {
        color: #dff7ff;
        font-size: 12px;
        font-weight: 750;
        letter-spacing: .025em;
    }
    .dashboard-page .table tbody td {
        color: #d4e8f0;
        font-size: 13px;
        font-weight: 500;
    }
    @media (max-width: 767.98px) {
        .dashboard-page .stat-box { min-height: 92px; padding: 14px 16px; }
        .dashboard-page .card-custom h5 { padding: 15px 16px 12px; }
        .dashboard-page .table > :not(caption) > * > * { padding: 10px 12px; }
    }
</style>

<div class="dashboard-page">

<div class="row">

    <div class="col-md-3 mb-4">
        <div class="stat-box">
            <h6>Total Dealers</h6>
            <asp:Label ID="lblDealers" runat="server" Font-Size="25px"></asp:Label>
        </div>
    </div>

    <div class="col-md-3 mb-4">
        <div class="stat-box">
            <h6>Pending Dealers</h6>
            <asp:Label ID="lblPendingDealers" runat="server" Font-Size="25px"></asp:Label>
        </div>
    </div>

    <div class="col-md-3 mb-4">
        <div class="stat-box">
            <h6>Total Bikes</h6>
            <asp:Label ID="lblBikes" runat="server" Font-Size="25px"></asp:Label>
        </div>
    </div>

    <div class="col-md-3 mb-4">
        <div class="stat-box">
            <h6>Pending Bikes</h6>
            <asp:Label ID="lblPendingBikes" runat="server" Font-Size="25px"></asp:Label>
        </div>
    </div>

</div>

<div class="row">

    <div class="col-md-6 mb-4">
        <div class="stat-box">
            <h6>Total Customers</h6>
            <asp:Label ID="lblCustomers" runat="server" Font-Size="25px"></asp:Label>
        </div>
    </div>

    <div class="col-md-6 mb-4">
        <div class="stat-box">
            <h6>Total Leads</h6>
            <asp:Label ID="lblLeads" runat="server" Font-Size="25px"></asp:Label>
        </div>
    </div>

</div>

<div class="card-custom mt-4">
    <h5>Recent Leads</h5>
    <asp:GridView ID="gvLeads" runat="server" CssClass="table table-dark table-striped"
        AutoGenerateColumns="false">
        <Columns>
            <asp:BoundField DataField="FullName" HeaderText="Customer" />
            <asp:BoundField DataField="ModelName" HeaderText="Bike" />
            <asp:BoundField DataField="CreatedAt" HeaderText="Date" />
        </Columns>
    </asp:GridView>
</div>

</div>

</asp:Content>
