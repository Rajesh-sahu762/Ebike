<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="ManageBrands.aspx.cs"
    Inherits="Admin_ManageBrands" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="card-custom p-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4 class="mb-0">Manage Brands</h4>
    </div>

    <!-- ADD BRAND -->
    <div class="brand-box mb-4">
        <div class="row g-3 align-items-center">

            <div class="col-md-4">
                <asp:TextBox ID="txtBrand" runat="server"
                    CssClass="form-control modern-input"
                    placeholder="Enter Brand Name"></asp:TextBox>
            </div>

            <div class="col-md-3">
                <asp:FileUpload ID="fuLogo" runat="server"
                    CssClass="form-control modern-input" />
            </div>

            <div class="col-md-2">
                <asp:CheckBox ID="chkActive" runat="server"
                    Checked="true" Text=" Active" />
            </div>

            <div class="col-md-3">
                <asp:Button ID="btnSave" runat="server"
                    Text="Add Brand"
                    CssClass="btn btn-gradient w-100"
                    OnClick="btnSave_Click" />
            </div>

        </div>
    </div>

    <!-- SEARCH BAR -->
    <div class="d-flex justify-content-between align-items-center mb-3">

        <div style="width:350px;">
            <asp:TextBox ID="txtSearch" runat="server"
                CssClass="form-control modern-input"
                placeholder="Search Brand"></asp:TextBox>
        </div>

        <asp:Button ID="btnSearch" runat="server"
            Text="Search"
            CssClass="btn btn-light px-4"
            OnClick="btnSearch_Click" />

    </div>

    <!-- TABLE -->
    <div class="table-responsive">
        <asp:GridView ID="gvBrands" runat="server"
            CssClass="table table-hover modern-table"
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
                        <img src='../Uploads/Brands/<%# Eval("LogoPath") %>'
                            class="brand-logo" />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="BrandName"
                    HeaderText="Brand"
                    SortExpression="BrandName" />

                <asp:BoundField DataField="BikeCount"
                    HeaderText="Total Bikes"
                    SortExpression="BikeCount" />

                <asp:TemplateField HeaderText="Status">
                    <ItemTemplate>
                        <%# Convert.ToBoolean(Eval("IsActive")) 
                            ? "<span class='badge bg-success'>Active</span>" 
                            : "<span class='badge bg-secondary'>Inactive</span>" %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Action">
                    <ItemTemplate>

                        <div class="d-flex gap-2">

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
                                OnClientClick="return confirm('Delete this brand?');" />

                        </div>

                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>

        </asp:GridView>
    </div>

</div>

<style>

/* ADD SECTION BOX */
.brand-box{
    background:#1f2937;
    padding:20px;
    border-radius:12px;
}

/* INPUT STYLE */
.modern-input{
    background:#111827;
    color:white;
    border:1px solid #374151;
}

.modern-input::placeholder{
    color:#9ca3af;
}

/* TABLE */
.modern-table thead{
    background:#111827;
    color:white;
}

.modern-table tbody tr{
    transition:0.3s;
}

.modern-table tbody tr:hover{
    background:#1f2937;
}

/* LOGO */
.brand-logo{
    width:50px;
    height:50px;
    border-radius:50%;
    object-fit:cover;
    border:2px solid #374151;
}

</style>

</asp:Content>
