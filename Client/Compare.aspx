<%@ Page Title="Compare Bikes" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="Compare.aspx.cs"
    Inherits="Compare" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>

/* ========== TOP ADD BIKE SECTION ========== */

.compare-top{
background:#fff;
padding:40px;
border-radius:18px;
box-shadow:0 8px 30px rgba(0,0,0,0.06);
margin-bottom:40px;
}

.add-bike-grid{
display:grid;
grid-template-columns:1fr 1fr;
gap:30px;
}

.add-bike-card{
border:2px dashed #e5e7eb;
border-radius:16px;
padding:40px;
text-align:center;
cursor:pointer;
transition:0.3s;
}

.add-bike-card:hover{
border-color:#111827;
}

/* ========== DARK COMPARE SECTION ========== */

.compare-dark{
background:#0f172a;
color:#fff;
padding:40px;
border-radius:20px;
margin-bottom:50px;
}

.compare-header{
display:grid;
grid-template-columns:1fr 80px 1fr;
align-items:center;
gap:20px;
margin-bottom:30px;
}

.compare-bike{
text-align:center;
}

.compare-bike img{
height:180px;
object-fit:contain;
}

.vs-circle{
width:70px;
height:70px;
border-radius:50%;
background:#111827;
display:flex;
align-items:center;
justify-content:center;
font-weight:bold;
}

/* ========== TABS ========== */

.compare-tabs{
display:flex;
gap:30px;
border-bottom:1px solid #334155;
margin-bottom:25px;
}

.compare-tabs div{
cursor:pointer;
padding-bottom:10px;
}

.compare-tabs .active{
border-bottom:3px solid #06b6d4;
}

/* ========== SPEC TABLE ========== */

.spec-table{
width:100%;
border-collapse:collapse;
}

.spec-table th{
text-align:left;
padding:14px;
background:#1e293b;
}

.spec-table td{
padding:14px;
text-align:center;
border-top:1px solid #334155;
}

.highlight{
background:#0ea5e9;
}

/* ========== POPULAR SECTION ========== */

.popular-section{
background:#fff;
padding:40px;
border-radius:18px;
box-shadow:0 8px 25px rgba(0,0,0,0.06);
}

.popular-grid{
display:grid;
grid-template-columns:repeat(auto-fill,minmax(300px,1fr));
gap:25px;
}

.popular-card{
background:#fafafa;
border-radius:14px;
padding:20px;
text-align:center;
}

.tab-content{
display:none;
opacity:0;
transition:opacity 0.3s ease;
}

.tab-content.active{
display:block;
opacity:1;
}


@media(max-width:768px){
.add-bike-grid{grid-template-columns:1fr;}
.compare-header{grid-template-columns:1fr;}
}

</style>

<!-- ================= TOP SECTION ================= -->

<div class="compare-top">
<h4>Select Bikes to Compare</h4>

<div class="add-bike-grid">
<asp:Literal ID="Bike1Select" runat="server"></asp:Literal>
<asp:Literal ID="Bike2Select" runat="server"></asp:Literal>
</div>

<div class="text-center mt-4">
<button runat="server" id="btnCompare" onserverclick="CompareNow"
class="btn btn-danger px-5 py-2">
Compare Now
</button>
</div>
</div>

<!-- ================= DARK COMPARE RESULT ================= -->

<asp:Panel ID="ComparePanel" runat="server" Visible="false">

<div class="compare-dark">

<div class="compare-header">

<div class="compare-bike">
<asp:Literal ID="Bike1Header" runat="server"></asp:Literal>
</div>

<div class="vs-circle">VS</div>

<div class="compare-bike">
<asp:Literal ID="Bike2Header" runat="server"></asp:Literal>
</div>

</div>

<div class="compare-tabs">
<div class="tab active" data-tab="spec">Specifications</div>
<div class="tab" data-tab="features">Features</div>
<div class="tab" data-tab="colours">Colours</div>
<div class="tab" data-tab="reviews">Reviews</div>
<div class="tab" data-tab="images">Images</div>
</div>


<div id="tabContent">
<table class="spec-table">
<tbody id="tabBody">

<tr>
<th>Price</th>
<asp:Literal ID="PriceRow" runat="server"></asp:Literal>
</tr>

<tr>
<th>Range</th>
<asp:Literal ID="RangeRow" runat="server"></asp:Literal>
</tr>

<tr>
<th>Top Speed</th>
<asp:Literal ID="SpeedRow" runat="server"></asp:Literal>
</tr>

<tr>
<th>Motor Power</th>
<asp:Literal ID="MotorRow" runat="server"></asp:Literal>
</tr>

<tr>
<th>Battery Type</th>
<asp:Literal ID="BatteryRow" runat="server"></asp:Literal>
</tr>

</tbody>
</table>

</div>
    <div style="margin-bottom:15px;">
<label>
<input type="checkbox" id="hideCommon" />
Hide Common Features
</label>
</div>

</div>

</asp:Panel>

<!-- ================= POPULAR ================= -->

<div class="popular-section">
<h4>Popular Bikes Comparison</h4>

<div class="popular-grid">
<asp:Repeater ID="rptPopular" runat="server">
<ItemTemplate>
<div class="popular-card">
<img src='/Uploads/Bikes/<%# Eval("Image1") %>' height="150" />
<h6 class="mt-3"><%# Eval("ModelName") %></h6>
<a href='Compare.aspx?b1=<%# Eval("BikeID") %>&b2=1'
class="btn btn-dark btn-sm mt-2">Compare</a>
</div>
</ItemTemplate>
</asp:Repeater>
</div>

</div>


<script>

    document.getElementById("hideCommon").addEventListener("change", function(){

        let rows = document.querySelectorAll(".spec-table tbody tr");

        rows.forEach(function(row){

            let cols = row.querySelectorAll("td");

            if(cols.length === 2){
                if(cols[0].innerText === cols[1].innerText){
                    row.style.display = "none";
                } else {
                    row.style.display = "";
                }
            }

        });

    });


    var b1 = "<%= Request.QueryString["b1"] %>";
    var b2 = "<%= Request.QueryString["b2"] %>";

    document.querySelectorAll(".tab").forEach(function(tab){

        tab.addEventListener("click", function(){

            document.querySelectorAll(".tab").forEach(t=>t.classList.remove("active"));
            tab.classList.add("active");

            let tabName = tab.getAttribute("data-tab");

            if(tabName === "spec"){
                // reload page spec data
                location.reload();
                return;
            }

            $.ajax({
                type: "POST",
                url: "Compare.aspx/LoadTabData",
                data: JSON.stringify({ tab: tabName, b1: b1, b2: b2 }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(res){
                    $("#tabBody").html(res.d);
                }
            });

        });

    });


    let table = document.querySelector(".spec-table");

    if(table){
        table.addEventListener("scroll", function(){
            document.querySelectorAll(".spec-table").forEach(function(t){
                if(t !== table){
                    t.scrollTop = table.scrollTop;
                }
            });
        });
    }


</script>




</asp:Content>
