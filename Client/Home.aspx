<%@ Page Title="Home" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="Home.aspx.cs"
    Inherits="Client_Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
    .hero-wrapper {
    padding: 90px 0;
    background: #f8fafc;
}

.hero-badge {
    font-weight: 500;
    color: #16a34a;
    margin-bottom: 15px;
}

.hero-heading {
    font-size: 52px;
    font-weight: 700;
    line-height: 1.2;
    margin-bottom: 25px;
    color: #111827;
}

.hero-tabs span {
    margin-right: 25px;
    font-weight: 500;
    cursor: pointer;
    color: #6b7280;
}

.hero-tabs .active-tab {
    color: #111827;
    border-bottom: 2px solid #ef4444;
    padding-bottom: 3px;
}

.hero-search-box {
    margin-top: 25px;
    display: flex;
    background: white;
    padding: 12px;
    border-radius: 18px;
    box-shadow: 0 15px 40px rgba(0,0,0,0.08);
}

.hero-select {
    flex: 1;
    border: none;
    outline: none;
    padding: 12px;
    border-radius: 12px;
}

.hero-search-btn {
    background: #dc2626;
    border: none;
    color: white;
    padding: 12px 30px;
    border-radius: 14px;
    font-weight: 600;
}

.hero-search-btn:hover {
    background: #b91c1c;
}

.hero-image-wrapper {
    position: relative;
}

.hero-image {
    max-width: 100%;
    border-radius: 25px;
}

.slider-dots {
    margin-top: 20px;
}

.dot {
    height: 8px;
    width: 8px;
    background: #d1d5db;
    border-radius: 50%;
    display: inline-block;
    margin: 0 4px;
}

.active-dot {
    background: #ef4444;
}

</style>

<!-- HERO SECTION START -->
<section class="hero-wrapper">

<div class="container">
<div class="row align-items-center">

<!-- LEFT SIDE -->
<div class="col-lg-6">

    <div class="hero-badge">
        <span>🌿</span> Green Initiatives
    </div>

    <h1 class="hero-heading">
        Electric Bikes Bringing<br />
        Revolution to India
    </h1>

    <!-- FILTER TABS -->
    <div class="hero-tabs">
        <span class="active-tab">Price</span>
        <span>Brand</span>
        <span>Range</span>
    </div>

    <!-- SEARCH BOX -->
    <div class="hero-search-box">

        <asp:DropDownList ID="ddlBudget"
            runat="server"
            CssClass="hero-select">

            <asp:ListItem Value="">Select Budget</asp:ListItem>
            <asp:ListItem Value="100000">Under ₹1 Lakh</asp:ListItem>
            <asp:ListItem Value="150000">Under ₹1.5 Lakh</asp:ListItem>
            <asp:ListItem Value="200000">Under ₹2 Lakh</asp:ListItem>

        </asp:DropDownList>

        <asp:Button ID="btnSearch"
            runat="server"
            Text="Search"
            CssClass="hero-search-btn"
            OnClick="btnSearch_Click" />

    </div>

</div>

<!-- RIGHT SIDE -->
<div class="col-lg-6 text-center position-relative">

    <div class="hero-image-wrapper">

        <img src="/Assets/hero-scooter.png"
             class="hero-image" />

        <div class="slider-dots">
            <span class="dot active-dot"></span>
            <span class="dot"></span>
            <span class="dot"></span>
        </div>

    </div>

</div>

</div>
</div>

</section>
<!-- HERO SECTION END -->



<!-- BIKE LIST -->
<section class="py-5">
<div class="container">

<h4 class="mb-4">Popular Electric Bikes</h4>

<asp:Repeater ID="rptBikes" runat="server">
<ItemTemplate>

<div class="col-md-4 mb-4 d-inline-block">
<div class="bike-card p-3 position-relative">

<input type="checkbox"
       class="compare-check"
       value='<%# Eval("BikeID") %>' />

<img src='/Uploads/Bikes/<%# Eval("Image1") %>'
     style="width:100%; height:220px; object-fit:cover; border-radius:15px;" />

<h5 class="mt-3"><%# Eval("ModelName") %></h5>

<div class="text-muted mb-2">
₹ <%# Eval("Price","{0:N0}") %>
</div>

<div class="mb-2">
Range: <%# Eval("RangeKM") %> KM
</div>

<a href='BikeDetails.aspx?slug=<%# Eval("Slug") %>'
   class="btn btn-outline-dark w-100">
View Details
</a>

</div>
</div>

</ItemTemplate>
</asp:Repeater>

</div>
</section>

</asp:Content>
