<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="Reports.aspx.cs"
    Inherits="Admin_Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="dashboard-wrapper">

    <h3 class="dashboard-title mb-4">Analytics & Revenue Dashboard</h3>

    <!-- Summary Cards -->
    <div class="row g-4 mb-5">

        <div class="col-lg-3 col-md-6">
            <div class="dashboard-card revenue-card">
                <span>Total Revenue</span>
                <h2><asp:Label ID="lblRevenue" runat="server" /></h2>
            </div>
        </div>

        <div class="col-lg-3 col-md-6">
            <div class="dashboard-card">
                <span>This Month Revenue</span>
                <h2><asp:Label ID="lblMonthRevenue" runat="server" /></h2>
            </div>
        </div>

        <div class="col-lg-3 col-md-6">
            <div class="dashboard-card">
                <span>Total Leads</span>
                <h2><asp:Label ID="lblLeads" runat="server" /></h2>
            </div>
        </div>

        <div class="col-lg-3 col-md-6">
            <div class="dashboard-card">
                <span>Unread Leads</span>
                <h2><asp:Label ID="lblUnread" runat="server" /></h2>
            </div>
        </div>

    </div>

    <!-- Charts Section -->
    <div class="row g-4">

        <div class="col-lg-6">
            <div class="chart-card">
                <h6>Monthly Leads</h6>
                <canvas id="leadChart"></canvas>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="chart-card">
                <h6>Monthly Revenue</h6>
                <canvas id="revenueChart"></canvas>
            </div>
        </div>

        <div class="col-lg-12">
            <div class="chart-card">
                <h6>Top Dealer Revenue</h6>
                <canvas id="dealerRevenueChart"></canvas>
            </div>
        </div>

    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    function renderChart(id, type, labels, data, label) {
        new Chart(document.getElementById(id), {
            type: type,
            data: {
                labels: labels,
                datasets: [{
                    label: label,
                    data: data,
                    borderWidth: 2,
                    borderColor: '#7c3aed',
                    backgroundColor: 'rgba(124,58,237,0.3)',
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { labels: { color: 'white' } }
                },
                scales: {
                    x: { ticks: { color: 'white' } },
                    y: { ticks: { color: 'white' } }
                }
            }
        });
    }

</script>



    <style>
        .dashboard-wrapper {
    padding: 20px;
}

.dashboard-title {
    font-weight: 700;
    color: white;
}

.dashboard-card {
    background: linear-gradient(135deg, #1e1b4b, #25215a);
    border-radius: 18px;
    padding: 25px;
    color: white;
    box-shadow: 0 15px 35px rgba(0,0,0,0.4);
    transition: all 0.3s ease;
}

.dashboard-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 20px 45px rgba(0,0,0,0.6);
}

.dashboard-card span {
    font-size: 14px;
    opacity: 0.8;
}

.dashboard-card h2 {
    font-size: 28px;
    margin-top: 10px;
    font-weight: bold;
}

.revenue-card {
    background: linear-gradient(135deg, #7c3aed, #06b6d4);
}

.chart-card {
    background: linear-gradient(135deg, #1e1b4b, #25215a);
    border-radius: 18px;
    padding: 25px;
    color: white;
    box-shadow: 0 15px 35px rgba(0,0,0,0.4);
}

.chart-card h6 {
    margin-bottom: 20px;
    font-weight: 600;
}

    </style>

</asp:Content>
