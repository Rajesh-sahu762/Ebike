<%@ Page Title="Manage Charging Stations" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
AutoEventWireup="true" CodeFile="ManageChargingStations.aspx.cs"
Inherits="Vendor_ManageChargingStations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.ms-page{padding:28px 0 42px;color:#26344a}.ms-kicker{font:700 11px 'Quicksand',sans-serif;letter-spacing:1.2px;text-transform:uppercase;color:#1686a5;margin-bottom:7px}
.ms-heading{margin-bottom:22px}.ms-heading h2{font:800 27px 'Manrope',sans-serif;color:#26344a;margin:0}.ms-heading p{font-size:14px;color:#7b8798;margin:7px 0 0}
.ms-panel{background:#edf1f7;border-radius:21px;padding:23px;box-shadow:9px 9px 20px #d3d9e2,-9px -9px 20px #fff}
.ms-panel h3{font:800 18px 'Manrope',sans-serif;color:#26344a;margin:0 0 5px}.ms-sub{font-size:12px;color:#8490a1;margin:0 0 18px}
.ms-table-wrap{overflow-x:auto;border-radius:14px;padding:7px;background:#edf1f7;box-shadow:inset 4px 4px 9px #d5dbe4,inset -4px -4px 9px #fff}
.ms-table{width:100%;min-width:620px;margin:0!important;border-collapse:separate!important;border-spacing:0 7px!important}
.ms-table th{border:0!important;background:transparent!important;color:#8490a1!important;font:700 10px 'Quicksand',sans-serif;text-transform:uppercase;letter-spacing:.7px;padding:10px!important;white-space:nowrap}
.ms-table td{border:0!important;background:#f4f6fa!important;color:#475569;font-size:13px;padding:14px 11px!important;vertical-align:middle!important}
.ms-table td:first-child{border-radius:9px 0 0 9px}.ms-table td:last-child{border-radius:0 9px 9px 0}
.ms-table .badge{border-radius:20px;padding:6px 9px;font-size:10px}
.ms-table .btn-danger{border:0;border-radius:8px;padding:7px 11px;font-size:11px}
@media(max-width:575px){.ms-page{padding:18px 0 30px}.ms-heading h2{font-size:23px}.ms-panel{padding:17px;border-radius:17px}}
</style>

<div class="container-fluid ms-page">
    <div class="ms-heading">
        <div class="ms-kicker">Charging network</div>
        <h2>Manage Charging Stations</h2>
        <p>View your registered charging locations and their approval status.</p>
    </div>
    <section class="ms-panel">
        <div class="ms-kicker">Your locations</div>
        <h3>Charging Station Directory</h3>
        <p class="ms-sub">Review station details and remove listings when required.</p>
        <div class="ms-table-wrap">
            <asp:GridView ID="gvStations" runat="server" CssClass="table ms-table"
                AutoGenerateColumns="false" OnRowCommand="gvStations_RowCommand" DataKeyNames="StationID">
                <Columns>
                    <asp:BoundField DataField="StationName" HeaderText="Station" />
                    <asp:BoundField DataField="City" HeaderText="City" />
                    <asp:BoundField DataField="ConnectorType" HeaderText="Connector" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <%# Convert.ToBoolean(Eval("IsApproved")) ?
                            "<span class='badge bg-success'>Approved</span>" :
                            "<span class='badge bg-warning text-dark'>Pending</span>" %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-danger btn-sm"
                                CommandName="DeleteStation" CommandArgument='<%# Eval("StationID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </section>
</div>

</asp:Content>