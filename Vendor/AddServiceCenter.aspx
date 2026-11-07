<%@ Page Title="Manage Service Center" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
AutoEventWireup="true" CodeFile="AddServiceCenter.aspx.cs"
Inherits="Vendor_AddServiceCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.sc-page{padding:28px 0 42px;color:#26344a}
.sc-heading{margin-bottom:22px}
.sc-kicker{font-family:'Quicksand',sans-serif;font-size:11px;font-weight:700;letter-spacing:1.2px;text-transform:uppercase;color:#1686a5;margin-bottom:7px}
.sc-heading h2,.sc-panel h3{font-family:'Manrope',sans-serif;font-weight:800;color:#26344a;margin:0}
.sc-heading h2{font-size:27px}
.sc-heading p{font-size:14px;color:#7b8798;margin:7px 0 0}
.sc-layout{display:grid;grid-template-columns:minmax(270px,340px) minmax(0,1fr);gap:22px;align-items:start}
.sc-panel{min-width:0;background:#edf1f7;border-radius:21px;padding:23px;box-shadow:9px 9px 20px #d3d9e2,-9px -9px 20px #fff}
.sc-panel h3{font-size:18px;margin-bottom:5px}
.sc-sub{font-size:12px;color:#8490a1;margin:0 0 20px}
.sc-field{margin-bottom:14px}
.sc-field label{display:block;font-family:'Quicksand',sans-serif;font-size:12px;font-weight:700;color:#59677c;margin-bottom:7px}
.sc-input{width:100%;min-height:44px;border:0!important;border-radius:11px!important;background:#edf1f7!important;color:#334155!important;padding:10px 12px!important;box-shadow:inset 4px 4px 8px #d5dbe4,inset -4px -4px 8px #fff!important}
.sc-input:focus{box-shadow:inset 3px 3px 6px #d5dbe4,inset -3px -3px 6px #fff,0 0 0 2px rgba(22,134,165,.18)!important}
.sc-action{border:0;border-radius:11px;padding:11px 16px;background:linear-gradient(135deg,#147f9e,#2365a7);color:#fff;font-weight:700}
.sc-action:hover{color:#fff}
.sc-msg{display:block;margin-top:12px;font-size:12px;font-weight:600}
.sc-search{display:grid;grid-template-columns:minmax(150px,1fr) minmax(130px,.55fr) auto;gap:10px;align-items:center;margin:17px 0}
.sc-table-wrap{overflow-x:auto;border-radius:13px;padding:7px;background:#edf1f7;box-shadow:inset 4px 4px 9px #d5dbe4,inset -4px -4px 9px #fff}
.sc-table{min-width:570px;width:100%;margin:0!important;border-collapse:separate!important;border-spacing:0 7px!important}
.sc-table th{border:0!important;background:transparent!important;color:#8490a1!important;font:700 10px 'Quicksand',sans-serif;text-transform:uppercase;letter-spacing:.7px;padding:10px!important;white-space:nowrap}
.sc-table td{border:0!important;background:#f4f6fa!important;padding:12px 10px!important;vertical-align:middle!important;color:#475569;font-size:12px}
.sc-table td:first-child{border-radius:9px 0 0 9px}.sc-table td:last-child{border-radius:0 9px 9px 0}
.sc-table .badge{border-radius:20px;padding:6px 9px;font-size:10px}
.sc-table .btn-danger{border:0;border-radius:8px;font-size:11px}
@media(max-width:850px){.sc-layout{grid-template-columns:1fr}}
@media(max-width:575px){.sc-page{padding:18px 0 30px}.sc-panel{padding:18px;border-radius:17px}.sc-heading h2{font-size:23px}.sc-search{grid-template-columns:1fr 1fr}.sc-search input:first-child{grid-column:1/-1}.sc-search .btn{width:100%}}
</style>

<div class="container-fluid sc-page">
    <div class="sc-heading">
        <div class="sc-kicker">Service network</div>
        <h2>Manage Service Centers</h2>
        <p>Register your workshop and manage its listing and approval status.</p>
    </div>
    <div class="sc-layout">
        <section class="sc-panel">
            <div class="sc-kicker">New listing</div>
            <h3>Add Service Center</h3>
            <p class="sc-sub">Provide the center's contact and service details.</p>
            <div class="sc-field">
                <label for="<%= txtName.ClientID %>">Center name</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control sc-input" placeholder="Enter center name"></asp:TextBox>
            </div>
            <div class="sc-field">
                <label for="<%= txtPhone.ClientID %>">Phone number</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control sc-input" placeholder="Enter phone number"></asp:TextBox>
            </div>
            <div class="sc-field">
                <label for="<%= txtCity.ClientID %>">City</label>
                <asp:TextBox ID="txtCity" runat="server" CssClass="form-control sc-input" placeholder="Enter city"></asp:TextBox>
            </div>
            <div class="sc-field">
                <label for="<%= txtAddress.ClientID %>">Full address</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control sc-input" placeholder="Street, area and landmark"></asp:TextBox>
            </div>
            <div class="sc-field">
                <label for="<%= txtService.ClientID %>">Services offered</label>
                <asp:TextBox ID="txtService" runat="server" CssClass="form-control sc-input" placeholder="e.g. Battery repair, diagnostics"></asp:TextBox>
            </div>
            <asp:Button ID="btnSave" runat="server" Text="Add Service Center" CssClass="btn sc-action w-100" OnClick="btnSave_Click"/>
            <asp:Label ID="lblMsg" runat="server" CssClass="sc-msg"></asp:Label>
        </section>

        <section class="sc-panel">
            <div class="sc-kicker">Your listings</div>
            <h3>Service Center Directory</h3>
            <p class="sc-sub">Search centers and filter by approval status.</p>
            <div class="sc-search">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control sc-input" placeholder="Search by name or city"></asp:TextBox>
                <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-control sc-input">
                    <asp:ListItem Value="">All Status</asp:ListItem>
                    <asp:ListItem Value="0">Pending</asp:ListItem>
                    <asp:ListItem Value="1">Approved</asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn sc-action" OnClick="btnSearch_Click"/>
            </div>
            <div class="sc-table-wrap">
                <asp:GridView ID="gvCenters" runat="server" CssClass="table sc-table" AutoGenerateColumns="false"
                    OnRowCommand="gvCenters_RowCommand" DataKeyNames="ServiceID">
                    <Columns>
                        <asp:BoundField DataField="CenterName" HeaderText="Center"/>
                        <asp:BoundField DataField="City" HeaderText="City"/>
                        <asp:BoundField DataField="ServiceType" HeaderText="Service"/>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <%# Convert.ToBoolean(Eval("IsApproved")) ?
                                "<span class='badge bg-success'>Approved</span>" :
                                "<span class='badge bg-warning text-dark'>Pending</span>" %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"
                                    CommandName="DeleteCenter" CommandArgument='<%# Eval("ServiceID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </section>
    </div>
</div>

</asp:Content>