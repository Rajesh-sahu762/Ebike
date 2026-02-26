<%@ Page Title="" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="BikeDetails.aspx.cs" Inherits="Client_BikeDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <style>
        /* ================================
   PREMIUM BIKE DETAILS SECTION
================================ */



.bike-hero{
max-width:1180px;
margin:60px auto 30px auto;
display:flex;
gap:60px;
padding:30px 20px;
background:#ffffff; /* remove gradient */
border-radius:18px;
box-shadow:0 10px 30px rgba(0,0,0,0.04);
}

/* ===== LEFT IMAGE SECTION ===== */

.bike-gallery{
flex:0 0 52%;
}

.bike-info{
flex:0 0 48%;
padding-left:20px;
}

/* ===== FIXED IMAGE SIZE ===== */

.bike-main{
height:320px;
background:#f3f4f6;
border-radius:14px;
display:flex;
align-items:center;
justify-content:center;
padding:20px;
overflow:hidden;
}



.bike-title{
font-size:28px;
font-weight:700;
margin-bottom:6px;
}

.bike-price{
font-size:30px;
margin-top:10px;
margin-bottom:10px;
}

.bike-emi{
background:#f1f5f9;
padding:8px 12px;
border-radius:8px;
display:inline-block;
}
.bike-main img{
width:100%;
max-width:420px;   /* control max width */
height:auto;
object-fit:contain;
}

.bike-main img:hover{
transform:scale(1.04);
}

.bike-thumbs{
display:flex;
gap:15px;
margin-top:15px;
}

.bike-thumbs img{
width:70px;
height:55px;
object-fit:cover;
border-radius:8px;
cursor:pointer;
border:2px solid transparent;
transition:0.2s;
}

.bike-thumbs img:hover{
border-color:#ff3b3b;
}

.bike-hero{
align-items:flex-start;
}

/* ===== RIGHT SIDE CLEAN PROFESSIONAL ===== */

.bike-meta{
display:flex;
align-items:center;
gap:20px;
font-size:14px;
color:#6b7280;
margin-bottom:20px;
}

.rating{
background:#fff7ed;
color:#f59e0b;
padding:6px 12px;
border-radius:50px;
font-weight:600;
}

.bike-price{
font-size:32px;
font-weight:800;
color:#111827;
margin-bottom:15px;
}

.bike-emi{
font-size:14px;
color:#374151;
margin-bottom:20px;
}

.divider{
border:none;
border-top:1px solid #e5e7eb;
margin:25px 0;
}

.quick-specs{
display:grid;
grid-template-columns:1fr 1fr;
gap:12px 30px;
font-size:14px;
color:#374151;
}

.quick-specs strong{
color:#111827;
}

.bike-actions{
margin-top:20px;
}

