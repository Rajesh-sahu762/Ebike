<%@ Page Title="Manage Charging Stations" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
AutoEventWireup="true" CodeFile="ManageChargingStations.aspx.cs"
Inherits="Admin_ManageChargingStations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h4 class="mb-4 text-white">All Charging Stations</h4>

<asp:GridView ID="gvStations" runat="server"
CssClass="table table-dark"
AutoGenerateColumns="false"
OnRowCommand="gvStations_RowCommand"
DataKeyNames="StationID">

<Columns>

<asp:BoundField DataField="StationName" HeaderText="Station" />
<asp:BoundField DataField="City" HeaderText="City" />
<asp:BoundField DataField="ConnectorType" HeaderText="Connector" />
<asp:BoundField DataField="VendorName" HeaderText="Vendor" />

<asp:TemplateField HeaderText="Status">
<ItemTemplate>

<%# Convert.ToBoolean(Eval("IsApproved")) ?

"<span class='badge bg-success'>Approved</span>" :

"<span class='badge bg-warning'>Pending</span>" %>

</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField>
<ItemTemplate>

<asp:Button ID="btnApprove" runat="server"
Text="Approve"
CssClass="btn btn-success btn-sm"
CommandName="Approve"
CommandArgument='<%# Eval("StationID") %>'
Visible='<%# !Convert.ToBoolean(Eval("IsApproved")) %>' />

<asp:Button ID="btnDelete" runat="server"
Text="Delete"
CssClass="btn btn-danger btn-sm"
CommandName="DeleteStation"
CommandArgument='<%# Eval("StationID") %>' />

</ItemTemplate>
</asp:TemplateField>

</Columns>

</asp:GridView>

</asp:Content>