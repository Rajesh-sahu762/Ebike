
<%@ Page Title="Home" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="Home.aspx.cs"
    Inherits="Client_Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .hero-wrapper {
    padding: 90px 0;
    background: #f8fafc;
}

.hero-heading {
    font-size: 48px;
    font-weight: 700;
}

.hero-search-box {
    display: flex;
    gap: 10px;
    margin-top: 25px;
}

.hero-select {
    padding: 12px;
    border-radius: 10px;
}

.hero-search-btn {
    background: #dc2626;
    border: none;
    color: white;
    padding: 12px 25px;
    border-radius: 10px;
}

.featured-section {
    padding: 80px 0;
    background: #ffffff;
}

.section-title {
    font-weight: 600;
    margin-bottom: 40px;
}

.featured-wrapper {
    position: relative;
}

.featured-slider {
    display: flex;
    gap: 20px;
    overflow-x: auto;
    scroll-behavior: smooth;
    padding-bottom: 10px;
}

.featured-slider::-webkit-scrollbar {
    display: none;
}

.featured-card {
    min-width: 300px;
    background: white;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0,0,0,0.05);
    transition: 0.3s;
}

.featured-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 20px 40px rgba(0,0,0,0.15);
}

.card-image img {
    width: 100%;
    height: 220px;
    object-fit: cover;
}

.card-body {
    padding: 20px;
}

.card-price {
    font-weight: 600;
    margin-bottom: 10px;
}

.card-range {
    font-size: 14px;
    color: #6b7280;
    margin-bottom: 15px;
}

.btn-card {
    display: block;
    text-align: center;
    background: #111827;
    color: white;
    padding: 10px;
    border-radius: 12px;
    text-decoration: none;
}

.btn-card:hover {
    background: #000000;
}

.featured-arrow {
    position: absolute;
    top: 40%;
    transform: translateY(-50%);
    background: white;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display:flex;
    align-items:center;
    justify-content:center;
    cursor:pointer;
    box-shadow: 0 10px 20px rgba(0,0,0,0.15);
    z-index: 10;
}

.featured-arrow.left {
    left: -15px;
}

.featured-arrow.right {
    right: -15px;
}


.hero-slider {
    position: relative;
    border-radius: 25px;
    overflow: hidden;
}

.hero-slide {
    display: none;
}

.hero-slide img {
    width: 100%;
    height: 360px;
    object-fit: cover;
    border-radius: 25px;
}

.hero-slide.active {
    display: block;
}

.hero-next {
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    background: white;
    /*color: black;*/
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display:flex;
    align-items:center;
    justify-content:center;
    cursor:pointer;
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
}

.hero-dots {
    position: absolute;
    bottom: 15px;
    left: 50%;
    transform: translateX(-50%);
}

.dot {
    height: 8px;
    width: 8px;
    background: #d1d5db;
    border-radius: 50%;
    display: inline-block;
    margin: 0 4px;
    cursor:pointer;
}

.active-dot {
    background: #ef4444;
}


.browse-section {
    background: #0f172a;
    padding: 80px 0;
    color: white;
}

.browse-title {
    font-size: 28px;
    font-weight: 600;
    margin-bottom: 25px;
}

.browse-tabs {
    margin-bottom: 30px;
}

.browse-tabs .tab {
    margin-right: 25px;
    cursor: pointer;
    font-weight: 500;
    color: #9ca3af;
}

.browse-tabs .active-tab {
    color: #06b6d4;
    border-bottom: 2px solid #06b6d4;
    padding-bottom: 5px;
}

.browse-grid {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 20px;
}

.brand-card {
    background: #1e293b;
    border-radius: 15px;
    padding: 25px;
    text-align: center;
    border: 1px solid #334155;
    transition: 0.3s;
}

.brand-card:hover {
    border-color: #06b6d4;
    transform: translateY(-5px);
}

.brand-logo img {
    height: 45px;
    object-fit: contain;
    margin-bottom: 15px;
}

.brand-name {
    font-weight: 500;
}

.view-more {
    color: #06b6d4;
    text-decoration: none;
}


    </style>


<!-- HERO SECTION -->
<section class="hero-wrapper">
<div class="container">
<div class="row align-items-center">

<div class="col-lg-6">

    <div class="hero-badge">🌿 Green Initiatives</div>

    <h1 class="hero-heading">
        Electric Bikes Bringing<br />
        Revolution to India
    </h1>

    <div class="hero-search-box">

        <asp:DropDownList ID="ddlBudget"
            runat="server"
            CssClass="hero-select">
            <asp:ListItem Value="">Select Budget</asp:ListItem>
            <asp:ListItem Value="100000">Under ₹1 Lakh</asp:ListItem>
            <asp:ListItem Value="150000">Under ₹1.5 Lakh</asp:ListItem>
            <asp:ListItem Value="200000">Under ₹2 Lakh</asp:ListItem>
        </asp:DropDownList>

        <asp:DropDownList ID="ddlBrand"
            runat="server"
            CssClass="hero-select">
        </asp:DropDownList>

        <asp:Button ID="btnSearch"
            runat="server"
            Text="Search"
            CssClass="hero-search-btn"
            OnClick="btnSearch_Click" />

    </div>

</div>

