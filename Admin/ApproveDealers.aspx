<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="ApproveDealers.aspx.cs"
    Inherits="Admin_ApproveDealers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="card-custom">

    <h4 class="mb-4">Pending Dealer Approvals</h4>

   <div class="row mb-4">

    <div class="col-md-4">
        <asp:DropDownList ID="ddlCity" runat="server"
            CssClass="form-control custom-input">
            <asp:ListItem Value="" Selected="True">Select City...</asp:ListItem>
        </asp:DropDownList>
    </div>

    <div class="col-md-5">
        <asp:TextBox ID="txtSearch" runat="server"
            CssClass="form-control custom-input"
            placeholder="Search by Name or Email"></asp:TextBox>
    </div>

    <div class="col-md-3">
        <asp:Button ID="btnSearch" runat="server"
            Text="Search Dealer"
            CssClass="btn btn-gradient w-100"
            OnClick="btnSearch_Click" />
    </div>

</div>


    <asp:GridView ID="gvDealers" runat="server"
        CssClass="table table-dark table-striped"
        AutoGenerateColumns="false"
        OnRowCommand="gvDealers_RowCommand">

        <Columns>

            <asp:BoundField DataField="FullName" HeaderText="Name" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Mobile" HeaderText="Mobile" />
            <asp:BoundField DataField="ShopName" HeaderText="Shop Name" />
            <asp:BoundField DataField="City" HeaderText="City" />

            <asp:TemplateField>
                <ItemTemplate>

                    <asp:Button ID="btnApprove"
                        runat="server"
                        Text="Approve"
                        CssClass="btn btn-success btn-sm"
                        CommandName="Approve"
                        CommandArgument='<%# Eval("UserID") %>' />

                    <asp:Button ID="btnReject"
                        runat="server"
                        Text="Reject"
                        CssClass="btn btn-danger btn-sm"
                        CommandName="Reject"
                        CommandArgument='<%# Eval("UserID") %>' />

                    <asp:Button ID="btnView"
    runat="server"
    Text="View"
    CssClass="btn btn-info btn-sm"
    CommandName="ViewDealer"
    CommandArgument='<%# Eval("UserID") %>' />



                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

    <!-- Dealer Details Modal -->
<div class="modal fade" id="dealerModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content" style="background:#1e1b4b; color:white;">
      <div class="modal-header">
        <h5 class="modal-title">Dealer Details</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <asp:Literal ID="litDealerDetails" runat="server"></asp:Literal>
      </div>
    </div>
  </div>
</div>


</div>

</asp:Content>
