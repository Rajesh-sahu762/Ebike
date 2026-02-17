<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="ManageLeads.aspx.cs"
    Inherits="Admin_ManageLeads" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

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

        <asp:BoundField DataField="LeadAmount" HeaderText="Amount (₹)" />
        <asp:BoundField DataField="CommissionAmount" HeaderText="Commission (₹)" />

        <asp:TemplateField HeaderText="Net (₹)">
            <ItemTemplate>
                <%# Convert.ToDecimal(Eval("LeadAmount")) - Convert.ToDecimal(Eval("CommissionAmount")) %>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Settlement">
            <ItemTemplate>
                <%# Convert.ToBoolean(Eval("IsSettled")) ?
                "<span class='badge bg-success'>Settled</span>" :
                (Convert.ToBoolean(Eval("SettlementRequested")) ?
                "<span class='badge bg-warning'>Requested</span>" :
                "<span class='badge bg-secondary'>Pending</span>") %>
            </ItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="CreatedAt" HeaderText="Date" SortExpression="CreatedAt" />

        <asp:TemplateField>
            <ItemTemplate>

                <asp:Button ID="Button1" runat="server"
                    Text="View"
                    CssClass="btn btn-info btn-sm"
                    CommandName="ViewLead"
                    CommandArgument='<%# Eval("LeadID") %>' />

                <asp:Button ID="Button2" runat="server"
                    Text="Approve"
                    CssClass="btn btn-success btn-sm"
                    CommandName="ApproveSettlement"
                    CommandArgument='<%# Eval("LeadID") %>'
                    Visible='<%# Convert.ToBoolean(Eval("SettlementRequested")) && !Convert.ToBoolean(Eval("IsSettled")) %>' />

                <asp:Button ID="Button3" runat="server"
                    Text="Delete"
                    CssClass="btn btn-danger btn-sm"
                    CommandName="DeleteLead"
                    CommandArgument='<%# Eval("LeadID") %>' />

            </ItemTemplate>
        </asp:TemplateField>

    </Columns>
</asp:GridView>


</div>

<!-- Modal -->
<div class="modal fade" id="leadModal" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content custom-modal">
      <div class="modal-header border-0">
        <h5 class="modal-title">Lead Message</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <asp:Literal ID="litLeadMessage" runat="server"></asp:Literal>
      </div>
    </div>
  </div>
</div>

<script>
    function toggleAll(source) {
        var checkboxes = document.querySelectorAll("#<%= gvLeads.ClientID %> input[type='checkbox']");
    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = source.checked;
    }
}
</script>

</asp:Content>
