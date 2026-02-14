<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master"
    AutoEventWireup="true" CodeFile="Settings.aspx.cs"
    Inherits="Admin_Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="card-custom">

    <h4 class="mb-4">Site Settings</h4>

    <div class="row mb-4">
        <div class="col-md-6">
            <asp:TextBox ID="txtSiteTitle" runat="server"
                CssClass="form-control custom-input"
                placeholder="Site Title"></asp:TextBox>
        </div>

        <div class="col-md-6">
            <asp:TextBox ID="txtTagline" runat="server"
                CssClass="form-control custom-input"
                placeholder="Tagline"></asp:TextBox>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-6">
            <asp:TextBox ID="txtAdminEmail" runat="server"
                CssClass="form-control custom-input"
                placeholder="Admin Email"></asp:TextBox>
        </div>

        <div class="col-md-6">
            <asp:TextBox ID="txtSupportPhone" runat="server"
                CssClass="form-control custom-input"
                placeholder="Support Phone"></asp:TextBox>
        </div>
    </div>

    <div class="mb-4">
        <asp:FileUpload ID="fuLogo" runat="server"
            CssClass="form-control custom-input" />
        <br />
        <asp:Image ID="imgLogo" runat="server"
            Width="100" />
    </div>

    <h5 class="mt-4 mb-3">SMTP Settings</h5>

    <div class="row mb-4">
        <div class="col-md-4">
            <asp:TextBox ID="txtSMTPHost" runat="server"
                CssClass="form-control custom-input"
                placeholder="SMTP Host"></asp:TextBox>
        </div>

        <div class="col-md-2">
            <asp:TextBox ID="txtSMTPPort" runat="server"
                CssClass="form-control custom-input"
                placeholder="Port"></asp:TextBox>
        </div>

        <div class="col-md-3">
            <asp:TextBox ID="txtSMTPEmail" runat="server"
                CssClass="form-control custom-input"
                placeholder="SMTP Email"></asp:TextBox>
        </div>

        <div class="col-md-3">
            <asp:TextBox ID="txtSMTPPassword" runat="server"
                TextMode="Password"
                CssClass="form-control custom-input"
                placeholder="SMTP Password"></asp:TextBox>
        </div>
    </div>

    <div class="mb-4">
        <asp:CheckBox ID="chkSSL" runat="server" Text="Enable SSL" />
    </div>

    <h5 class="mt-4 mb-3">Revenue Settings</h5>

    <div class="row mb-4">
        <div class="col-md-6">
            <asp:TextBox ID="txtLeadPrice" runat="server"
                CssClass="form-control custom-input"
                placeholder="Lead Price"></asp:TextBox>
        </div>

        <div class="col-md-6">
            <asp:TextBox ID="txtCommission" runat="server"
                CssClass="form-control custom-input"
                placeholder="Commission %"></asp:TextBox>
        </div>
    </div>

    <h5 class="mt-4 mb-3">Maintenance</h5>

    <div class="mb-3">
        <asp:CheckBox ID="chkMaintenance" runat="server"
            Text="Enable Maintenance Mode" />
    </div>

    <div class="mb-4">
        <asp:TextBox ID="txtMaintenanceMsg" runat="server"
            CssClass="form-control custom-input"
            TextMode="MultiLine"
            Rows="3"
            placeholder="Maintenance Message"></asp:TextBox>
    </div>

    <asp:Button ID="btnSave" runat="server"
        Text="Save Settings"
        CssClass="btn btn-gradient"
        OnClick="btnSave_Click" />

</div>


     <style>
       .custom-input::placeholder {
    color: #6c757d; /* Bootstrap muted gray */
    opacity: 1;     /* Ensure visibility */
}

    </style>


</asp:Content>
