<%@ Page Title="Dealer Ratings" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="DealerRatings.aspx.cs"
    Inherits="Vendor_DealerRatings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.dr-page{padding:28px 0 42px;color:#26344a}.dr-kicker{font:700 11px 'Quicksand',sans-serif;letter-spacing:1.2px;text-transform:uppercase;color:#1686a5;margin-bottom:7px}
.dr-heading{margin-bottom:22px}.dr-heading h2{font:800 27px 'Manrope',sans-serif;color:#26344a;margin:0}.dr-heading p{font-size:14px;color:#7b8798;margin:7px 0 0}
.dr-stats{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:16px;margin-bottom:22px}
.dr-stat{background:#edf1f7;border-radius:18px;padding:21px;box-shadow:8px 8px 17px #d3d9e2,-8px -8px 17px #fff}
.dr-stat-label{font:700 11px 'Quicksand',sans-serif;letter-spacing:.7px;text-transform:uppercase;color:#8490a1}
.dr-stat-value{font:800 27px 'Manrope',sans-serif;color:#26344a;margin-top:8px}
.dr-stars{color:#e5a629;font-size:17px;letter-spacing:2px;margin-top:4px}
.dr-panel{background:#edf1f7;border-radius:21px;padding:22px;box-shadow:9px 9px 20px #d3d9e2,-9px -9px 20px #fff}
.dr-panel h3{font:800 18px 'Manrope',sans-serif;color:#26344a;margin:0 0 5px}.dr-sub{font-size:12px;color:#8490a1;margin:0 0 18px}
.dr-table-wrap{overflow-x:auto;border-radius:14px;padding:7px;background:#edf1f7;box-shadow:inset 4px 4px 9px #d5dbe4,inset -4px -4px 9px #fff}
.dr-table{width:100%;min-width:950px;margin:0!important;border-collapse:separate!important;border-spacing:0 7px!important}
.dr-table th{border:0!important;background:transparent!important;color:#8490a1!important;font:700 10px 'Quicksand',sans-serif;text-transform:uppercase;letter-spacing:.65px;padding:10px!important;white-space:nowrap}
.dr-table td{border:0!important;background:#f4f6fa!important;color:#475569;font-size:12px;padding:13px 10px!important;vertical-align:middle!important}
.dr-table td:first-child{border-radius:9px 0 0 9px}.dr-table td:last-child{border-radius:0 9px 9px 0}
.dr-table .badge{border-radius:20px;padding:6px 9px;font-size:10px}
.dr-table .btn{border:0;border-radius:8px;font-size:10px;font-weight:700;padding:7px 9px;margin:2px}
@media(max-width:700px){.dr-stats{grid-template-columns:1fr}.dr-stat{padding:16px}}
@media(max-width:575px){.dr-page{padding:18px 0 30px}.dr-heading h2{font-size:23px}.dr-panel{padding:16px;border-radius:17px}}
</style>

<div class="container-fluid dr-page">
    <div class="dr-heading">
        <div class="dr-kicker">Customer feedback</div>
        <h2>Dealer Ratings & Reviews</h2>
        <p>Monitor customer feedback and manage review approval.</p>
    </div>

    <div class="dr-stats">
        <div class="dr-stat">
            <div class="dr-stat-label">Average Rating</div>
            <div class="dr-stat-value"><asp:Label ID="lblAvg" runat="server" /></div>
            <div id="starDisplay" class="dr-stars" aria-label="Average rating stars">★★★★★</div>
        </div>
        <div class="dr-stat">
            <div class="dr-stat-label">Total Reviews</div>
            <div class="dr-stat-value"><asp:Label ID="lblTotal" runat="server" /></div>
        </div>
        <div class="dr-stat">
            <div class="dr-stat-label">5 Star Reviews</div>
            <div class="dr-stat-value"><asp:Label ID="lblFive" runat="server" /></div>
        </div>
    </div>

    <section class="dr-panel">
        <div class="dr-kicker">Review moderation</div>
        <h3>Customer Reviews</h3>
        <p class="dr-sub">Review submitted feedback and approve, reject or remove reviews.</p>
        <div class="dr-table-wrap">
            <asp:GridView ID="gvRatings" runat="server"
                CssClass="table dr-table"
                AutoGenerateColumns="false"
                AllowPaging="true"
                PageSize="5"
                OnPageIndexChanging="gvRatings_PageIndexChanging"
                OnRowCommand="gvRatings_RowCommand">
                <Columns>
                    <asp:BoundField DataField="ModelName" HeaderText="Bike"/>
                    <asp:BoundField DataField="FullName" HeaderText="Customer"/>
                    <asp:TemplateField HeaderText="Rating">
                        <ItemTemplate><%# GetStars(Convert.ToInt32(Eval("Rating"))) %></ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ReviewText" HeaderText="Review"/>
                    <asp:BoundField DataField="CreatedAt" HeaderText="Date"/>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <%# Convert.ToBoolean(Eval("IsApproved"))
                            ? "<span class='badge bg-success'>Approved</span>"
                            : "<span class='badge bg-warning text-dark'>Pending</span>" %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="approve"
                                CommandArgument='<%# Eval("ReviewID") %>' CssClass="btn btn-success btn-sm">Approve</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" CommandName="reject"
                                CommandArgument='<%# Eval("ReviewID") %>' CssClass="btn btn-warning btn-sm">Reject</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton3" runat="server" CommandName="delete"
                                CommandArgument='<%# Eval("ReviewID") %>' CssClass="btn btn-danger btn-sm"
                                OnClientClick="return confirm('Delete review?');">Delete</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </section>
</div>

</asp:Content>