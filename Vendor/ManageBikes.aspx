<%@ Page Title="" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="ManageBikes.aspx.cs"
    Inherits="Vendor_ManageBikes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="card shadow-sm p-4">

    <h4 class="mb-4">Manage Bikes</h4>

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

            <asp:TemplateField HeaderText="Type">
                <ItemTemplate>
                    <%# Convert.ToBoolean(Eval("IsForRent") == DBNull.Value ? false : Eval("IsForRent"))
                        ? "<span class='badge bg-info'>Sell + Rent</span>"
                        : "<span class='badge bg-secondary'>Sell Only</span>" %>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Rental">
                <ItemTemplate>
                    <asp:LinkButton ID="btnToggleRent" runat="server"
                        CommandName="ToggleRent"
                        CommandArgument='<%# Eval("BikeID") %>'
                        CssClass='<%# Convert.ToBoolean(Eval("IsForRent") == DBNull.Value ? false : Eval("IsForRent")) ? "btn btn-sm btn-success" : "btn btn-sm btn-secondary" %>'>
                        <%# Convert.ToBoolean(Eval("IsForRent") == DBNull.Value ? false : Eval("IsForRent")) ? "ON" : "OFF" %>
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

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

                    <asp:LinkButton ID="btnEdit" runat="server"
                        CssClass="btn btn-sm btn-info"
                        CommandName="EditBike"
                        CommandArgument='<%# Eval("BikeID") %>'>
                        Edit
                    </asp:LinkButton>

                    <asp:LinkButton ID="btnDelete" runat="server"
                        CssClass="btn btn-sm btn-danger"
                        OnClientClick="return confirm('Delete this bike permanently?');"
                        CommandName="DeleteBike"
                        CommandArgument='<%# Eval("BikeID") %>'>
                        Delete
                    </asp:LinkButton>

                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>

    <br />
    <asp:Label ID="lblMsg" runat="server" CssClass="fw-bold"></asp:Label>

</div> 



    <div class="modal fade" id="editModal" tabindex="-1">
  <div class="modal-dialog modal-xl modal-dialog-centered">
    <div class="modal-content rounded-4 shadow-lg">

      <div class="modal-header bg-dark text-white">
        <h5 class="modal-title">Edit Bike</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body p-4">

        <asp:HiddenField ID="hfBikeID" runat="server" />

        <div class="row g-3">

            <div class="col-md-6">
                <label>Brand</label>
                <asp:DropDownList ID="ddlBrandEdit" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>

            <div class="col-md-6">
                <label>Model</label>
                <asp:TextBox ID="txtModelEdit" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-4">
                <label>Price</label>
                <asp:TextBox ID="txtPriceEdit" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-4">
                <label>Range</label>
                <asp:TextBox ID="txtRangeEdit" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-4">
                <label>Available For Rent</label><br />
                <asp:CheckBox ID="chkRentEdit" runat="server" />
            </div>

            <div class="col-md-4">
                <label>Rent Per Day</label>
                <asp:TextBox ID="txtRentDayEdit" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-4">
                <label>Rent Per Week</label>
                <asp:TextBox ID="txtRentWeekEdit" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-4">
                <label>Rent Per Month</label>
                <asp:TextBox ID="txtRentMonthEdit" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-12">
                <label>Description</label>
                <asp:TextBox ID="txtDescEdit" runat="server" TextMode="MultiLine"
                    Rows="3" CssClass="form-control"></asp:TextBox>
            </div>

        </div>

      </div>

      <div class="modal-footer">
        <asp:Button ID="btnUpdateBike" runat="server"
            Text="Update Bike"
            CssClass="btn btn-success"
            OnClick="btnUpdateBike_Click" />
      </div>

    </div>
  </div>
</div>

</asp:Content>
