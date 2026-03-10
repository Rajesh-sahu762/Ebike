<%@ Page Title="Earnings" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="VendorEarnings.aspx.cs"
    Inherits="Vendor_VendorEarnings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h4 class="mb-4">COD Earnings</h4>

<div class="row mb-4">

    <div class="col-md-2">
        <div class="card p-3 text-center shadow-sm">
            <h6>Total Revenue</h6>
            ₹ <asp:Label ID="lblRevenue" runat="server" />
        </div>
    </div>

    <div class="col-md-2">
        <div class="card p-3 text-center shadow-sm">
            <h6>Platform Fee</h6>
            ₹ <asp:Label ID="lblCommission" runat="server" />
        </div>
    </div>

    <div class="col-md-2">
        <div class="card p-3 text-center shadow-sm">
            <h6>Net Earnings</h6>
            ₹ <asp:Label ID="lblNet" runat="server" />
        </div>
    </div>

    <div class="col-md-3">
        <div class="card p-3 text-center shadow-sm bg-success text-white">
            <h6>Settled</h6>
            ₹ <asp:Label ID="lblSettled" runat="server" />
        </div>
    </div>

    <div class="col-md-3">
        <div class="card p-3 text-center shadow-sm bg-warning">
            <h6>Pending Settlement</h6>
            ₹ <asp:Label ID="lblPending" runat="server" />
        </div>
    </div>

</div>

<asp:GridView ID="gvEarnings" runat="server"
    CssClass="table table-bordered"
    AutoGenerateColumns="false"
    AllowPaging="true"
    PageSize="5"
    DataKeyNames="LeadID"
    OnPageIndexChanging="gvEarnings_PageIndexChanging"
    OnRowCommand="gvEarnings_RowCommand">

    <Columns>

        <asp:BoundField DataField="FullName" HeaderText="Customer" />
        <asp:BoundField DataField="ModelName" HeaderText="Bike" />
        <asp:BoundField DataField="LeadAmount" HeaderText="Amount (₹)" />
        <asp:BoundField DataField="Commission" HeaderText="Platform Fee (₹)" />
        <asp:BoundField DataField="NetAmount" HeaderText="Net (₹)" />
        <asp:BoundField
DataField="CreatedAt"
HeaderText="Date"
DataFormatString="{0:dd MMM yyyy}" />

     <asp:TemplateField HeaderText="Status">
<ItemTemplate>

<asp:Label ID="Label1" runat="server"
Text='<%# Convert.ToBoolean(Eval("IsSettled")) ? 
"Settled" :
(Convert.ToBoolean(Eval("SettlementRequested")) ?
"Requested" :
"Not Requested") %>'
CssClass='<%# Convert.ToBoolean(Eval("IsSettled")) ? 
"badge bg-success" :
(Convert.ToBoolean(Eval("SettlementRequested")) ?
"badge bg-warning" :
"badge bg-secondary") %>' />

</ItemTemplate>
</asp:TemplateField>

        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>
                <asp:Button ID="btnRequest"
                    runat="server"
                    Text="Request Settlement"
                    CssClass="btn btn-primary btn-sm"
                    CommandName="RequestSettlement"
                    CommandArgument='<%# Eval("LeadID") %>'
                    Visible='<%# !(Convert.ToBoolean(Eval("SettlementRequested")) || Convert.ToBoolean(Eval("IsSettled"))) %>' />
            </ItemTemplate>
        </asp:TemplateField>

    </Columns>

</asp:GridView>

</asp:Content>

