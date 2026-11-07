<%@ Page Title="Earnings" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="VendorEarnings.aspx.cs"
    Inherits="Vendor_VendorEarnings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.ve-page{padding:28px 0 42px;color:#26344a}.ve-kicker{font:700 11px 'Quicksand',sans-serif;letter-spacing:1.2px;text-transform:uppercase;color:#1686a5;margin-bottom:7px}
.ve-heading{margin-bottom:22px}.ve-heading h2{font:800 27px 'Manrope',sans-serif;color:#26344a;margin:0}.ve-heading p{font-size:14px;color:#7b8798;margin:7px 0 0}
.ve-stats{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:15px;margin-bottom:22px}
.ve-stat{background:#edf1f7;border-radius:17px;padding:19px;box-shadow:7px 7px 16px #d3d9e2,-7px -7px 16px #fff}
.ve-stat-label{font:700 11px 'Quicksand',sans-serif;letter-spacing:.65px;text-transform:uppercase;color:#8490a1}
.ve-stat-value{font:800 24px 'Manrope',sans-serif;color:#26344a;margin-top:8px;overflow-wrap:anywhere}
.ve-stat.pending{background:#f1eee5;box-shadow:7px 7px 16px #d9d5ca,-7px -7px 16px #fff}
.ve-stat.pending .ve-stat-value{color:#9a6a13}
.ve-panel{background:#edf1f7;border-radius:21px;padding:22px;box-shadow:9px 9px 20px #d3d9e2,-9px -9px 20px #fff}
.ve-panel-head{display:flex;align-items:center;justify-content:space-between;gap:15px;margin-bottom:17px}
.ve-panel-title{font:800 18px 'Manrope',sans-serif;color:#26344a;margin:0 0 5px}
.ve-sub{font-size:12px;color:#8490a1;margin:0}
.ve-settle{border:0;border-radius:11px;padding:11px 16px;background:linear-gradient(135deg,#147f9e,#2365a7);color:#fff;font-size:12px;font-weight:700;white-space:nowrap}
.ve-table-wrap{overflow-x:auto;border-radius:14px;padding:7px;background:#edf1f7;box-shadow:inset 4px 4px 9px #d5dbe4,inset -4px -4px 9px #fff}
.ve-table{width:100%;min-width:950px;margin:0!important;border-collapse:separate!important;border-spacing:0 7px!important}
.ve-table th{border:0!important;background:transparent!important;color:#8490a1!important;font:700 10px 'Quicksand',sans-serif;text-transform:uppercase;letter-spacing:.65px;padding:10px!important;white-space:nowrap}
.ve-table td{border:0!important;background:#f4f6fa!important;color:#475569;font-size:12px;padding:12px 10px!important;vertical-align:middle!important;white-space:nowrap}
.ve-table td:first-child{border-radius:9px 0 0 9px}.ve-table td:last-child{border-radius:0 9px 9px 0}
.ve-table input[type=checkbox]{width:16px;height:16px;accent-color:#147f9e;vertical-align:middle}
@media(max-width:950px){.ve-stats{grid-template-columns:repeat(2,minmax(0,1fr))}}
@media(max-width:575px){.ve-page{padding:18px 0 30px}.ve-heading h2{font-size:23px}.ve-stats{gap:10px}.ve-stat{padding:14px}.ve-stat-value{font-size:20px}.ve-panel{padding:16px;border-radius:17px}.ve-panel-head{align-items:flex-start;flex-direction:column}.ve-settle{width:100%}.ve-table{min-width:900px}}
</style>

<div class="container-fluid ve-page">
    <div class="ve-heading">
        <div class="ve-kicker">Financial overview</div>
        <h2>My Earnings</h2>
        <p>Track your revenue, platform fees, net earnings and settlement requests.</p>
    </div>

    <div class="ve-stats">
        <div class="ve-stat">
            <div class="ve-stat-label">Total Revenue</div>
            <div class="ve-stat-value">₹ <asp:Label ID="lblRevenue" runat="server"/></div>
        </div>
        <div class="ve-stat">
            <div class="ve-stat-label">Platform Fee</div>
            <div class="ve-stat-value">₹ <asp:Label ID="lblCommission" runat="server"/></div>
        </div>
        <div class="ve-stat">
            <div class="ve-stat-label">Net Earnings</div>
            <div class="ve-stat-value">₹ <asp:Label ID="lblNet" runat="server"/></div>
        </div>
        <div class="ve-stat pending">
            <div class="ve-stat-label">Pending Settlement</div>
            <div class="ve-stat-value">₹ <asp:Label ID="lblPending" runat="server"/></div>
        </div>
    </div>

    <section class="ve-panel">
        <div class="ve-panel-head">
            <div>
                <div class="ve-kicker">Payout activity</div>
                <h3 class="ve-panel-title">Earnings Transactions</h3>
                <p class="ve-sub">Select eligible records and submit a settlement request.</p>
            </div>
            <asp:Button ID="btnMassSettlement" runat="server"
                Text="Request Settlement Selected"
                CssClass="btn ve-settle"
                OnClick="btnMassSettlement_Click"/>
        </div>

        <div class="ve-table-wrap">
            <asp:GridView ID="gvEarnings" runat="server"
                CssClass="table ve-table"
                AutoGenerateColumns="false"
                DataKeyNames="RecordID,Source"
                AllowPaging="true"
                PageSize="10"
                OnPageIndexChanging="gvEarnings_PageIndexChanging">
                <Columns>
                    <asp:TemplateField HeaderText="Select">
                        <ItemTemplate><asp:CheckBox ID="chkSelect" runat="server"/></ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Source" HeaderText="Source"/>
                    <asp:BoundField DataField="ModelName" HeaderText="Bike"/>
                    <asp:BoundField DataField="Customer" HeaderText="Customer"/>
                    <asp:BoundField DataField="Amount" HeaderText="Amount"/>
                    <asp:BoundField DataField="Commission" HeaderText="Platform Fee"/>
                    <asp:BoundField DataField="Net" HeaderText="Vendor Net"/>
                    <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}"/>
                    <asp:BoundField DataField="Status" HeaderText="Status"/>
                </Columns>
            </asp:GridView>
        </div>
    </section>
</div>

</asp:Content>