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
                    <img src='../Uploads/Bikes/<%# Eval("Image1") %>'
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
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content admin-modal">

      <div class="modal-header border-0">
        <h5 class="modal-title fw-bold">Bike Details</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        <div class="row">

            <!-- LEFT: DETAILS -->
            <div class="col-md-6">
                <div class="bike-info-box">
                    <asp:Literal ID="litBikeDetails" runat="server"></asp:Literal>
                </div>
            </div>

            <!-- RIGHT: IMAGE GALLERY -->
            <div class="col-md-6">
                <div class="bike-gallery" id="bikeGallery">
                    <!-- Images injected dynamically -->
                </div>
            </div>

        </div>
      </div>

    </div>
  </div>
</div>

    <style>
.admin-modal {
    background: linear-gradient(145deg,#1e1b4b,#0f172a);
    color: white;
    border-radius: 16px;
    box-shadow: 0 20px 40px rgba(0,0,0,0.5);
}

.bike-info-box {
    background: rgba(255,255,255,0.05);
    padding: 20px;
    border-radius: 12px;
    line-height: 1.8;
    font-size: 15px;
}

.bike-gallery {
    display: grid;
    grid-template-columns: repeat(2,1fr);
    gap: 15px;
}

.bike-gallery img {
    width: 100%;
    height: 180px;
    object-fit: cover;
    border-radius: 12px;
    transition: 0.3s ease;
    cursor: pointer;
}

.bike-gallery img:hover {
    transform: scale(1.05);
    box-shadow: 0 10px 20px rgba(0,0,0,0.6);
}
</style>


</asp:Content>
