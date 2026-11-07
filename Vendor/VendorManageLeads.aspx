<%@ Page Title="Manage Leads" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
AutoEventWireup="true" CodeFile="VendorManageLeads.aspx.cs"
Inherits="Vendor_VendorManageLeads" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.ml-page{padding:28px 0 42px;color:#26344a}.ml-kicker{font:700 11px 'Quicksand',sans-serif;letter-spacing:1.2px;text-transform:uppercase;color:#1686a5;margin-bottom:7px}
.ml-heading{margin-bottom:22px}.ml-heading h2{font:800 27px 'Manrope',sans-serif;color:#26344a;margin:0}.ml-heading p{font-size:14px;color:#7b8798;margin:7px 0 0}
.ml-stats{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:15px;margin-bottom:21px}
.ml-stat{background:#edf1f7;border-radius:16px;padding:17px 19px;box-shadow:7px 7px 15px #d3d9e2,-7px -7px 15px #fff}
.ml-stat-label{font:700 11px 'Quicksand',sans-serif;text-transform:uppercase;letter-spacing:.6px;color:#8490a1}
.ml-stat-value{font:800 25px 'Manrope',sans-serif;color:#26344a;margin-top:7px}
.ml-panel{background:#edf1f7;border-radius:21px;padding:22px;box-shadow:9px 9px 20px #d3d9e2,-9px -9px 20px #fff}
.ml-panel h3{font:800 18px 'Manrope',sans-serif;color:#26344a;margin:0 0 5px}.ml-sub{font-size:12px;color:#8490a1;margin:0 0 17px}
.ml-filters{display:grid;grid-template-columns:minmax(150px,1fr) minmax(140px,.8fr) minmax(180px,1.2fr) 130px;gap:11px;align-items:center;margin-bottom:18px}
.ml-control{width:100%;min-height:43px;border:0!important;border-radius:11px!important;background:#edf1f7!important;color:#334155!important;padding:10px 12px!important;box-shadow:inset 4px 4px 8px #d5dbe4,inset -4px -4px 8px #fff!important}
.ml-control:focus{box-shadow:inset 3px 3px 6px #d5dbe4,inset -3px -3px 6px #fff,0 0 0 2px rgba(22,134,165,.18)!important}
.ml-filter-btn{border:0;border-radius:11px;min-height:43px;background:linear-gradient(135deg,#147f9e,#2365a7);color:#fff;font-weight:700}
.ml-table-wrap{overflow-x:auto;border-radius:14px;padding:7px;background:#edf1f7;box-shadow:inset 4px 4px 9px #d5dbe4,inset -4px -4px 9px #fff}
.ml-table{width:100%;min-width:1050px;margin:0!important;border-collapse:separate!important;border-spacing:0 7px!important}
.ml-table th{border:0!important;background:transparent!important;color:#8490a1!important;font:700 10px 'Quicksand',sans-serif;text-transform:uppercase;letter-spacing:.65px;padding:10px!important;white-space:nowrap}
.ml-table td{border:0!important;background:#f4f6fa!important;color:#475569;font-size:12px;padding:12px 10px!important;vertical-align:middle!important;white-space:nowrap}
.ml-table td:first-child{border-radius:9px 0 0 9px}.ml-table td:last-child{border-radius:0 9px 9px 0}
.ml-table .badge{border-radius:20px;padding:6px 9px;font-size:10px}
.ml-table .btn{border:0;border-radius:8px;font-size:10px;font-weight:700;padding:7px 9px;margin:2px}
.ml-table .btn-success{background:#d8f0e3;color:#176a43}.ml-table .btn-warning{background:#f9edc9;color:#86610a}.ml-table .btn-danger{background:#f9dddd;color:#9b3030}
@media(max-width:900px){.ml-stats{grid-template-columns:repeat(2,minmax(0,1fr))}.ml-filters{grid-template-columns:1fr 1fr}}
@media(max-width:575px){.ml-page{padding:18px 0 30px}.ml-heading h2{font-size:23px}.ml-panel{padding:16px;border-radius:17px}.ml-stats{gap:10px}.ml-stat{padding:14px}.ml-stat-value{font-size:22px}.ml-filters{grid-template-columns:1fr}.ml-table{min-width:1000px}}
</style>

<div class="container-fluid ml-page">
    <div class="ml-heading">
        <div class="ml-kicker">Customer enquiries</div>
        <h2>Manage Customer Leads</h2>
        <p>Keep track of customer interest and follow up with potential buyers.</p>
    </div>

    <div class="ml-stats">
        <div class="ml-stat"><div class="ml-stat-label">Today's Leads</div><div class="ml-stat-value"><asp:Label ID="lblToday" runat="server" /></div></div>
        <div class="ml-stat"><div class="ml-stat-label">This Month</div><div class="ml-stat-value"><asp:Label ID="lblMonth" runat="server" /></div></div>
        <div class="ml-stat"><div class="ml-stat-label">Unread Leads</div><div class="ml-stat-value"><asp:Label ID="lblUnread" runat="server" /></div></div>
        <div class="ml-stat"><div class="ml-stat-label">Total Leads</div><div class="ml-stat-value"><asp:Label ID="lblTotal" runat="server" /></div></div>
    </div>

    <section class="ml-panel">
        <div class="ml-kicker">Lead management</div>
        <h3>Customer Enquiries</h3>
        <p class="ml-sub">Filter by bike, read status or customer name.</p>
        <div class="ml-filters">
            <asp:DropDownList ID="ddlBikeFilter" runat="server" CssClass="form-control ml-control"></asp:DropDownList>
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control ml-control">
                <asp:ListItem Value="">All Status</asp:ListItem>
                <asp:ListItem Value="0">Unread</asp:ListItem>
                <asp:ListItem Value="1">Viewed</asp:ListItem>
            </asp:DropDownList>
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control ml-control" placeholder="Search customer name"></asp:TextBox>
            <asp:Button ID="btnFilter" runat="server" Text="Apply Filters" CssClass="btn ml-filter-btn" OnClick="btnFilter_Click"/>
        </div>

        <div class="ml-table-wrap">
            <asp:GridView ID="gvLeads" runat="server" CssClass="table ml-table"
                AutoGenerateColumns="false" AllowPaging="true" PageSize="8"
                OnPageIndexChanging="gvLeads_PageIndexChanging"
                OnRowCommand="gvLeads_RowCommand" DataKeyNames="LeadID">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="Customer"/>
                    <asp:BoundField DataField="Mobile" HeaderText="Phone"/>
                    <asp:BoundField DataField="Email" HeaderText="Email"/>
                    <asp:BoundField DataField="City" HeaderText="City"/>
                    <asp:BoundField DataField="ModelName" HeaderText="Bike"/>
                    <asp:BoundField DataField="CreatedAt" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}"/>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label runat="server"
                                Text='<%# Convert.ToBoolean(Eval("IsViewed")) ? "Viewed" : "Unread" %>'
                                CssClass='<%# Convert.ToBoolean(Eval("IsViewed")) ? "badge bg-success" : "badge bg-warning text-dark" %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Contact">
                        <ItemTemplate>
                            <a href='tel:<%# Eval("Mobile") %>' class="btn btn-sm btn-success">Call</a>
                            <a target="_blank" href='https://wa.me/91<%# Eval("Mobile") %>' class="btn btn-sm btn-success">WhatsApp</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnMark" runat="server" Text="Mark Viewed" CssClass="btn btn-sm btn-warning"
                                CommandName="MarkViewed" CommandArgument='<%# Eval("LeadID") %>'/>
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-sm btn-danger"
                                CommandName="DeleteLead" CommandArgument='<%# Eval("LeadID") %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </section>
</div>

</asp:Content>