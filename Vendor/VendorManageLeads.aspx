<%@ Page Title="Manage Leads" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="VendorManageLeads.aspx.cs"
    Inherits="Vendor_VendorManageLeads" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h4 class="mb-4">Manage Leads</h4>

<!-- ===== SUMMARY CARDS ===== -->
<div class="row mb-4">

    <div class="col-md-3">
        <div class="card p-3 text-center shadow-sm">
            <h6>Today</h6>
            <asp:Label ID="lblToday" runat="server" Font-Size="20px"></asp:Label>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card p-3 text-center shadow-sm">
            <h6>This Month</h6>
            <asp:Label ID="lblMonth" runat="server" Font-Size="20px"></asp:Label>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card p-3 text-center shadow-sm">
            <h6>Unread</h6>
            <asp:Label ID="lblUnread" runat="server" Font-Size="20px"></asp:Label>
        </div>
    </div>

    <div class="col-md-3">
        <div class="card p-3 text-center shadow-sm">
            <h6>Total Revenue</h6>
            ₹ <asp:Label ID="lblRevenue" runat="server" Font-Size="20px"></asp:Label>
        </div>
    </div>

</div>

<!-- ===== FILTERS ===== -->
<div class="row mb-3">

    <div class="col-md-3">
        <asp:DropDownList ID="ddlBikeFilter" runat="server"
            CssClass="form-control"></asp:DropDownList>
    </div>

    <div class="col-md-3">
        <asp:DropDownList ID="ddlStatus" runat="server"
            CssClass="form-control">
            <asp:ListItem Value="">All Status</asp:ListItem>
            <asp:ListItem Value="0">Unread</asp:ListItem>
            <asp:ListItem Value="1">Viewed</asp:ListItem>
        </asp:DropDownList>
    </div>

    <div class="col-md-3">
        <asp:TextBox ID="txtSearch" runat="server"
            CssClass="form-control"
            placeholder="Search Customer"></asp:TextBox>
    </div>

    <div class="col-md-3">
        <asp:Button ID="btnFilter" runat="server"
            Text="Apply Filter"
            CssClass="btn btn-primary w-100"
            OnClick="btnFilter_Click" />
    </div>

</div>

<!-- ===== GRID ===== -->
<asp:GridView ID="gvLeads" runat="server"
    CssClass="table table-bordered table-hover"
    AutoGenerateColumns="false"
    AllowPaging="true"
    PageSize="5"
    OnPageIndexChanging="gvLeads_PageIndexChanging"
    OnRowCommand="gvLeads_RowCommand"
    DataKeyNames="LeadID">

    <Columns>

        <asp:BoundField DataField="FullName" HeaderText="Customer" />
        <asp:BoundField DataField="ModelName" HeaderText="Bike" />
        <asp:BoundField DataField="LeadAmount" HeaderText="Amount (₹)" />
        <asp:BoundField DataField="CommissionAmount" HeaderText="Platform Fee (₹)" />

        <asp:TemplateField HeaderText="Net (₹)">
            <ItemTemplate>
                <%# Convert.ToDecimal(Eval("LeadAmount")) - Convert.ToDecimal(Eval("CommissionAmount")) %>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="CreatedAt" HeaderText="Date" />

        <asp:TemplateField HeaderText="Lead Status">
            <ItemTemplate>
                <%# Convert.ToBoolean(Eval("IsViewed")) ?
                "<span class='badge bg-success'>Viewed</span>" :
                "<span class='badge bg-warning'>Unread</span>" %>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Settlement">
            <ItemTemplate>
                <%# Convert.ToBoolean(Eval("IsSettled")) ?
                "<span class='badge bg-success'>Settled</span>" :
                (Convert.ToBoolean(Eval("SettlementRequested")) ?
                "<span class='badge bg-warning'>Requested</span>" :
                "<span class='badge bg-secondary'>Not Requested</span>") %>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>

                <asp:Button ID="btnMark" runat="server"
                    Text="Mark"
                    CssClass="btn btn-sm btn-warning"
                    CommandName="MarkViewed"
                    CommandArgument='<%# Eval("LeadID") %>' />

                <asp:Button ID="btnRequestSettlement" runat="server"
                    Text="Request"
                    CssClass="btn btn-sm btn-primary"
                    CommandName="RequestSettlement"
                    CommandArgument='<%# Eval("LeadID") %>'
                    Visible='<%# !(Convert.ToBoolean(Eval("SettlementRequested")) || Convert.ToBoolean(Eval("IsSettled"))) %>' />

                <asp:Button ID="btnDelete" runat="server"
                    Text="Delete"
                    CssClass="btn btn-sm btn-danger"
                    CommandName="DeleteLead"
                    CommandArgument='<%# Eval("LeadID") %>' />

            </ItemTemplate>
        </asp:TemplateField>

    </Columns>
</asp:GridView>


</asp:Content>
