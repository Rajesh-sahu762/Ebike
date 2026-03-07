<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AdminSubscriptionRequests.aspx.cs" Inherits="Admin_AdminSubscriptionRequests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

  <h3 style="color:white;">Dealer Subscription Management</h3>

<!-- PENDING REQUESTS -->

<div class="card-custom mb-4">

<h4>Pending Requests</h4>

<asp:GridView
ID="gvRequests"
runat="server"
CssClass="table table-dark table-striped"
AutoGenerateColumns="false"
OnRowCommand="gvRequests_RowCommand">

<Columns>

<asp:BoundField DataField="FullName" HeaderText="Dealer"/>

<asp:BoundField DataField="PlanName" HeaderText="Plan"/>

<asp:BoundField DataField="BikeLimit" HeaderText="Bike Limit"/>

<asp:BoundField DataField="FeaturedLimit" HeaderText="Featured"/>

<asp:BoundField DataField="Amount" HeaderText="Amount"/>

<asp:BoundField DataField="CreatedAt" HeaderText="Requested"/>

<asp:TemplateField HeaderText="Action">

<ItemTemplate>

<asp:Button ID="Button1"
runat="server"
Text="Approve"
CssClass="btn btn-success btn-sm"
CommandName="Approve"
CommandArgument='<%# Eval("RequestID") %>' />

<asp:Button ID="Button2"
runat="server"
Text="Reject"
CssClass="btn btn-danger btn-sm"
CommandName="Reject"
CommandArgument='<%# Eval("RequestID") %>' />

</ItemTemplate>

</asp:TemplateField>

</Columns>

</asp:GridView>

</div>



<!-- ACTIVE SUBSCRIPTIONS -->

<div class="card-custom">

<h4>Active Subscriptions</h4>

<asp:GridView
ID="gvActive"
runat="server"
CssClass="table table-success table-striped"
AutoGenerateColumns="false"
OnRowCommand="gvActive_RowCommand">

<Columns>

<asp:BoundField DataField="FullName" HeaderText="Dealer"/>

<asp:BoundField DataField="PlanName" HeaderText="Plan"/>

<asp:BoundField DataField="MaxBikes" HeaderText="Bike Limit"/>

<asp:BoundField DataField="StartDate" HeaderText="Start"/>

<asp:BoundField DataField="EndDate" HeaderText="Expiry"/>

<asp:TemplateField HeaderText="Status">

<ItemTemplate>

<%# Convert.ToDateTime(Eval("EndDate")) < DateTime.Now 
? "<span class='badge bg-danger'>Expired</span>"
: "<span class='badge bg-success'>Active</span>" %>

</ItemTemplate>

</asp:TemplateField>

<asp:TemplateField HeaderText="Action">

<ItemTemplate>

<asp:Button ID="Button3"
runat="server"
Text="Extend"
CssClass="btn btn-warning btn-sm"
CommandName="Extend"
CommandArgument='<%# Eval("SubscriptionID") %>' />

<asp:Button ID="Button4"
runat="server"
Text="Cancel"
CssClass="btn btn-danger btn-sm"
CommandName="Cancel"
CommandArgument='<%# Eval("SubscriptionID") %>' />

</ItemTemplate>

</asp:TemplateField>

</Columns>

</asp:GridView>

</div>

</asp:Content>