.btn-primary{
width:80%;
padding:14px;
border-radius:10px;
background:linear-gradient(135deg,#ff3b3b,#e60023);
box-shadow:0 8px 20px rgba(255,0,0,0.2);
}

.btn-primary:hover{
transform:none;
box-shadow:0 10px 25px rgba(255,0,0,0.25);
}

.secondary-actions{
margin-top:15px;
font-size:14px;
display:flex;
gap:10px;
color:#6b7280;
}

.secondary-actions a{
text-decoration:none;
color:#6b7280;
transition:0.3s;
}

.secondary-actions a:hover{
color:#111827;
}
/* ===== ACTION BUTTONS ===== */

.bike-actions{
display:flex;
gap:18px;
flex-wrap:wrap;
margin-top:15px;
}

.btn-primary{
padding:15px 32px;
border-radius:14px;
background:linear-gradient(135deg,#ff4d4d,#e60023);
color:#fff;
border:none;
font-weight:600;
cursor:pointer;
transition:0.3s;
box-shadow:0 10px 25px rgba(255,0,0,0.25);
}

.btn-primary:hover{
transform:translateY(-3px);
box-shadow:0 15px 35px rgba(255,0,0,0.35);
}

.btn-outline{
padding:15px 32px;
border-radius:14px;
border:2px solid #111827;
background:#fff;
color:#111827;
font-weight:600;
cursor:pointer;
transition:0.3s;
}

.btn-outline:hover{
background:#111827;
color:#fff;
transform:translateY(-3px);
}

/* ===== Responsive ===== */

@media(max-width:992px){

.bike-hero{
flex-direction:column;
gap:50px;
padding:25px;
}

.bike-main{
height:280px;
}
}

        /* ===============================
   CLEAN BIKE HIGHLIGHTS SECTION
================================ */

.highlights-section{
max-width:1180px;
margin:0 auto 80px auto;
padding:0 20px;
}

.highlights-card{
background:#ffffff;
border-radius:18px;
padding:25px;
display:grid;
grid-template-columns:repeat(4,1fr);
gap:25px;
box-shadow:0 10px 30px rgba(0,0,0,0.04);
}
.bike-hero{
border-bottom-left-radius:0;
border-bottom-right-radius:0;
}


.highlight-item{
display:flex;
align-items:center;
gap:15px;
padding:12px 10px;
border-radius:10px;
transition:0.25s ease;
}

.highlight-item:hover{
background:#f8fafc;
}

.highlight-icon{
width:45px;
height:45px;
border-radius:12px;
background:#fff1f2;
display:flex;
align-items:center;
justify-content:center;
font-size:18px;
color:#ef4444;
flex-shrink:0;
}

.highlight-text h4{
margin:0;
font-size:16px;
font-weight:600;
color:#111827;
}

.highlight-text p{
margin:2px 0 0;
font-size:12px;
color:#6b7280;
}

/* Tablet */

@media(max-width:992px){
.highlights-card{
grid-template-columns:repeat(2,1fr);
}
}

/* Mobile */

@media(max-width:600px){
.highlights-card{
grid-template-columns:1fr;
}
}

        /* ===============================
   STICKY BUY BAR
================================ */

.sticky-buy-bar{
position:fixed;
bottom:0;
left:0;
width:100%;
background:#ffffff;
box-shadow:0 -10px 30px rgba(0,0,0,0.08);
padding:15px 30px;
display:flex;
justify-content:space-between;
align-items:center;
z-index:999;
transition:0.4s ease;
transform:translateY(100%);
}

.sticky-buy-bar.active{
transform:translateY(0);
}

.sticky-left{
display:flex;
flex-direction:column;
}

.sticky-title{
font-weight:600;
color:#111827;
font-size:15px;
}

.sticky-price{
font-weight:700;
color:#ef4444;
font-size:18px;
}

.sticky-actions{
display:flex;
gap:15px;
flex-wrap:wrap;
}

.sticky-btn-primary{
padding:10px 22px;
border-radius:8px;
background:#ef4444;
color:#fff;
border:none;
font-weight:600;
cursor:pointer;
transition:0.3s;
}

.sticky-btn-primary:hover{
background:#dc2626;
}

.sticky-btn-outline{
padding:10px 22px;
border-radius:8px;
border:2px solid #111827;
background:#fff;
color:#111827;
font-weight:600;
cursor:pointer;
transition:0.3s;
}

.sticky-btn-outline:hover{
background:#111827;
color:#fff;
}

/* Mobile */

@media(max-width:768px){

.sticky-buy-bar{
flex-direction:column;
gap:12px;
align-items:flex-start;
padding:15px;
}

.sticky-actions{
width:100%;
display:flex;
gap:10px;
}

.sticky-btn-primary,
.sticky-btn-outline{
flex:1;
text-align:center;
}

}



        
/* ===============================
   TABS SECTION
================================ */

.tabs-section{
max-width:1200px;
margin:80px auto;
padding:0 20px;
}

.tabs-card{
background:#ffffff;
border-radius:20px;
box-shadow:0 15px 40px rgba(0,0,0,0.05);
overflow:hidden;
}

/* Tab Header */

.tabs-header{
display:flex;
border-bottom:1px solid #e5e7eb;
}

.tab-btn{
flex:1;
padding:18px;
text-align:center;
cursor:pointer;
font-weight:600;
color:#6b7280;
transition:0.3s;
}

.tab-btn.active{
color:#ef4444;
border-bottom:3px solid #ef4444;
background:#fff;
}

/* Tab Content */

.tab-content{
display:none;
padding:40px;
animation:fadeIn 0.4s ease;
}

.tab-content.active{
display:block;
}

@keyframes fadeIn{
from{opacity:0;transform:translateY(10px);}
to{opacity:1;transform:translateY(0);}
}

/* Overview */

.overview-text{
color:#374151;
line-height:1.7;
font-size:15px;
}

/* Specs Table */

.spec-table{
width:100%;
border-collapse:collapse;
}

.spec-table tr{
border-bottom:1px solid #f1f5f9;
}

.spec-table td{
padding:14px 10px;
font-size:14px;
}

.spec-table td:first-child{
font-weight:600;
color:#111827;
width:40%;
}

/* Features Grid */

.features-grid{
display:grid;
grid-template-columns:repeat(3,1fr);
gap:20px;
}

.feature-item{
background:#f9fafb;
padding:20px;
border-radius:12px;
font-size:14px;
transition:0.3s;
}

.feature-item:hover{
background:#fee2e2;
transform:translateY(-4px);
}

/* Responsive */

@media(max-width:992px){

.bike-hero{
flex-direction:column;
gap:25px;
padding:20px;
margin:40px 15px 20px 15px;
border-radius:16px;
}

.bike-gallery{
flex:100%;
}

.bike-info{
flex:100%;
padding-left:0;
}

.bike-main{
height:auto;
padding:15px;
}

.bike-main img{
max-width:100%;
width:100%;
height:auto;
}

.bike-thumbs{
justify-content:flex-start;
flex-wrap:wrap;
gap:10px;
}

.bike-price{
font-size:24px;
}

.bike-title{
font-size:22px;
}

.quick-specs{
grid-template-columns:1fr;
gap:8px;
}

.btn-primary{
width:100%;
padding:12px;
font-size:14px;
}

.secondary-actions{
justify-content:flex-start;
}

}

@media(max-width:600px){

.tabs-header{
flex-direction:column;
}

.features-grid{
grid-template-columns:1fr;
}

.tab-content{
padding:25px;
}
.bike-hero{
box-shadow:none;
border:1px solid #f1f5f9;
}

.bike-meta{
flex-wrap:wrap;
gap:10px;
}

.rating{
font-size:12px;
padding:4px 8px;
}
}


        /* ===============================
   MOBILE HERO TEXT IMPROVEMENT
================================ */

@media(max-width:768px){

/* Hero full width stack */
.bike-hero{
flex-direction:column;
gap:20px;
padding:18px;
margin:20px 10px;
}

/* Image full width */
.bike-gallery{
width:100%;
}

.bike-main{
height:auto;
padding:10px;
}

.bike-main img{
width:100%;
height:auto;
}

/* Text section below image */
.bike-info{
width:100%;
padding:0;
}

/* Title bigger */
.bike-title{
font-size:24px;
font-weight:700;
margin-bottom:8px;
}

/* Rating slightly bigger */
.bike-meta{
font-size:15px;
margin-bottom:10px;
}

/* Price bigger like 2nd screenshot */
.bike-price{
font-size:26px;
font-weight:800;
margin:8px 0;
}

/* EMI text */
.bike-emi{
font-size:14px;
margin-bottom:15px;
}

/* Specs readable */
.quick-specs{
grid-template-columns:1fr;
gap:6px;
font-size:14px;
}

/* Button full width */
.btn-primary{
width:100%;
font-size:15px;
padding:14px;
}

/* Secondary links */
.secondary-actions{
font-size:14px;
margin-top:10px;
}

}
    </style>


<section class="bike-hero">

<!-- LEFT IMAGE -->
<div class="bike-gallery">

<div class="bike-main">
<asp:Image ID="imgMain" runat="server" />
</div>

<div class="bike-thumbs">
<asp:Literal ID="litThumbs" runat="server"></asp:Literal>
</div>

</div>


<!-- RIGHT INFO -->
<div class="bike-info">

<div class="bike-title">
<asp:Literal ID="litBikeName" runat="server"></asp:Literal>
</div>

<div class="bike-meta">
<span class="brand">By <asp:Literal ID="litBrand" runat="server"></asp:Literal></span>
<span class="rating"><asp:Literal ID="litRating" runat="server"></asp:Literal></span>
</div>

<div class="bike-price">
₹ <asp:Literal ID="litPrice" runat="server"></asp:Literal>
</div>

<div class="bike-emi">
EMI starting from ₹ <span id="emiAmount"></span> / month
</div>

<hr class="divider"/>

<div class="quick-specs">
<div><strong>Range:</strong> 120 km/charge</div>
<div><strong>Top Speed:</strong> 85 km/h</div>
<div><strong>Battery:</strong> 3.2 kWh</div>
<div><strong>Warranty:</strong> 3 Years</div>
</div>

<hr class="divider"/>

<div class="bike-actions">

<button class="btn-primary"
onclick="location.href='Enquiry.aspx?slug=<%= Request.QueryString["slug"] %>'">
Enquire Now
</button>

<div class="secondary-actions">
<a href="Compare.aspx?b1=<%= ViewState["BikeID"] %>">Compare</a>
<span>|</span>
<a href="#">Wishlist</a>
</div>

</div>

</div>



</section>


    <section class="highlights-section">

<div class="highlights-card">

<div class="highlight-item">
<div class="highlight-icon">🔋</div>
<div class="highlight-text">
<h4><asp:Literal ID="litRange" runat="server"></asp:Literal></h4>
<p>Range</p>
</div>
</div>

<div class="highlight-item">
<div class="highlight-icon">⚡</div>
<div class="highlight-text">
<h4><asp:Literal ID="litSpeed" runat="server"></asp:Literal></h4>
<p>Top Speed</p>
</div>
</div>

<div class="highlight-item">
<div class="highlight-icon">🔌</div>
<div class="highlight-text">
<h4><asp:Literal ID="litCharge" runat="server"></asp:Literal></h4>
<p>Charging Time</p>
</div>
</div>

<div class="highlight-item">
<div class="highlight-icon">🛵</div>
<div class="highlight-text">
<h4><asp:Literal ID="litMotor" runat="server"></asp:Literal></h4>
<p>Motor Power</p>
</div>
</div>

</div>

</section>

<section class="tabs-section">

<div class="tabs-card">

<div class="tabs-header">
<div class="tab-btn active" onclick="openTab(event,'overview')">Overview</div>
<div class="tab-btn" onclick="openTab(event,'specs')">Specifications</div>
<div class="tab-btn" onclick="openTab(event,'features')">Features</div>
</div>

<!-- OVERVIEW -->
<div id="overview" class="tab-content active">
<div class="overview-text">
<asp:Literal ID="litOverview" runat="server"></asp:Literal>
</div>
</div>

<!-- SPECIFICATIONS -->
<div id="specs" class="tab-content">
<table class="spec-table">
<asp:Literal ID="litSpecsTable" runat="server"></asp:Literal>
</table>
</div>

<!-- FEATURES -->
<div id="features" class="tab-content">
<div class="features-grid">
<asp:Literal ID="litFeatures" runat="server"></asp:Literal>
</div>
</div>

</div>

</section>


<div class="sticky-buy-bar" id="stickyBar">

<div class="sticky-left">
<div class="sticky-title">
<asp:Literal ID="litStickyName" runat="server"></asp:Literal>
</div>
<div class="sticky-price">
₹ <asp:Literal ID="litStickyPrice" runat="server"></asp:Literal>
</div>
</div>

<div class="sticky-actions">

<button class="sticky-btn-outline"
onclick="location.href='Compare.aspx?b1=<%= ViewState["BikeID"] %>'">
Compare
</button>

<button class="sticky-btn-primary"
onclick="location.href='Enquiry.aspx?slug=<%= Request.QueryString["slug"] %>'">
Enquire Now
</button>

</div>

</div>




    <script>

        document.addEventListener("DOMContentLoaded", function () {

            var price = parseFloat('<%= ViewState["Price"] ?? "0" %>');

    var interest = 9.5 / 100 / 12;
    var tenure = 36;

    var emi = (price * interest * Math.pow(1 + interest, tenure)) /
              (Math.pow(1 + interest, tenure) - 1);

    if (!isNaN(emi)) {
        document.getElementById("emiAmount").innerText =
        Math.round(emi).toLocaleString();
    }

});

        function changeImage(src) {
            var mainImg = document.querySelector(".bike-main img");
            mainImg.src = src;

            var thumbs = document.querySelectorAll(".bike-thumbs img");
            thumbs.forEach(function (img) {
                img.style.border = "2px solid transparent";
            });

            event.target.style.border = "2px solid #ff4d4d";
        }

</script>


    <script>

        document.addEventListener("DOMContentLoaded", function(){

        const stickyBar = document.getElementById("stickyBar");

            window.addEventListener("scroll", function(){

                if(window.scrollY > 500){
                    stickyBar.classList.add("active");
                }else{
                    stickyBar.classList.remove("active");
                }

            });

        });

</script>

    <script>

        function openTab(evt, tabName){

            var contents = document.querySelectorAll(".tab-content");
            var buttons = document.querySelectorAll(".tab-btn");

            contents.forEach(function(c){
                c.classList.remove("active");
            });

            buttons.forEach(function(b){
                b.classList.remove("active");
            });

            document.getElementById(tabName).classList.add("active");
            evt.currentTarget.classList.add("active");

        }

</script>


</asp:Content>

