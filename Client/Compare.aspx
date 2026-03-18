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
/* ===== GLOBAL DESIGN TOKENS ===== */
:root {
    --primary: #ef4444;
    --primary-dark: #dc2626;
    --primary-light: #fee2e2;
    --secondary: #22c55e;
    --secondary-dark: #16a34a;
    --dark: #0f172a;
    --dark-light: #1e293b;
    --light: #f8fafc;
    --light-gray: #e2e8f0;
    --text-dark: #0f172a;
    --text-muted: #64748b;
    --shadow-sm: 0 8px 20px rgba(0,0,0,0.04);
    --shadow-md: 0 15px 40px rgba(0,0,0,0.08);
    --shadow-lg: 0 25px 60px rgba(0,0,0,0.12);
    --shadow-hover: 0 35px 75px rgba(0,0,0,0.15);
    --radius-md: 16px;
    --radius-lg: 24px;
    --transition: all 0.3s ease;
}

/* ===== BASE ===== */
body {
    font-family: 'Inter', system-ui, -apple-system, sans-serif;
}

/* ===========================
   SECTION 1 WRAPPER
=========================== */
.compare-section{
    padding: 100px 20px;
    background: linear-gradient(180deg, var(--light) 0%, #eef2f7 100%);
    display: flex;
    justify-content: center;
}

/* ===========================
   CARD CONTAINER
=========================== */
.compare-card{
    width: 100%;
    max-width: 1100px;
    background: #ffffff;
    border-radius: var(--radius-lg);
    padding: 60px 50px;
    box-shadow: var(--shadow-md);
    transition: var(--transition);
}
.compare-card:hover{
    transform: translateY(-4px);
    box-shadow: var(--shadow-hover);
}

/* ===========================
   HEADER
=========================== */
.compare-title{
    text-align: center;
    margin-bottom: 50px;
}
.compare-title h1{
    font-size: 2rem;
    font-weight: 700;
    color: var(--text-dark);
    margin-bottom: 12px;
}
.compare-title p{
    font-size: 1rem;
    color: var(--text-muted);
    margin: 0;
}

/* ===========================
   FORM GRID
=========================== */
.compare-grid{
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 35px;
    margin-bottom: 45px;
}

/* ===========================
   FIELD
=========================== */
.compare-field{
    display: flex;
    flex-direction: column;
    gap: 8px;
}
.compare-field label{
    font-size: 0.9rem;
    font-weight: 600;
    color: #334155;
    letter-spacing: 0.3px;
}

/* ===========================
   DROPDOWN - CUSTOM STYLE
=========================== */
.compare-field select{
    height: 54px;
    border-radius: 14px;
    border: 1px solid var(--light-gray);
    padding: 0 18px;
    font-size: 1rem;
    background: var(--light);
    transition: var(--transition);
    appearance: none;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%23334155' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 18px center;
    background-size: 16px;
}
.compare-field select:focus{
    border-color: var(--primary);
    background-color: #ffffff;
    box-shadow: 0 0 0 4px rgba(239,68,68,0.15);
    outline: none;
}

/* ===========================
   BUTTON
=========================== */
.compare-action{
    text-align: center;
}
.compare-btn{
    padding: 14px 55px;
    border-radius: 40px;
    border: none;
    font-size: 1rem;
    font-weight: 600;
    letter-spacing: 0.5px;
    color: #ffffff;
    background: linear-gradient(135deg, var(--primary), var(--primary-dark));
    cursor: pointer;
    transition: var(--transition);
    box-shadow: 0 12px 25px rgba(239,68,68,0.35);
}
.compare-btn:hover{
    transform: translateY(-3px);
    box-shadow: 0 18px 35px rgba(239,68,68,0.45);
}
.compare-btn:active{
    transform: translateY(0);
}

/* ===========================
   RESPONSIVE
=========================== */
@media(max-width:900px){
    .compare-card{
        padding: 45px 30px;
    }
    .compare-grid{
        grid-template-columns: 1fr;
        gap: 25px;
    }
    .compare-title h1{
        font-size: 1.8rem;
    }
}
@media(max-width:500px){
    .compare-section{
        padding: 70px 15px;
    }
    .compare-card{
        padding: 35px 20px;
        border-radius: 18px;
    }
    .compare-btn{
        width: 100%;
        padding: 14px 0;
    }
}

/* ================= HERO SECTION ================= */
.compare-hero{
    margin-top: 60px;
    background: var(--dark);
    border-radius: var(--radius-lg);
    padding: 60px 50px;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 50px;
    color: #ffffff;
    box-shadow: var(--shadow-lg);
    position: relative;
    overflow: hidden;
}
.hero-bike{
    flex: 1;
    text-align: center;
}
.hero-bike img{
    height: 190px;
    object-fit: contain;
    margin-bottom: 20px;
    transition: var(--transition);
    filter: drop-shadow(0 10px 20px rgba(0,0,0,0.3));
}
.hero-bike img:hover{
    transform: scale(1.05);
}
.hero-bike h3{
    font-size: 1.4rem;
    font-weight: 600;
    margin-bottom: 6px;
}
.hero-bike p{
    font-size: 1.1rem;
    color: #94a3b8;
    margin: 0;
}
.hero-vs{
    width: 100px;
    height: 100px;
    border-radius: 50%;
    background: linear-gradient(135deg, var(--primary), var(--primary-dark));
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2rem;
    font-weight: 700;
    box-shadow: 0 10px 25px rgba(239,68,68,0.5);
    border: 4px solid rgba(255,255,255,0.2);
}
@media(max-width:900px){
    .compare-hero{
        flex-direction: column;
        gap: 30px;
        padding: 40px 25px;
    }
    .hero-vs{
        width: 70px;
        height: 70px;
        font-size: 1.5rem;
    }
    .hero-bike img{
        height: 150px;
    }
}

/* ================= SECTION 3 - SPECS ================= */
.compare-specs-card{
    margin-top: 50px;
    background: #ffffff;
    border-radius: var(--radius-lg);
    padding: 50px 40px;
    box-shadow: var(--shadow-md);
}
.specs-header h2{
    font-size: 1.6rem;
    font-weight: 700;
    color: var(--text-dark);
    margin: 0 0 30px 0;
}
.spec-row{
    display: flex;
    align-items: center;
    padding: 16px 0;
    border-bottom: 1px solid #e5e7eb;
    transition: background 0.2s;
}
.spec-row:hover{
    background: #f9fafb;
}
.spec-row:last-child{
    border-bottom: none;
}
.spec-title{
    width: 30%;
    font-weight: 600;
    color: #334155;
    font-size: 0.95rem;
    text-transform: capitalize;
}
.spec-value{
    width: 35%;
    text-align: center;
    font-size: 0.95rem;
    color: #111827;
    font-weight: 500;
}
.spec-highlight{
    background: #dcfce7;
    color: #15803d;
    padding: 4px 10px;
    border-radius: 30px;
    font-weight: 600;
    display: inline-block;
    font-size: 0.85rem;
}
@media(max-width:900px){
    .compare-specs-card{
        padding: 35px 25px;
    }
    .spec-row{
        flex-direction: column;
        align-items: flex-start;
        gap: 8px;
    }
    .spec-title,
    .spec-value{
        width: 100%;
        text-align: left;
    }
}

/* ===============================
   TOGGLE DIFF
=================================*/
.compare-toggle-wrapper{
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: var(--light);
    padding: 18px 25px;
    border-radius: var(--radius-md);
    margin: 40px 0 0;
    box-shadow: var(--shadow-sm);
    gap: 20px;
    flex-wrap: wrap;
}
.compare-toggle-left h4{
    margin: 0;
    font-size: 1.1rem;
    font-weight: 600;
    color: var(--text-dark);
}
.compare-toggle-left p{
    margin: 4px 0 0;
    font-size: 0.85rem;
    color: var(--text-muted);
}
.toggle-switch{
    position: relative;
    display: inline-block;
    width: 56px;
    height: 30px;
}
.toggle-switch input{
    opacity: 0;
    width: 0;
    height: 0;
}
.slider{
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #cbd5e1;
    transition: .3s;
    border-radius: 34px;
}
.slider:before{
    position: absolute;
    content: "";
    height: 24px;
    width: 24px;
    left: 3px;
    bottom: 3px;
    background-color: white;
    transition: .3s;
    border-radius: 50%;
    box-shadow: 0 2px 6px rgba(0,0,0,0.2);
}
.toggle-switch input:checked + .slider{
    background: linear-gradient(135deg, var(--secondary), var(--secondary-dark));
    box-shadow: 0 0 12px rgba(34,197,94,0.5);
}
.toggle-switch input:checked + .slider:before{
    transform: translateX(26px);
}
.diff-badge{
    font-size: 0.8rem;
    font-weight: 600;
    padding: 6px 14px;
    border-radius: 30px;
    background: #e2e8f0;
    color: #475569;
    transition: var(--transition);
}
.diff-badge.active{
    background: #dcfce7;
    color: #15803d;
    box-shadow: 0 0 10px rgba(34,197,94,0.3);
}
@media(max-width:768px){
    .compare-toggle-wrapper{
        flex-direction: column;
        align-items: flex-start;
    }
}

/* ===============================
   PREMIUM GALLERY
=================================*/
.compare-gallery-card{
    margin-top: 70px;
    background: linear-gradient(145deg, #ffffff, var(--light));
    border-radius: var(--radius-lg);
    padding: 60px 50px;
    box-shadow: var(--shadow-md);
}
.compare-gallery-card h2{
    font-size: 1.8rem;
    font-weight: 700;
    margin-bottom: 40px;
    color: var(--text-dark);
}
.gallery-grid{
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 50px;
}
.gallery-column{
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
    gap: 20px;
}
.gallery-column img{
    width: 100%;
    height: 130px;
    object-fit: cover;
    border-radius: var(--radius-md);
    cursor: pointer;
    transition: var(--transition);
    box-shadow: var(--shadow-sm);
}
.gallery-column img:hover{
    transform: scale(1.05);
    box-shadow: var(--shadow-lg);
}

/* ===============================
   PREMIUM REVIEWS (unchanged but restyled)
=================================*/
.compare-review-card{
    margin-top: 70px;
    background: #ffffff;
    border-radius: var(--radius-lg);
    padding: 60px 50px;
    box-shadow: var(--shadow-md);
}
.compare-review-card h2{
    font-size: 1.8rem;
    font-weight: 700;
    margin-bottom: 45px;
    color: var(--text-dark);
}
.review-grid{
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 60px;
    align-items: center;
    position: relative;
}
.review-grid::before{
    content: "";
    position: absolute;
    left: 50%;
    top: 0;
    bottom: 0;
    width: 1px;
    background: #e5e7eb;
}
.review-column{
    text-align: center;
    padding: 30px;
    border-radius: var(--radius-md);
    background: var(--light);
    transition: var(--transition);
}
.review-column:hover{
    transform: translateY(-6px);
    box-shadow: var(--shadow-md);
}
.rating-number{
    font-size: 3.2rem;
    font-weight: 800;
    color: #111827;
    margin-bottom: 10px;
}
.rating-stars{
    font-size: 1.4rem;
    color: #facc15;
    margin-bottom: 12px;
}
.review-count{
    font-size: 0.9rem;
    color: var(--text-muted);
    margin-bottom: 25px;
}
.rating-bar{
    height: 10px;
    background: #e5e7eb;
    border-radius: 30px;
    overflow: hidden;
    margin-bottom: 12px;
}
.rating-fill{
    height: 100%;
    background: linear-gradient(90deg, var(--secondary), var(--secondary-dark));
    border-radius: 30px;
    transition: width 0.5s ease;
}

/* ===============================
   PREMIUM PERFORMANCE SECTION
=================================*/
.compare-score-section{
    margin-top: 90px;
    padding: 100px 20px;
    background: linear-gradient(135deg, var(--dark), #111827);
    border-radius: 30px;
    position: relative;
    overflow: hidden;
}
.score-container{
    max-width: 1100px;
    margin: auto;
    text-align: center;
}
.score-title{
    color: #ffffff;
    font-size: 2rem;
    font-weight: 700;
    margin-bottom: 70px;
    letter-spacing: 1px;
}
.score-wrapper{
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 80px;
    flex-wrap: wrap;
}
.score-divider{
    font-size: 2.2rem;
    font-weight: 700;
    color: var(--primary);
    letter-spacing: 3px;
}
.score-box{
    width: 260px;
    height: 260px;
    border-radius: 50%;
    background: rgba(255,255,255,0.05);
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    backdrop-filter: blur(8px);
    transition: var(--transition);
}
.score-box:hover{
    transform: translateY(-8px);
    box-shadow: 0 20px 40px rgba(0,0,0,0.5);
}
.score-circle{
    width: 200px;
    height: 200px;
    border-radius: 50%;
    background: conic-gradient(var(--secondary) calc(var(--percent) * 1%), #1e293b 0%);
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
}
.score-inner{
    width: 150px;
    height: 150px;
    background: var(--dark);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-direction: column;
}
.score-value{
    font-size: 2.5rem;
    font-weight: 800;
    color: #ffffff;
    line-height: 1;
}
.score-label{
    font-size: 0.9rem;
    color: #94a3b8;
    margin-top: 6px;
    text-transform: uppercase;
    letter-spacing: 1px;
}
@media(max-width:900px){
    .score-wrapper{
        gap: 50px;
    }
    .score-box{
        width: 220px;
        height: 220px;
    }
    .score-circle{
        width: 170px;
        height: 170px;
    }
    .score-inner{
        width: 130px;
        height: 130px;
    }
}

/* ===============================
   POPULAR COMPARISONS - CAROUSEL
=================================*/
.popular-section{
    margin-top: 120px;
    padding: 80px 0;
    background: #ffffff;
}
.popular-header{
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 50px;
    padding: 0 60px;
}
.popular-header h2{
    font-size: 2rem;
    font-weight: 700;
    color: #111827;
}
.popular-carousel-wrapper{
    overflow: hidden;
    padding: 0 60px;
}
.popular-carousel{
    display: flex;
    gap: 40px;
    scroll-snap-type: x mandatory;
    overflow-x: auto;
    scroll-behavior: smooth;
    padding-bottom: 10px;
    scrollbar-width: none;
}
.popular-carousel::-webkit-scrollbar{
    display: none;
}
.popular-card{
    flex: 0 0 420px;
    background: #ffffff;
    border-radius: var(--radius-md);
    box-shadow: var(--shadow-sm);
    overflow: hidden;
    transition: var(--transition);
    scroll-snap-align: center;
    border: 1px solid #f0f2f5;
}
.popular-card:hover{
    transform: translateY(-8px);
    box-shadow: var(--shadow-lg);
}
.popular-image-area{
    background: #f3f4f6;
    padding: 25px 20px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: relative;
}
.popular-bike{
    flex: 1;
    text-align: center;
}
.popular-bike img{
    width: 160px;
    height: 130px;
    object-fit: contain;
    transition: var(--transition);
}
.popular-card:hover .popular-bike img{
    transform: scale(1.02);
}
.popular-vs{
    width: 48px;
    height: 48px;
    background: var(--dark);
    color: #fff;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 700;
    font-size: 1rem;
    box-shadow: 0 6px 12px rgba(0,0,0,0.1);
    border: 2px solid white;
}
.popular-content{
    padding: 22px;
    display: flex;
    flex-direction: column;
    gap: 12px;
}
.popular-names{
    display: flex;
    justify-content: space-between;
    font-weight: 600;
    font-size: 1.1rem;
    color: #111827;
}
.popular-controls{
    display: flex;
    gap: 15px;
}
.popular-controls button{
    width: 50px;
    height: 50px;
    border: none;
    border-radius: 50%;
    background: var(--dark);
    color: #ffffff;
    font-size: 1.2rem;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: var(--transition);
    box-shadow: var(--shadow-sm);
}
.popular-controls button:hover{
    background: var(--primary-dark);
    transform: translateY(-4px);
    box-shadow: 0 15px 30px rgba(220,38,38,0.4);
}
.popular-controls button:active{
    transform: scale(0.95);
}
.popular-prices{
    display: flex;
    justify-content: space-between;
    font-size: 1rem;
    color: #374151;
    font-weight: 500;
}
.popular-compare-btn{
    margin-top: 15px;
    padding: 14px 0;
    background: var(--primary-dark);
    color: #ffffff;
    text-align: center;
    border-radius: 40px;
    font-weight: 600;
    text-decoration: none;
    transition: var(--transition);
    border: none;
    display: block;
}
.popular-compare-btn:hover{
    background: #b91c1c;
    transform: translateY(-2px);
    box-shadow: 0 10px 20px rgba(185,28,28,0.3);
}
@media(max-width:768px){
    .popular-header,
    .popular-carousel-wrapper{
        padding: 0 20px;
    }
    .popular-card{
        flex: 0 0 85%;
    }
    .popular-bike img{
        width: 130px;
        height: 110px;
    }
}

/* ===============================
   SCROLL REVEAL ANIMATION
=================================*/
.reveal{
    opacity: 0;
    transform: translateY(60px);
    transition: all 0.8s cubic-bezier(.215,.61,.355,1);
}
.reveal.active{
    opacity: 1;
    transform: translateY(0);
}
.reveal .spec-row,
.reveal .gallery-column img,
.reveal .review-column,
.reveal .score-box{
    opacity: 0;
    transform: translateY(30px);
    transition: all 0.6s ease;
}
.reveal.active .spec-row,
.reveal.active .gallery-column img,
.reveal.active .review-column,
.reveal.active .score-box{
    opacity: 1;
    transform: translateY(0);
}

/* ===== DUPLICATE GALLERY PANEL (hidden, kept for compatibility) ===== */
#Panel1 {
    display: none;
}
</style>

<!-- ===== COMPARISON FORM ===== -->
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
            <button runat="server" id="btnCompare" onserverclick="CompareNow" class="compare-btn">
                Compare Now
            </button>
        </div>
    </div>
</div>

<!-- ===== HERO PANEL ===== -->
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

<!-- ===== SPECS PANEL ===== -->
<asp:Panel ID="CompareSpecsPanel" runat="server" Visible="false">
    <div class="compare-specs-card reveal">
        <div class="specs-header">
            <h2>Technical Specifications</h2>
        </div>
        <div class="specs-body">
            <asp:Literal ID="SpecRows" runat="server"></asp:Literal>
        </div>
        <!-- Smart Compare Toggle -->
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

<!-- ===== GALLERY PANEL ===== -->
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

<!-- ===== DUPLICATE GALLERY PANEL (kept for legacy) ===== -->
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

<!-- ===== SCORE PANEL ===== -->
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

<!-- ===== POPULAR COMPARISONS ===== -->
<section class="popular-section reveal">
    <div class="popular-header">
        <h2>Popular Bike Comparisons</h2>
        <div class="popular-controls">
            <button type="button" id="prevBtn">&#10094;</button>
            <button type="button" id="nextBtn">&#10095;</button>
        </div>
    </div>
    <div class="popular-carousel-wrapper">
        <div class="popular-carousel" id="popularCarousel">
            <asp:Repeater ID="rptPopular" runat="server">
                <ItemTemplate>
                    <div class="popular-card">
                        <div class="popular-image-area">
                            <div class="popular-bike">
                                <img src='/Uploads/Bikes/<%# Eval("Image1") %>' />
                            </div>
                            <div class="popular-vs">VS</div>
                            <div class="popular-bike">
                                <img src='/Uploads/Bikes/<%# Eval("Image2") %>' />
                            </div>
                        </div>
                        <div class="popular-content">
                            <div class="popular-names">
                                <span><%# Eval("ModelName") %></span>
                                <span><%# Eval("ModelName2") %></span>
                            </div>
                            <div class="popular-prices">
                                <span>₹ <%# FormatPrice(Eval("BikeID1")) %></span>
                                <span>₹ <%# FormatPrice(Eval("BikeID2")) %></span>
                            </div>
                            <a href='Compare.aspx?b1=<%# Eval("BikeID1") %>&b2=<%# Eval("BikeID2") %>' class="popular-compare-btn">
                                Know More
                            </a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</section>

<!-- ===== JAVASCRIPT (unchanged functionality) ===== -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Scroll reveal
        const reveals = document.querySelectorAll(".reveal");
        function revealOnScroll() {
            const windowHeight = window.innerHeight;
            reveals.forEach(function(section) {
                const sectionTop = section.getBoundingClientRect().top;
                if (sectionTop < windowHeight - 100) {
                    section.classList.add("active");
                }
            });
        }
        window.addEventListener("scroll", revealOnScroll);
        revealOnScroll();

        // Toggle diff functionality
        const toggle = document.getElementById("toggleDiff");
        const badge = document.getElementById("diffBadge");
        if (toggle) {
            toggle.addEventListener("change", function() {
                const rows = document.querySelectorAll(".spec-row");
                rows.forEach(function(row) {
                    const values = row.querySelectorAll(".spec-value");
                    if (values.length === 2) {
                        if (values[0].innerText.trim() === values[1].innerText.trim()) {
                            row.style.display = toggle.checked ? "none" : "flex";
                        }
                    }
                });
                if (toggle.checked) {
                    badge.innerText = "ON";
                    badge.classList.add("active");
                } else {
                    badge.innerText = "OFF";
                    badge.classList.remove("active");
                }
            });
        }

        // Carousel controls
        const carousel = document.querySelector(".popular-carousel");
        const nextBtn = document.getElementById("nextBtn");
        const prevBtn = document.getElementById("prevBtn");
        if (carousel && nextBtn && prevBtn) {
            function getScrollAmount() {
                const card = document.querySelector(".popular-card");
                return card ? card.offsetWidth + 40 : 420; // width + gap
            }
            nextBtn.addEventListener("click", function() {
                carousel.scrollBy({ left: getScrollAmount(), behavior: "smooth" });
            });
            prevBtn.addEventListener("click", function() {
                carousel.scrollBy({ left: -getScrollAmount(), behavior: "smooth" });
            });
        }
    });
</script>

</asp:Content>