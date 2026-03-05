<%@ Page Title="Dealer Ratings" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="DealerRatings.aspx.cs"
    Inherits="Vendor_DealerRatings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h4 class="mb-4">Dealer Ratings</h4>

<!-- ===== SUMMARY ===== -->
<div class="row mb-4">

    <div class="col-md-4">
        <div class="card p-3 text-center shadow-sm">
            <h6>Average Rating</h6>
            <asp:Label ID="lblAvg" runat="server" Font-Size="22px"></asp:Label>
            <div id="starDisplay"></div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card p-3 text-center shadow-sm">
            <h6>Total Reviews</h6>
            <asp:Label ID="lblTotal" runat="server" Font-Size="22px"></asp:Label>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card p-3 text-center shadow-sm">
            <h6>5 Star Reviews</h6>
            <asp:Label ID="lblFive" runat="server" Font-Size="22px"></asp:Label>
        </div>
    </div>

</div>

<!-- ===== GRID ===== -->
<asp:GridView ID="gvRatings" runat="server"
    CssClass="table table-bordered table-hover"
    AutoGenerateColumns="false"
    AllowPaging="true"
    PageSize="5"
    OnPageIndexChanging="gvRatings_PageIndexChanging"
    OnRowCommand="gvRatings_RowCommand">

<Columns>

<asp:BoundField DataField="ModelName" HeaderText="Bike"/>

<asp:BoundField DataField="FullName" HeaderText="Customer"/>

<asp:TemplateField HeaderText="Rating">
<ItemTemplate>
<%# GetStars(Convert.ToInt32(Eval("Rating"))) %>
</ItemTemplate>
</asp:TemplateField>

<asp:BoundField DataField="ReviewText" HeaderText="Review"/>

<asp:BoundField DataField="CreatedAt" HeaderText="Date"/>

<asp:TemplateField HeaderText="Status">
<ItemTemplate>

<%# Convert.ToBoolean(Eval("IsApproved")) 
? "<span class='badge bg-success'>Approved</span>" 
: "<span class='badge bg-warning'>Pending</span>" %>

</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField HeaderText="Action">
<ItemTemplate>

<asp:LinkButton ID="LinkButton1" runat="server"
CommandName="approve"
CommandArgument='<%# Eval("ReviewID") %>'
CssClass="btn btn-success btn-sm">
Approve
</asp:LinkButton>

<asp:LinkButton ID="LinkButton2" runat="server"
CommandName="reject"
CommandArgument='<%# Eval("ReviewID") %>'
CssClass="btn btn-warning btn-sm">
Reject
</asp:LinkButton>

<asp:LinkButton ID="LinkButton3" runat="server"
CommandName="delete"
CommandArgument='<%# Eval("ReviewID") %>'
CssClass="btn btn-danger btn-sm"
OnClientClick="return confirm('Delete review?');">
Delete
</asp:LinkButton>

</ItemTemplate>
</asp:TemplateField>

</Columns>
</asp:GridView>

</asp:Content>
