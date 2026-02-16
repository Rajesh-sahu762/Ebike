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
    AllowSorting="true"
    OnPageIndexChanging="gvRatings_PageIndexChanging"
    OnSorting="gvRatings_Sorting">

    <Columns>

        <asp:BoundField DataField="FullName" HeaderText="Customer" SortExpression="FullName" />

        <asp:TemplateField HeaderText="Rating" SortExpression="Rating">
            <ItemTemplate>
                <%# GetStars(Convert.ToInt32(Eval("Rating"))) %>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="Review" HeaderText="Review" />

        <asp:BoundField DataField="CreatedAt" HeaderText="Date" SortExpression="CreatedAt" />

    </Columns>

</asp:GridView>

</asp:Content>
