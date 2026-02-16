<%@ Page Title="" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="AddBike.aspx.cs"
    Inherits="Vendor_AddBike" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="card shadow-sm p-4">
    <h4 class="mb-4">Add New Bike</h4>

    <div class="row g-3">

        <div class="col-md-6">
            <label>Brand *</label>
            <asp:DropDownList ID="ddlBrand" runat="server" CssClass="form-control"></asp:DropDownList>
        </div>

        <div class="col-md-6">
            <label>Model Name *</label>
            <asp:TextBox ID="txtModel" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-6">
            <label>Price</label>
            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-6">
            <label>Range (KM)</label>
            <asp:TextBox ID="txtRange" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-6">
            <label>Battery Type</label>
            <asp:TextBox ID="txtBattery" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-6">
            <label>Motor Power</label>
            <asp:TextBox ID="txtMotor" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-6">
            <label>Top Speed (KM/H)</label>
            <asp:TextBox ID="txtSpeed" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-6">
            <label>Charging Time</label>
            <asp:TextBox ID="txtCharge" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-12">
            <label>Description</label>
            <asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine"
                Rows="3" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="col-md-4">
            <label>Image 1</label>
            <asp:FileUpload ID="fu1" runat="server" CssClass="form-control" />
        </div>

        <div class="col-md-4">
            <label>Image 2</label>
            <asp:FileUpload ID="fu2" runat="server" CssClass="form-control" />
        </div>

        <div class="col-md-4">
            <label>Image 3</label>
            <asp:FileUpload ID="fu3" runat="server" CssClass="form-control" />
        </div>

    </div>

    <asp:Button ID="btnAddBike" runat="server"
        Text="Submit for Approval"
        CssClass="btn btn-primary mt-4"
        OnClick="btnAddBike_Click" />

    <br /><br />
    <asp:Label ID="lblMsg" runat="server"></asp:Label>

</div>

</asp:Content>
