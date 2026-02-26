<%@ Page Title="Browse Bikes" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="Bikes.aspx.cs"
    Inherits="Client_Bikes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<link href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.7.0/nouislider.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.7.0/nouislider.min.js"></script>

<style>

/* ===== Layout ===== */

.bike-wrapper{
padding:70px 0;
background:#f4f6f9;
min-height:100vh;
}

.bike-layout{
display:flex;
gap:25px;
}

/* ===== Sidebar ===== */

.sidebar{
width:260px;
background:#fff;
padding:20px;
border-radius:14px;
box-shadow:0 6px 18px rgba(0,0,0,0.06);
position:sticky;
top:100px;
height:fit-content;
}

.content-area{
flex:1;
}

/* ===== Cards ===== */

.bike-grid{
display:grid;
grid-template-columns:repeat(auto-fill,minmax(250px,1fr));
gap:20px;
}

.bike-card{
background:#fff;
border-radius:14px;
overflow:hidden;
box-shadow:0 6px 18px rgba(0,0,0,0.08);
display:flex;
flex-direction:column;
transition:0.3s;
}

.bike-card:hover{
transform:translateY(-4px);
box-shadow:0 12px 30px rgba(0,0,0,0.15);
}

.bike-img{
position:relative;
}

.bike-img img{
width:100%;
height:200px;
object-fit:cover;
}

.wishlist{
position:absolute;
top:10px;
right:10px;
width:32px;
height:32px;
border-radius:50%;
background:#fff;
display:flex;
align-items:center;
justify-content:center;
box-shadow:0 4px 12px rgba(0,0,0,0.15);
cursor:pointer;
}

.wishlist.active{
background:#ef4444;
color:#fff;
}

.compare-label{
position:absolute;
bottom:10px;
left:1px;
background:#fff;
padding:4px 10px;
border-radius:20px;
font-size:12px;
display:flex;
align-items:center;
gap:6px;
box-shadow:0 4px 12px rgba(0,0,0,0.1);
}

.bike-body{
margin-top: 10px;
padding:15px;
display:flex;
flex-direction:column;
flex-grow:1;
}

.bike-body h6{
font-size:15px;
font-weight:600;
margin-bottom:6px;
}

.price{
font-size:16px;
font-weight:700;
margin-bottom:4px;
}

.view-btn{
margin-top:auto;
background:#111827;
color:#fff;
padding:8px;
border-radius:8px;
text-align:center;
text-decoration:none;
}

.view-btn:hover{
background:#06b6d4;
}

/* ===== Compare Bar ===== */

.compare-bar{
position:fixed;
bottom:90px;
left:50%;
transform:translateX(-50%);
background:#111827;
color:#fff;
padding:10px 25px;
border-radius:40px;
display:none;
z-index:999;
}

/* ===== Mobile ===== */

.mobile-filter-btn{
display:none;
}

.mobile-filter-drawer{
position:fixed;
top:0;
right:-100%;
width:80%;
height:100%;
background:#fff;
z-index:2000;
box-shadow:-5px 0 20px rgba(0,0,0,0.2);
transition:0.3s;
padding:20px;
overflow-y:auto;
}

.mobile-filter-drawer.active{
right:0;
}

.drawer-header{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:20px;
}

.drawer-close{
cursor:pointer;
font-size:20px;
}

.compare-bar{
position:fixed;
bottom:30px;
left:50%;
transform:translateX(-50%);
background:#111827;
color:#fff;
padding:12px 25px;
border-radius:40px;
display:none;
z-index:9999;
display:flex;
align-items:center;
gap:15px;
box-shadow:0 10px 30px rgba(0,0,0,0.25);
}

.compare-btn{
background:#06b6d4;
border:none;
padding:8px 18px;
border-radius:20px;
color:#fff;
font-weight:600;
cursor:pointer;
}

.compare-btn:hover{
background:#0891b2;
}


@media(max-width:992px){

.bike-layout{
flex-direction:column;
}

.sidebar{
display:none;
}

.mobile-filter-btn{
display:inline-block;
background:#111827;
color:#fff;
padding:8px 15px;
border-radius:8px;
cursor:pointer;
}

.compare-bar{
bottom:70px;
}

}

</style>

    <asp:HiddenField ID="hfSearch" runat="server" />

    <section class="bike-wrapper">
<div class="container">

<div class="d-flex justify-content-between align-items-center mb-4">
<h4>All Electric Bikes</h4>

<div class="d-flex gap-2">
<select id="sortFilter" class="form-control" onchange="applyFilters()">
<option value="new">Newest</option>
<option value="priceAsc">Price Low → High</option>
<option value="priceDesc">Price High → Low</option>
</select>

<div class="mobile-filter-btn d-lg-none" onclick="toggleMobileFilter()">
Filters
</div>
</div>
</div>

<div class="bike-layout">

<!-- Desktop Sidebar -->
<div class="sidebar">
<h6>Brands</h6>
<div id="brandFilter"></div>

