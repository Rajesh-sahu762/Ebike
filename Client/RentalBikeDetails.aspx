<%@ Page Title="" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="RentalBikeDetails.aspx.cs" Inherits="Client_Default" %>

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


/* ===============================
   SIMILAR BIKES SLIDER
================================ */

.similar-section{
max-width:1180px;
margin:50px auto 100px auto;
padding:0 20px;
}

.similar-header{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:20px;
}

.slider-controls button{
border:none;
background:#111827;
color:#fff;
width:36px;
height:36px;
border-radius:6px;
cursor:pointer;
margin-left:5px;
}

.slider-controls button:hover{
background:#ef4444;
}

/* slider */

.similar-slider-wrapper{
overflow:hidden;
}

.similar-slider{
display:flex;
gap:20px;
overflow-x:auto;
scroll-behavior:smooth;
padding-bottom:10px;
}

.similar-slider::-webkit-scrollbar{
display:none;
}

/* card */

.similar-card{
min-width:240px;
background:#fff;
border-radius:14px;
box-shadow:0 8px 20px rgba(0,0,0,0.06);
overflow:hidden;
flex-shrink:0;
transition:0.3s;
}

.similar-card:hover{
transform:translateY(-5px);
box-shadow:0 12px 30px rgba(0,0,0,0.12);
}

.similar-img{
height:160px;
background:#f3f4f6;
display:flex;
align-items:center;
justify-content:center;
padding:15px;
}

.similar-img img{
max-width:100%;
max-height:100%;
object-fit:contain;
}

.similar-body{
padding:14px;
}

.similar-name{
font-weight:600;
font-size:15px;
margin-bottom:5px;
}

.similar-price{
font-weight:700;
color:#ef4444;
margin-bottom:10px;
}

.similar-btn{
display:block;
text-align:center;
padding:8px;
background:#111827;
color:#fff;
border-radius:6px;
text-decoration:none;
font-size:13px;
}

.similar-btn:hover{
background:#ef4444;
}

/* ===============================
   REVIEWS SECTION PREMIUM UI
================================ */

.reviews-section{
max-width:1180px;
margin:70px auto;
padding:0 20px;
}

.reviews-container{
background:#ffffff;
border-radius:16px;
padding:40px;
box-shadow:0 10px 30px rgba(0,0,0,0.06);
}

/* TOP LAYOUT */

.reviews-top{
display:flex;
align-items:flex-start;
justify-content:space-between;
gap:80px;
margin-bottom:40px;
flex-wrap:wrap;
}

/* LEFT RATING */

.reviews-rating{
width:300px;
}

.rating-number{
font-size:52px;
font-weight:700;
line-height:1;
margin-bottom:6px;
}

.rating-stars{
color:#f59e0b;
font-size:20px;
margin-bottom:6px;
}

.rating-count{
font-size:13px;
color:#6b7280;
margin-bottom:14px;
}

.rating-breakdown{
width:100%;
}

.breakdown-row{
display:flex;
align-items:center;
gap:10px;
margin-bottom:8px;
font-size:13px;
}

.breakdown-bar{
flex:1;
height:6px;
background:#e5e7eb;
border-radius:4px;
overflow:hidden;
}

.breakdown-fill{
height:100%;
background:#f59e0b;
}

/* REVIEW FORM */

.review-form-mini{
width:420px;
display:flex;
flex-direction:column;
gap:12px;
}

.review-form-mini h4{
font-size:20px;
margin-bottom:4px;
}

.review-form-mini select,
.review-form-mini input,
.review-form-mini textarea{
width:100%;
padding:12px;
border-radius:8px;
border:1px solid #e5e7eb;
font-size:14px;
}

.review-form-mini textarea{
height:100px;
resize:none;
}

.review-form-mini button{
background:#ef4444;
color:#fff;
border:none;
padding:14px;
border-radius:8px;
font-weight:600;
cursor:pointer;
}

.review-form-mini button:hover{
background:#dc2626;
}

/* CAROUSEL */

.reviews-slider-wrapper{
position:relative;
margin-top:20px;
}

.reviews-slider{
display:flex;
gap:20px;
overflow-x:auto;
scroll-behavior:smooth;
padding-bottom:10px;
}

.reviews-slider::-webkit-scrollbar{
display:none;
}

/* REVIEW CARD */

.review-card{
min-width:320px;
background:#ffffff;
border-radius:14px;
padding:20px;
box-shadow:0 8px 25px rgba(0,0,0,0.05);
}

.review-user{
display:flex;
align-items:center;
gap:12px;
margin-bottom:10px;
}

.user-avatar{
width:40px;
height:40px;
background:#e5e7eb;
border-radius:50%;
display:flex;
align-items:center;
justify-content:center;
font-weight:600;
font-size:14px;
}

