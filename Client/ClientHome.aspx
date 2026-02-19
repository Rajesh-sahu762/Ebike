<%@ Page Title="Home" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="ClientHome.aspx.cs"
    Inherits="Client_ClientHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>

/* HERO */
.hero {
    background: linear-gradient(135deg,#0f172a,#1e3a8a);
    color:white;
    padding:100px 0;
    text-align:center;
}

.hero h1{
    font-size:48px;
    font-weight:700;
}

.hero p{
    opacity:0.9;
    margin-top:15px;
}

.gradient-btn{
    background:linear-gradient(90deg,#2563eb,#06b6d4);
    border:none;
    padding:12px 30px;
    border-radius:30px;
    color:white;
    transition:0.4s;
}

.gradient-btn:hover{
    transform:translateY(-3px);
    box-shadow:0 10px 25px rgba(0,0,0,0.3);
}

/* BIKE CARD */
.bike-card{
    border-radius:15px;
    overflow:hidden;
    transition:0.4s;
    background:white;
}

.bike-card:hover{
    transform:translateY(-8px);
    box-shadow:0 15px 35px rgba(0,0,0,0.15);
}

.bike-img{
    height:200px;
    object-fit:cover;
    width:100%;
}

.section{
    padding:80px 0;
}

.stat-box{
    background:white;
    padding:30px;
    border-radius:15px;
    text-align:center;
    box-shadow:0 5px 15px rgba(0,0,0,0.08);
    transition:0.3s;
}

.stat-box:hover{
    transform:translateY(-5px);
}

</style>

<!-- HERO -->
<section class="hero">
    <div class="container">
        <h1>Find Your Perfect E-Bike</h1>
        <p>Buy • Sell • Rent • Compare</p>

        <asp:TextBox ID="txtSearch" runat="server"
            CssClass="form-control mt-4 mb-3"
            placeholder="Search bikes..."></asp:TextBox>

        <asp:Button ID="btnSearch" runat="server"
            Text="Search Now"
            CssClass="gradient-btn"
            OnClick="btnSearch_Click" />
    </div>
</section>

<!-- FEATURED BIKES -->
<section class="section">
    <div class="container">
        <h2 class="text-center mb-5">Featured Bikes</h2>

        <div class="row">
            <asp:Repeater ID="rptBikes" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 mb-4">
                        <div class="bike-card">
                            <img src='<%# Eval("Image1") %>' class="bike-img" />
                            <div class="p-3">
                                <h5><%# Eval("ModelName") %></h5>
                                <p>₹ <%# Eval("Price") %></p>

                                <a href='BikeDetails.aspx?slug=<%# Eval("Slug") %>'
                                   class="btn btn-sm btn-primary">
                                   View Details
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

    </div>
</section>

<!-- SELL BIKE -->
<section class="section bg-light text-center">
    <div class="container">
        <h2>Sell Your Old Bike</h2>
        <p>Get instant best value</p>
        <a href="SellBike.aspx" class="gradient-btn">Sell Now</a>
    </div>
</section>

<!-- RENTAL -->
<section class="section text-center">
    <div class="container">
        <h2>Bike Rental</h2>
        <p>Short term rental options available</p>
        <a href="BikeRental.aspx" class="gradient-btn">Explore Rentals</a>
    </div>
</section>

<!-- STATS -->
<section class="section bg-light">
    <div class="container">
        <div class="row">

            <div class="col-md-4">
                <div class="stat-box">
                    <h3><asp:Label ID="lblTotalBikes" runat="server"></asp:Label></h3>
                    <p>Total Bikes</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stat-box">
                    <h3><asp:Label ID="lblDealers" runat="server"></asp:Label></h3>
                    <p>Verified Dealers</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stat-box">
                    <h3><asp:Label ID="lblCustomers" runat="server"></asp:Label></h3>
                    <p>Happy Customers</p>
                </div>
            </div>

        </div>
    </div>
</section>

</asp:Content>
