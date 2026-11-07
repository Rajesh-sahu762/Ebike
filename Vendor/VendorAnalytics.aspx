<%@ Page Title="Analytics" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
AutoEventWireup="true" CodeFile="VendorAnalytics.aspx.cs"
Inherits="Vendor_VendorAnalytics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
    .va-page { color:#26334d; }
    .va-heading { display:flex; align-items:flex-start; justify-content:space-between; gap:16px; margin-bottom:26px; flex-wrap:wrap; }
    .va-eyebrow { color:#71809a; font-size:11px; font-weight:800; letter-spacing:1.5px; text-transform:uppercase; margin-bottom:6px; }
    .va-title { color:#202d47; font-family:'Manrope',sans-serif; font-size:25px; font-weight:800; margin:0; }
    .va-subtitle { color:#7c899f; font-size:13px; margin:7px 0 0; }
    .va-period { display:inline-flex; align-items:center; gap:8px; padding:10px 15px; border-radius:14px; color:#52627e; background:#e8edf5; box-shadow:6px 6px 13px #cbd2dd,-6px -6px 13px #fff; font-size:12px; font-weight:700; }
    .va-metric { height:100%; min-height:132px; padding:20px; border-radius:20px; background:#e8edf5; box-shadow:7px 7px 16px #cbd2dd,-7px -7px 16px #fff; position:relative; overflow:hidden; }
    .va-metric-top { display:flex; align-items:center; justify-content:space-between; gap:10px; }
    .va-metric-label { color:#78869c; font-size:12px; font-weight:800; letter-spacing:.35px; }
    .va-metric-icon { width:38px; height:38px; border-radius:13px; display:flex; align-items:center; justify-content:center; color:#fff; font-size:16px; box-shadow:0 6px 13px rgba(31,75,130,.16); }
    .va-icon-blue { background:linear-gradient(135deg,#477fe5,#2857b8); }
    .va-icon-cyan { background:linear-gradient(135deg,#35c6d8,#1699b9); }
    .va-icon-violet { background:linear-gradient(135deg,#9b83ed,#7055c9); }
    .va-icon-orange { background:linear-gradient(135deg,#ffb45d,#ed8740); }
    .va-metric-value { display:block; color:#243450; font-family:'Manrope',sans-serif; font-size:25px; font-weight:800; margin-top:15px; line-height:1.2; }
    .va-metric-foot { color:#98a3b4; font-size:11px; margin-top:5px; }
    .va-panel { padding:22px; border-radius:20px; background:#e8edf5; box-shadow:7px 7px 16px #cbd2dd,-7px -7px 16px #fff; height:100%; }
    .va-panel-head { display:flex; align-items:flex-start; justify-content:space-between; gap:12px; margin-bottom:18px; flex-wrap:wrap; }
    .va-panel-title { color:#263650; font-family:'Manrope',sans-serif; font-size:16px; font-weight:800; margin:0; }
    .va-panel-caption { color:#8995a9; font-size:11px; margin:5px 0 0; }
    .va-chart-wrap { position:relative; width:100%; height:285px; }
    .va-chart-legend { color:#7e8ba1; font-size:11px; font-weight:700; display:flex; align-items:center; gap:7px; }
    .va-legend-dot { width:8px; height:8px; border-radius:50%; background:#3478df; display:inline-block; }
    .va-table-wrap { overflow-x:auto; width:100%; border-radius:13px; }
    .va-table { width:100%; min-width:560px; border-collapse:separate !important; border-spacing:0 7px !important; margin:0 !important; color:#53627b; font-size:12px; }
    .va-table th { border:0 !important; color:#8793a7; font-size:10px; font-weight:800; letter-spacing:.7px; text-transform:uppercase; padding:10px 13px !important; white-space:nowrap; }
    .va-table td { border:0 !important; background:#edf1f7; padding:13px !important; vertical-align:middle !important; }
    .va-table td:first-child { border-radius:10px 0 0 10px; color:#30415e; font-weight:800; }
    .va-table td:last-child { border-radius:0 10px 10px 0; }
    .va-table tr:hover td { background:#f1f4f9; }
    .va-empty { padding:25px !important; text-align:center; color:#98a3b4; }
    .va-status { display:inline-block; padding:5px 10px; border-radius:20px; font-size:10px; font-weight:800; }
    .va-status-approved { background:#d9f5e9; color:#19865c; }
    .va-status-pending { background:#fff0d9; color:#b87920; }
    @media(max-width:767px) {
        .va-title { font-size:22px; }
        .va-metric { min-height:118px; padding:16px; }
        .va-metric-value { font-size:22px; }
        .va-panel { padding:16px; }
        .va-chart-wrap { height:230px; }
    }
</style>

<div class="va-page">
    <div class="va-heading">
        <div>
            <div class="va-eyebrow">Vendor workspace / Insights</div>
            <h4 class="va-title">Business Analytics</h4>
            <p class="va-subtitle">Understand your revenue, leads and business performance at a glance.</p>
        </div>
        <div class="va-period"><i class="fas fa-chart-line"></i> Performance overview</div>
    </div>

    <div class="row mb-4">
        <div class="col-xl-3 col-sm-6 mb-3">
            <div class="va-metric">
                <div class="va-metric-top"><span class="va-metric-label">TOTAL REVENUE</span><span class="va-metric-icon va-icon-blue"><i class="fas fa-wallet"></i></span></div>
                <span class="va-metric-value">₹ <asp:Label ID="lblRevenue" runat="server" /></span>
                <div class="va-metric-foot">Lead + completed rental revenue</div>
            </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-3">
            <div class="va-metric">
                <div class="va-metric-top"><span class="va-metric-label">TOTAL COMMISSION</span><span class="va-metric-icon va-icon-violet"><i class="fas fa-percent"></i></span></div>
                <span class="va-metric-value">₹ <asp:Label ID="lblCommission" runat="server" /></span>
                <div class="va-metric-foot">Platform commission amount</div>
            </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-3">
            <div class="va-metric">
                <div class="va-metric-top"><span class="va-metric-label">NET EARNINGS</span><span class="va-metric-icon va-icon-cyan"><i class="fas fa-coins"></i></span></div>
                <span class="va-metric-value">₹ <asp:Label ID="lblNet" runat="server" /></span>
                <div class="va-metric-foot">Revenue after commission</div>
            </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-3">
            <div class="va-metric">
                <div class="va-metric-top"><span class="va-metric-label">TOTAL LEADS</span><span class="va-metric-icon va-icon-orange"><i class="fas fa-user-group"></i></span></div>
                <span class="va-metric-value"><asp:Label ID="lblLeads" runat="server" /></span>
                <div class="va-metric-foot">Customer enquiries received</div>
            </div>
        </div>
    </div>

    <div class="va-panel mb-4">
        <div class="va-panel-head">
            <div>
                <h5 class="va-panel-title">Revenue Overview</h5>
                <p class="va-panel-caption">Monthly lead revenue trend for the last 6 months</p>
            </div>
            <div class="va-chart-legend"><span class="va-legend-dot"></span> Revenue</div>
        </div>
        <div class="va-chart-wrap"><canvas id="revenueChart"></canvas></div>
    </div>

    <div class="va-panel mb-4">
        <div class="va-panel-head">
            <div>
                <h5 class="va-panel-title">Top Performing Bikes</h5>
                <p class="va-panel-caption">Your top 5 bikes ranked by lead revenue</p>
            </div>
            <span class="va-chart-legend"><i class="fas fa-trophy"></i> Top performers</span>
        </div>
        <div class="va-table-wrap">
            <asp:GridView ID="gvTopBikes" runat="server" AutoGenerateColumns="false" CssClass="table va-table" GridLines="None" EmptyDataText="No bike performance data available yet.">
                <Columns>
                    <asp:BoundField DataField="ModelName" HeaderText="Bike" />
                    <asp:BoundField DataField="TotalRevenue" HeaderText="Revenue (₹)" DataFormatString="{0:N0}" />
                    <asp:BoundField DataField="LeadCount" HeaderText="Leads" />
                </Columns>
                <EmptyDataRowStyle CssClass="va-empty" />
            </asp:GridView>
        </div>
    </div>

    <div class="va-panel">
        <div class="va-panel-head">
            <div>
                <h5 class="va-panel-title">Settlement History</h5>
                <p class="va-panel-caption">Track submitted settlements and approval status</p>
            </div>
            <span class="va-chart-legend"><i class="fas fa-receipt"></i> Payout records</span>
        </div>
        <div class="va-table-wrap">
            <asp:GridView ID="gvSettlement" runat="server" AutoGenerateColumns="false" CssClass="table va-table" GridLines="None" EmptyDataText="No settlement records found.">
                <Columns>
                    <asp:BoundField DataField="TotalRevenue" HeaderText="Revenue" DataFormatString="₹ {0:N0}" />
                    <asp:BoundField DataField="CommissionAmount" HeaderText="Commission" DataFormatString="₹ {0:N0}" />
                    <asp:BoundField DataField="NetAmount" HeaderText="Net Paid" DataFormatString="₹ {0:N0}" />
                    <asp:BoundField DataField="CreatedAt" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='<%# Convert.ToBoolean(Eval("IsApproved")) ? "va-status va-status-approved" : "va-status va-status-pending" %>'>
                                <%# Convert.ToBoolean(Eval("IsApproved")) ? "Approved" : "Pending" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataRowStyle CssClass="va-empty" />
            </asp:GridView>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    (function () {
        var canvas = document.getElementById('revenueChart');
        if (!canvas || typeof Chart === 'undefined') return;

        var labels = <%= MonthLabels %>;
        var revenue = <%= MonthRevenue %>;

        new Chart(canvas.getContext('2d'), {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Revenue',
                    data: revenue,
                    borderColor: '#3478df',
                    backgroundColor: 'rgba(52,120,223,0.12)',
                    borderWidth: 3,
                    pointRadius: 4,
                    pointHoverRadius: 6,
                    pointBackgroundColor: '#ffffff',
                    pointBorderColor: '#3478df',
                    pointBorderWidth: 2,
                    fill: true,
                    tension: 0.38
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        backgroundColor: '#243450',
                        padding: 12,
                        displayColors: false,
                        callbacks: {
                            label: function (context) {
                                return ' ₹ ' + Number(context.parsed.y || 0).toLocaleString('en-IN');
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        grid: { display: false },
                        ticks: { color: '#8995a9', font: { size: 11 } },
                        border: { display: false }
                    },
                    y: {
                        beginAtZero: true,
                        grid: { color: 'rgba(133,149,173,0.16)', drawBorder: false },
                        ticks: {
                            color: '#8995a9',
                            font: { size: 10 },
                            callback: function (value) { return '₹' + Number(value).toLocaleString('en-IN'); }
                        },
                        border: { display: false }
                    }
                }
            }
        });
    })();
</script>

</asp:Content>