.review-stars{
color:#f59e0b;
font-size:14px;
}

.review-title{
font-weight:600;
font-size:14px;
}

.review-text{
font-size:13px;
color:#6b7280;
margin-top:8px;
line-height:1.5;
}

/* SLIDER BUTTON */

.review-nav{
position:absolute;
top:50%;
transform:translateY(-50%);
width:36px;
height:36px;
border-radius:50%;
background:#ffffff;
border:1px solid #e5e7eb;
cursor:pointer;
}

.review-nav.left{
left:-18px;
}

.review-nav.right{
right:-18px;
}

/* MOBILE */

@media(max-width:768px){

.reviews-top{
flex-direction:column;
gap:30px;
}

.reviews-rating{
width:100%;
}

.review-form-mini{
width:100%;
}

}

        /* ===============================
   DEALER SECTION
================================ */

.dealer-section{
max-width:1180px;
margin:60px auto;
padding:0 20px;
}

.dealer-card{
background:#fff;
border-radius:16px;
box-shadow:0 10px 30px rgba(0,0,0,0.06);
padding:30px;
display:flex;
justify-content:space-between;
align-items:center;
flex-wrap:wrap;
gap:20px;
}

.dealer-left{
display:flex;
flex-direction:column;
gap:6px;
}

.dealer-title{
font-size:14px;
color:#6b7280;
}

.dealer-name{
font-size:22px;
font-weight:700;
}

.dealer-meta{
font-size:14px;
color:#6b7280;
}

.dealer-actions{
display:flex;
gap:12px;
}

.dealer-btn{
padding:10px 18px;
border-radius:8px;
font-size:14px;
cursor:pointer;
border:none;
}

.btn-contact{
background:#ef4444;
color:#fff;
}

.btn-view{
background:#111827;
color:#fff;
}

/* MOBILE */

@media(max-width:768px){

.dealer-card{
flex-direction:column;
align-items:flex-start;
}

.dealer-actions{
width:100%;
}

.dealer-btn{
flex:1;
}

}
        #wishlistBtn.active{
color:#ef4444;
font-weight:600;
}

        .breakdown-row{
display:flex;
align-items:center;
gap:10px;
margin-bottom:6px;
font-size:13px;
}

.breakdown-bar{
flex:1;
height:6px;
background:#e5e7eb;
border-radius:4px;
overflow:hidden;
}

