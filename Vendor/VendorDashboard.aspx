<%@ Page Title="" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="VendorDashboard.aspx.cs"
    Inherits="Vendor_VendorDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

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

<!-- Recent Leads -->
<div class="card shadow-sm mt-4 p-3">
    <h5 class="mb-3">Recent Leads</h5>

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
