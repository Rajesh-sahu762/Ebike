<%@ Page Title="Manage Parts" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
AutoEventWireup="true" CodeFile="ManageParts.aspx.cs"
Inherits="Vendor_ManageParts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.parts-page{padding:28px 0 42px;color:#26344a}
.parts-heading{display:flex;align-items:flex-end;justify-content:space-between;gap:16px;margin-bottom:24px}
.parts-heading h2{font-family:'Manrope',sans-serif;font-weight:800;margin:0;color:#26344a}
.parts-heading p{margin:7px 0 0;color:#7b8798;font-size:14px}
.parts-kicker{font-family:'Quicksand',sans-serif;font-weight:700;letter-spacing:1.3px;text-transform:uppercase;color:#1686a5;font-size:11px;margin-bottom:8px}
.parts-layout{display:grid;grid-template-columns:minmax(280px,350px) minmax(0,1fr);gap:22px;align-items:start}
.parts-panel{background:#edf1f7;border-radius:22px;padding:24px;box-shadow:9px 9px 20px #d3d9e2,-9px -9px 20px #fff}
.parts-panel-title{font-family:'Manrope',sans-serif;font-weight:800;font-size:18px;margin:0 0 5px;color:#26344a}
.parts-panel-subtitle{font-size:13px;color:#8490a1;margin:0 0 22px}
.parts-field{margin-bottom:15px}
.parts-field label{display:block;font-family:'Quicksand',sans-serif;font-size:12px;font-weight:700;color:#59677c;margin:0 0 7px}
.parts-control{width:100%;min-height:44px;border:0!important;border-radius:12px!important;background:#edf1f7!important;color:#334155!important;padding:11px 13px!important;box-shadow:inset 4px 4px 8px #d5dbe4,inset -4px -4px 8px #fff!important;outline:none}
.parts-control:focus{box-shadow:inset 3px 3px 6px #d5dbe4,inset -3px -3px 6px #fff,0 0 0 2px rgba(22,134,165,.18)!important}
.parts-control::placeholder{color:#9aa5b4}
.parts-upload{padding:9px!important;font-size:12px}
.parts-save{border:0;border-radius:12px;padding:12px 16px;background:linear-gradient(135deg,#147f9e,#2365a7);color:#fff;font-weight:700;box-shadow:5px 5px 12px #cbd3df,-4px -4px 10px #fff;transition:transform .2s,box-shadow .2s}
.parts-save:hover{color:#fff;transform:translateY(-1px);box-shadow:3px 3px 8px #cbd3df,-3px -3px 8px #fff}
.parts-message{display:block;margin-top:13px;font-size:13px;font-weight:600}
.parts-list-panel{min-width:0}
.parts-list-head{display:flex;justify-content:space-between;align-items:center;gap:12px;margin-bottom:16px}
.parts-list-head h3{font-family:'Manrope',sans-serif;font-size:18px;font-weight:800;margin:0;color:#26344a}
.parts-list-head span{font-size:12px;color:#8490a1}
.parts-table-wrap{overflow-x:auto;border-radius:15px;padding:8px;background:#edf1f7;box-shadow:inset 4px 4px 9px #d5dbe4,inset -4px -4px 9px #fff}
.parts-table{width:100%;margin:0!important;border-collapse:separate!important;border-spacing:0 7px!important;min-width:650px}
.parts-table th{border:0!important;background:transparent!important;color:#8490a1!important;text-transform:uppercase;font-family:'Quicksand',sans-serif;font-size:10px;letter-spacing:.8px;padding:10px 12px!important;white-space:nowrap}
.parts-table td{background:#f4f6fa!important;border:0!important;padding:12px!important;vertical-align:middle!important;color:#475569;font-size:13px}
.parts-table td:first-child{border-radius:10px 0 0 10px}
.parts-table td:last-child{border-radius:0 10px 10px 0}
.parts-table img{width:48px;height:42px;object-fit:cover;border-radius:9px;box-shadow:2px 2px 5px #d1d7e0}
.parts-table .badge{font-size:10px;padding:6px 9px;border-radius:20px}
.parts-table .btn-danger{border:0;border-radius:8px;padding:6px 10px;font-size:11px}
@media(max-width:900px){.parts-layout{grid-template-columns:1fr}.parts-form-panel{max-width:none}}
@media(max-width:575px){.parts-page{padding:18px 0 30px}.parts-panel{padding:18px;border-radius:17px}.parts-heading h2{font-size:23px}.parts-heading{margin-bottom:18px}}
</style>

<div class="container-fluid parts-page">
    <div class="parts-heading">
        <div>
            <div class="parts-kicker">Vendor inventory</div>
            <h2>Manage Parts</h2>
            <p>Add spare parts to your catalogue and manage their availability.</p>
        </div>
    </div>

    <div class="parts-layout">
        <section class="parts-panel parts-form-panel">
            <div class="parts-kicker">New listing</div>
            <h3 class="parts-panel-title">Add a Spare Part</h3>
            <p class="parts-panel-subtitle">Enter the part details below to submit it for approval.</p>

            <div class="parts-field">
                <label for="<%= txtName.ClientID %>">Part name</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control parts-control" placeholder="e.g. Lithium Battery"></asp:TextBox>
            </div>
            <div class="parts-field">
                <label for="<%= ddlCategory.ClientID %>">Category</label>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control parts-control"></asp:DropDownList>
            </div>
            <div class="row">
                <div class="col-6 parts-field">
                    <label for="<%= txtPrice.ClientID %>">Price (₹)</label>
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control parts-control" placeholder="0.00"></asp:TextBox>
                </div>
                <div class="col-6 parts-field">
                    <label for="<%= txtStock.ClientID %>">Stock quantity</label>
                    <asp:TextBox ID="txtStock" runat="server" CssClass="form-control parts-control" placeholder="0"></asp:TextBox>
                </div>
            </div>
            <div class="parts-field">
                <label for="<%= txtDesc.ClientID %>">Description</label>
                <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control parts-control" placeholder="Short description of the part"></asp:TextBox>
            </div>
            <div class="parts-field">
                <label for="<%= fuImage.ClientID %>">Part image</label>
                <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control parts-control parts-upload"/>
            </div>
            <asp:Button ID="btnSave" runat="server" Text="Add Part"
                CssClass="btn parts-save w-100"
                OnClick="btnSave_Click"/>
            <asp:Label ID="lblMsg" runat="server" CssClass="parts-message"></asp:Label>
        </section>

        <section class="parts-list-panel">
            <div class="parts-list-head">
                <div>
                    <div class="parts-kicker">Your catalogue</div>
                    <h3>Listed Parts</h3>
                </div>
                <span>Inventory overview</span>
            </div>
            <div class="parts-table-wrap">
                <asp:GridView ID="gvParts" runat="server"
                    CssClass="table parts-table"
                    AutoGenerateColumns="false"
                    OnRowCommand="gvParts_RowCommand"
                    DataKeyNames="PartID">
                    <Columns>
                        <asp:BoundField DataField="PartName" HeaderText="Name"/>
                        <asp:BoundField DataField="Category" HeaderText="Category"/>
                        <asp:BoundField DataField="Price" HeaderText="Price"/>
                        <asp:BoundField DataField="Stock" HeaderText="Stock"/>
                        <asp:TemplateField HeaderText="Image">
                            <ItemTemplate>
                                <img src='/Uploads/Parts/<%# Eval("Image1") %>' width="50" alt="Part image"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <%# Convert.ToBoolean(Eval("IsApproved")) ?
                                "<span class='badge bg-success'>Approved</span>" :
                                "<span class='badge bg-warning text-dark'>Pending</span>" %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                    CssClass="btn btn-danger btn-sm"
                                    CommandName="DeletePart"
                                    CommandArgument='<%# Eval("PartID") %>'/>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </section>
    </div>
</div>

</asp:Content>