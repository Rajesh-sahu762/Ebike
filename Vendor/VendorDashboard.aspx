<%@ Page Title="" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="VendorDashboard.aspx.cs"
    Inherits="Vendor_VendorDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <style>

.card{
border-radius:12px;
transition:0.2s;
}

.card:hover{
transform:translateY(-3px);
box-shadow:0 10px 25px rgba(0,0,0,0.08);
}

</style>

    <div class="row g-4 mb-4">

<!-- Total Rentals -->
<div class="col-md-3">
<div class="card shadow-sm p-3 text-center">
<h6>Total Rentals</h6>
<h3 class="fw-bold text-primary">
<asp:Label ID="lblTotalRentals" runat="server"></asp:Label>
</h3>
</div>
</div>

<!-- Active Rentals -->
<div class="col-md-3">
<div class="card shadow-sm p-3 text-center">
<h6>Active Rentals</h6>
<h3 class="fw-bold text-success">
<asp:Label ID="lblActiveRentals" runat="server"></asp:Label>
</h3>
</div>
</div>

<!-- Total Earnings -->
<div class="col-md-3">
<div class="card shadow-sm p-3 text-center">
<h6>Total Earnings</h6>
<h3 class="fw-bold text-dark">
₹ <asp:Label ID="lblTotalEarnings" runat="server"></asp:Label>
</h3>
</div>
</div>

<!-- Admin Commission -->
<div class="col-md-3">
<div class="card shadow-sm p-3 text-center">
<h6>Admin Commission</h6>
<h3 class="fw-bold text-danger">
₹ <asp:Label ID="lblAdminCommission" runat="server"></asp:Label>
</h3>
</div>
</div>

</div>

<div class="row g-4">

    <!-- Total Bikes -->
    <div class="col-md-3">
        <div class="card shadow-sm p-3 text-center">
            <h6>Total Bikes</h6>
            <h3 class="fw-bold text-primary">
                <asp:Label ID="lblTotalBikes" runat="server"></asp:Label>
            </h3>
        </div>
    </div>

    <!-- Approved Bikes -->
    <div class="col-md-3">
        <div class="card shadow-sm p-3 text-center">
            <h6>Approved Bikes</h6>
            <h3 class="fw-bold text-success">
                <asp:Label ID="lblApprovedBikes" runat="server"></asp:Label>
            </h3>
        </div>
    </div>

    <!-- Pending Bikes -->
    <div class="col-md-3">
        <div class="card shadow-sm p-3 text-center">
            <h6>Pending Bikes</h6>
            <h3 class="fw-bold text-warning">
                <asp:Label ID="lblPendingBikes" runat="server"></asp:Label>
            </h3>
        </div>
    </div>

    <!-- Total Leads -->
    <div class="col-md-3">
        <div class="card shadow-sm p-3 text-center">
            <h6>Total Leads</h6>
            <h3 class="fw-bold text-danger">
                <asp:Label ID="lblTotalLeads" runat="server"></asp:Label>
            </h3>
        </div>
    </div>

</div>

    <div class="card shadow-sm mt-4 p-3">

<h5>Subscription Plan</h5>

<div class="row">

<div class="col-md-4">
Plan :
<asp:Label ID="lblPlanName" runat="server"></asp:Label>
</div>

<div class="col-md-4">
Expiry :
<asp:Label ID="lblExpiry" runat="server"></asp:Label>
</div>

<div class="col-md-4">
Bike Limit :
<asp:Label ID="lblBikeLimit" runat="server"></asp:Label>
</div>

</div>

<br />

<asp:Button ID="btnUpgradePlan"
runat="server"
Text="Upgrade Plan"
CssClass="btn btn-warning"
/>

</div>

<!-- Recent Leads -->
<div class="card shadow-sm mt-4 p-3">
   <h5 class="mb-3">
Recent Leads
<small class="text-muted">(latest customer enquiries)</small>
</h5>

    <asp:GridView ID="gvRecentLeads" runat="server"
        CssClass="table table-striped"
        AutoGenerateColumns="false">

        <Columns>
            <asp:BoundField DataField="FullName" HeaderText="Customer" />
            <asp:BoundField DataField="ModelName" HeaderText="Bike" />
            <asp:BoundField DataField="CreatedAt" HeaderText="Date" />
        </Columns>

    </asp:GridView>
</div>

</asp:Content>