<h6 class="mt-3">Price</h6>
<div id="priceSlider"></div>
<div id="priceValue" class="mt-2"></div>

<h6 class="mt-3">Range</h6>
<select id="rangeFilter" class="form-control">
<option value="">All</option>
<option value="100">Under 100 KM</option>
<option value="150">Under 150 KM</option>
</select>

<button class="btn btn-dark mt-3 w-100" onclick="applyFilters();return false;">
Apply
</button>
</div>

<!-- Content -->
<div class="content-area">
<div id="bikeContainer" class="bike-grid"></div>
<div id="loader" class="text-center mt-3" style="display:none;">Loading...</div>
</div>

</div>
</div>
</section>

<!-- Mobile Drawer -->
<div class="mobile-filter-drawer" id="mobileFilterDrawer">
<div class="drawer-header">
<h5>Filters</h5>
<div class="drawer-close" onclick="toggleMobileFilter()">✕</div>
</div>

<div id="brandFilterMobile"></div>

<select id="rangeFilterMobile" class="form-control mt-3">
<option value="">All</option>
<option value="100">Under 100 KM</option>
<option value="150">Under 150 KM</option>
</select>

<button class="btn btn-dark mt-3 w-100" onclick="applyMobileFilters()">
Apply Filters
</button>
</div>

<div class="compare-bar" id="compareBar">
<span id="compareText">2 Bikes Selected</span>
<button type="button" onclick="goCompare()" class="compare-btn">
    Compare Now
</button>

</div>


<script>

    let page=1,loading=false,finished=false;
    let minPrice=0,maxPrice=500000;

    noUiSlider.create(document.getElementById('priceSlider'),{
        start:[0,300000],
        connect:true,
        range:{min:0,max:500000}
    }).on('update',function(v){
        minPrice=parseInt(v[0]);
        maxPrice=parseInt(v[1]);
        $("#priceValue").text("₹"+minPrice+" - ₹"+maxPrice);
    });

    function loadBrands(){
        $.ajax({
            type:"POST",
            url:"/Client/Bikes.aspx/GetBrands",
            contentType:"application/json; charset=utf-8",
            dataType:"json",
            success:function(res){
                $("#brandFilter").html(res.d);
                $("#brandFilterMobile").html(res.d);
            }
        });
    }

    function loadBikes(reset){
        if(loading||finished)return;
        loading=true;$("#loader").show();

        let brands=[];
        $(".brand-check:checked").each(function(){brands.push($(this).val());});

        $.ajax({
            type:"POST",
            url:"/Client/Bikes.aspx/GetBikes",
            data: JSON.stringify({
                page:page,
                minPrice:minPrice,
                maxPrice:maxPrice,
                range:$("#rangeFilter").val(),
                sort:$("#sortFilter").val(),
                brands:brands,
                search: $("#<%= hfSearch.ClientID %>").val()
           }),
            contentType:"application/json; charset=utf-8",
            dataType:"json",
            success:function(res){
                let d=res.d;
                if(reset)$("#bikeContainer").html("");
                if(d.count==0){finished=true;$("#loader").hide();return;}
                $("#bikeContainer").append(d.html);
                page++;loading=false;$("#loader").hide();
            }
        });
    }

    function applyFilters(){
        page=1;finished=false;
        $("#bikeContainer").html("");
        loadBikes(true);
    }

    function toggleMobileFilter(){
        $("#mobileFilterDrawer").toggleClass("active");
    }

    function applyMobileFilters(){
        $("#rangeFilter").val($("#rangeFilterMobile").val());
        applyFilters();
        toggleMobileFilter();
    }

    $(document).ready(function(){
        loadBrands();
        loadBikes();
        $(window).scroll(function(){
            if($(window).scrollTop()+$(window).height()>=$(document).height()-150){
                loadBikes();
            }
        });
    });

    let selectedCompare = [];

    function toggleCompare(el, id) {

        if (el.checked) {

            if (selectedCompare.length >= 2) {
                alert("Only 2 bikes allowed");
                el.checked = false;
                return;
            }

            selectedCompare.push(id);

        } else {

            selectedCompare = selectedCompare.filter(x => x != id);

        }

        if (selectedCompare.length === 2) {
            $("#compareBar").fadeIn();
        } else {
            $("#compareBar").fadeOut();
        }
    }

    function goCompare() {

        if (selectedCompare.length !== 2) {
            alert("Select 2 bikes first");
            return;
        }

        window.location.href =
            "Compare.aspx?b1=" + selectedCompare[0] +
            "&b2=" + selectedCompare[1];
    }


    function toggleWishlist(el, id) {

        $.ajax({
            type: "POST",
            url: "/Client/Bikes.aspx/ToggleWishlist",
            data: JSON.stringify({ bikeId: id }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (res) {

                if (res.d === "added") {
                    $(el).addClass("active");
                }
                else {
                    $(el).removeClass("active");
                }
            }
        });
    }


</script>

</asp:Content>
