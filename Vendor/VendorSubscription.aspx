<%@ Page Title="" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master" AutoEventWireup="true" CodeFile="VendorSubscription.aspx.cs" Inherits="Vendor_VendorSubscription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


  <div class="container mt-4">

<h3>Dealer Subscription</h3>

<div class="card p-3 mb-4">

<h5>Current Plan</h5>

<div class="row">

<div class="col-md-3">
Plan :
<asp:Label ID="lblPlan" runat="server"></asp:Label>
</div>

<div class="col-md-3">
Expiry :
<asp:Label ID="lblExpiry" runat="server"></asp:Label>
</div>

<div class="col-md-3">
Bike Limit :
<asp:Label ID="lblBikeLimit" runat="server"></asp:Label>
</div>

<div class="col-md-3">
Featured Limit :
<asp:Label ID="lblFeaturedLimit" runat="server"></asp:Label>
</div>

</div>

</div>


<h4>Available Plans</h4>

<div class="row mt-3">

<div class="col-md-3">
<div class="card shadow p-3 text-center">

<h5>Basic</h5>
<h3>₹999</h3>

<p>10 Bikes</p>

<asp:Button ID="Button1" runat="server"
Text="Request"
CssClass="btn btn-dark"
OnClick="btnBasic_Click"/>

</div>
</div>

<div class="col-md-3">
<div class="card shadow p-3 text-center">

<h5>Pro</h5>
<h3>₹1999</h3>

<p>50 Bikes</p>

<asp:Button ID="Button2" runat="server"
Text="Request"
CssClass="btn btn-dark"
OnClick="btnPro_Click"/>

</div>
</div>

<div class="col-md-3">
<div class="card shadow p-3 text-center">

<h5>Featured</h5>
<h3>₹499</h3>

<p>1 Featured Bike</p>

<asp:Button ID="Button3" runat="server"
Text="Request"
CssClass="btn btn-warning"
OnClick="btnFeatured_Click"/>

</div>
</div>

<div class="col-md-3">
<div class="card shadow p-3 text-center border border-danger">

<h5>Combo</h5>
<h3>₹2499</h3>

<p>50 Bikes</p>
<p>3 Featured</p>

<asp:Button ID="Button4" runat="server"
Text="Best Offer"
CssClass="btn btn-danger"
OnClick="btnCombo_Click"/>

</div>
</div>

</div>

<br>

<asp:Label ID="lblMsg" runat="server"></asp:Label>

</div>
</asp:Content>

