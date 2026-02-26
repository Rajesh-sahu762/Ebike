<%@ Page Title="" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="BikeDetails.aspx.cs" Inherits="Client_BikeDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <style>
 /* ===============================
   GLOBAL
================================ */

body{
background:#f8fafc;
font-family:Segoe UI, sans-serif;
color:#111827;
margin:0;
}

h1,h2,h3,h4,p{
margin:0;
}

/* ===============================
   HERO SECTION
================================ */

.bike-hero{
max-width:1180px;
margin:60px auto 40px auto;
display:flex;
gap:50px;
padding:30px;
background:#ffffff;
border-radius:16px;
box-shadow:0 8px 25px rgba(0,0,0,0.05);
align-items:flex-start;
}

/* LEFT SIDE */

.bike-gallery{
flex:1;
}

.bike-main{
height:360px;
background:#f3f4f6;
border-radius:12px;
display:flex;
align-items:center;
justify-content:center;
padding:20px;
overflow:hidden;
}

.bike-main img{
max-width:100%;
max-height:100%;
object-fit:contain;
}

.bike-thumbs{
display:flex;
gap:12px;
margin-top:15px;
flex-wrap:wrap;
}

.bike-thumbs img{
width:75px;
height:60px;
object-fit:cover;
border-radius:8px;
cursor:pointer;
border:2px solid transparent;
}

/* RIGHT SIDE */

.bike-info{
flex:1;
display:flex;
flex-direction:column;
}

.bike-title{
font-size:28px;
font-weight:700;
margin-bottom:8px;
}

.bike-meta{
display:flex;
gap:15px;
font-size:14px;
color:#6b7280;
margin-bottom:10px;
flex-wrap:wrap;
}

.rating{
background:#fff7ed;
color:#f59e0b;
padding:5px 10px;
border-radius:20px;
font-size:13px;
}

.bike-price{
font-size:30px;
font-weight:800;
margin:8px 0;
}

.bike-emi{
background:#f1f5f9;
padding:6px 12px;
border-radius:6px;
font-size:13px;
margin-bottom:18px;
display:inline-block;
}

.divider{
border:none;
border-top:1px solid #e5e7eb;
margin:15px 0;
}

.quick-specs{
display:grid;
grid-template-columns:1fr 1fr;
gap:8px 20px;
font-size:14px;
}

.quick-specs div{
display:flex;
justify-content:space-between;
}

.bike-actions{
margin-top:20px;
display:flex;
flex-direction:column;
gap:12px;
}

.btn-primary{
width:100%;
padding:14px;
border-radius:10px;
background:#ef4444;
color:#fff;
border:none;
font-weight:600;
cursor:pointer;
}

.secondary-actions{
font-size:14px;
display:flex;
gap:8px;
color:#6b7280;
}

.secondary-actions a{
text-decoration:none;
color:#6b7280;
}

/* ===============================
   HIGHLIGHTS
================================ */

.highlights-section{
max-width:1180px;
margin:0 auto 60px auto;
padding:0 20px;
}

.highlights-card{
background:#ffffff;
border-radius:14px;
padding:25px;
display:grid;
grid-template-columns:repeat(4,1fr);
gap:20px;
box-shadow:0 8px 25px rgba(0,0,0,0.05);
}

.highlight-item{
display:flex;
gap:12px;
align-items:center;
}

.highlight-text h4{
font-size:15px;
font-weight:600;
}

.highlight-text p{
font-size:12px;
color:#6b7280;
}

/* ===============================
   TABS
================================ */

.tabs-section{
max-width:1180px;
margin:60px auto;
padding:0 20px;
}

.tabs-card{
background:#ffffff;
border-radius:14px;
box-shadow:0 8px 25px rgba(0,0,0,0.05);
overflow:hidden;
}

.tabs-header{
display:flex;
border-bottom:1px solid #e5e7eb;
}

.tab-btn{
flex:1;
padding:16px;
text-align:center;
cursor:pointer;
font-weight:600;
color:#6b7280;
}

.tab-btn.active{
color:#ef4444;
border-bottom:3px solid #ef4444;
}

.tab-content{
display:none;
padding:30px;
font-size:14px;
line-height:1.6;
}

.tab-content.active{
display:block;
}

.spec-table td{
padding:10px;
}

.features-grid{
display:grid;
grid-template-columns:repeat(3,1fr);
gap:15px;
}

.feature-item{
background:#f9fafb;
padding:12px;
border-radius:8px;
font-size:13px;
}

/* ===============================
   STICKY BAR
================================ */

.sticky-buy-bar{
position:fixed;
bottom:0;
left:0;
width:100%;
background:#ffffff;
box-shadow:0 -5px 20px rgba(0,0,0,0.08);
padding:12px 20px;
display:flex;
justify-content:space-between;
align-items:center;
z-index:999;
transform:translateY(100%);
transition:0.3s;
}

.sticky-buy-bar.active{
transform:translateY(0);
}

.sticky-actions{
display:flex;
gap:10px;
}

.sticky-btn-primary{
background:#ef4444;
color:#fff;
border:none;
padding:8px 18px;
border-radius:6px;
}

.sticky-btn-outline{
border:2px solid #111827;
background:#fff;
padding:8px 18px;
border-radius:6px;
}

/* ===============================
   RESPONSIVE
================================ */

@media(max-width:992px){

.bike-hero{
flex-direction:column;
gap:25px;
padding:20px;
margin:40px 15px;
}

.bike-main{
height:auto;
}

.quick-specs{
grid-template-columns:1fr;
}

.highlights-card{
grid-template-columns:repeat(2,1fr);
}

.features-grid{
grid-template-columns:repeat(2,1fr);
}

}

@media(max-width:600px){

.bike-title{
font-size:24px;
}

.bike-price{
font-size:26px;
}

.bike-meta{
font-size:15px;
}

.highlights-card{
grid-template-columns:1fr;
}

.features-grid{
grid-template-columns:1fr;
}

.tabs-header{
flex-direction:column;
}

}

        /* ===============================
   FORCE MOBILE HERO FIX
================================ */

@media screen and (max-width:768px){

.bike-hero{
display:flex !important;
flex-direction:column !important;
gap:20px !important;
padding:15px !important;
margin:20px 10px !important;
}

.bike-gallery,
.bike-info{
width:100% !important;
flex:100% !important;
padding:0 !important;
}

.bike-main{
height:auto !important;
padding:10px !important;
}

.bike-main img{
width:100% !important;
max-width:100% !important;
height:auto !important;
}

.bike-title{
font-size:24px !important;
margin-bottom:8px !important;
}

.bike-meta{
font-size:15px !important;
margin-bottom:10px !important;
}

.bike-price{
font-size:26px !important;
margin:10px 0 !important;
}

.bike-emi{
font-size:14px !important;
margin-bottom:15px !important;
}

.quick-specs{
grid-template-columns:1fr !important;
font-size:14px !important;
gap:6px !important;
}

.btn-primary{
width:100% !important;
padding:14px !important;
font-size:15px !important;
}

.secondary-actions{
font-size:14px !important;
margin-top:10px !important;
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

