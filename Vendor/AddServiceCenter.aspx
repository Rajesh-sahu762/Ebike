<%@ Page Title="Manage Service Center" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
AutoEventWireup="true" CodeFile="AddServiceCenter.aspx.cs"
Inherits="Vendor_AddServiceCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>

.container-box{
max-width:1100px;
margin:40px auto;
padding:0 20px;
}

.card{
background:#fff;
border-radius:14px;
padding:25px;
box-shadow:0 10px 30px rgba(0,0,0,0.08);
margin-bottom:20px;
}

.title{
font-size:20px;
font-weight:700;
margin-bottom:15px;
}

.form-control{
border-radius:10px;
height:45px;
}

.btn-main{
background:#ef4444;
color:#fff;
border:none;
padding:10px;
border-radius:8px;
}

.search-box{
display:flex;
gap:10px;
margin-bottom:15px;
}

</style>

<div class="container-box">

<!-- ADD -->
<div class="card">
<div class="title">Add Service Center</div>

<asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Center Name"></asp:TextBox><br/>

<asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Phone"></asp:TextBox><br/>

<asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City"></asp:TextBox><br/>

<asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address"></asp:TextBox><br/>

<asp:TextBox ID="txtService" runat="server" CssClass="form-control" placeholder="Services"></asp:TextBox><br/>

<asp:Button ID="btnSave" runat="server" Text="Add Center"
CssClass="btn-main w-100"
OnClick="btnSave_Click"/>

<asp:Label ID="lblMsg" runat="server"></asp:Label>

</div>

<!-- SEARCH -->
<div class="card">

<div class="search-box">

<asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
placeholder="Search by name or city"></asp:TextBox>

<asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-control">
<asp:ListItem Value="">All</asp:ListItem>
<asp:ListItem Value="0">Pending</asp:ListItem>
<asp:ListItem Value="1">Approved</asp:ListItem>
</asp:DropDownList>

<asp:Button ID="btnSearch" runat="server"
Text="Search"
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

<asp:BoundField DataField="CenterName" HeaderText="Center"/>
<asp:BoundField DataField="City" HeaderText="City"/>
<asp:BoundField DataField="ServiceType" HeaderText="Service"/>

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