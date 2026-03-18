<%@ Page Title="Manage Parts" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
AutoEventWireup="true" CodeFile="ManageParts.aspx.cs"
Inherits="Vendor_ManageParts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-4">

<h3 class="mb-4">Manage Parts</h3>

<div class="row">

<!-- ADD FORM -->

<div class="col-md-4">
<div class="card p-3 shadow-sm">

<h5>Add Part</h5>

<asp:TextBox ID="txtName" runat="server" CssClass="form-control mb-2" placeholder="Part Name"></asp:TextBox>

<asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control mb-2">
</asp:DropDownList>

<asp:TextBox ID="txtPrice" runat="server" CssClass="form-control mb-2" placeholder="Price"></asp:TextBox>

<asp:TextBox ID="txtStock" runat="server" CssClass="form-control mb-2" placeholder="Stock"></asp:TextBox>

<asp:TextBox ID="txtDesc" runat="server" CssClass="form-control mb-2" placeholder="Description"></asp:TextBox>

<asp:FileUpload ID="fuImage" runat="server" CssClass="form-control mb-2"/>

<asp:Button ID="btnSave" runat="server" Text="Add Part"
CssClass="btn btn-primary w-100"
OnClick="btnSave_Click"/>

<asp:Label ID="lblMsg" runat="server" CssClass="text-success"></asp:Label>

</div>
</div>

<!-- LIST -->

<div class="col-md-8">

<asp:GridView ID="gvParts" runat="server"
CssClass="table table-bordered"
AutoGenerateColumns="false"
OnRowCommand="gvParts_RowCommand"
DataKeyNames="PartID">

<Columns>

<asp:BoundField DataField="PartName" HeaderText="Name"/>
<asp:BoundField DataField="Category" HeaderText="Category"/>
<asp:BoundField DataField="Price" HeaderText="Price"/>
<asp:BoundField DataField="Stock" HeaderText="Stock"/>

<asp:TemplateField HeaderText="Image">
<ItemTemplate>
<img src='/Uploads/Parts/<%# Eval("Image1") %>' width="50"/>
</ItemTemplate>
</asp:TemplateField>


<asp:TemplateField HeaderText="Status">
<ItemTemplate>
<%# Convert.ToBoolean(Eval("IsApproved")) ?
"<span class='badge bg-success'>Approved</span>" :
"<span class='badge bg-warning'>Pending</span>" %>
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField>
<ItemTemplate>
<asp:Button ID="btnDelete" runat="server"
Text="Delete"
CssClass="btn btn-danger btn-sm"
CommandName="DeletePart"
CommandArgument='<%# Eval("PartID") %>'/>
</ItemTemplate>
</asp:TemplateField>

</Columns>

</asp:GridView>

</div>

</div>

</div>

</asp:Content>