<div class="col-lg-6 position-relative">

    <div class="hero-slider">

        <div class="hero-slide active">
            <img src="../Uploads/Banner/banner1.jpg" />
        </div>

        <div class="hero-slide">
            <img src="../Uploads/Banner/banner2.jpg" />
            </div>

        <div class="hero-slide">
            <img src="../Uploads/Banner/banner3.jpg" />
            </div>

        <!-- Arrow -->
        <div class="hero-next" onclick="nextSlide()">
            <i class="fa fa-chevron-right" aria-hidden="true"></i>
        </div>

        <!-- Dots -->
        <div class="hero-dots">
            <span class="dot active-dot" onclick="currentSlide(0)"></span>
            <span class="dot" onclick="currentSlide(1)"></span>
            <span class="dot" onclick="currentSlide(2)"></span>
        </div>

    </div>

</div>


</div>
</div>
</section>


<!-- FEATURED BIKES SLIDER -->
<section class="featured-section">
<div class="container">

<h3 class="section-title">Featured Electric Bikes</h3>

<div class="featured-wrapper">

    <div class="featured-arrow left" onclick="slideLeft()">&#10094;</div>

    <div class="featured-slider" id="featuredSlider">

        <asp:Repeater ID="rptFeatured" runat="server">
        <ItemTemplate>

            <div class="featured-card">

                <div class="card-image">
                    <img src='/Uploads/Bikes/<%# Eval("Image1") %>' />
                </div>

                <div class="card-body">

                    <h5><%# Eval("ModelName") %></h5>

                    <div class="card-price">
                        ₹ <%# Eval("Price","{0:N0}") %>
                    </div>

                    <div class="card-range">
                        Range: <%# Eval("RangeKM") %> KM
                    </div>

                    <a href='BikeDetails.aspx?slug=<%# Eval("Slug") %>'
                       class="btn-card">
                       View Details
                    </a>

                </div>

            </div>

        </ItemTemplate>
        </asp:Repeater>

    </div>

    <div class="featured-arrow right" onclick="slideRight()">&#10095;</div>

</div>

</div>
</section>


    <!-- BROWSE BIKES BY -->
<section class="browse-section">
<div class="container">

<h3 class="browse-title">Browse Bikes By</h3>

<div class="browse-tabs">
    <span class="tab active-tab" onclick="showTab('brand')">Brand</span>
    <span class="tab" onclick="showTab('budget')">Budget</span>
    <span class="tab" onclick="showTab('range')">Range</span>
    <span class="tab" onclick="showTab('body')">Body Style</span>
</div>

<!-- BRAND TAB -->
<div id="brandTab">

<div class="browse-grid">

<asp:Repeater ID="rptBrandsTop" runat="server">
<ItemTemplate>

<div class="brand-card">
    <a href='Bikes.aspx?brand=<%# Eval("BrandID") %>'>
        <div class="brand-logo">
            <img src='/Uploads/Brands/<%# Eval("LogoPath") %>' />
        </div>
        <div class="brand-name">
            <%# Eval("BrandName") %>
        </div>
    </a>
</div>

</ItemTemplate>
</asp:Repeater>

</div>

<!-- HIDDEN FULL LIST -->
<div id="moreBrands" style="display:none;">
    <div class="browse-grid mt-4">

    <asp:Repeater ID="rptBrandsAll" runat="server">
    <ItemTemplate>

    <div class="brand-card">
        <a href='Bikes.aspx?brand=<%# Eval("BrandID") %>'>
            <div class="brand-logo">
                <img src='/Uploads/Brands/<%# Eval("LogoPath") %>' />
            </div>
            <div class="brand-name">
                <%# Eval("BrandName") %>
            </div>
        </a>
    </div>

    </ItemTemplate>
    </asp:Repeater>

    </div>
</div>

<div class="text-center mt-4">
    <a href="javascript:void(0);" onclick="toggleBrands()" class="view-more">
        View More Brands
    </a>
</div>

</div>

</div>
</section>




    <script>

        let slideIndex = 0;
        let slides = document.getElementsByClassName("hero-slide");
        let dots = document.getElementsByClassName("dot");

        function showSlide(index) {

            for (let i = 0; i < slides.length; i++) {
                slides[i].classList.remove("active");
                dots[i].classList.remove("active-dot");
            }

        slides[index].classList.add("active");
        dots[index].classList.add("active-dot");

        slideIndex = index;
        }

        function nextSlide() {
            slideIndex++;
            if (slideIndex >= slides.length) slideIndex = 0;
            showSlide(slideIndex);
        }

        function currentSlide(index) {
            showSlide(index);
        }

        setInterval(nextSlide, 4000);



        function slideLeft() {
            document.getElementById('featuredSlider')
                .scrollBy({ left: -320, behavior: 'smooth' });
        }

        function slideRight() {
            document.getElementById('featuredSlider')
                .scrollBy({ left: 320, behavior: 'smooth' });
        }


        function toggleBrands() {
            var more = document.getElementById("moreBrands");

            if (more.style.display === "none") {
                more.style.display = "block";
            } else {
                more.style.display = "none";
            }
        }

        function showTab(tabName) {
            var tabs = document.querySelectorAll(".tab");
            tabs.forEach(t => t.classList.remove("active-tab"));

            event.target.classList.add("active-tab");

            // future: switch content by tab
        }


</script>


</asp:Content>

