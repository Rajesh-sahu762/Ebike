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
flex:1;
}

/* ===== FIXED IMAGE SIZE ===== */

.bike-main{
height:340px;
background:#f8fafc;
border-radius:16px;
box-shadow:none;
}

.bike-main img{
max-width:85%;
max-height:85%;
}

.bike-info{
padding-top:10px;
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

.bike-main img:hover{
transform:scale(1.04);
}

.bike-thumbs img{
width:75px;   /* Pehle 90px */
height:60px;
padding:6px;
border-radius:10px;
}

.bike-thumbs img{
width:90px;
height:75px;
background:#f3f4f6;
padding:10px;
border-radius:14px;
cursor:pointer;
transition:0.3s;
border:2px solid transparent;
}

.bike-thumbs img:hover{
border:2px solid #ff4d4d;
transform:translateY(-4px);
box-shadow:0 8px 20px rgba(0,0,0,0.12);
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
width:100%;
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


</asp:Content>

