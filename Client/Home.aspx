
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
/* ===== BROWSE SECTION PREMIUM ===== */

.browse-section {
    background: #0b1120;
    padding: 90px 0;
    color: #f1f5f9;
}

.browse-title {
    font-size: 30px;
    font-weight: 600;
    margin-bottom: 30px;
}

.browse-tabs {
    margin-bottom: 35px;
}

.browse-tabs .tab {
    margin-right: 30px;
    cursor: pointer;
    font-weight: 500;
    color: #94a3b8;
    transition: 0.3s;
}

.browse-tabs .tab:hover {
    color: #06b6d4;
}

.browse-tabs .active-tab {
    color: #06b6d4;
    border-bottom: 2px solid #06b6d4;
    padding-bottom: 6px;
}

.tab-content {
    display: none;
}

.active-content {
    display: block;
}

/* GRID */
.browse-grid {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    gap: 25px;
}

/* BRAND CARD */
.brand-card {
    background: #111827;
    border-radius: 16px;
    padding: 30px 20px;
    text-align: center;
    border: 1px solid #1f2937;
    transition: 0.3s;
    text-decoration: none;
    color: #e5e7eb;
}

.brand-card:hover {
    border-color: #06b6d4;
    transform: translateY(-6px);
    box-shadow: 0 10px 25px rgba(6,182,212,0.2);
}

.brand-logo img {
    height: 50px;
    object-fit: contain;
    margin-bottom: 15px;
}

.brand-name {
    font-weight: 500;
    font-size: 15px;
}

/* BODY STYLE SPECIAL */
.body-card {
    background: #111827;
    border-radius: 16px;
    padding: 35px 20px;
    text-align: center;
    border: 1px solid #1f2937;
    transition: 0.3s;
    text-decoration: none;
    color: #f8fafc;
}

.body-card:hover {
    border-color: #06b6d4;
    transform: translateY(-6px);
    box-shadow: 0 10px 25px rgba(6,182,212,0.2);
}

.body-icon {
    font-size: 40px;
    margin-bottom: 12px;
}

.view-more {
    color: #06b6d4;
    text-decoration: none;
    font-weight: 500;
}


.brand-card {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;

    background: #111827;
    border-radius: 18px;
    padding: 35px 20px;
    text-align: center;
    border: 1px solid #1f2937;
    transition: 0.3s ease;
    text-decoration: none;
    color: #f8fafc;
    position: relative;
    overflow: hidden;
}

.brand-card:hover {
    border-color: #06b6d4;
    box-shadow: 0 0 25px rgba(6,182,212,0.25);
    transform: translateY(-6px);
}

.brand-logo img {
    height: 50px;
    object-fit: contain;
    margin-bottom: 15px;
}

.brand-name {
    font-weight: 500;
    font-size: 15px;
    letter-spacing: 0.5px;
}


.battery-section {
    padding: 100px 0;
    background: #f3f4f6;
}

.battery-image-box {
    /*background: #3AA6A1;*/
    border-radius: 30px;
    padding: 40px;
    text-align: center;
}

.battery-image-box img {
    border-radius: 30px;
    max-height: 420px;
}

.battery-content {
    padding-left: 30px;
}

.battery-title {
    font-size: 34px;
    font-weight: 700;
    margin-bottom: 30px;
}

.battery-item {
    margin-bottom: 25px;
}

.battery-item h5 {
    font-weight: 600;
    margin-bottom: 8px;
}

.battery-item p {
    font-size: 14px;
    color: #4b5563;
    line-height: 1.6;
}


.review-section {
    background: #111827;
    padding: 100px 0;
    color: white;
}

.review-title {
    font-size: 32px;
    font-weight: 700;
}

.review-subtitle {
    color: #9ca3af;
    margin-bottom: 25px;
}

.review-search-box input {
    width: 100%;
    max-width: 500px;
    padding: 12px 15px;
    background: #1f2937;
    border: 1px solid #374151;
    border-radius: 12px;
    color: white;
}

.review-divider {
    border-color: #374151;
    margin: 40px 0;
}

.recent-title {
    margin-bottom: 30px;
}

.review-cards {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 25px;
}

.review-card {
    background: #1f2937;
    padding: 25px;
    border-radius: 20px;
    transition: 0.3s;
}

.review-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 20px 40px rgba(0,0,0,0.4);
}

.review-user {
    display: flex;
    align-items: center;
    gap: 10px;
    font-weight: 600;
}

.user-avatar {
    width: 40px;
    height: 40px;
    background: #374151;
    border-radius: 50%;
}

