<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="ManageBrands.aspx.cs"
    Inherits="Admin_ManageBrands" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="card-custom">

    <h4 class="mb-4">Manage Brands</h4>

    <!-- Add Brand Section -->
    <div class="row mb-4">

        <div class="col-md-4">
            <asp:TextBox ID="txtBrand" runat="server"
                CssClass="form-control custom-input"
                placeholder="Enter Brand Name"></asp:TextBox>
        </div>

        <div class="col-md-3">
            <asp:FileUpload ID="fuLogo" runat="server"
                CssClass="form-control custom-input" />
        </div>

        <div class="col-md-2">
            <asp:CheckBox ID="chkActive" runat="server" Checked="true" Text="Active" />
        </div>

        <div class="col-md-3">
            <asp:Button ID="btnSave" runat="server"
                Text="Add Brand"
                CssClass="btn btn-gradient w-100"
                OnClick="btnSave_Click" />
        </div>

    </div>

    <!-- Search -->
    <div class="row mb-3">
        <div class="col-md-4">
            <asp:TextBox ID="txtSearch" runat="server"
                CssClass="form-control custom-input"
                placeholder="Search Brand"></asp:TextBox>
        </div>
        <div class="col-md-2">
            <asp:Button ID="btnSearch" runat="server"
                Text="Search"
                CssClass="btn btn-light"
                OnClick="btnSearch_Click" />
        </div>
    </div>

    <!-- Grid -->
  <asp:GridView ID="gvBrands" runat="server"
    CssClass="table table-dark table-striped"
    AutoGenerateColumns="false"
    AllowPaging="true"
    AllowSorting="true"
    PageSize="5"
    DataKeyNames="BrandID"
    OnPageIndexChanging="gvBrands_PageIndexChanging"
    OnSorting="gvBrands_Sorting"
    OnRowCommand="gvBrands_RowCommand">


        <Columns>

            <asp:TemplateField HeaderText="Logo">
                <ItemTemplate>
                    <img src='<%# Eval("LogoPath") %>'
                        style="width:50px;height:50px;border-radius:50%;object-fit:cover;" />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="BrandName" HeaderText="Brand" SortExpression="BrandName" />
            <asp:BoundField DataField="BikeCount" HeaderText="Total Bikes" SortExpression="BikeCount" />
            <asp:BoundField DataField="IsActive" HeaderText="Active" SortExpression="IsActive" />

            <asp:TemplateField>
                <ItemTemplate>

                    <asp:Button ID="Button1" runat="server"
                        Text="Edit"
                        CssClass="btn btn-warning btn-sm"
                        CommandName="EditBrand"
                        CommandArgument='<%# Eval("BrandID") %>' />

                    <asp:Button ID="Button2" runat="server"
                        Text="Delete"
                        CssClass="btn btn-danger btn-sm"
                        CommandName="DeleteBrand"
                        CommandArgument='<%# Eval("BrandID") %>'
                        OnClientClick="return confirm('Are you sure?');" />

                </ItemTemplate>
            </asp:TemplateField>

        </Columns>

    </asp:GridView>

</div>


    <style>
       .custom-input::placeholder {
    color: #6c757d; /* Bootstrap muted gray */
    opacity: 1;     /* Ensure visibility */
}

    </style>

</asp:Content>
