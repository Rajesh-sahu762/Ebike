<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="ManageLeads.aspx.cs"
    Inherits="Admin_ManageLeads" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        /* ===== PREMIUM MODAL ===== */

.premium-modal{
background: linear-gradient(145deg,#25215a,#1e1b4b);
border:none;
border-radius:18px;
color:white;
box-shadow:0 20px 50px rgba(0,0,0,0.5);
}

/* HEADER */

.premium-modal-header{
border-bottom:1px solid rgba(255,255,255,0.08);
padding:18px 22px;
display:flex;
justify-content:space-between;
align-items:center;
}

.modal-title-wrap{
display:flex;
align-items:center;
gap:10px;
}

.modal-icon{
font-size:22px;
color:#06b6d4;
}

/* BODY */

.premium-modal-body{
padding:25px;
}

.lead-message-box{
background:#1a1740;
padding:20px;
border-radius:12px;
font-size:15px;
line-height:1.6;
color:#e2e8f0;
border:1px solid rgba(255,255,255,0.05);
}

/* FOOTER */

.premium-modal-footer{
border-top:1px solid rgba(255,255,255,0.08);
padding:15px 20px;
}

/* MODAL ANIMATION */

.modal.fade .modal-dialog{
transform:scale(.9);
transition:all .25s ease;
}

.modal.show .modal-dialog{
transform:scale(1);
}
    </style>

<div class="card-custom">

    <h4 class="mb-4">Manage Leads</h4>

    <!-- Filters -->
    <div class="row mb-4">

        <div class="col-md-3">
            <asp:DropDownList ID="ddlDealer" runat="server"
                CssClass="form-control custom-input">
            </asp:DropDownList>
        </div>

        <div class="col-md-3">
            <asp:TextBox ID="txtFrom" runat="server"
                CssClass="form-control custom-input"
                TextMode="Date"></asp:TextBox>
        </div>

        <div class="col-md-3">
            <asp:TextBox ID="txtTo" runat="server"
                CssClass="form-control custom-input"
                TextMode="Date"></asp:TextBox>
        </div>

        <div class="col-md-3">
            <asp:Button ID="btnFilter" runat="server"
                Text="Filter"
                CssClass="btn btn-gradient w-100"
                OnClick="btnFilter_Click" />
        </div>

    </div>

    <!-- Summary Cards -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="stat-box text-center">
                <h6>Today's Leads</h6>
                <asp:Label ID="lblToday" runat="server" Font-Size="22px"></asp:Label>
            </div>
        </div>

        <div class="col-md-4">
            <div class="stat-box text-center">
                <h6>This Month</h6>
                <asp:Label ID="lblMonth" runat="server" Font-Size="22px"></asp:Label>
            </div>
        </div>

        <div class="col-md-4">
            <div class="stat-box text-center">
                <h6>Unread Leads</h6>
                <asp:Label ID="lblUnread" runat="server" Font-Size="22px"></asp:Label>
            </div>
        </div>
    </div>

    <!-- Bulk Delete -->
    <asp:Button ID="btnBulkDelete" runat="server"
        Text="Delete Selected"
        CssClass="btn btn-danger mb-3"
        OnClick="btnBulkDelete_Click" />

    <!-- Grid -->
<asp:GridView ID="gvLeads" runat="server"
CssClass="table table-dark table-striped"
AutoGenerateColumns="false"
AllowPaging="true"
AllowSorting="true"
PageSize="6"
DataKeyNames="LeadID"
OnPageIndexChanging="gvLeads_PageIndexChanging"
OnSorting="gvLeads_Sorting"
OnRowCommand="gvLeads_RowCommand">

<Columns>

<asp:TemplateField>
<HeaderTemplate>
<input type="checkbox" onclick="toggleAll(this)" />
</HeaderTemplate>
<ItemTemplate>
<asp:CheckBox ID="chkSelect" runat="server" />
</ItemTemplate>
</asp:TemplateField>

<asp:BoundField DataField="FullName" HeaderText="Customer" SortExpression="FullName" />

<asp:BoundField DataField="ModelName" HeaderText="Bike" SortExpression="ModelName" />

<asp:BoundField DataField="DealerName" HeaderText="Dealer" SortExpression="DealerName" />

<asp:BoundField DataField="CreatedAt" HeaderText="Date" SortExpression="CreatedAt" />

<asp:TemplateField HeaderText="Status">
<ItemTemplate>

<%# Convert.ToBoolean(Eval("IsViewed")) ?

"<span class='badge bg-success'>Viewed</span>" :

"<span class='badge bg-warning'>Unread</span>" %>

</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField>

<ItemTemplate>

<asp:Button ID="btnView" runat="server"
Text="View"
CssClass="btn btn-info btn-sm"
CommandName="ViewLead"
CommandArgument='<%# Eval("LeadID") %>' />

<asp:Button ID="btnDelete" runat="server"
Text="Delete"
CssClass="btn btn-danger btn-sm"
CommandName="DeleteLead"
CommandArgument='<%# Eval("LeadID") %>' />

</ItemTemplate>

</asp:TemplateField>

</Columns>
</asp:GridView>


</div>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>

<!-- PREMIUM LEAD MODAL -->

<div class="modal fade" id="leadModal" tabindex="-1">
<div class="modal-dialog modal-dialog-centered modal-lg">

<div class="modal-content premium-modal">

<div class="modal-header premium-modal-header">

<div class="modal-title-wrap">

<i class="bi bi-chat-left-text modal-icon"></i>

<h5 class="modal-title">Lead Message</h5>

</div>

<button type="button"
class="btn-close btn-close-white"
data-bs-dismiss="modal"></button>

</div>

<div class="modal-body premium-modal-body">

<div class="lead-message-box">

<asp:Literal ID="litLeadMessage" runat="server"></asp:Literal>

</div>

</div>

<div class="modal-footer premium-modal-footer">

<button class="btn btn-gradient"
data-bs-dismiss="modal">

Close

</button>

</div>

</div>

</div>
</div>

</ContentTemplate>
</asp:UpdatePanel>

<script>
    function toggleAll(source) {
        var checkboxes = document.querySelectorAll("#<%= gvLeads.ClientID %> input[type='checkbox']");
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = source.checked;
    }
}
</script>

</asp:Content>
