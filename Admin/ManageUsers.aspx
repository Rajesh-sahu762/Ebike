<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="ManageUsers.aspx.cs"
    Inherits="Admin_ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="card-custom">

    <h4 class="mb-4">Manage Users</h4>

    <!-- Filters -->
    <div class="row mb-4">

        <div class="col-md-4">
            <asp:DropDownList ID="ddlRole" runat="server"
                CssClass="form-control custom-input">
                <asp:ListItem Value="">All Roles</asp:ListItem>
                <asp:ListItem Value="Admin">Admin</asp:ListItem>
                <asp:ListItem Value="Dealer">Dealer</asp:ListItem>
                <asp:ListItem Value="Customer">Customer</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="col-md-5">
            <asp:TextBox ID="txtSearch" runat="server"
                CssClass="form-control custom-input"
                placeholder="Search by Name or Email"></asp:TextBox>
        </div>

        <div class="col-md-3">
            <asp:Button ID="btnSearch" runat="server"
                Text="Search"
                CssClass="btn btn-gradient w-100"
                OnClick="btnSearch_Click" />
        </div>

    </div>

    <!-- Grid -->
 <asp:GridView ID="gvUsers" runat="server"
    CssClass="table table-dark table-striped"
    AutoGenerateColumns="false"
    AllowPaging="true"
    AllowSorting="true"
    PageSize="5"
    OnPageIndexChanging="gvUsers_PageIndexChanging"
    OnSorting="gvUsers_Sorting"
    OnRowCommand="gvUsers_RowCommand">

    <Columns>

        <asp:TemplateField HeaderText="Profile">
            <ItemTemplate>
                <img src='<%# Eval("ProfileImage") %>'
                     style="width:50px; height:50px; border-radius:50%; object-fit:cover;" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="FullName" />
        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
        <asp:BoundField DataField="Role" HeaderText="Role" SortExpression="Role" />
        <asp:BoundField DataField="IsActive" HeaderText="Active" SortExpression="IsActive" />

        <asp:TemplateField>
            <ItemTemplate>

                <asp:Button ID="Button1" runat="server"
                    Text="View"
                    CssClass="btn btn-info btn-sm"
                    CommandName="ViewUser"
                    CommandArgument='<%# Eval("UserID") %>' />

                <asp:Button ID="Button2" runat="server"
                    Text="Toggle"
                    CssClass="btn btn-warning btn-sm"
                    CommandName="ToggleUser"
                    CommandArgument='<%# Eval("UserID") %>' />

                <asp:Button ID="Button3" runat="server"
                    Text="Delete"
                    CssClass="btn btn-danger btn-sm"
                    CommandName="DeleteUser"
                    CommandArgument='<%# Eval("UserID") %>' />

            </ItemTemplate>
        </asp:TemplateField>

    </Columns>

</asp:GridView>


</div>

<!-- Premium User Detail Modal -->
<div class="modal fade" id="userModal" tabindex="-1">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content custom-modal">

      <div class="modal-header border-0">
        <h5 class="modal-title fw-bold">User Details</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>

      <div class="modal-body">
        <div class="row align-items-center">

          <!-- Left Side Image -->
          <div class="col-md-4 text-center mb-3">
            <img id="modalUserImage"
                 src=""
                 class="modal-profile-img" />
          </div>

          <!-- Right Side Details -->
          <div class="col-md-8">
            <div id="modalUserContent"></div>
          </div>

        </div>
      </div>

    </div>
  </div>
</div>


    <style>
        .custom-modal {
    background: linear-gradient(135deg, #1e1b4b, #25215a);
    color: white;
    border-radius: 20px;
    padding: 20px;
    box-shadow: 0 20px 40px rgba(0,0,0,0.5);
}

.modal-profile-img {
    width: 140px;
    height: 140px;
    border-radius: 50%;
    object-fit: cover;
    border: 4px solid #7c3aed;
    box-shadow: 0 0 20px rgba(124,58,237,0.6);
}

.badge-role {
    background: #7c3aed;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 13px;
}

.badge-active {
    background: #16a34a;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 13px;
}

.badge-inactive {
    background: #dc2626;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 13px;
}

    </style>

</asp:Content>
