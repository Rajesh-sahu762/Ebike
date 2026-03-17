<%@ Page Title="Add Charging Station" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
AutoEventWireup="true" CodeFile="AddChargingStation.aspx.cs"
Inherits="Vendor_AddChargingStation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.form-box{
max-width:700px;
margin:40px auto;
background:#fff;
padding:30px;
border-radius:14px;
box-shadow:0 10px 30px rgba(0,0,0,0.08);
}

.btn-save{
background:#ef4444;
color:white;
border:none;
padding:12px;
width:100%;
border-radius:8px;
font-weight:600;
}
</style>

<div class="form-box">

<h4>Add Charging Station</h4>

<asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Station Name"></asp:TextBox><br/>

<asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Phone"></asp:TextBox><br/>

<asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City"></asp:TextBox><br/>

<asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Full Address"></asp:TextBox><br/>

<asp:TextBox ID="txtConnector" runat="server" CssClass="form-control" placeholder="Connector Type (Fast/DC/etc)"></asp:TextBox><br/>

<asp:Button ID="btnSave" runat="server" Text="Add Station"
CssClass="btn-save"
OnClick="btnSave_Click" />

<br /><br/>

<asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>

</div>

</asp:Content>