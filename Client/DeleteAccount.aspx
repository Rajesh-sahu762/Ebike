<%@ Page Title="Delete Account" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true" CodeFile="DeleteAccount.aspx.cs"
Inherits="Client_DeleteAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<section class="delete-wrapper">

<div class="delete-card">

<h2>Delete My Account</h2>

<p class="warning">
⚠ This action is permanent. All your data will be removed.
</p>

<label>Enter Password to Confirm</label>

<asp:TextBox ID="txtPassword"
runat="server"
TextMode="Password"
CssClass="input"></asp:TextBox>

<asp:Button ID="btnDelete"
runat="server"
Text="Delete My Account"
CssClass="btn-delete"
OnClick="btnDelete_Click" />

<a href="MyProfile.aspx" class="btn-cancel">
Cancel
</a>

</div>

</section>

<style>

.delete-wrapper{
max-width:500px;
margin:100px auto;
padding:0 20px;
}

.delete-card{
background:#fff;
padding:30px;
border-radius:14px;
box-shadow:0 10px 30px rgba(0,0,0,0.08);
text-align:center;
}

.warning{
color:#ef4444;
margin-bottom:20px;
font-weight:600;
}

.input{
width:100%;
padding:10px;
border:1px solid #ddd;
border-radius:6px;
margin:10px 0 20px 0;
}

.btn-delete{
background:#ef4444;
border:none;
color:white;
padding:10px 20px;
border-radius:6px;
cursor:pointer;
}

.btn-delete:hover{
background:#dc2626;
}

.btn-cancel{
display:inline-block;
margin-left:10px;
padding:10px 20px;
background:#111827;
color:white;
border-radius:6px;
text-decoration:none;
}

</style>

</asp:Content>