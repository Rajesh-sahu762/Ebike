<%@ Page Title="Used Bikes" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true" CodeFile="UsedBikes.aspx.cs"
Inherits="Client_UsedBikes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
/* ===== Electric Pulse - Used Bikes Catalog ===== */
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
    background: #10B981;
    box-shadow: 0 0 10px #10B981;
    display: inline-block;
}

.bike-header-sub {
    font-size: 14px;
    color: var(--ep-text-muted, #64748B);
    margin-top: 4px;
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
    margin-bottom: 8px;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.sidebar-label {
    font-size: 12px;
    font-weight: 700;
    color: var(--ep-text-muted, #64748B);
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: 6px;
    display: block;
}

.filter-input {
    width: 100%;
    background: #FFFFFF;
    border: 1.5px solid var(--ep-border, #E2E8F0);
    border-radius: 10px;
    padding: 10px 14px;
    font-size: 14px;
    color: var(--ep-text, #334155);
    font-family: var(--font-body, 'Inter', sans-serif);
    outline: none;
    transition: all 0.2s ease;
    margin-bottom: 16px;
    box-sizing: border-box;
}

.filter-input:focus {
    border-color: var(--ep-secondary-cyan, #0891B2);
    box-shadow: 0 0 0 3px rgba(8, 145, 178, 0.15);
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
    margin-top: 8px;
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
    border-color: #10B981;
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

.bike-body div:not(.price) {
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
    background: linear-gradient(135deg, #10B981, #059669);
    color: #FFFFFF !important;
    box-shadow: 0 6px 16px rgba(16, 185, 129, 0.35);
    transform: translateY(-2px);
}

@media(max-width: 992px) {
    .bike-layout {
        flex-direction: column;
    }
    .sidebar {
        width: 100%;
        position: static;
    }
}
</style>

<section class="bike-wrapper">
    <div class="container">
        <!-- Top bar / Hero header -->
        <div class="bike-header-bar">
            <div>
                <span class="badge-ep badge-ep-cyan mb-2">⚡ CERTIFIED SECOND HAND</span>
                <h1 class="bike-header-title">
                    Used Electric Bikes <span class="accent-dot"></span>
                </h1>
                <p class="bike-header-sub">Quality checked pre-owned EVs with verified battery health and ownership transparency.</p>
            </div>
        </div>

        <div class="bike-layout">
            <!-- FILTERS SIDEBAR -->
            <div class="sidebar">
                <div class="sidebar-title">
                    <span>Search Filters</span>
                    <i class="fas fa-sliders-h text-muted"></i>
                </div>

                <label class="sidebar-label" for="txtSearch">Model Name</label>
                <input type="text" id="txtSearch" class="filter-input" placeholder="e.g. Ather 450X, Ola S1..." />

                <label class="sidebar-label" for="txtPrice">Max Budget (₹)</label>
                <input type="number" id="txtPrice" class="filter-input" placeholder="e.g. 80000" />

                <label class="sidebar-label" for="txtKM">Max KM Driven</label>
                <input type="number" id="txtKM" class="filter-input" placeholder="e.g. 15000" />

                <label class="sidebar-label" for="ddlOwner">Ownership</label>
                <select id="ddlOwner" class="filter-input">
                    <option value="">All Owners</option>
                    <option value="1">1st Owner Only</option>
                    <option value="2">2nd Owner</option>
                    <option value="3">3rd Owner or more</option>
                </select>

                <button type="button" class="btn-filter-apply" onclick="applyFilters()">
                    <i class="fas fa-search"></i> Search Bikes
                </button>
            </div>

            <!-- GRID -->
            <div class="content-area">
                <div id="bikeContainer" class="bike-grid"></div>
                <div id="loader" class="text-center py-5" style="display:none;">
                    <div class="spinner-border text-success" role="status" style="width: 2.2rem; height: 2.2rem;">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="text-muted mt-2 fw-medium">Searching Verified Pre-owned EVs...</p>
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

                    if(page==1){

                        $("#bikeContainer").html(
                        "<div style='grid-column:1/-1;text-align:center;padding:40px;font-weight:600;'>No Used Bikes Found</div>");

                    }

                    finished=false;   // important fix

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
        loading=false;

        $("#bikeContainer").html("");

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

                if (window.updateWishCount) {
                    window.updateWishCount();
                }

            }

        });

    }

</script>

</asp:Content>