<%@ Page Title="Browse Bikes" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="Bikes.aspx.cs"
    Inherits="Client_Bikes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<link href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.7.0/nouislider.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.7.0/nouislider.min.js"></script>

<style>
.bike-wrapper{padding:100px 0;background:#f8fafc;}
.filter-panel{background:white;padding:25px;border-radius:20px;box-shadow:0 10px 30px rgba(0,0,0,0.06);}
.bike-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(280px,1fr));gap:25px;}
.bike-card{background:white;border-radius:20px;overflow:hidden;box-shadow:0 15px 35px rgba(0,0,0,0.08);transition:0.3s;}
.bike-card:hover{transform:translateY(-6px);}
.bike-img{position:relative;}
.bike-img img{width:100%;height:220px;object-fit:cover;}
.card-actions{position:absolute;top:15px;right:15px;display:flex;gap:8px;}
.wishlist{background:white;border-radius:50%;width:36px;height:36px;display:flex;align-items:center;justify-content:center;cursor:pointer;}
.compare-check{width:18px;height:18px;}
.bike-body{padding:20px;}
.price{font-weight:700;}
.sort-box{margin-bottom:20px;}
.compare-bar{
position:fixed;bottom:20px;left:50%;transform:translateX(-50%);
background:#111827;color:white;padding:15px 30px;border-radius:50px;
display:none;align-items:center;gap:20px;box-shadow:0 15px 40px rgba(0,0,0,0.3);
}
.compare-bar button{background:#06b6d4;border:none;padding:8px 20px;border-radius:20px;color:white;}

.view-btn{
display:block;
background:#111827;
color:white;
padding:10px;
border-radius:12px;
text-align:center;
text-decoration:none;
margin-top:12px;
transition:0.3s;
}
.view-btn:hover{
background:#06b6d4;
color:white;
}

</style>

<section class="bike-wrapper">
<div class="container">

<div class="row">

<!-- FILTER -->
<div class="col-lg-3">
<div class="filter-panel">

<h5>Brands</h5>
<div id="brandFilter"></div>

<h5 class="mt-4">Price Range</h5>
<div id="priceSlider"></div>
<div id="priceValue" class="mt-2"></div>

<h5 class="mt-4">Range (KM)</h5>
<select id="rangeFilter" class="form-control">
<option value="">All</option>
<option value="100">Under 100 KM</option>
<option value="150">Under 150 KM</option>
</select>

<button class="btn btn-dark mt-3 w-100" onclick="applyFilters()">Apply Filters</button>

</div>
</div>

<!-- LIST -->
<div class="col-lg-9">

<div class="d-flex justify-content-between align-items-center sort-box">
<h4>All Electric Bikes</h4>
<select id="sortFilter" class="form-control w-auto" onchange="applyFilters()">
<option value="new">Newest</option>
<option value="priceAsc">Price Low → High</option>
<option value="priceDesc">Price High → Low</option>
</select>
</div>

<div id="bikeContainer" class="bike-grid"></div>
<div id="loader" class="text-center mt-4" style="display:none;">Loading...</div>

</div>

</div>
</div>
</section>

<div class="compare-bar" id="compareBar">
<span id="compareCount">2 Selected</span>
<button onclick="goCompare()">Compare Now</button>
</div>


    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    let page=1;
    let loading=false;
    let finished=false;
    let selectedCompare=[];

    let minPrice=0;
    let maxPrice=500000;

    var slider=document.getElementById('priceSlider');
    noUiSlider.create(slider,{
        start:[0,300000],
        connect:true,
        range:{min:0,max:500000}
    });

    slider.noUiSlider.on('update',function(values){
        minPrice=parseInt(values[0]);
        maxPrice=parseInt(values[1]);
        document.getElementById('priceValue').innerHTML=
        "₹"+minPrice+" - ₹"+maxPrice;
    });

    function loadBrands(){
        $.ajax({
            type:"POST",
            url:"/Client/Bikes.aspx/GetBrands",
            contentType:"application/json; charset=utf-8",
            dataType:"json",
            success:function(res){
                $("#brandFilter").html(res.d);
            }
        });

    }

    function loadBikes(reset){
        if(loading||finished)return;
        loading=true;
        $("#loader").show();

        let selectedBrands = [];
        $(".brand-check:checked").each(function(){
            selectedBrands.push($(this).val());
        });

        $.ajax({
            type:"POST",
            url:"/Client/Bikes.aspx/GetBikes",
            data:JSON.stringify({
                page:page,
                minPrice:minPrice,
                maxPrice:maxPrice,
                range:$("#rangeFilter").val(),
                sort:$("#sortFilter").val(),
                brands:selectedBrands
            }),
            contentType:"application/json; charset=utf-8",
            dataType:"json",
            success:function(res){
                let data=res.d;
                if(reset)$("#bikeContainer").html("");
                if(data.count===0){finished=true;$("#loader").hide();return;}
                $("#bikeContainer").append(data.html);
                page++;
                loading=false;
                $("#loader").hide();
            }
        });
    }


    function applyFilters(){
        page=1;
        finished=false;
        loadBikes(true);
    }

    $(document).ready(function(){
        loadBrands();
        loadBikes();
        $(window).scroll(function(){
            if($(window).scrollTop()+$(window).height()>=
            $(document).height()-200){
                loadBikes();
            }
        });
    });

    function toggleCompare(id){
        if(selectedCompare.includes(id)){
            selectedCompare=selectedCompare.filter(x=>x!=id);
        }else{
            if(selectedCompare.length>=2){
                alert("Only 2 bikes allowed");
                return;
            }
            selectedCompare.push(id);
        }
        if(selectedCompare.length==2){
            $("#compareCount").text("2 Bikes Selected");
            $("#compareBar").fadeIn();
        }else{
            $("#compareBar").hide();
        }
    }

    function goCompare(){
        window.location="Compare.aspx?b1="+selectedCompare[0]+"&b2="+selectedCompare[1];
    }

    function addWishlist(id){
        $.ajax({
            type:"POST",
            url:"/Client/Bikes.aspx/AddWishlist",
            data:JSON.stringify({bikeId:id}),
            contentType:"application/json; charset=utf-8",
            dataType:"json",
            success:function(){
                alert("Added to Wishlist");
            }
        });

    }
</script>

</asp:Content>
