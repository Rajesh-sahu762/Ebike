<%@ Page Title="Used Bikes" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true" CodeFile="UsedBikes.aspx.cs"
Inherits="Client_UsedBikes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>

.bike-wrapper{
padding:70px 0;
background:#f4f6f9;
min-height:100vh;
}

.bike-layout{
display:flex;
gap:25px;
}

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
cursor:pointer;
}

.wishlist.active{
background:#ef4444;
color:#fff;
}

.bike-body{
padding:15px;
display:flex;
flex-direction:column;
flex-grow:1;
}

.price{
font-weight:700;
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

.wishlist{
position:absolute;
top:10px;
right:10px;
width:34px;
height:34px;
border-radius:50%;
background:#fff;
display:flex;
align-items:center;
justify-content:center;
cursor:pointer;
font-size:16px;
box-shadow:0 4px 12px rgba(0,0,0,0.15);
}

.wishlist.active{
background:#ef4444;
color:#fff;
}

</style>

<section class="bike-wrapper">

<div class="container">

<h4 class="mb-4">Used Electric Bikes</h4>

<div class="bike-layout">

<!-- FILTERS -->

<div class="sidebar">

<label>Search</label>
<input type="text" id="txtSearch" class="form-control mb-2">

<label>Max Price</label>
<input type="number" id="txtPrice" class="form-control mb-2">

<label>Max KM</label>
<input type="number" id="txtKM" class="form-control mb-2">

<label>Owner</label>
<select id="ddlOwner" class="form-control mb-3">
<option value="">All</option>
<option value="1">First Owner</option>
<option value="2">Second Owner</option>
<option value="3">Third Owner</option>
</select>

<button class="btn btn-dark w-100"
onclick="applyFilters()">Apply</button>

</div>

<!-- GRID -->

<div class="content-area">

<div id="bikeContainer" class="bike-grid"></div>

<div id="loader" class="text-center mt-3" style="display:none;">
Loading...
</div>

</div>

</div>

</div>

</section>




<script>

    let page=1;
    let loading=false;
    let finished=false;

    function loadBikes(reset){

        if(loading || finished) return;

        loading=true;
        $("#loader").show();

        $.ajax({

            type:"POST",
            url:"/Client/UsedBikes.aspx/GetUsedBikes",

            data: JSON.stringify({

                page:page,
                search:$("#txtSearch").val(),
                price:$("#txtPrice").val(),
                km:$("#txtKM").val(),
                owner:$("#ddlOwner").val()

            }),

            contentType:"application/json; charset=utf-8",
            dataType:"json",

            success:function(res){

                let d=res.d;

                if(reset) $("#bikeContainer").html("");

                if(d.count==0){

                    finished=true;
                    $("#loader").hide();
                    return;

                }

                $("#bikeContainer").append(d.html);

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

        loadBikes();

        $(window).scroll(function(){

            if($(window).scrollTop()+$(window).height()>=
            $(document).height()-150){

                loadBikes();

            }

        });

    });

    function toggleWishlist(el, id) {

        $.ajax({

            type: "POST",
            url: "/Client/Bikes.aspx/ToggleWishlist",

            data: JSON.stringify({ bikeId: id }),

            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (res) {

                if (res.d === "login") {

                    alert("Please login first");
                    window.location.href = "ClientLogin.aspx";
                    return;

                }

                if (res.d === "added") {

                    $(el).addClass("active");

                }
                else {

                    $(el).removeClass("active");

                }

                refreshWishlistCount();

            }

        });

    }

</script>

</asp:Content>