.review-bike {
    display: flex;
    gap: 15px;
    margin: 20px 0;
}

.review-bike img {
    width: 90px;
    height: 60px;
    object-fit: cover;
}

.stars {
    color: #22c55e;
}

.review-text {
    color: #d1d5db;
    font-size: 14px;
    margin-bottom: 15px;
}

.review-card a {
    color: #06b6d4;
    text-decoration: none;
    font-weight: 500;
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
<!-- BROWSE BIKES BY -->
<section class="browse-section">
<div class="container">

<h3 class="browse-title">Browse Bikes By</h3>

<div class="browse-tabs">
    <span class="tab active-tab" onclick="showTab(event,'brand')">Brand</span>
    <span class="tab" onclick="showTab(event,'budget')">Budget</span>
    <span class="tab" onclick="showTab(event,'range')">Range</span>
    <span class="tab" onclick="showTab(event,'body')">Body Style</span>
</div>

<!-- BRAND TAB -->
<div id="brandTab" class="tab-content active-content">

    <div class="browse-grid">

        <asp:Repeater ID="rptBrandsTop" runat="server">
        <ItemTemplate>
            <div class="brand-card">
             <a href='Bikes.aspx?brand=<%# Eval("BrandID") %>' class="brand-card">
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

    <div id="moreBrands" style="display:none;">
        <div class="browse-grid mt-4">

            <asp:Repeater ID="rptBrandsAll" runat="server">
            <ItemTemplate>
                <div class="brand-card">
                    <a href='Bikes.aspx?brand=<%# Eval("BrandID") %>' class="brand-card">
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

<!-- BUDGET -->
<div id="budgetTab" class="tab-content">
    <div class="browse-grid">
        <a href="Bikes.aspx?budget=100000" class="brand-card">Under ₹1 Lakh</a>
        <a href="Bikes.aspx?budget=150000" class="brand-card">Under ₹1.5 Lakh</a>
        <a href="Bikes.aspx?budget=200000" class="brand-card">Under ₹2 Lakh</a>
        <a href="Bikes.aspx?budget=300000" class="brand-card">Under ₹3 Lakh</a>
    </div>
</div>

<!-- RANGE -->
<div id="rangeTab" class="tab-content">
    <div class="browse-grid">
        <a href="Bikes.aspx?range=80" class="brand-card">Under 80 KM</a>
        <a href="Bikes.aspx?range=120" class="brand-card">Under 120 KM</a>
        <a href="Bikes.aspx?range=200" class="brand-card">Under 200 KM</a>
    </div>
</div>

<!-- BODY STYLE -->
<div id="bodyTab" class="tab-content">
    <div class="browse-grid">

        <a href="Bikes.aspx?type=Sports" class="body-card">
            <div class="body-icon">🏍</div>
            Sports Bike
        </a>

        <a href="Bikes.aspx?type=Scooter" class="body-card">
            <div class="body-icon">🛵</div>
            Scooter
        </a>

        <a href="Bikes.aspx?type=Cruiser" class="body-card">
            <div class="body-icon">🏍</div>
            Cruiser
        </a>

        <a href="Bikes.aspx?type=Commuter" class="body-card">
            <div class="body-icon">🚲</div>
            Commuter
        </a>

        <a href="Bikes.aspx?type=Street" class="body-card">
            <div class="body-icon">🏍</div>
            Street Bike
        </a>

        <a href="Bikes.aspx?type=Super" class="body-card">
            <div class="body-icon">🏍</div>
            Super Bike
        </a>

        <a href="Bikes.aspx?type=Cafe" class="body-card">
            <div class="body-icon">🏍</div>
            Cafe Racer
        </a>

        <a href="Bikes.aspx?type=Adventure" class="body-card">
            <div class="body-icon">🏍</div>
            Adventure
        </a>

        <a href="Bikes.aspx?type=Moped" class="body-card">
            <div class="body-icon">🛵</div>
            Moped
        </a>

        <a href="Bikes.aspx?type=Tourer" class="body-card">
            <div class="body-icon">🏍</div>
            Tourer
        </a>

    </div>
</div>


</div>
</section>


    <section class="battery-section">
    <div class="container">
        <div class="row align-items-center">

            <!-- Left Image -->
            <div class="col-lg-6">
                <div class="battery-image-box">
                    <img src="../Uploads/Banner/maintain.png" class="img-fluid" />
                </div>
            </div>

            <!-- Right Content -->
            <div class="col-lg-6">
                <div class="battery-content">

                    <h2 class="battery-title">
                        How To Maintain Your Electric<br />
                        Bike/scooter's Battery
                    </h2>

                    <div class="battery-item">
                        <h5>Minimise Exposure To Extreme Environment</h5>
                        <p>
                            Do not park your electric two-wheeler under the hot sun or in extreme cold for extended durations.
                            Even though the batteries have inbuilt protection, avoiding exposure to such extreme environments
                            will go a long way in preserving the battery's lifespan.
                        </p>
                    </div>

                    <div class="battery-item">
                        <h5>Keep an eye on your charging habits</h5>
                        <p>
                            Do not charge your battery to 100 percent regularly, or don’t even let it drain to below 20 percent.
                            Doing so puts more stress on the battery’s electrodes.
                        </p>
                    </div>

                    <div class="battery-item">
                        <h5>Use slow charging whenever possible</h5>
                        <p>
                            Even though batteries have fast-charging tech with adequate cooling mechanisms,
                            using conventional charging systems puts far less load on the batteries.
                        </p>
                    </div>

                    <div class="battery-item">
                        <h5>Avoid long periods of non-use</h5>
                        <p>
                            Leaving your electric two-wheeler parked for several days can have a detrimental effect
                            as it causes trickle discharge in the background.
                        </p>
                    </div>

                </div>
            </div>

        </div>
    </div>
</section>


    <section class="review-section">
<div class="container">

    <h2 class="review-title">User Reviews</h2>
    <p class="review-subtitle">
        3000+ unbiased, verified reviews from bike owners.
        Know the pros and cons of 200+ bike models from real owners.
    </p>

    <div class="review-search-box">
        <input type="text" placeholder="Search bike e.g. Bajaj Dominar 400" />
    </div>

    <hr class="review-divider" />

    <h4 class="recent-title">Recently Added Reviews</h4>

    <div class="review-cards">

        <!-- Card 1 -->
        <div class="review-card">
            <div class="review-header">
                <div class="review-user">
                    <div class="user-avatar"></div>
                    <span>Arun Garg</span>
                </div>
            </div>

            <div class="review-bike">
                <img src="../Uploads/Bikes/sample1.png" />
                <div>
                    <small>Review on</small>
                    <h6>Bajaj Pulsar N160</h6>
                    <div class="stars">★★★★★</div>
                    <small>1 week ago</small>
                </div>
            </div>

            <p class="review-text">
                I am using Bajaj Pulsar N160 from last 3 years and overall experience is very good...
            </p>

            <a href="#">Read Full Review</a>
        </div>

        <!-- Card 2 -->
        <div class="review-card">
            <div class="review-header">
                <div class="review-user">
                    <div class="user-avatar"></div>
                    <span>Shivraj</span>
                </div>
            </div>

            <div class="review-bike">
                <img src="../Uploads/Bikes/sample2.png" />
                <div>
                    <small>Review on</small>
                    <h6>Bajaj Pulsar NS400Z</h6>
                    <div class="stars">★★★★★</div>
                    <small>1 day ago</small>
                </div>
            </div>

            <p class="review-text">
                Recently got the Bajaj Pulsar NS400Z and my overall experience has been amazing...
            </p>

            <a href="#">Read Full Review</a>
        </div>

        <!-- Card 3 -->
        <div class="review-card">
            <div class="review-header">
                <div class="review-user">
                    <div class="user-avatar"></div>
                    <span>Deba Das</span>
                </div>
            </div>

            <div class="review-bike">
                <img src="../Uploads/Bikes/sample3.png" />
                <div>
                    <small>Review on</small>
                    <h6>KTM 250 Adventure</h6>
                    <div class="stars">★★★★★</div>
                    <small>1 day ago</small>
                </div>
            </div>

            <p class="review-text">
                Unbelievable bike of all time. I ride this bike 1900 km and never feel any issue...
            </p>

            <a href="#">Read Full Review</a>
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

    <script>

        function showTab(evt, tabName) {

            // remove active class from all tabs
            document.querySelectorAll(".tab").forEach(t =>
                t.classList.remove("active-tab"));

            // activate clicked tab
            evt.currentTarget.classList.add("active-tab");

            // hide all content
            document.querySelectorAll(".tab-content").forEach(c =>
                c.classList.remove("active-content"));

            // show selected tab
            document.getElementById(tabName + "Tab")
                .classList.add("active-content");
        }

        function toggleBrands() {
            var more = document.getElementById("moreBrands");

            if (more.style.display === "none" || more.style.display === "") {
                more.style.display = "block";
            } else {
                more.style.display = "none";
            }
        }

</script>



</asp:Content>

