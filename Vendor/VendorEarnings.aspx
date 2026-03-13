<%@ Page Title="Earnings" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="VendorEarnings.aspx.cs"
    Inherits="Vendor_VendorEarnings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h3 class="mb-4">My Earnings</h3>

<div class="row mb-4">

<div class="col-md-3">
<div class="card p-3 text-center shadow-sm">
<h6>Total Revenue</h6>
₹ <asp:Label ID="lblRevenue" runat="server"/>
</div>
</div>

<div class="col-md-3">
<div class="card p-3 text-center shadow-sm">
<h6>Platform Fee</h6>
₹ <asp:Label ID="lblCommission" runat="server"/>
</div>
</div>

<div class="col-md-3">
<div class="card p-3 text-center shadow-sm">
<h6>Net Earnings</h6>
₹ <asp:Label ID="lblNet" runat="server"/>
</div>
</div>

<div class="col-md-3">
<div class="card p-3 text-center shadow-sm bg-warning">
<h6>Pending Settlement</h6>
₹ <asp:Label ID="lblPending" runat="server"/>
</div>
</div>

</div>


<asp:Button ID="btnMassSettlement"
runat="server"
Text="Request Settlement Selected"
CssClass="btn btn-danger mb-3"
OnClick="btnMassSettlement_Click"/>


<asp:GridView ID="gvEarnings"
runat="server"
CssClass="table table-bordered"
AutoGenerateColumns="false"
DataKeyNames="RecordID,Source"
AllowPaging="true"
PageSize="10"
OnPageIndexChanging="gvEarnings_PageIndexChanging">

<Columns>

<asp:TemplateField>
<ItemTemplate>

<asp:CheckBox ID="chkSelect"
runat="server"/>

</ItemTemplate>
</asp:TemplateField>

<asp:BoundField DataField="Source" HeaderText="Source"/>

<asp:BoundField DataField="ModelName" HeaderText="Bike"/>

<asp:BoundField DataField="Customer" HeaderText="Customer"/>

<asp:BoundField DataField="Amount" HeaderText="Amount"/>

<asp:BoundField DataField="Commission" HeaderText="Platform Fee"/>

<asp:BoundField DataField="Net" HeaderText="Vendor Net"/>

<asp:BoundField DataField="Date"
HeaderText="Date"
DataFormatString="{0:dd MMM yyyy}"/>

<asp:BoundField DataField="Status"
HeaderText="Status"/>

</Columns>

</asp:GridView>

</asp:Content>

