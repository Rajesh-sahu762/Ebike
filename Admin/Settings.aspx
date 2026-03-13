<%@ Page Title="Site Settings" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
AutoEventWireup="true" CodeFile="Settings.aspx.cs"
Inherits="Admin_Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="card-custom">

<h4 class="mb-4">Platform Settings</h4>

<!-- SITE SETTINGS -->

<h5 class="section-title">Site Information</h5>

<div class="row mb-4">

<div class="col-md-6">
<asp:TextBox ID="txtSiteTitle" runat="server"
CssClass="form-control"
placeholder="Site Title" />
</div>

<div class="col-md-6">
<asp:TextBox ID="txtTagline" runat="server"
CssClass="form-control"
placeholder="Tagline" />
</div>

</div>

<div class="row mb-4">

<div class="col-md-6">
<asp:TextBox ID="txtAdminEmail" runat="server"
CssClass="form-control"
placeholder="Admin Email" />
</div>

<div class="col-md-6">
<asp:TextBox ID="txtSupportPhone" runat="server"
CssClass="form-control"
placeholder="Support Phone" />
</div>

</div>

<div class="mb-4">

<asp:FileUpload ID="fuLogo" runat="server"
CssClass="form-control" />

<br/>

<asp:Image ID="imgLogo" runat="server" Width="120" />

</div>


<!-- COMMISSION -->

<h5 class="section-title">Revenue Settings</h5>

<div class="row mb-4">

<div class="col-md-6">
<asp:TextBox ID="txtCommission" runat="server"
CssClass="form-control"
placeholder="Platform Commission %" />
</div>

</div>


<!-- SMTP -->

<h5 class="section-title">Email System</h5>

<div class="row mb-4">

<div class="col-md-4">
<asp:TextBox ID="txtSMTPHost" runat="server"
CssClass="form-control"
placeholder="SMTP Host" />
</div>

<div class="col-md-2">
<asp:TextBox ID="txtSMTPPort" runat="server"
CssClass="form-control"
placeholder="Port" />
</div>

<div class="col-md-3">
<asp:TextBox ID="txtSMTPEmail" runat="server"
CssClass="form-control"
placeholder="SMTP Email" />
</div>

<div class="col-md-3">
<asp:CheckBox ID="chkSSL" runat="server"
Text="Enable SSL" />
</div>

</div>


<!-- MAINTENANCE -->

<h5 class="section-title">Maintenance Mode</h5>

<div class="mb-3">

<asp:CheckBox ID="chkMaintenance"
runat="server"
Text="Enable Maintenance Mode" />

</div>

<div class="mb-4">

<asp:TextBox ID="txtMaintenanceMsg"
runat="server"
CssClass="form-control"
TextMode="MultiLine"
Rows="3"
placeholder="Maintenance Message" />

</div>


<asp:Button ID="btnSave"
runat="server"
Text="Save Settings"
CssClass="btn btn-gradient"
OnClick="btnSave_Click" />

</div>

<style>

.card-custom{
background:#1e1b4b;
padding:30px;
border-radius:15px;
color:white;
}

.section-title{
margin-top:25px;
margin-bottom:15px;
font-weight:600;
}

.form-control{
background:#2a2669;
border:none;
color:white;
}

.form-control::placeholder{
color:#9ca3af;
}

.btn-gradient{
background:linear-gradient(135deg,#7c3aed,#06b6d4);
border:none;
padding:10px 20px;
color:white;
border-radius:8px;
}

</style>

</asp:Content>