<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="ApproveBikes.aspx.cs"
    Inherits="Admin_ApproveBikes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="card-custom">

    <h4 class="mb-4">Pending Bike Approvals</h4>

    <asp:GridView ID="gvBikes" runat="server"
        CssClass="table table-dark table-striped"
        AutoGenerateColumns="false"
        OnRowCommand="gvBikes_RowCommand">

        <Columns>

            <asp:BoundField DataField="BrandName" HeaderText="Brand" />
            <asp:BoundField DataField="ModelName" HeaderText="Model" />
            <asp:BoundField DataField="Price" HeaderText="Price" />
            <asp:BoundField DataField="RangeKM" HeaderText="Range (KM)" />

            <asp:TemplateField HeaderText="Image">
                <ItemTemplate>
                    <img src='<%# Eval("Image1") %>'
                         style="width:80px; height:60px; object-fit:cover; border-radius:8px;" />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField>
                <ItemTemplate>

                    <asp:Button ID="btnView"
                        runat="server"
                        Text="View"
                        CssClass="btn btn-info btn-sm"
                        CommandName="ViewBike"
                        CommandArgument='<%# Eval("BikeID") %>' />

                    <asp:Button ID="btnApprove"
                        runat="server"
                        Text="Approve"
                        CssClass="btn btn-success btn-sm"
                        CommandName="ApproveBike"
                        CommandArgument='<%# Eval("BikeID") %>' />

                    <asp:Button ID="btnReject"
                        runat="server"
                        Text="Reject"
                        CssClass="btn btn-danger btn-sm"
                        CommandName="RejectBike"
                        CommandArgument='<%# Eval("BikeID") %>' />

                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

</div>

<!-- Bike Detail Modal -->
<div class="modal fade" id="bikeModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content" style="background:#1e1b4b; color:white;">
      <div class="modal-header">
        <h5 class="modal-title">Bike Details</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <asp:Literal ID="litBikeDetails" runat="server"></asp:Literal>
      </div>
    </div>
  </div>
</div>

</asp:Content>
