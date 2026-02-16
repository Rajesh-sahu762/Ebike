<%@ Page Title="Earnings" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="VendorEarnings.aspx.cs"
    Inherits="Vendor_VendorEarnings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h4 class="mb-4">COD Earnings</h4>

<!-- SUMMARY -->
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
            <h6>This Month</h6>
            ₹ <asp:Label ID="lblMonth" runat="server" Font-Size="20px"></asp:Label>
        </div>
    </div>

</div>

<!-- GRID -->
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

        <asp:TemplateField HeaderText="Commission">
            <ItemTemplate>
                ₹ <%# Eval("Commission") %>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Net">
            <ItemTemplate>
                ₹ <%# Eval("NetAmount") %>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="CreatedAt" HeaderText="Date" />

        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>
                <asp:Button ID="btnMark"
                    runat="server"
                    Text="Mark Paid"
                    CssClass="btn btn-success btn-sm"
                    CommandName="MarkPaid"
                    CommandArgument='<%# Eval("LeadID") %>' />
            </ItemTemplate>
        </asp:TemplateField>

    </Columns>

</asp:GridView>

</asp:Content>
