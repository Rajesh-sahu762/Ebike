<%@ Page Title="Browse Bikes" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
    AutoEventWireup="true" CodeFile="~/Client/Rental.aspx.cs"
    Inherits="Client_Rental" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<link href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.7.0/nouislider.min.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.7.0/nouislider.min.js"></script>

<style>
/* ===== Electric Pulse - Rental Bikes Catalog ===== */
.bike-wrapper {
    padding: 40px 0 80px;
    background: var(--ep-bg, #F4F8FC);
    min-height: 100vh;
    font-family: var(--font-body, 'Inter', sans-serif);
}

.bike-header-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 28px;
    flex-wrap: wrap;
    gap: 16px;
}

.bike-header-title {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-size: 26px;
    font-weight: 800;
    color: var(--ep-heading, #0F172A);
    margin: 0;
    display: flex;
    align-items: center;
    gap: 10px;
}

.bike-header-title .accent-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: var(--ep-brand-orange, #F97316);
    box-shadow: 0 0 10px var(--ep-brand-orange, #F97316);
    display: inline-block;
}

.bike-header-sub {
    font-size: 14px;
    color: var(--ep-text-muted, #64748B);
    margin-top: 4px;
}

.bike-sort-select {
    background: #FFFFFF;
    border: 1.5px solid var(--ep-border, #E2E8F0);
    border-radius: 10px;
    padding: 10px 16px;
    font-size: 14px;
    font-weight: 600;
    color: var(--ep-text, #334155);
    font-family: var(--font-body, 'Inter', sans-serif);
    outline: none;
    cursor: pointer;
    transition: var(--transition-fast, all 0.2s ease);
    box-shadow: 0 2px 6px rgba(7, 26, 47, 0.03);
}

.bike-sort-select:focus {
    border-color: var(--ep-secondary-cyan, #0891B2);
    box-shadow: 0 0 0 3px rgba(8, 145, 178, 0.15);
}

.bike-layout {
    display: flex;
    gap: 28px;
    align-items: flex-start;
}

/* ===== Modern Sidebar Filter ===== */
.sidebar {
    width: 280px;
    flex-shrink: 0;
    background: #FFFFFF;
    padding: 24px;
    border-radius: 18px;
    border: 1px solid var(--ep-border, #E2E8F0);
    box-shadow: 0 4px 20px rgba(7, 26, 47, 0.04);
    position: sticky;
    top: 96px;
    height: fit-content;
}

.sidebar-title {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-size: 13px;
    font-weight: 800;
    color: var(--ep-heading, #0F172A);
    text-transform: uppercase;
    letter-spacing: 0.8px;
    margin-bottom: 12px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.sidebar-title i {
    color: var(--ep-secondary-cyan, #0891B2);
}

.filter-divider {
    height: 1px;
    background: var(--ep-border, #E2E8F0);
    margin: 20px 0;
}

.brand-scroll {
    max-height: 190px;
    overflow-y: auto;
    padding-right: 6px;
}

.brand-scroll::-webkit-scrollbar {
    width: 4px;
}

.brand-scroll::-webkit-scrollbar-thumb {
    background: #CBD5E1;
    border-radius: 4px;
}

#brandFilter div, #brandFilterMobile div {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 6px 8px;
    border-radius: 8px;
    font-size: 14px;
    color: var(--ep-text, #334155);
    transition: background 0.15s ease;
    cursor: pointer;
}

#brandFilter div:hover, #brandFilterMobile div:hover {
    background: #F8FAFC;
    color: var(--ep-secondary-cyan, #0891B2);
}

#brandFilter input[type="checkbox"], #brandFilterMobile input[type="checkbox"] {
    width: 16px;
    height: 16px;
    accent-color: var(--ep-secondary-cyan, #0891B2);
    cursor: pointer;
}

.price-range-badge {
    background: #F8FAFC;
    border: 1px solid var(--ep-border, #E2E8F0);
    border-radius: 8px;
    padding: 8px 12px;
    font-size: 13px;
    font-weight: 700;
    color: var(--ep-primary-navy, #071A2F);
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    text-align: center;
    margin-top: 10px;
}

/* noUiSlider Custom Styling */
.noUi-target {
    background: #E2E8F0;
    border: none;
    border-radius: 6px;
    box-shadow: none;
    height: 6px;
}

.noUi-connect {
    background: linear-gradient(90deg, var(--ep-secondary-cyan, #0891B2), var(--ep-accent-cyan, #22D3EE));
}

.noUi-handle {
    border: 2.5px solid var(--ep-secondary-cyan, #0891B2) !important;
    border-radius: 50% !important;
    background: #FFFFFF !important;
    box-shadow: 0 2px 8px rgba(7, 26, 47, 0.2) !important;
    cursor: grab !important;
    width: 18px !important;
    height: 18px !important;
    top: -6px !important;
    right: -9px !important;
}

.noUi-handle:before, .noUi-handle:after {
    display: none !important;
}

.btn-filter-apply {
    background: var(--ep-primary-navy, #071A2F);
    color: #FFFFFF;
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-weight: 700;
    font-size: 14px;
    padding: 12px 20px;
    border-radius: 10px;
    border: none;
    width: 100%;
    margin-top: 20px;
    cursor: pointer;
    transition: all 0.25s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

.btn-filter-apply:hover {
    background: var(--ep-secondary-cyan, #0891B2);
    box-shadow: 0 6px 18px rgba(8, 145, 178, 0.35);
    transform: translateY(-2px);
    color: #FFFFFF;
}

/* ===== Bike Grid & Cards ===== */
.content-area {
    flex: 1;
    min-width: 0;
}

.bike-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 24px;
}

.bike-card {
    background: #FFFFFF;
    border-radius: 18px;
    border: 1px solid var(--ep-border, #E2E8F0);
    overflow: hidden;
    box-shadow: 0 4px 16px rgba(7, 26, 47, 0.04);
    display: flex;
    flex-direction: column;
    transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
    position: relative;
}

.bike-card:hover {
    transform: translateY(-6px);
    border-color: var(--ep-accent-cyan, #22D3EE);
    box-shadow: 0 16px 36px rgba(7, 26, 47, 0.1);
}

.bike-img {
    position: relative;
    background: #F8FAFC;
    height: 200px;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 16px;
}

.bike-img img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    transition: transform 0.4s ease;
}

.bike-card:hover .bike-img img {
    transform: scale(1.06);
}

.wishlist {
    position: absolute;
    top: 12px;
    right: 12px;
    width: 34px;
    height: 34px;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(4px);
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 3px 10px rgba(7, 26, 47, 0.12);
    cursor: pointer;
    font-size: 16px;
    color: var(--ep-text-muted, #64748B);
    transition: all 0.2s ease;
    z-index: 2;
}

.wishlist:hover {
    color: #EF4444;
    transform: scale(1.1);
}

.wishlist.active {
    background: #EF4444;
    color: #FFFFFF;
}

.compare-label {
    position: absolute;
    bottom: 12px;
    left: 12px;
    background: rgba(255, 255, 255, 0.92);
    backdrop-filter: blur(6px);
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: 700;
    color: var(--ep-text, #334155);
    display: flex;
    align-items: center;
    gap: 6px;
    box-shadow: 0 2px 8px rgba(7, 26, 47, 0.08);
    border: 1px solid var(--ep-border, #E2E8F0);
    user-select: none;
    cursor: pointer;
}

.compare-label input[type="checkbox"] {
    accent-color: var(--ep-secondary-cyan, #0891B2);
    cursor: pointer;
}

.bike-body {
    padding: 18px;
    display: flex;
    flex-direction: column;
    flex-grow: 1;
}

.bike-body h6 {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-size: 16px;
    font-weight: 700;
    color: var(--ep-heading, #0F172A);
    margin-bottom: 8px;
    line-height: 1.35;
}

.price {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-size: 18px;
    font-weight: 800;
    color: var(--ep-primary-navy, #071A2F);
    margin-bottom: 8px;
}

.bike-body div {
    font-size: 13px;
    color: var(--ep-text-muted, #64748B);
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 6px;
    margin-bottom: 14px;
}

.view-btn {
    margin-top: auto;
    background: var(--ep-primary-navy, #071A2F);
    color: #FFFFFF !important;
    padding: 10px 16px;
    border-radius: 10px;
    text-align: center;
    text-decoration: none;
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-weight: 700;
    font-size: 13px;
    transition: all 0.25s ease;
    display: block;
}

.view-btn:hover {
    background: linear-gradient(135deg, var(--ep-brand-orange, #F97316), #EA580C);
    color: #FFFFFF !important;
    box-shadow: 0 6px 16px rgba(249, 115, 22, 0.35);
    transform: translateY(-2px);
}

/* ===== Floating Compare Bar ===== */
.compare-bar {
    position: fixed;
    bottom: 30px;
    left: 50%;
    transform: translateX(-50%);
    background: var(--ep-primary-navy, #071A2F);
    border: 1px solid rgba(34, 211, 238, 0.3);
    color: #FFFFFF;
    padding: 12px 28px;
    border-radius: 50px;
    display: none;
    z-index: 9999;
    align-items: center;
    gap: 18px;
    box-shadow: 0 14px 40px rgba(7, 26, 47, 0.45);
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-size: 14px;
    font-weight: 700;
    backdrop-filter: blur(10px);
}

.compare-btn {
    background: linear-gradient(135deg, var(--ep-brand-orange, #F97316), #EA580C);
    border: none;
    padding: 8px 22px;
    border-radius: 30px;
    color: #FFFFFF;
    font-weight: 700;
    font-size: 13px;
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    cursor: pointer;
    transition: all 0.2s ease;
    box-shadow: 0 4px 14px rgba(249, 115, 22, 0.35);
}

.compare-btn:hover {
    background: linear-gradient(135deg, #FB923C, var(--ep-brand-orange, #F97316));
    transform: translateY(-1px);
    box-shadow: 0 6px 20px rgba(249, 115, 22, 0.5);
}

/* ===== Mobile Filter Controls ===== */
.mobile-filter-btn {
    display: none;
    background: var(--ep-primary-navy, #071A2F);
    color: #FFFFFF;
    padding: 10px 18px;
    border-radius: 10px;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    transition: all 0.2s ease;
}

.mobile-filter-btn:hover {
    background: var(--ep-secondary-cyan, #0891B2);
}

.mobile-filter-drawer {
    position: fixed;
    top: 0;
    right: -100%;
    width: 320px;
    max-width: 85%;
    height: 100%;
    background: #FFFFFF;
    z-index: 2000;
    box-shadow: -8px 0 30px rgba(7, 26, 47, 0.2);
    transition: right 0.3s cubic-bezier(0.16, 1, 0.3, 1);
    padding: 24px;
    overflow-y: auto;
}

.mobile-filter-drawer.active {
    right: 0;
}

.drawer-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 16px;
    margin-bottom: 20px;
    border-bottom: 1px solid var(--ep-border, #E2E8F0);
}

.drawer-header h5 {
    font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
    font-weight: 800;
    font-size: 18px;
    color: var(--ep-heading, #0F172A);
    margin: 0;
}

.drawer-close {
    cursor: pointer;
    width: 32px;
    height: 32px;
    border-radius: 50%;
    background: #F1F5F9;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    color: var(--ep-text, #334155);
    transition: background 0.2s ease;
}

.drawer-close:hover {
    background: #E2E8F0;
}

@media(max-width: 992px) {
    .bike-layout {
        flex-direction: column;
    }
    .sidebar {
        display: none;
    }
    .mobile-filter-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }
    .compare-bar {
        bottom: 75px;
    }
}
</style>

<asp:HiddenField ID="hfSearch" runat="server" />
<asp:HiddenField ID="hfDealer" runat="server" />

<section class="bike-wrapper">
    <div class="container">
        <!-- Top bar / Hero header -->
        <div class="bike-header-bar">
            <div>
                <span class="badge-ep badge-ep-orange mb-2">⚡ FLEXIBLE MOBILITY</span>
                <h1 class="bike-header-title">
                    Electric Bikes for Rent <span class="accent-dot"></span>
                </h1>
                <p class="bike-header-sub">Rent top-rated electric bikes on daily, weekly, or monthly flexible plans.</p>
            </div>

            <div class="d-flex align-items-center gap-2">
                <select id="sortFilter" class="bike-sort-select" onchange="applyFilters()">
                    <option value="new">⚡ Newest Rentals</option>
                    <option value="priceAsc">Rent: Low → High</option>
                    <option value="priceDesc">Rent: High → Low</option>
                </select>

                <div class="mobile-filter-btn" onclick="toggleMobileFilter()">
                    <i class="fas fa-sliders-h"></i> Filters
                </div>
            </div>
        </div>

        <div class="bike-layout">
            <!-- Desktop Sidebar -->
            <div class="sidebar">
                <div class="sidebar-title">
                    <span>Brands</span>
                    <i class="fas fa-tag"></i>
                </div>
                <div id="brandFilter" class="brand-scroll"></div>

                <div class="filter-divider"></div>

                <div class="sidebar-title">
                    <span>Price Range</span>
                    <i class="fas fa-indian-rupee-sign"></i>
                </div>
                <div id="priceSlider"></div>
                <div id="priceValue" class="price-range-badge">₹0 - ₹5,00,000</div>

                <div class="filter-divider"></div>

                <div class="sidebar-title">
                    <span>Max Range</span>
                    <i class="fas fa-battery-three-quarters"></i>
                </div>
                <select id="rangeFilter" class="bike-sort-select w-100">
                    <option value="">All Ranges</option>
                    <option value="100">Under 100 KM</option>
                    <option value="150">Under 150 KM</option>
                </select>

                <button class="btn-filter-apply" onclick="applyFilters();return false;">
                    <i class="fas fa-filter"></i> Apply Filters
                </button>
            </div>

            <!-- Content Area -->
            <div class="content-area">
                <div id="bikeContainer" class="bike-grid"></div>
                <div id="loader" class="text-center py-5" style="display:none;">
                    <div class="spinner-border text-warning" role="status" style="width: 2.2rem; height: 2.2rem;">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="text-muted mt-2 fw-medium">Loading Rental Fleet...</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Mobile Filter Drawer -->
<div class="mobile-filter-drawer" id="mobileFilterDrawer">
    <div class="drawer-header">
        <h5>Filter Rentals</h5>
        <div class="drawer-close" onclick="toggleMobileFilter()">✕</div>
    </div>

    <div class="sidebar-title">Brands</div>
    <div id="brandFilterMobile" class="brand-scroll mb-3"></div>

    <div class="filter-divider"></div>

    <div class="sidebar-title">Max Range</div>
    <select id="rangeFilterMobile" class="bike-sort-select w-100 mb-4">
        <option value="">All Ranges</option>
        <option value="100">Under 100 KM</option>
        <option value="150">Under 150 KM</option>
    </select>

    <button class="btn-filter-apply" onclick="applyMobileFilters()">
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
            url:"/Client/Rental.aspx/GetBikes",
            data: JSON.stringify({
                page:page,
                minPrice:minPrice,
                maxPrice:maxPrice,
                range:$("#rangeFilter").val(),
                sort:$("#sortFilter").val(),
                brands:brands,
                search: $("#<%= hfSearch.ClientID %>").val(),
                dealer: $("#<%= hfDealer.ClientID %>").val()
            }),
            contentType:"application/json; charset=utf-8",
            dataType:"json",
            success:function(res){
                let d=res.d;
                if(reset)$("#bikeContainer").html("");
                if(d.count==0){

                    if(page==1){

                        $("#bikeContainer").html(
                        "<div style='grid-column:1/-1;text-align:center;padding:40px;font-weight:600;'>No Rental Bikes Found</div>");

                    }

                    finished=false; // important fix

                    $("#loader").hide();
                    return;

                }
                $("#bikeContainer").append(d.html);
                page++;loading=false;$("#loader").hide();
            }
        });
    }

    function applyFilters(){

        page=1;
        finished=false;
        loading=false;

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

                if (window.updateWishCount) {
                    window.updateWishCount();
                }
            }
        });
    }


</script>

</asp:Content>
