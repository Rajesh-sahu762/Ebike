<%@ Page Title="" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="BikeDetails.aspx.cs" Inherits="Client_BikeDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <style>
        /* ================================
   PREMIUM BIKE DETAILS SECTION
================================ */

.bike-hero{
max-width:1250px;
margin:90px auto;
display:flex;
gap:80px;
padding:40px;
background:linear-gradient(135deg,#ffffff,#f9fafb);
border-radius:24px;
box-shadow:0 25px 60px rgba(0,0,0,0.06);
}

/* ===== LEFT IMAGE SECTION ===== */

.bike-gallery{
flex:1;
}

/* ===== FIXED IMAGE SIZE ===== */

.bike-main{
width:100%;
height:380px;   /* Pehle 460 tha */
background:#ffffff;
border-radius:18px;
display:flex;
align-items:center;
justify-content:center;
overflow:hidden;
box-shadow:0 10px 25px rgba(0,0,0,0.06);
}

.bike-main img{
max-width:80%;   /* Pehle 90% tha */
max-height:80%;
object-fit:contain;
transition:0.3s ease;
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
border-radius:12px;
background:#111827;
color:#fff;
border:none;
font-weight:600;
cursor:pointer;
transition:0.3s;
}

.btn-primary:hover{
background:#000;
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

