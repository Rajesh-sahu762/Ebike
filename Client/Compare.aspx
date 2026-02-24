<%@ Page Title="Compare Bikes"
Language="C#"
MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true"
CodeFile="Compare.aspx.cs"
Inherits="Compare" %>

<asp:Content ID="Content1"
ContentPlaceHolderID="ContentPlaceHolder1"
runat="server">

<style>

/* ===========================
   SECTION 1 WRAPPER
=========================== */

.compare-section{
padding:100px 20px;
background:linear-gradient(180deg,#f8fafc 0%,#eef2f7 100%);
display:flex;
justify-content:center;
}

/* ===========================
   CARD CONTAINER
=========================== */

.compare-card{
width:100%;
max-width:1000px;
background:#ffffff;
border-radius:24px;
padding:60px 50px;
box-shadow:
0 25px 60px rgba(0,0,0,0.08),
0 8px 20px rgba(0,0,0,0.04);
transition:0.3s ease;
}

.compare-card:hover{
transform:translateY(-4px);
box-shadow:
0 35px 75px rgba(0,0,0,0.12),
0 10px 30px rgba(0,0,0,0.06);
}

/* ===========================
   HEADER
=========================== */

.compare-title{
text-align:center;
margin-bottom:50px;
}

.compare-title h1{
font-size:30px;
font-weight:700;
color:#0f172a;
margin-bottom:12px;
}

.compare-title p{
font-size:15px;
color:#64748b;
margin:0;
}

/* ===========================
   FORM GRID
=========================== */

.compare-grid{
display:grid;
grid-template-columns:1fr 1fr;
gap:35px;
margin-bottom:45px;
}

/* ===========================
   FIELD
=========================== */

.compare-field{
display:flex;
flex-direction:column;
gap:8px;
}

.compare-field label{
font-size:14px;
font-weight:600;
color:#334155;
}

/* ===========================
   DROPDOWN
=========================== */

.compare-field select{
height:54px;
border-radius:14px;
border:1px solid #e2e8f0;
padding:0 18px;
font-size:15px;
background:#f8fafc;
transition:all 0.25s ease;
}

.compare-field select:focus{
border-color:#2563eb;
background:#ffffff;
box-shadow:0 0 0 4px rgba(37,99,235,0.15);
outline:none;
}

/* ===========================
   BUTTON
=========================== */

.compare-action{
text-align:center;
}

.compare-btn{
padding:14px 55px;
border-radius:40px;
border:none;
font-size:15px;
font-weight:600;
letter-spacing:0.5px;
color:#ffffff;
background:linear-gradient(135deg,#ef4444,#dc2626);
cursor:pointer;
transition:all 0.3s ease;
box-shadow:0 12px 25px rgba(239,68,68,0.35);
}

.compare-btn:hover{
transform:translateY(-3px);
box-shadow:0 18px 35px rgba(239,68,68,0.45);
}

.compare-btn:active{
transform:translateY(0);
}

/* ===========================
   RESPONSIVE
=========================== */

@media(max-width:900px){

.compare-card{
padding:45px 30px;
}

.compare-grid{
grid-template-columns:1fr;
gap:25px;
}

.compare-title h1{
font-size:24px;
}

}

@media(max-width:500px){

.compare-section{
padding:70px 15px;
}

.compare-card{
padding:35px 20px;
border-radius:18px;
}

.compare-btn{
width:100%;
padding:14px 0;
}

}


    /* ================= HERO SECTION ================= */

.compare-hero{
margin-top:60px;
background:#0f172a;
border-radius:22px;
padding:60px 50px;
display:flex;
align-items:center;
justify-content:center;
gap:50px;
color:#ffffff;
box-shadow:0 25px 60px rgba(0,0,0,0.5);
position:relative;
overflow:hidden;
}

.hero-bike{
flex:1;
text-align:center;
}

.hero-bike img{
height:190px;
object-fit:contain;
margin-bottom:20px;
transition:0.3s ease;
}

.hero-bike img:hover{
transform:scale(1.05);
}

.hero-bike h3{
font-size:20px;
font-weight:600;
margin-bottom:6px;
}

.hero-bike p{
font-size:16px;
color:#94a3b8;
margin:0;
}

.hero-vs{
width:100px;
height:100px;
border-radius:50%;
background:linear-gradient(135deg,#ef4444,#dc2626);
display:flex;
align-items:center;
justify-content:center;
font-size:28px;
font-weight:700;
box-shadow:0 10px 25px rgba(239,68,68,0.5);
}

/* ===== RESPONSIVE ===== */

@media(max-width:900px){

.compare-hero{
flex-direction:column;
gap:30px;
padding:40px 25px;
}

.hero-vs{
width:70px;
height:70px;
font-size:20px;
}

.hero-bike img{
height:150px;
}

}

    /* ================= SECTION 3 - SPECS ================= */

.compare-specs-card{
margin-top:50px;
background:#ffffff;
border-radius:20px;
padding:50px 40px;
box-shadow:0 15px 40px rgba(0,0,0,0.08);
}

.specs-header{
margin-bottom:30px;
}

.specs-header h2{
font-size:22px;
font-weight:700;
color:#0f172a;
margin:0;
}

/* Row Layout */

.spec-row{
display:flex;
align-items:center;
padding:16px 0;
border-bottom:1px solid #e5e7eb;
}

.spec-row:last-child{
border-bottom:none;
}

.spec-title{
width:30%;
font-weight:600;
color:#334155;
font-size:14px;
}

.spec-value{
width:35%;
text-align:center;
font-size:14px;
color:#111827;
}

/* Highlight Better */

.spec-highlight{
background:#dcfce7;
color:#15803d;
padding:4px 8px;
border-radius:6px;
font-weight:600;
display:inline-block;
}

/* Responsive */

@media(max-width:900px){

.compare-specs-card{
padding:35px 25px;
}

.spec-row{
flex-direction:column;
align-items:flex-start;
gap:8px;
}

.spec-title,
.spec-value{
width:100%;
text-align:left;
}

}

/* ===============================
   SECTION 4 — PREMIUM GALLERY
=================================*/

.compare-gallery-card{
margin-top:70px;
background:linear-gradient(145deg,#ffffff,#f8fafc);
border-radius:24px;
padding:60px 50px;
box-shadow:0 25px 60px rgba(0,0,0,0.06);
position:relative;
}

.compare-gallery-card h2{
font-size:24px;
font-weight:700;
margin-bottom:40px;
color:#0f172a;
letter-spacing:0.5px;
}

.gallery-grid{
display:grid;
grid-template-columns:1fr 1fr;
gap:50px;
}

.gallery-column{
display:grid;
grid-template-columns:repeat(auto-fill,minmax(130px,1fr));
gap:18px;
}

.gallery-column img{
width:100%;
height:120px;
object-fit:cover;
border-radius:16px;
cursor:pointer;
transition:all 0.35s ease;
box-shadow:0 8px 20px rgba(0,0,0,0.08);
}

.gallery-column img:hover{
transform:scale(1.08);
box-shadow:0 20px 40px rgba(0,0,0,0.18);
}


/* ===============================
   SECTION 5 — PREMIUM REVIEWS
=================================*/

.compare-review-card{
margin-top:70px;
background:#ffffff;
border-radius:24px;
padding:60px 50px;
box-shadow:0 25px 60px rgba(0,0,0,0.06);
}

.compare-review-card h2{
font-size:24px;
font-weight:700;
margin-bottom:45px;
color:#0f172a;
}

.review-grid{
display:grid;
grid-template-columns:1fr 1fr;
gap:60px;
align-items:center;
}

.review-column{
text-align:center;
padding:30px;
border-radius:20px;
background:#f8fafc;
transition:0.3s ease;
}

.review-column:hover{
transform:translateY(-6px);
box-shadow:0 20px 40px rgba(0,0,0,0.08);
}

/* Big Rating */

.rating-number{
font-size:48px;
font-weight:800;
color:#111827;
margin-bottom:10px;
}

.rating-stars{
font-size:20px;
color:#facc15;
margin-bottom:12px;
}

.review-count{
font-size:14px;
color:#64748b;
margin-bottom:25px;
}

/* Rating Bars */

.rating-bar{
height:10px;
background:#e5e7eb;
border-radius:30px;
overflow:hidden;
margin-bottom:12px;
}

.rating-fill{
height:100%;
background:linear-gradient(90deg,#22c55e,#16a34a);
border-radius:30px;
transition:width 0.5s ease;
}


/* ===============================
   RESPONSIVE
=================================*/

@media(max-width:992px){

.gallery-grid{
grid-template-columns:1fr;
gap:40px;
}

.review-grid{
grid-template-columns:1fr;
gap:40px;
}

}

@media(max-width:576px){

.compare-gallery-card,
.compare-review-card{
padding:40px 25px;
}

.gallery-column{
grid-template-columns:repeat(auto-fill,minmax(100px,1fr));
}

.gallery-column img{
height:100px;
}

.rating-number{
font-size:38px;
}

}

    .review-grid{
position:relative;
}

.review-grid::before{
content:"";
position:absolute;
left:50%;
top:0;
bottom:0;
width:1px;
background:#e5e7eb;
}


/* ===============================
   PREMIUM PERFORMANCE SECTION
=================================*/

.compare-score-section{
margin-top:90px;
padding:100px 20px;
background:linear-gradient(135deg,#0f172a,#111827);
border-radius:30px;
position:relative;
overflow:hidden;
}

.score-container{
max-width:1100px;
margin:auto;
text-align:center;
}

.score-title{
color:#ffffff;
font-size:28px;
font-weight:700;
margin-bottom:70px;
letter-spacing:1px;
}

/* Wrapper */

.score-wrapper{
display:flex;
align-items:center;
justify-content:center;
gap:80px;
flex-wrap:wrap;
}

/* Divider */

.score-divider{
font-size:26px;
font-weight:700;
color:#ef4444;
letter-spacing:3px;
}

/* Score Box */

.score-box{
width:260px;
height:260px;
border-radius:50%;
background:rgba(255,255,255,0.05);
display:flex;
align-items:center;
justify-content:center;
position:relative;
backdrop-filter:blur(8px);
transition:0.3s ease;
}

.score-box:hover{
transform:translateY(-8px);
box-shadow:0 20px 40px rgba(0,0,0,0.5);
}

/* Circular Progress */

.score-circle{
width:200px;
height:200px;
border-radius:50%;
background:conic-gradient(#22c55e var(--percent), #1e293b 0%);
display:flex;
align-items:center;
justify-content:center;
position:relative;
}

.score-inner{
width:150px;
height:150px;
background:#0f172a;
border-radius:50%;
display:flex;
align-items:center;
justify-content:center;
flex-direction:column;
}

.score-value{
font-size:36px;
font-weight:800;
color:#ffffff;
}

.score-label{
font-size:14px;
color:#94a3b8;
margin-top:6px;
}

/* Responsive */

@media(max-width:900px){

.score-wrapper{
gap:50px;
}

.score-box{
width:220px;
height:220px;
}

.score-circle{
width:170px;
height:170px;
}

.score-inner{
width:130px;
height:130px;
}

}


    /* ===============================
   SCROLL REVEAL ANIMATION
=================================*/

.reveal{
opacity:0;
transform:translateY(60px);
transition:all 0.8s cubic-bezier(.215,.61,.355,1);
}

.reveal.active{
opacity:1;
transform:translateY(0);
}

/* Slight stagger effect for nested elements */

.reveal .spec-row,
.reveal .gallery-column img,
.reveal .review-column,
.reveal .score-box{
opacity:0;
transform:translateY(30px);
transition:all 0.6s ease;
}

.reveal.active .spec-row,
.reveal.active .gallery-column img,
.reveal.active .review-column,
.reveal.active .score-box{
opacity:1;
transform:translateY(0);
}

/* ===============================
   PREMIUM DIFFERENCE TOGGLE
=================================*/

.compare-toggle-wrapper{
display:flex;
align-items:center;
justify-content:space-between;
background:#f8fafc;
padding:20px 25px;
border-radius:16px;
margin-bottom:35px;
box-shadow:0 8px 20px rgba(0,0,0,0.05);
gap:20px;
flex-wrap:wrap;
}

.compare-toggle-left h4{
margin:0;
font-size:16px;
font-weight:600;
color:#0f172a;
}

.compare-toggle-left p{
margin:4px 0 0;
font-size:13px;
color:#64748b;
}

/* Toggle Switch */

.toggle-switch{
position:relative;
display:inline-block;
width:54px;
height:28px;
}

.toggle-switch input{
opacity:0;
width:0;
height:0;
}

.slider{
position:absolute;
cursor:pointer;
top:0;
left:0;
right:0;
bottom:0;
background-color:#cbd5e1;
transition:.4s;
border-radius:34px;
}

.slider:before{
position:absolute;
content:"";
height:22px;
width:22px;
left:3px;
bottom:3px;
background-color:white;
transition:.4s;
border-radius:50%;
box-shadow:0 2px 6px rgba(0,0,0,0.2);
}

.toggle-switch input:checked + .slider{
background:linear-gradient(135deg,#22c55e,#16a34a);
box-shadow:0 0 10px rgba(34,197,94,0.6);
}

.toggle-switch input:checked + .slider:before{
transform:translateX(26px);
}

/* Badge */

.diff-badge{
font-size:12px;
font-weight:600;
padding:6px 12px;
border-radius:20px;
background:#e2e8f0;
color:#475569;
transition:0.3s ease;
}

/* Active Badge */

.diff-badge.active{
background:#dcfce7;
color:#15803d;
box-shadow:0 0 10px rgba(34,197,94,0.4);
}

/* Mobile */

@media(max-width:768px){

.compare-toggle-wrapper{
flex-direction:column;
align-items:flex-start;
}

}

    /* ===============================
   PREMIUM POPULAR CAROUSEL
=================================*/

.popular-section{
margin-top:100px;
padding:80px 0;
}

.popular-header{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:50px;
}

.popular-header h2{
font-size:26px;
font-weight:700;
color:#0f172a;
}

.popular-controls button{
width:40px;
height:40px;
border:none;
border-radius:50%;
background:#111827;
color:#fff;
cursor:pointer;
transition:0.3s ease;
}

.popular-controls button:hover{
background:#0ea5e9;
transform:scale(1.1);
}

/* Carousel Wrapper */

.popular-carousel-wrapper{
overflow:hidden;
position:relative;
}

.popular-carousel{
display:flex;
gap:30px;
transition:transform 0.5s ease;
}

/* Card */

.popular-card{
min-width:340px;
background:#ffffff;
border-radius:24px;
padding:30px;
box-shadow:0 20px 40px rgba(0,0,0,0.08);
display:flex;
flex-direction:column;
align-items:center;
justify-content:space-between;
transition:0.4s ease;
opacity:0;
transform:translateY(40px);
}

.popular-card.visible{
opacity:1;
transform:translateY(0);
}

.popular-card:hover{
transform:translateY(-10px);
box-shadow:0 30px 60px rgba(0,0,0,0.15);
}

/* Top */

.popular-top{
display:flex;
align-items:center;
justify-content:space-between;
width:100%;
gap:15px;
margin-bottom:25px;
}

.popular-bike{
text-align:center;
flex:1;
}

.popular-bike img{
height:100px;
object-fit:contain;
margin-bottom:8px;
transition:0.3s ease;
}

.popular-card:hover .popular-bike img{
transform:scale(1.05);
}

.popular-bike p{
font-weight:600;
font-size:15px;
margin:0;
color:#111827;
}

.popular-vs{
font-weight:800;
font-size:18px;
color:#ef4444;
}

/* Button */

.popular-compare-btn{
display:inline-block;
padding:10px 25px;
background:#111827;
color:#fff;
border-radius:30px;
font-size:14px;
text-decoration:none;
transition:0.3s ease;
}

.popular-compare-btn:hover{
background:#0ea5e9;
transform:translateY(-2px);
}

/* Responsive */

@media(max-width:768px){

.popular-card{
min-width:280px;
}

}



</style>


<div class="compare-section">

<div class="compare-card">

<div class="compare-title">
<h1>Compare Electric Bikes</h1>
<p>Select any two bikes to explore a detailed comparison</p>
</div>

<div class="compare-grid">

<div class="compare-field">
<label>First Bike</label>
<asp:Literal ID="Bike1Select" runat="server"></asp:Literal>
</div>

<div class="compare-field">
<label>Second Bike</label>
<asp:Literal ID="Bike2Select" runat="server"></asp:Literal>
</div>

</div>

<div class="compare-action">
<button runat="server"
id="btnCompare"
onserverclick="CompareNow"
class="compare-btn">
Compare Now
</button>
</div>

</div>

</div>


    <asp:Panel ID="CompareHeroPanel" runat="server" Visible="false">

<div class="compare-hero reveal">

    <div class="hero-bike">
        <asp:Literal ID="HeroBike1" runat="server"></asp:Literal>
    </div>

    <div class="hero-vs">
        <span>VS</span>
    </div>

    <div class="hero-bike">
        <asp:Literal ID="HeroBike2" runat="server"></asp:Literal>
    </div>

</div>

</asp:Panel>


    <asp:Panel ID="CompareSpecsPanel" runat="server" Visible="false">

<div class="compare-specs-card reveal">

    <div class="specs-header">
        <h2>Technical Specifications</h2>
    </div>

    <div class="specs-body">
        <asp:Literal ID="SpecRows" runat="server"></asp:Literal>
    </div>
    <br />
           <div class="compare-toggle-wrapper">

    <div class="compare-toggle-left">
        <h4>Smart Compare Mode</h4>
        <p>Highlight only the differences between bikes</p>
    </div>

    <label class="toggle-switch">
        <input type="checkbox" id="toggleDiff">
        <span class="slider"></span>
    </label>

    <span class="diff-badge" id="diffBadge">OFF</span>

</div>

</div>

 


</asp:Panel>


    <asp:Panel ID="CompareGalleryPanel" runat="server" Visible="false">

<div class="compare-gallery-card reveal">

    <h2>Image Gallery</h2>

    <div class="gallery-grid">

        <div class="gallery-column">
            <asp:Literal ID="GalleryBike1" runat="server"></asp:Literal>
        </div>

        <div class="gallery-column">
            <asp:Literal ID="GalleryBike2" runat="server"></asp:Literal>
        </div>

    </div>

</div>

</asp:Panel>


    <asp:Panel ID="Panel1" runat="server" Visible="false">

<div class="compare-gallery-card reveal">

    <h2>Image Gallery</h2>

    <div class="gallery-grid">

        <div class="gallery-column">
            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
        </div>

        <div class="gallery-column">
            <asp:Literal ID="Literal2" runat="server"></asp:Literal>
        </div>

    </div>

</div>

</asp:Panel>

    <asp:Panel ID="CompareScorePanel" runat="server" Visible="false">

<section class="compare-score-section reveal">

    <div class="score-container">

        <h2 class="score-title">Performance Comparison</h2>

        <div class="score-wrapper">

            <div class="score-box winner-check">
                <asp:Literal ID="ScoreBike1" runat="server"></asp:Literal>
            </div>

            <div class="score-divider">VS</div>

            <div class="score-box winner-check">
                <asp:Literal ID="ScoreBike2" runat="server"></asp:Literal>
            </div>

        </div>

    </div>

</section>

</asp:Panel>



    <!-- ================= POPULAR COMPARISONS ================= -->

<section class="popular-section reveal">

    <div class="popular-header">
        <h2>Popular Bike Comparisons</h2>
        <div class="popular-controls">
            <button id="prevBtn">&#10094;</button>
            <button id="nextBtn">&#10095;</button>
        </div>
    </div>

    <div class="popular-carousel-wrapper">
        <div class="popular-carousel" id="popularCarousel">

            <asp:Repeater ID="rptPopular" runat="server">
                <ItemTemplate>

                    <div class="popular-card">

                        <div class="popular-top">

                            <div class="popular-bike">
                                <img src='/Uploads/Bikes/<%# Eval("Image1") %>' />
                                <p><%# Eval("ModelName") %></p>
                            </div>

                            <div class="popular-vs">VS</div>

                            <div class="popular-bike">
                                <img src='/Uploads/Bikes/<%# Eval("Image2") %>' />
                                <p><%# Eval("ModelName2") %></p>
                            </div>

                        </div>

                        <a href='Compare.aspx?b1=<%# Eval("BikeID1") %>&b2=<%# Eval("BikeID2") %>'
                           class="popular-compare-btn">
                            Compare Now
                        </a>

                    </div>

                </ItemTemplate>
            </asp:Repeater>

        </div>
    </div>

</section>





    <script>
        document.addEventListener("DOMContentLoaded", function(){

            const reveals = document.querySelectorAll(".reveal");

            function revealOnScroll(){
                const windowHeight = window.innerHeight;

                reveals.forEach(function(section){
                    const sectionTop = section.getBoundingClientRect().top;

                    if(sectionTop < windowHeight - 100){
                        section.classList.add("active");
                    }
                });
            }

            window.addEventListener("scroll", revealOnScroll);
            revealOnScroll();

        });

        const toggle = document.getElementById("toggleDiff");
const badge = document.getElementById("diffBadge");

        if(toggle){

            toggle.addEventListener("change", function(){

                const rows = document.querySelectorAll(".spec-row");

                rows.forEach(function(row){

                    const values = row.querySelectorAll(".spec-value");

                    if(values.length === 2){

                        if(values[0].innerText.trim() === values[1].innerText.trim()){
                            row.style.display = toggle.checked ? "none" : "flex";
                        }

                    }

                });

                // Badge Update
                if(toggle.checked){
                    badge.innerText = "ON";
                    badge.classList.add("active");
                }else{
                    badge.innerText = "OFF";
                    badge.classList.remove("active");
                }

            });

        }

</script>

    <script>
        document.addEventListener("DOMContentLoaded", function(){

            const carousel = document.getElementById("popularCarousel");
            const cards = document.querySelectorAll(".popular-card");
            const nextBtn = document.getElementById("nextBtn");
            const prevBtn = document.getElementById("prevBtn");

            let scrollAmount = 0;
            const cardWidth = 370;

            nextBtn.addEventListener("click", function(){
                scrollAmount += cardWidth;
                carousel.style.transform = "translateX(-" + scrollAmount + "px)";
            });

            prevBtn.addEventListener("click", function(){
                scrollAmount -= cardWidth;
                if(scrollAmount < 0) scrollAmount = 0;
                carousel.style.transform = "translateX(-" + scrollAmount + "px)";
            });

            // Stagger Fade-Up Animation
            const observer = new IntersectionObserver(entries => {
                entries.forEach(entry => {
                    if(entry.isIntersecting){
                        cards.forEach((card, index) => {
                            setTimeout(() => {
                                card.classList.add("visible");
        }, index * 120);
        });
        }
        });
        }, { threshold: 0.2 });

        observer.observe(document.querySelector(".popular-section"));

        });
</script>


</asp:Content>
