<%@ Page Title="Rental Settlement" Language="C#" 
MasterPageFile="~/Admin/AdminMaster.master"
AutoEventWireup="true"
CodeFile="AdminRentalSettlement.aspx.cs"
Inherits="Admin_AdminRentalSettlement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.card-box {
    background:white;
    padding:20px;
    border-radius:15px;
    box-shadow:0 5px 20px rgba(0,0,0,0.05);
    margin-bottom:25px;
}
.table thead {
    background:#0f172a;
    color:white;
}
</style>

<h2 style="color:white;">Dealer Rental Settlement</h2>
<hr />

<div class="card-box">

<asp:GridView ID="gvSettlement" runat="server"
    AutoGenerateColumns="False"
    CssClass="table table-bordered table-hover"
    OnRowCommand="gvSettlement_RowCommand">

    <Columns>

        <asp:BoundField DataField="DealerID" HeaderText="Dealer ID" />
        <asp:BoundField DataField="DealerName" HeaderText="Dealer Name" />
        <asp:BoundField DataField="TotalRentals" HeaderText="Total Rentals" />
        <asp:BoundField DataField="TotalRevenue" HeaderText="Revenue" DataFormatString="₹ {0:N0}" />
        <asp:BoundField DataField="TotalCommission" HeaderText="Commission" DataFormatString="₹ {0:N0}" />
        <asp:BoundField DataField="NetAmount" HeaderText="Net Payable" DataFormatString="₹ {0:N0}" />

        <asp:TemplateField HeaderText="Action">
            <ItemTemplate>
                <asp:LinkButton ID="btnApprove" runat="server"
                    CommandName="ApproveSettlement"
                    CommandArgument='<%# Eval("DealerID") %>'
                    CssClass="btn btn-success btn-sm">
                    Approve Settlement
                </asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>

    </Columns>

</asp:GridView>

</div>

</asp:Content>