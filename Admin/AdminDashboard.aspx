<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="AdminDashboard.aspx.cs"
    Inherits="Admin_AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

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

</asp:Content>
