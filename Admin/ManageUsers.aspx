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
        OnRowCommand="gvUsers_RowCommand">

        <Columns>

            <asp:TemplateField HeaderText="Profile">
                <ItemTemplate>
                    <img src='<%# Eval("ProfileImage") %>'
                         style="width:50px; height:50px; border-radius:50%; object-fit:cover;" />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="FullName" HeaderText="Name" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Role" HeaderText="Role" />
            <asp:BoundField DataField="IsActive" HeaderText="Active" />

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

<!-- User Detail Modal -->
<div class="modal fade" id="userModal" tabindex="-1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content" style="background:#1e1b4b; color:white;">
      <div class="modal-header">
        <h5 class="modal-title">User Details</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <asp:Literal ID="litUserDetails" runat="server"></asp:Literal>
      </div>
    </div>
  </div>
</div>

</asp:Content>