.breakdown-fill{
height:100%;
background:#f59e0b;
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
</div>


<!-- RENT PRICE -->
<div class="bike-price">
₹ <asp:Literal ID="litRentPerDay" runat="server"></asp:Literal> / Day
</div>

<hr class="divider"/>

<h4>Rental Booking</h4>

<label>Start Date</label>
<input type="date" id="startDate" class="form-control mb-2"/>

<label>End Date</label>
<input type="date" id="endDate" class="form-control mb-3"/>


<div class="quick-specs">

<div>
<span>Total Days</span>
<strong id="days">0</strong>
</div>

<div>
<span>Total Rent</span>
<strong>₹ <span id="totalRent">0</span></strong>
</div>

</div>


<button class="btn-primary mt-3" onclick="bookRental()">
Book Rental
</button>

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

<div class="tab-btn active" onclick="openTab(event,'overview')">
Overview
</div>

<div class="tab-btn" onclick="openTab(event,'specs')">
Specifications
</div>

<div class="tab-btn" onclick="openTab(event,'features')">
Features
</div>

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

    <section class="dealer-section">

<h2 style="margin-bottom:20px;">Rental Provider</h2>

<div class="dealer-card">

<div class="dealer-left">

<div class="dealer-title">
Authorized Electric Bike Rental Provider
</div>

<div class="dealer-name">
<asp:Literal ID="litDealerName" runat="server"></asp:Literal>
</div>

<div class="dealer-meta">
📞 <asp:Literal ID="litDealerPhone" runat="server"></asp:Literal>
</div>

<div class="dealer-meta">
✉ <asp:Literal ID="litDealerEmail" runat="server"></asp:Literal>
</div>

<div class="dealer-meta">
📍 <asp:Literal ID="litDealerCity" runat="server"></asp:Literal>
</div>

</div>


<div class="dealer-actions">

<button class="dealer-btn btn-contact"
onclick="contactDealer()">
Contact Dealer
</button>

<button type="button" class="dealer-btn btn-view"
onclick="viewDealerBikes()">
View Dealer Bikes
</button>

</div>

</div>

</section>


    <section class="reviews-section">

<div class="reviews-container">

<div class="reviews-top">

<!-- Review Form -->

<div class="review-form-mini">

<h4>Write a Review</h4>

<select id="rating" class="form-control">

<option value="5">★★★★★ (5)</option>
<option value="4">★★★★ (4)</option>
<option value="3">★★★ (3)</option>
<option value="2">★★ (2)</option>
<option value="1">★ (1)</option>

</select>

<input type="text"
id="reviewTitle"
class="form-control"
placeholder="Review title">

<textarea id="reviewText"
class="form-control"
placeholder="Write your review"></textarea>

<button onclick="submitReview()">
Submit Review
</button>

<div id="reviewMsg"></div>

</div>


<!-- Rating Summary -->

<div class="reviews-rating">

<div class="rating-number">
<asp:Literal ID="litAvgRating" runat="server"></asp:Literal>
</div>

<div class="rating-stars">
<asp:Literal ID="litAvgStars" runat="server"></asp:Literal>
</div>

<div class="rating-count">
Based on <asp:Literal ID="litReviewCount" runat="server"></asp:Literal>
</div>

<div class="rating-breakdown">
<asp:Literal ID="litBreakdown" runat="server"></asp:Literal>
</div>

</div>

</div>


<!-- Reviews Slider -->

<div class="reviews-slider-wrapper">

<button class="review-nav left"
onclick="slideReviews(-1)">
‹
</button>

<div class="reviews-slider" id="reviewsSlider">

<asp:Literal ID="litRecentReviews" runat="server"></asp:Literal>

</div>

<button class="review-nav right"
onclick="slideReviews(1)">
›
</button>

</div>

</div>

</section>

    <section class="similar-section">

<div class="similar-header">

<h2>Similar Rental Bikes</h2>

<div class="slider-controls">
<button type="button" onclick="return slideLeft(event)">‹</button>
<button type="button" onclick="return slideRight(event)">›</button>
</div>

</div>


<div class="similar-slider-wrapper">

<div class="similar-slider" id="similarSlider">

<asp:Literal ID="litSimilarBikes" runat="server"></asp:Literal>

</div>

</div>

</section>




    <script>

        function slideLeft(e){

            if(e) e.preventDefault();

            var slider = document.getElementById("similarSlider");

            slider.scrollLeft -= 260;

            return false;

        }

        function slideRight(e){

            if(e) e.preventDefault();

            var slider = document.getElementById("similarSlider");

            slider.scrollLeft += 260;

            return false;

        }

</script>


    <script>

        function slideReviews(dir){

            var slider = document.getElementById("reviewsSlider");

            slider.scrollBy({
                left: dir * 320,
                behavior:'smooth'
            });

        }


        function submitReview(){

            var rating = document.getElementById("rating").value;
            var title = document.getElementById("reviewTitle").value;
            var text = document.getElementById("reviewText").value;

            if(text.trim()==""){
                alert("Please write review");
                return;
            }

            $.ajax({

                type:"POST",
                url:"RentalBikeDetails.aspx/SubmitReview",

                data: JSON.stringify({

                    rating: rating,
                    title: title,
                    review: text

                }),

                contentType:"application/json; charset=utf-8",
                dataType:"json",

                success:function(res){

                    if(res.d==="login"){
                        alert("Please login first");
                        return;
                    }

                    if(res.d==="exists"){
                        alert("You already reviewed this bike");
                        return;
                    }

                    document.getElementById("reviewMsg").innerHTML =
                    "Review submitted. Waiting for admin approval.";

                    document.getElementById("reviewTitle").value="";
                    document.getElementById("reviewText").value="";

                }

            });

        }

</script>

    <script>

        function contactDealer(){

            var phone = "<%= litDealerPhone.Text %>";

    if(phone!=""){
        window.location.href="tel:"+phone;
    }

}


function viewDealerBikes(){

    var dealerId = "<%= ViewState["DealerID"] %>";

    if(dealerId!=""){

        window.location.href = "Bikes.aspx?dealer=" + dealerId;

    }

}

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

    <script>
        
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

        let bikeId = "<%= ViewState["BikeID"] %>";
        let rentPerDay = parseFloat("<%= ViewState["RentPerDay"] ?? "0" %>");

        $("#startDate,#endDate").change(function(){

            let s = new Date($("#startDate").val());
            let e = new Date($("#endDate").val());

            let days = (e - s) / (1000*60*60*24) + 1;

            if(days > 0){

                $("#days").text(days);

                let total = days * rentPerDay;

                $("#totalRent").text(total.toLocaleString());

            }

        });

        function bookRental(){

            $.ajax({

                type:"POST",
                url:"RentalBikeDetails.aspx/BookRental",

                data: JSON.stringify({

                    bikeId: bikeId,
                    start: $("#startDate").val(),
                    end: $("#endDate").val()

                }),

                contentType:"application/json; charset=utf-8",
                dataType:"json",

                success:function(res){

                    alert(res.d);

                }

            });

        }

</script>







</asp:Content>

