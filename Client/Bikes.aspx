<%@ Page Title="Browse Bikes" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="Bikes.aspx.cs"
    Inherits="Client_Bikes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<link href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.7.0/nouislider.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.7.0/nouislider.min.js"></script>

<style>
.bike-wrapper{padding:80px 0;background:#f8fafc;}
.filter-panel{
background:#ffffff;
padding:20px;
border-radius:18px;
box-shadow:0 8px 25px rgba(0,0,0,0.05);
position:sticky;
top:100px;
}

.bike-grid{
display:grid;
grid-template-columns:repeat(auto-fill,minmax(260px,1fr));
gap:25px;
align-items:stretch;
}

.bike-card{
background:#ffffff;
border-radius:16px;
overflow:hidden;
box-shadow:0 10px 25px rgba(0,0,0,0.08);
transition:0.3s;
display:flex;
flex-direction:column;
height:100%;
}

.bike-card:hover{
transform:translateY(-6px);
box-shadow:0 18px 40px rgba(0,0,0,0.15);
}

.bike-img{
position:relative;
}

.bike-img img{
width:100%;
height:220px;
object-fit:cover;
display:block;
}

.wishlist{
position:absolute;
top:12px;
right:12px;
background:white;
width:36px;
height:36px;
border-radius:50%;
display:flex;
align-items:center;
justify-content:center;
cursor:pointer;
font-size:16px;
box-shadow:0 4px 12px rgba(0,0,0,0.15);
}

.wishlist.active{
background:#ef4444;
color:white;
}

.compare-label{
position:relative;
bottom:45px;
width:40%;
left:12px;
background:white;
padding:6px 10px;
border-radius:20px;
font-size:13px;
display:flex;
align-items:center;
gap:6px;
box-shadow:0 4px 12px rgba(0,0,0,0.15);
cursor:pointer;
}

.bike-body{
    margin-top:25px;
padding:18px;
flex-grow:1;
display:flex;
flex-direction:column;
}

.bike-body h6{
font-size:16px;
font-weight:600;
margin-bottom:8px;
line-height:1.4;
color:#111827;
}

.price{
font-size:18px;
font-weight:700;
margin-bottom:6px;
color:#111827;
}

.view-btn{
margin-top:auto;
display:block;
background:#0f172a;
color:white;
padding:10px;
border-radius:10px;
text-align:center;
text-decoration:none;
transition:0.3s;
}

.view-btn:hover{
background:#06b6d4;
color:white;
}

@media (max-width: 991px){
.bike-wrapper{
padding:50px 15px;
}

.filter-panel{
margin-bottom:20px;
}

.bike-grid{
grid-template-columns:repeat(auto-fill,minmax(220px,1fr));
gap:18px;
}
}

@media (max-width: 576px){
.bike-grid{
grid-template-columns:1fr;
}

.bike-img img{
height:200px;
}
}


.compare-bar{position:fixed;bottom:20px;left:50%;transform:translateX(-50%);background:#111827;color:white;padding:12px 25px;border-radius:40px;display:none;}
.compare-bar button{background:#06b6d4;border:none;padding:6px 15px;border-radius:20px;color:white;}
</style>

<section class="bike-wrapper">
<div class="container">
<div class="row">

<div class="col-lg-3">
<div class="filter-panel">
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

<button class="btn btn-dark mt-3 w-100" onclick="applyFilters(); return false;">Apply</button>

</div>
</div>

<div class="col-lg-9">
<div class="d-flex justify-content-between mb-3">
<h4>All Electric Bikes</h4>
<select id="sortFilter" class="form-control w-auto" onchange="applyFilters()">
<option value="new">Newest</option>
<option value="priceAsc">Price Low → High</option>
<option value="priceDesc">Price High → Low</option>
</select>
</div>

<div id="bikeContainer" class="bike-grid"></div>
<div id="loader" class="text-center mt-3" style="display:none;">Loading...</div>
</div>

</div>
</div>
</section>

<div class="compare-bar" id="compareBar">
<span>2 Bikes Selected</span>
<button onclick="goCompare()">Compare</button>
</div>

<script>
    let page=1,loading=false,finished=false;
    let selectedCompare=[];
    let minPrice=0,maxPrice=500000;

    noUiSlider.create(document.getElementById('priceSlider'),{
        start:[0,300000],connect:true,range:{min:0,max:500000}
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
            success:function(res){$("#brandFilter").html(res.d);}
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
            data:JSON.stringify({page:page,minPrice:minPrice,maxPrice:maxPrice,range:$("#rangeFilter").val(),sort:$("#sortFilter").val(),brands:brands}),
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
        page=1;
        finished=false;
        $("#bikeContainer").html("");
        loadBikes(true);
    }


    $(document).ready(function(){
        loadBrands();loadBikes();
        $(window).scroll(function(){
            if($(window).scrollTop()+$(window).height()>=$(document).height()-150){
                loadBikes();
            }});
    });

    function toggleCompare(id){
        if(selectedCompare.includes(id))
            selectedCompare=selectedCompare.filter(x=>x!=id);
        else{
            if(selectedCompare.length>=2){alert("Max 2");return;}
            selectedCompare.push(id);
        }
        if(selectedCompare.length==2)$("#compareBar").fadeIn();
        else $("#compareBar").hide();
    }

    function goCompare(){
        window.location="Compare.aspx?b1="+selectedCompare[0]+"&b2="+selectedCompare[1];
    }

    function addWishlist(el,id){
        $.ajax({
            type:"POST",
            url:"/Client/Bikes.aspx/AddWishlist",
            data:JSON.stringify({bikeId:id}),
            contentType:"application/json; charset=utf-8",
            dataType:"json",
            success:function(){$(el).toggleClass("active");}
        });
    }
</script>

</asp:Content>
