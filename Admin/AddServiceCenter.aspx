<%@ Page Title="Manage Service Centers" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
AutoEventWireup="true" CodeFile="AddServiceCenter.aspx.cs"
Inherits="Admin_AddServiceCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.container-box{
max-width:1100px;
margin:40px auto;
}

.form-box{
background:#111827;
padding:25px;
border-radius:12px;
color:white;
margin-bottom:25px;
}

.grid-box{
background:#fff;
padding:20px;
border-radius:12px;
box-shadow:0 10px 30px rgba(0,0,0,0.08);
}

.btn-main{
background:#ef4444;
color:white;
border:none;
padding:10px;
border-radius:8px;
width:100%;
}

.search-box{
display:flex;
gap:10px;
margin-bottom:15px;
}
</style>

<div class="container-box">

<!-- ADD FORM -->
<div class="form-box">

<h4>Add Service Center</h4>

<asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Center Name"></asp:TextBox><br/>

<asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Phone"></asp:TextBox><br/>

<asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City"></asp:TextBox><br/>

<asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address"></asp:TextBox><br/>

<asp:TextBox ID="txtService" runat="server" CssClass="form-control" placeholder="Services"></asp:TextBox><br/>

<asp:Button ID="btnSave" runat="server" Text="Add Center"
CssClass="btn-main"
OnClick="btnSave_Click"/>

<br />
<asp:Label ID="lblMsg" runat="server"></asp:Label>

</div>

<!-- SEARCH -->
<div class="grid-box">

<div class="search-box">

<asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search City / Name"></asp:TextBox>

<asp:Button ID="btnSearch" runat="server" Text="Search"
CssClass="btn btn-dark"
OnClick="btnSearch_Click"/>

</div>

<!-- GRID -->

<asp:GridView ID="gvCenters" runat="server"
CssClass="table table-bordered"
AutoGenerateColumns="false"
OnRowCommand="gvCenters_RowCommand"
DataKeyNames="ServiceID">

<Columns>

<asp:BoundField DataField="CenterName" HeaderText="Center" />
<asp:BoundField DataField="City" HeaderText="City" />
<asp:BoundField DataField="ServiceType" HeaderText="Service" />

<asp:TemplateField HeaderText="Status">
<ItemTemplate>

<%# Convert.ToBoolean(Eval("IsApproved")) ?
"<span class='badge bg-success'>Approved</span>" :
"<span class='badge bg-warning'>Pending</span>" %>

</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField>

<ItemTemplate>

<asp:Button ID="Button1" runat="server"
Text="Approve"
CssClass="btn btn-success btn-sm"
CommandName="Approve"
CommandArgument='<%# Eval("ServiceID") %>'
Visible='<%# !Convert.ToBoolean(Eval("IsApproved")) %>' />

<asp:Button ID="Button2" runat="server"
Text="Delete"
CssClass="btn btn-danger btn-sm"
CommandName="DeleteCenter"
CommandArgument='<%# Eval("ServiceID") %>' />

</ItemTemplate>

</asp:TemplateField>

</Columns>

</asp:GridView>

</div>

</div>

</asp:Content>