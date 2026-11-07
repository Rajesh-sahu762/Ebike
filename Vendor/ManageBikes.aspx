<%@ Page Title="Manage Bikes" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="ManageBikes.aspx.cs"
    Inherits="Vendor_ManageBikes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.mb-page{padding:28px 0 42px;color:#26344a}
.mb-heading{margin-bottom:22px}
.mb-kicker{font-family:'Quicksand',sans-serif;font-size:11px;font-weight:700;letter-spacing:1.2px;text-transform:uppercase;color:#1686a5;margin-bottom:7px}
.mb-heading h2,.mb-panel-title{font-family:'Manrope',sans-serif;font-weight:800;color:#26344a;margin:0}
.mb-heading h2{font-size:27px}
.mb-heading p{font-size:14px;color:#7b8798;margin:7px 0 0}
.mb-panel{background:#edf1f7;border-radius:21px;padding:22px;box-shadow:9px 9px 20px #d3d9e2,-9px -9px 20px #fff}
.mb-panel-title{font-size:18px;margin-bottom:5px}
.mb-sub{font-size:12px;color:#8490a1;margin:0 0 18px}
.mb-filters{display:grid;grid-template-columns:minmax(180px,1.5fr) minmax(150px,1fr) minmax(145px,1fr) 110px;gap:12px;align-items:center;margin-bottom:19px}
.mb-control{width:100%;min-height:43px;border:0!important;border-radius:11px!important;background:#edf1f7!important;color:#334155!important;padding:10px 12px!important;box-shadow:inset 4px 4px 8px #d5dbe4,inset -4px -4px 8px #fff!important}
.mb-control:focus{box-shadow:inset 3px 3px 6px #d5dbe4,inset -3px -3px 6px #fff,0 0 0 2px rgba(22,134,165,.18)!important}
.mb-filter-btn{border:0;border-radius:11px;min-height:43px;background:linear-gradient(135deg,#147f9e,#2365a7);color:white;font-weight:700}
.mb-table-wrap{overflow-x:auto;border-radius:14px;padding:7px;background:#edf1f7;box-shadow:inset 4px 4px 9px #d5dbe4,inset -4px -4px 9px #fff}
.mb-table{width:100%;min-width:1050px;margin:0!important;border-collapse:separate!important;border-spacing:0 7px!important}
.mb-table th{border:0!important;background:transparent!important;color:#8490a1!important;font:700 10px 'Quicksand',sans-serif;text-transform:uppercase;letter-spacing:.65px;padding:10px 9px!important;white-space:nowrap}
.mb-table td{border:0!important;background:#f4f6fa!important;color:#475569;font-size:12px;padding:10px 9px!important;vertical-align:middle!important;white-space:nowrap}
.mb-table td:first-child{border-radius:9px 0 0 9px}.mb-table td:last-child{border-radius:0 9px 9px 0}
.mb-table img{width:58px!important;height:44px!important;object-fit:cover;border-radius:8px;box-shadow:2px 2px 5px #d1d7e0}
.mb-table .badge{font-size:10px;border-radius:20px;padding:6px 8px}
.mb-table .btn{border:0;border-radius:8px;font-size:10px;font-weight:700;padding:6px 9px;margin:2px}
.mb-table .btn-info{background:#d8edf4;color:#17647b}.mb-table .btn-warning{background:#f9edc9;color:#86610a}.mb-table .btn-success{background:#d8f0e3;color:#176a43}.mb-table .btn-secondary{background:#e1e6ed;color:#536174}
.mb-message{display:block;margin-top:14px;color:#526176;font-size:13px}
#editModal .modal-content{border:0;border-radius:20px;background:#edf1f7;box-shadow:12px 12px 26px rgba(30,45,65,.18)}
#editModal .modal-header{border:0;border-radius:20px 20px 0 0;background:#263b55!important;padding:19px 24px}
#editModal .modal-title{font-family:'Manrope',sans-serif;font-weight:800}
#editModal .modal-body{padding:24px!important}
#editModal .modal-body label{display:block;font-family:'Quicksand',sans-serif;font-size:12px;font-weight:700;color:#59677c;margin:0 0 7px}
#editModal .form-control{min-height:43px;border:0;border-radius:11px;background:#edf1f7;box-shadow:inset 4px 4px 8px #d5dbe4,inset -4px -4px 8px #fff;color:#334155}
#editModal .modal-footer{border:0;padding:0 24px 22px}
#editModal .modal-footer .btn{border:0;border-radius:10px;padding:10px 18px;background:linear-gradient(135deg,#147f9e,#2365a7);font-weight:700}
@media(max-width:900px){.mb-filters{grid-template-columns:1fr 1fr}.mb-filter-btn{width:100%}}
@media(max-width:575px){.mb-page{padding:18px 0 30px}.mb-panel{padding:16px;border-radius:17px}.mb-heading h2{font-size:23px}.mb-filters{grid-template-columns:1fr}.mb-table{min-width:980px}#editModal .modal-body{padding:18px!important}}
</style>

<div class="container-fluid mb-page">
    <div class="mb-heading">
        <div class="mb-kicker">Bike inventory</div>
        <h2>Manage Bikes</h2>
        <p>Review your listed bikes, manage rental availability and update listings.</p>
    </div>

    <section class="mb-panel">
        <div class="mb-kicker">Inventory overview</div>
        <h3 class="mb-panel-title">Your Bike Listings</h3>
        <p class="mb-sub">Search and filter your bikes, or use the row actions to manage each listing.</p>

        <div class="mb-filters">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control mb-control" placeholder="Search by model"></asp:TextBox>
            <asp:DropDownList ID="ddlBrandFilter" runat="server" CssClass="form-control mb-control"></asp:DropDownList>
            <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-control mb-control">
                <asp:ListItem Value="">All Status</asp:ListItem>
                <asp:ListItem Value="1">Approved</asp:ListItem>
                <asp:ListItem Value="0">Pending</asp:ListItem>
            </asp:DropDownList>
            <asp:Button ID="btnFilter" runat="server" Text="Apply Filters" CssClass="btn mb-filter-btn" OnClick="btnFilter_Click" />
        </div>

        <div class="mb-table-wrap">
            <asp:GridView ID="gvBikes" runat="server"
                CssClass="table mb-table"
                AutoGenerateColumns="false"
                AllowPaging="true"
                PageSize="5"
                OnPageIndexChanging="gvBikes_PageIndexChanging"
                OnRowCommand="gvBikes_RowCommand"
                DataKeyNames="BikeID">
                <Columns>
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <img src='../Uploads/Bikes/<%# Eval("Image1") %>' alt="Bike image" />
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
                            <asp:LinkButton ID="btnToggleRent" runat="server" CommandName="ToggleRent"
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
                    <asp:TemplateField HeaderText="Featured">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnFeature" runat="server" CssClass="btn btn-sm btn-warning"
                                CommandName="FeatureBike" CommandArgument='<%# Eval("BikeID") %>'>Feature</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CssClass="btn btn-sm btn-info"
                                CommandName="EditBike" CommandArgument='<%# Eval("BikeID") %>'>Edit</asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn btn-sm btn-danger"
                                OnClientClick="return confirm('Delete this bike permanently?');"
                                CommandName="DeleteBike" CommandArgument='<%# Eval("BikeID") %>'>Delete</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <asp:Label ID="lblMsg" runat="server" CssClass="mb-message fw-bold"></asp:Label>
    </section>
</div>

<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header text-white">
                <h5 class="modal-title" id="editModalTitle">Edit Bike Details</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
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
                        <label>Range (KM)</label>
                        <asp:TextBox ID="txtRangeEdit" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label>Available for rent</label>
                        <div class="d-flex align-items-center h-100 pt-2">
                            <asp:CheckBox ID="chkRentEdit" runat="server" />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label>Rent per day</label>
                        <asp:TextBox ID="txtRentDayEdit" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label>Rent per week</label>
                        <asp:TextBox ID="txtRentWeekEdit" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-md-4">
                        <label>Rent per month</label>
                        <asp:TextBox ID="txtRentMonthEdit" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-12">
                        <label>Description</label>
                        <asp:TextBox ID="txtDescEdit" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <asp:Button ID="btnUpdateBike" runat="server" Text="Update Bike"
                    CssClass="btn btn-success" OnClick="btnUpdateBike_Click" />
            </div>
        </div>
    </div>
</div>

</asp:Content>