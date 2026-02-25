<%@ Page Title="Rental Management" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="RentalManagement.aspx.cs"
    Inherits="Admin_RentalManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.dashboard-cards {
    display: grid;
    grid-template-columns: repeat(auto-fit,minmax(220px,1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.stat-card {
    padding: 25px;
    border-radius: 15px;
    color: white;
    box-shadow: 0 8px 25px rgba(0,0,0,0.08);
    transition: 0.3s;
}

.stat-card:hover {
    transform: translateY(-5px);
}

.stat-title {
    font-size: 14px;
    opacity: 0.9;
}

.stat-value {
    font-size: 28px;
    font-weight: 700;
}

.bg-gradient-blue {
    background: linear-gradient(135deg,#2563eb,#1e40af);
}

.bg-gradient-orange {
    background: linear-gradient(135deg,#f59e0b,#d97706);
}

.bg-gradient-green {
    background: linear-gradient(135deg,#10b981,#047857);
}

.bg-gradient-purple {
    background: linear-gradient(135deg,#8b5cf6,#6d28d9);
}

.bg-gradient-dark {
    background: linear-gradient(135deg,#0f172a,#1e293b);
}

.filter-box {
    background: white;
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.05);
    margin-bottom: 25px;
}

.grid-box {
    background: white;
    padding: 20px;
    border-radius: 15px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.05);
}

.table thead {
    background: #0f172a;
    color: white;
}
</style>

<h2 style="margin-bottom:20px;color:white; ">Rental Management</h2>

<!-- Dashboard Cards -->
<div class="dashboard-cards">

    <div class="stat-card bg-gradient-blue">
        <div class="stat-title">Total Rentals</div>
        <div class="stat-value">
            <asp:Label ID="lblTotal" runat="server"></asp:Label>
        </div>
    </div>

    <div class="stat-card bg-gradient-orange">
        <div class="stat-title">Pending Rentals</div>
        <div class="stat-value">
            <asp:Label ID="lblPending" runat="server"></asp:Label>
        </div>
    </div>

    <div class="stat-card bg-gradient-purple">
        <div class="stat-title">Active Rentals</div>
        <div class="stat-value">
            <asp:Label ID="lblActive" runat="server"></asp:Label>
        </div>
    </div>

    <div class="stat-card bg-gradient-green">
        <div class="stat-title">Completed Rentals</div>
        <div class="stat-value">
            <asp:Label ID="lblCompleted" runat="server"></asp:Label>
        </div>
    </div>

    <div class="stat-card bg-gradient-dark">
        <div class="stat-title">Total Commission</div>
        <div class="stat-value">
            ₹ <asp:Label ID="lblCommission" runat="server"></asp:Label>
        </div>
    </div>

</div>

<!-- Filter Section -->
<div class="filter-box">
    <div class="row">
        <div class="col-md-4">
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                <asp:ListItem>Pending</asp:ListItem>
                <asp:ListItem>Approved</asp:ListItem>
                <asp:ListItem>Active</asp:ListItem>
                <asp:ListItem>Completed</asp:ListItem>
                <asp:ListItem>Rejected</asp:ListItem>
                <asp:ListItem>Cancelled</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-md-4">
            <asp:TextBox ID="txtSearch" runat="server"
                CssClass="form-control"
                placeholder="Search Model / Customer"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:Button ID="btnFilter" runat="server"
                Text="Apply Filter"
                CssClass="btn btn-primary w-100"
                OnClick="btnFilter_Click" />
        </div>
    </div>
</div>

<!-- Rental Grid -->
<div class="grid-box">

<asp:GridView ID="gvRentals" runat="server"
    AutoGenerateColumns="False"
    CssClass="table table-bordered table-hover"
    OnRowCommand="gvRentals_RowCommand">

    <Columns>

        <asp:BoundField DataField="RentalID" HeaderText="ID" />
        <asp:BoundField DataField="ModelName" HeaderText="Bike" />
        <asp:BoundField DataField="CustomerName" HeaderText="Customer" />
        <asp:BoundField DataField="DealerName" HeaderText="Dealer" />
        <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:dd-MMM-yyyy}" />
        <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:dd-MMM-yyyy}" />
        <asp:BoundField DataField="RentAmount" HeaderText="Amount" DataFormatString="₹ {0:N0}" />
        <asp:BoundField DataField="CommissionAmount" HeaderText="Commission" DataFormatString="₹ {0:N0}" />
        <asp:BoundField DataField="Status" HeaderText="Status" />

        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>

                <asp:LinkButton ID="btnActive" runat="server"
                    CommandName="SetActive"
                    CommandArgument='<%# Eval("RentalID") %>'
                    CssClass="btn btn-sm btn-info mb-1">Active</asp:LinkButton>

                <asp:LinkButton ID="btnComplete" runat="server"
                    CommandName="Complete"
                    CommandArgument='<%# Eval("RentalID") %>'
                    CssClass="btn btn-sm btn-success mb-1">Complete</asp:LinkButton>

                <asp:LinkButton ID="btnCancel" runat="server"
                    CommandName="CancelRental"
                    CommandArgument='<%# Eval("RentalID") %>'
                    CssClass="btn btn-sm btn-danger">Cancel</asp:LinkButton>

            </ItemTemplate>
        </asp:TemplateField>

    </Columns>

</asp:GridView>

</div>

</asp:Content>