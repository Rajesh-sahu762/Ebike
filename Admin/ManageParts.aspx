<%@ Page Title="Manage Parts" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
AutoEventWireup="true" CodeFile="ManageParts.aspx.cs"
Inherits="Admin_ManageParts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="card-custom">

<h4 class="mb-4">Manage Parts</h4>

<asp:GridView ID="gvParts" runat="server"
CssClass="table table-dark table-striped"
AutoGenerateColumns="false"
DataKeyNames="PartID"
OnRowCommand="gvParts_RowCommand">

<Columns>

<asp:BoundField DataField="PartName" HeaderText="Part"/>

<asp:BoundField DataField="Category" HeaderText="Category"/>

<asp:BoundField DataField="Price" HeaderText="Price"/>

<asp:BoundField DataField="Stock" HeaderText="Stock"/>

<asp:BoundField DataField="VendorName" HeaderText="Vendor"/>

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

<asp:TemplateField HeaderText="Action">
<ItemTemplate>

<asp:Button ID="Button1" runat="server"
Text="Approve"
CssClass="btn btn-success btn-sm"
CommandName="ApprovePart"
CommandArgument='<%# Eval("PartID") %>'
Visible='<%# !Convert.ToBoolean(Eval("IsApproved")) %>'/>

<asp:Button ID="Button2" runat="server"
Text="Delete"
CssClass="btn btn-danger btn-sm"
CommandName="DeletePart"
CommandArgument='<%# Eval("PartID") %>'/>

</ItemTemplate>
</asp:TemplateField>

</Columns>

</asp:GridView>

</div>

</asp:Content>