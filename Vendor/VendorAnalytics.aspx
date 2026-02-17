<%@ Page Title="Analytics" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="VendorAnalytics.aspx.cs"
    Inherits="Vendor_VendorAnalytics" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h4 class="mb-4">Advanced Analytics</h4>

<!-- SUMMARY CARDS -->
<div class="row mb-4">

    <div class="col-md-3">
        <div class="card p-3 text-center shadow-sm">
            <h6>Total Revenue</h6>
            ₹ <asp:Label ID="lblRevenue" runat="server" Font-Size="20px"></asp:Label>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card p-3 text-center shadow-sm">
            <h6>Commission</h6>
            ₹ <asp:Label ID="lblCommission" runat="server" Font-Size="20px"></asp:Label>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card p-3 text-center shadow-sm">
            <h6>Net Earnings</h6>
            ₹ <asp:Label ID="lblNet" runat="server" Font-Size="20px"></asp:Label>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card p-3 text-center shadow-sm">
            <h6>Total Leads</h6>
            <asp:Label ID="lblLeads" runat="server" Font-Size="20px"></asp:Label>
        </div>
    </div>

</div>

    <div class="row mb-4">

    <div class="col-md-3">
        <div class="card p-3 text-center shadow-sm">
            <h6>This Month</h6>
            ₹ <asp:Label ID="lblThisMonth" runat="server" />
        </div>
    </div>

    <div class="col-md-3">
        <div class="card p-3 text-center shadow-sm">
            <h6>Last Month</h6>
            ₹ <asp:Label ID="lblLastMonth" runat="server" />
        </div>
    </div>

    <div class="col-md-3">
        <div class="card p-3 text-center shadow-sm">
            <h6>Growth %</h6>
            <asp:Label ID="lblGrowth" runat="server" />
        </div>
    </div>

    <div class="col-md-3">
        <div class="card p-3 text-center shadow-sm">
            <h6>Total Settled</h6>
            ₹ <asp:Label ID="lblSettled" runat="server" />
        </div>
    </div>

</div>


<!-- CHART -->
<div class="card p-4 mb-4 shadow-sm">
    <h5>Last 6 Months Revenue</h5>
    <canvas id="revenueChart"></canvas>
</div>

<!-- TOP BIKE PERFORMANCE -->
<div class="card p-4 shadow-sm">
    <h5>Top Performing Bikes</h5>

    <asp:GridView ID="gvTopBikes" runat="server"
        CssClass="table table-bordered"
        AutoGenerateColumns="false">

        <Columns>
            <asp:BoundField DataField="ModelName" HeaderText="Bike" />
            <asp:BoundField DataField="TotalRevenue" HeaderText="Revenue (₹)" />
            <asp:BoundField DataField="LeadCount" HeaderText="Leads" />
        </Columns>

    </asp:GridView>

</div>

    <div class="card p-4 mt-4 shadow-sm">
    <h5>Commission History</h5>

    <asp:GridView ID="gvCommissionHistory" runat="server"
        CssClass="table table-bordered"
        AutoGenerateColumns="false">

        <Columns>
            <asp:BoundField DataField="TotalRevenue" HeaderText="Revenue" />
            <asp:BoundField DataField="CommissionAmount" HeaderText="Commission" />
            <asp:BoundField DataField="NetAmount" HeaderText="Net Paid" />
            <asp:BoundField DataField="CreatedAt" HeaderText="Date" />
            <asp:BoundField DataField="IsApproved" HeaderText="Approved" />
        </Columns>

    </asp:GridView>

</div>



<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    var ctx = document.getElementById('revenueChart').getContext('2d');
    var revenueChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: <%= MonthLabels %>,
            datasets: [{
                label: 'Revenue',
                data: <%= MonthRevenue %>,
                borderColor: '#2563eb',
                backgroundColor: 'rgba(37,99,235,0.1)',
                fill: true,
                tension: 0.4
            }]
        }
    });
</script>

</asp:Content>
