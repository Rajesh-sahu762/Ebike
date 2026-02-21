<%@ Page Title="" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="ManageBikes.aspx.cs"
    Inherits="Vendor_ManageBikes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="card shadow-sm p-4">

    <h4 class="mb-4">Manage Bikes</h4>

    <!-- Filters -->
    <div class="row mb-3">

        <div class="col-md-4">
            <asp:TextBox ID="txtSearch" runat="server"
                CssClass="form-control"
                placeholder="Search by Model"></asp:TextBox>
        </div>

        <div class="col-md-3">
            <asp:DropDownList ID="ddlBrandFilter" runat="server"
                CssClass="form-control"></asp:DropDownList>
        </div>

        <div class="col-md-3">
            <asp:DropDownList ID="ddlStatusFilter" runat="server"
                CssClass="form-control">
                <asp:ListItem Value="">All Status</asp:ListItem>
                <asp:ListItem Value="1">Approved</asp:ListItem>
                <asp:ListItem Value="0">Pending</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-md-2">
            <asp:Button ID="btnFilter" runat="server"
                Text="Filter"
                CssClass="btn btn-primary w-100"
                OnClick="btnFilter_Click" />
        </div>

    </div>

    <!-- Grid -->
    <asp:GridView ID="gvBikes" runat="server"
        CssClass="table table-striped table-bordered"
        AutoGenerateColumns="false"
        AllowPaging="true"
        PageSize="5"
        OnPageIndexChanging="gvBikes_PageIndexChanging"
        OnRowCommand="gvBikes_RowCommand"
        DataKeyNames="BikeID">

        <Columns>

            <asp:TemplateField HeaderText="Image">
                <ItemTemplate>
                    <img src='../Uploads/Bikes/<%# Eval("Image1") %>'
                         style="width:70px;height:50px;object-fit:cover;" />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="BrandName" HeaderText="Brand" />
            <asp:BoundField DataField="ModelName" HeaderText="Model" />
            <asp:BoundField DataField="Price" HeaderText="Price" />

            <asp:BoundField DataField="LeadCount" HeaderText="Leads" />

            <asp:TemplateField HeaderText="Status">
                <ItemTemplate>
                    <%# Convert.ToBoolean(Eval("IsApproved")) 
                        ? "<span class='badge bg-success'>Approved</span>"
                        : "<span class='badge bg-warning text-dark'>Pending</span>" %>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="CreatedAt" HeaderText="Created" />

            <asp:TemplateField>
                <ItemTemplate>

                    <asp:Button ID="btnEdit" runat="server"
                        Text="Edit"
                        CssClass="btn btn-sm btn-info"
                        CommandName="EditBike"
                        CommandArgument='<%# Eval("BikeID") %>' />

                    <asp:Button ID="btnDelete" runat="server"
                        Text="Delete"
                        CssClass="btn btn-sm btn-danger"
                        OnClientClick="return confirm('Delete this bike permanently?');"
                        CommandName="DeleteBike"
                        CommandArgument='<%# Eval("BikeID") %>' />

                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

    <!-- Edit Bike Modal -->
<div class="modal fade" id="editModal" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content p-4">

        <h5>Edit Bike</h5>
        <hr />

        <asp:HiddenField ID="hfBikeID" runat="server" />

        <div class="row">

            <div class="col-md-6 mb-3">
                <label>Brand</label>
                <asp:DropDownList ID="ddlBrandEdit" runat="server"
                    CssClass="form-control"></asp:DropDownList>
            </div>

            <div class="col-md-6 mb-3">
                <label>Model Name</label>
                <asp:TextBox ID="txtModelEdit" runat="server"
                    CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-6 mb-3">
                <label>Price</label>
                <asp:TextBox ID="txtPriceEdit" runat="server"
                    CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-6 mb-3">
                <label>Range (KM)</label>
                <asp:TextBox ID="txtRangeEdit" runat="server"
                    CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-12 mb-3">
                <label>Description</label>
                <asp:TextBox ID="txtDescEdit" runat="server"
                    TextMode="MultiLine"
                    Rows="3"
                    CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-4 mb-3">
                <label>Replace Image 1</label>
                <asp:FileUpload ID="fuImg1Edit" runat="server" />
            </div>

            <div class="col-md-4 mb-3">
                <label>Replace Image 2</label>
                <asp:FileUpload ID="fuImg2Edit" runat="server" />
            </div>

            <div class="col-md-4 mb-3">
                <label>Replace Image 3</label>
                <asp:FileUpload ID="fuImg3Edit" runat="server" />
            </div>

        </div>

        <asp:Button ID="btnUpdateBike" runat="server"
            Text="Update Bike"
            CssClass="btn btn-success"
            OnClick="btnUpdateBike_Click" />

    </div>
  </d


    <asp:Label ID="lblMsg" runat="server"></asp:Label>

</div>

</asp:Content>
