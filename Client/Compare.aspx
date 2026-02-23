<%@ Page Title="Compare Bikes" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="Compare.aspx.cs"
    Inherits="Compare" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
    /* ================= WRAPPER ================= */

.compare-wrapper{
padding:80px 0;
background:linear-gradient(to bottom,#f4f6f9,#eef2f7);
min-height:100vh;
}

/* ================= SELECT BOX ================= */

.select-box{
background:#fff;
padding:40px;
border-radius:18px;
box-shadow:0 15px 40px rgba(0,0,0,0.08);
margin-bottom:50px;
}

.select-box h4{
font-weight:600;
margin-bottom:25px;
}

.select-grid{
display:grid;
grid-template-columns:1fr 1fr;
gap:25px;
}

/* ================= DARK COMPARE SECTION ================= */

.compare-section{
background:#0f172a;
color:#e2e8f0;
padding:50px;
border-radius:24px;
box-shadow:0 25px 60px rgba(0,0,0,0.5);
margin-bottom:60px;
}

.compare-section h5{
margin-top:40px;
margin-bottom:18px;
font-weight:600;
color:#38bdf8;
border-left:4px solid #38bdf8;
padding-left:10px;
}

.compare-header{
display:grid;
grid-template-columns:1fr 100px 1fr;
align-items:center;
text-align:center;
margin-bottom:40px;
}

.compare-header img{
height:170px;
object-fit:contain;
margin-bottom:15px;
}

.compare-header h6{
font-weight:600;
font-size:18px;
margin-top:10px;
}

.vs{
font-size:32px;
font-weight:700;
color:#ef4444;
letter-spacing:2px;
}

/* ================= TABLE ================= */

.spec-table{
width:100%;
border-collapse:collapse;
margin-bottom:35px;
border-radius:12px;
overflow:hidden;
}

.spec-table th{
background:#1e293b;
color:#cbd5e1;
padding:14px;
text-align:left;
width:30%;
font-weight:500;
}

.spec-table td{
padding:14px;
text-align:center;
border-top:1px solid #334155;
}

.spec-table tr:hover{
background:#1e293b;
transition:0.2s;
}

.highlight{
background:#064e3b;
color:#4ade80;
padding:4px 8px;
border-radius:6px;
font-weight:600;
}

/* ================= POPULAR SECTION ================= */
/* ===== POPULAR GRID ===== */

.popular-grid{
display:grid;
grid-template-columns:repeat(auto-fill,minmax(320px,1fr));
gap:30px;
}

/* ===== CARD ===== */

.popular-card{
background:#ffffff;
border-radius:18px;
padding:25px 20px;
border:1px solid #e5e7eb;
transition:0.3s ease;
display:flex;
flex-direction:column;
align-items:center;
justify-content:center;
gap:20px;
min-height:260px;
}

.popular-card:hover{
transform:translateY(-6px);
box-shadow:0 15px 35px rgba(0,0,0,0.1);
}

/* ===== TOP SECTION ===== */

.popular-top{
display:flex;
align-items:center;
justify-content:center;
gap:25px;
width:100%;
}

.popular-bike{
text-align:center;
flex:1;
}

.popular-bike img{
height:95px;
object-fit:contain;
margin-bottom:8px;
}

.popular-bike p{
font-weight:600;
font-size:15px;
margin:0;
color:#111827;
}

/* ===== VS ===== */

.popular-vs{
font-weight:700;
color:#ef4444;
font-size:18px;
}

/* ===== BUTTON ===== */

.compare-btn{
margin-top:10px;
}

.compare-btn .btn{
background:#111827;
color:#fff;
border-radius:25px;
padding:8px 22px;
font-size:14px;
transition:0.3s;
}

.compare-btn .btn:hover{
background:#06b6d4;
color:#fff;
}

/* ===== RESPONSIVE ===== */

@media(max-width:768px){

.popular-top{
flex-direction:column;
gap:15px;
}

.popular-vs{
font-size:16px;
}

}


/* ================= RESPONSIVE ================= */


/* ================= GLOBAL WRAPPER ================= */

.compare-wrapper{
padding:90px 0;
background:linear-gradient(180deg,#f8fafc 0%,#eef2f7 100%);
min-height:100vh;
}

/* ================= SELECT SECTION ================= */

.select-box{
background:#ffffff;
padding:45px;
border-radius:22px;
box-shadow:0 20px 50px rgba(0,0,0,0.08);
margin-bottom:60px;
}

.select-box h4{
font-weight:700;
font-size:22px;
margin-bottom:30px;
color:#0f172a;
}

.select-grid{
display:grid;
grid-template-columns:1fr 1fr;
gap:30px;
}

.select-grid select{
height:48px;
border-radius:12px;
border:1px solid #e2e8f0;
padding:0 15px;
font-size:15px;
transition:0.2s;
}

.select-grid select:focus{
border-color:#0ea5e9;
box-shadow:0 0 0 3px rgba(14,165,233,0.15);
outline:none;
}

/* Compare Button */

.select-box .btn-danger{
background:#ef4444;
border:none;
padding:10px 35px;
border-radius:30px;
font-weight:600;
transition:0.3s;
}

.select-box .btn-danger:hover{
background:#dc2626;
transform:translateY(-2px);
}

/* ================= DARK COMPARE SECTION ================= */

.compare-section{
background:#0f172a;
color:#e2e8f0;
padding:60px;
border-radius:28px;
box-shadow:0 30px 70px rgba(0,0,0,0.6);
margin-bottom:70px;
}

.compare-header{
display:grid;
grid-template-columns:1fr 120px 1fr;
align-items:center;
text-align:center;
margin-bottom:50px;
}

.compare-header img{
height:180px;
object-fit:contain;
transition:0.3s;
}

.compare-header img:hover{
transform:scale(1.05);
}

.compare-header h6{
font-size:19px;
font-weight:600;
margin-top:15px;
color:#f1f5f9;
}

.vs{
font-size:34px;
font-weight:800;
color:#ef4444;
letter-spacing:3px;
}

/* ================= TABLE DESIGN ================= */

.compare-section h5{
margin-top:45px;
margin-bottom:20px;
font-weight:600;
font-size:18px;
color:#38bdf8;
position:relative;
}

.compare-section h5::after{
content:"";
display:block;
width:40px;
height:3px;
background:#38bdf8;
margin-top:8px;
border-radius:10px;
}

.spec-table{
width:100%;
border-collapse:collapse;
border-radius:16px;
overflow:hidden;
margin-bottom:40px;
background:#1e293b;
}

.spec-table th{
background:#1e293b;
color:#cbd5e1;
padding:16px;
text-align:left;
font-weight:500;
width:30%;
}

.spec-table td{
padding:16px;
text-align:center;
border-top:1px solid #334155;
font-size:14px;
}

.spec-table tr:hover{
background:#273449;
transition:0.2s;
}

.highlight{
background:#064e3b;
color:#4ade80;
padding:6px 10px;
border-radius:8px;
font-weight:600;
}

/* ================= POPULAR SECTION ================= */

.popular-section{
margin-top:60px;
}

.popular-section h4{
font-weight:700;
font-size:22px;
margin-bottom:35px;
color:#0f172a;
}

/* GRID */

.popular-grid{
display:grid;
grid-template-columns:repeat(auto-fill,minmax(340px,1fr));
gap:35px;
}

/* CARD */

.popular-card{
background:#ffffff;
border-radius:24px;
padding:30px 25px;
border:1px solid #e5e7eb;
transition:all 0.3s ease;
display:flex;
flex-direction:column;
align-items:center;
justify-content:center;
gap:25px;
min-height:280px;
position:relative;
overflow:hidden;
}

.popular-card:hover{
transform:translateY(-8px);
box-shadow:0 20px 40px rgba(0,0,0,0.1);
}

/* TOP SECTION */

.popular-top{
display:flex;
align-items:center;
justify-content:space-between;
gap:25px;
width:100%;
}

.popular-bike{
text-align:center;
flex:1;
}

.popular-bike img{
height:110px;
object-fit:contain;
margin-bottom:12px;
transition:0.3s;
}

.popular-card:hover .popular-bike img{
transform:scale(1.05);
}

.popular-bike p{
font-weight:600;
font-size:16px;
margin:0;
color:#111827;
}

/* VS */

.popular-vs{
font-weight:800;
color:#ef4444;
font-size:20px;
}

/* BUTTON */

.compare-btn .btn{
background:#111827;
color:#fff;
border-radius:30px;
padding:9px 28px;
font-size:14px;
font-weight:500;
transition:0.3s;
}

.compare-btn .btn:hover{
background:#0ea5e9;
color:#fff;
transform:translateY(-2px);
}

/* ================= RESPONSIVE ================= */

@media(max-width:992px){

.select-grid{
grid-template-columns:1fr;
}

.compare-header{
grid-template-columns:1fr;
gap:30px;
}

.vs{
display:none;
}

.compare-section{
padding:40px 30px;
}

}

@media(max-width:576px){

.compare-wrapper{
padding:60px 0;
}

.select-box{
padding:30px;
}

.compare-section{
padding:30px 20px;
border-radius:18px;
}

.popular-card{
padding:25px 20px;
}

.popular-top{
flex-direction:column;
gap:15px;
}

.popular-vs{
font-size:18px;
}

}


@media(max-width:992px){
.select-grid{
grid-template-columns:1fr;
}
.compare-header{
grid-template-columns:1fr;
gap:25px;
}
.vs{
display:none;
}
}

@media(max-width:576px){
.compare-section{
padding:30px 20px;
}
.popular-section{
padding:30px 20px;
}
}

</style>

<section class="compare-wrapper">
<div class="container">

<!-- ===== Select Bikes ===== -->

<div class="select-box">
<h4>Select Bikes to Compare</h4>

<div class="select-grid">
<asp:Literal ID="Bike1Select" runat="server"></asp:Literal>
<asp:Literal ID="Bike2Select" runat="server"></asp:Literal>
</div>

<div class="text-center mt-4">
<button runat="server" id="btnCompare" onserverclick="CompareNow"
class="btn btn-danger px-4">
Compare Now
</button>
</div>
</div>

<!-- ===== Compare Result ===== -->

<asp:Panel ID="ComparePanel" runat="server" Visible="false">

<div class="compare-section">

<div class="compare-header">
<asp:Literal ID="Bike1Header" runat="server"></asp:Literal>
<div class="vs">VS</div>
<asp:Literal ID="Bike2Header" runat="server"></asp:Literal>
</div>

<h5>Specifications</h5>
<table class="spec-table">
<tbody>
<asp:Literal ID="SpecRows" runat="server"></asp:Literal>
</tbody>
</table>

<h5>Features</h5>
<table class="spec-table">
<tbody>
<asp:Literal ID="FeatureRows" runat="server"></asp:Literal>
</tbody>
</table>

<h5>Colours</h5>
<table class="spec-table">
<tbody>
<asp:Literal ID="ColourRows" runat="server"></asp:Literal>
</tbody>
</table>

<h5>Images</h5>
<table class="spec-table">
<tbody>
<asp:Literal ID="ImageRows" runat="server"></asp:Literal>
</tbody>
</table>

<h5>Reviews</h5>
<table class="spec-table">
<tbody>
<asp:Literal ID="ReviewRows" runat="server"></asp:Literal>
</tbody>
</table>

</div>

</asp:Panel>

<!-- ===== Popular Comparison ===== -->

<div class="popular-section">
<h4>Popular Bike Comparisons</h4>

<div class="popular-grid">
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

<div class="compare-btn">
<a href='Compare.aspx?b1=<%# Eval("BikeID1") %>&b2=<%# Eval("BikeID2") %>'
class="btn">
Compare Now
</a>
</div>

</div>

</ItemTemplate>
</asp:Repeater>
</div>

</div>

</div>
</section>

</asp:Content>
