<%@ Page Title="E-Bike Parts" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="Parts.aspx.cs" Inherits="PartsPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

<style>
    /* ===== Electric Pulse - Spare Parts Store ===== */
    .parts-page-wrapper {
        background-color: var(--ep-bg, #F4F8FC);
        font-family: var(--font-body, 'Inter', sans-serif);
        min-height: 100vh;
        padding-bottom: 80px;
    }
    
    .parts-hero {
        background: linear-gradient(135deg, var(--ep-primary-navy, #071A2F) 0%, #0c2b4d 100%);
        color: #FFFFFF;
        padding: 56px 0 48px;
        border-bottom: 1px solid rgba(34, 211, 238, 0.2);
        position: relative;
        overflow: hidden;
    }

    .parts-hero::after {
        content: '';
        position: absolute;
        top: -50%;
        right: -10%;
        width: 450px;
        height: 450px;
        background: radial-gradient(circle, rgba(8, 145, 178, 0.2) 0%, transparent 70%);
        pointer-events: none;
    }

    .parts-hero-title {
        font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
        font-size: 32px;
        font-weight: 800;
        color: #FFFFFF;
        letter-spacing: -0.5px;
        margin-bottom: 8px;
    }

    .parts-hero-title span {
        color: var(--ep-accent-cyan, #22D3EE);
    }

    .parts-hero-desc {
        color: #94A3B8;
        font-size: 16px;
        max-width: 600px;
        margin: 0;
    }

    /* Category & Search Sidebar */
    .parts-sidebar-card {
        background: #FFFFFF;
        border: 1px solid var(--ep-border, #E2E8F0);
        border-radius: 18px;
        padding: 24px;
        box-shadow: 0 4px 16px rgba(7, 26, 47, 0.04);
        position: sticky;
        top: 96px;
    }

    .parts-sidebar-title {
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

    .part-search-input {
        width: 100%;
        background: #F8FAFC;
        border: 1.5px solid var(--ep-border, #E2E8F0);
        border-radius: 12px;
        padding: 11px 16px 11px 42px;
        font-size: 14px;
        color: var(--ep-text, #334155);
        font-family: var(--font-body, 'Inter', sans-serif);
        outline: none;
        transition: all 0.2s ease;
    }

    .part-search-input:focus {
        background: #FFFFFF;
        border-color: var(--ep-secondary-cyan, #0891B2);
        box-shadow: 0 0 0 3px rgba(8, 145, 178, 0.15);
    }

    .category-btn {
        width: 100%;
        text-align: left;
        padding: 10px 14px;
        border-radius: 10px;
        font-size: 14px;
        font-weight: 600;
        color: var(--ep-text, #334155);
        background: transparent;
        border: none;
        cursor: pointer;
        transition: all 0.2s ease;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .category-btn:hover, .category-btn.active {
        background: #F1F5F9;
        color: var(--ep-secondary-cyan, #0891B2);
    }
    
    /* Compact Card UI */
    .part-card { 
        background: #FFFFFF; 
        border-radius: 18px; 
        overflow: hidden; 
        border: 1px solid var(--ep-border, #E2E8F0);
        transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        height: 100%;
        display: flex;
        flex-direction: column;
        box-shadow: 0 4px 14px rgba(7, 26, 47, 0.04);
    }
    
    .part-card:hover { 
        transform: translateY(-5px); 
        box-shadow: 0 16px 32px rgba(7, 26, 47, 0.1); 
        border-color: var(--ep-accent-cyan, #22D3EE); 
    }

    /* Fixed Image Box */
    .img-container {
        position: relative;
        width: 100%;
        padding-top: 65%;
        background: #F8FAFC;
        border-bottom: 1px solid var(--ep-border, #E2E8F0);
        overflow: hidden;
    }

    .img-container img {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        max-width: 80%;
        max-height: 80%;
        object-fit: contain;
        transition: transform 0.3s ease;
    }

    .part-card:hover .img-container img {
        transform: translate(-50%, -50%) scale(1.05);
    }

    /* Content */
    .part-title {
        font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
        font-size: 15px;
        font-weight: 700;
        color: var(--ep-heading, #0F172A);
        line-height: 1.35;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        height: 2.7rem;
        margin-bottom: 6px;
    }

    .category-badge {
        background: #ECFEFF;
        color: var(--ep-secondary-cyan, #0891B2);
        font-size: 10px;
        font-weight: 800;
        padding: 3px 10px;
        border-radius: 6px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        display: inline-block;
    }

    .part-price-value {
        font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
        font-size: 18px;
        font-weight: 800;
        color: var(--ep-primary-navy, #071A2F);
    }

    .btn-add {
        background: var(--ep-primary-navy, #071A2F);
        color: #FFFFFF;
        padding: 9px 16px;
        border-radius: 10px;
        font-weight: 700;
        font-size: 13px;
        font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
        border: none;
        cursor: pointer;
        transition: all 0.25s ease;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .btn-add:hover { 
        background: var(--ep-brand-orange, #F97316); 
        color: #FFFFFF;
        box-shadow: 0 4px 14px rgba(249, 115, 22, 0.35);
        transform: translateY(-2px);
    }

    .line-clamp-2 {
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        font-size: 0.825rem;
        color: var(--ep-text-muted, #64748B);
    }
</style>
    <div class="parts-page-wrapper">
        <!-- Hero Banner -->
        <div class="parts-hero">
            <div class="max-w-7xl mx-auto px-6">
                <span class="badge-ep badge-ep-cyan mb-2">⚡ OEM & GENUINE ACCESSORIES</span>
                <h1 class="parts-hero-title">E-Bike Spare Parts <span>Store</span></h1>
                <p class="parts-hero-desc">Certified batteries, smart chargers, controllers, brake pads, and OEM components with direct warranty.</p>
            </div>
        </div>

        <div class="max-w-7xl mx-auto px-6 mt-10">
            <div class="flex flex-col lg:flex-row gap-10">
                
                <!-- Left Sidebar Filters -->
                <div class="w-full lg:w-72 flex-shrink-0">
                    <div class="parts-sidebar-card">
                        <div class="mb-6">
                            <h3 class="parts-sidebar-title">
                                <span>Search Part</span>
                                <i class="fas fa-search text-slate-400"></i>
                            </h3>
                            <div class="relative">
                                <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 text-sm"></i>
                                <input type="text" id="partSearch" onkeyup="filterParts()" placeholder="Type model or name..." 
                                    class="part-search-input" />
                            </div>
                        </div>

                        <div>
                            <h3 class="parts-sidebar-title">
                                <span>Categories</span>
                                <i class="fas fa-tags text-slate-400"></i>
                            </h3>
                            <div class="flex flex-wrap lg:flex-col gap-1">
                                <asp:Literal ID="LitCategories" runat="server"></asp:Literal>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right Parts Grid -->
                <div class="flex-1">
                    <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-6" id="partsGrid">
                        <asp:Repeater ID="rptParts" runat="server">
                           <ItemTemplate>
    <div class="part-card" data-category='<%# Eval("Category") %>' data-name='<%# Eval("PartName") %>'>
        
        <div class="img-container">
            <img src='<%# Eval("Image1").ToString().StartsWith("http") ? Eval("Image1") : "/Uploads/Parts/" + Eval("Image1") %>' 
                 alt="Ebike Part"
                 onerror="this.src='https://placehold.co/400x300?text=Part+Image';" />
            
            <div class="absolute top-2 left-2">
                <%# GetStockBadge(Eval("Stock")) %>
            </div>
        </div>

        <div class="p-4 flex flex-col flex-1">
            <div class="mb-2">
                <span class="category-badge"><%# Eval("Category") %></span>
            </div>
            
            <h3 class="part-title"><%# Eval("PartName") %></h3>
            <p class="line-clamp-2 mb-4"><%# Eval("Description") %></p>
            
            <div class="mt-auto pt-3 border-t border-slate-100 flex items-center justify-between">
                <div>
                    <p class="text-[10px] font-bold text-slate-400 uppercase tracking-wider">Price</p>
                    <p class="part-price-value">₹<%# Eval("Price", "{0:N0}") %> /-</p>
                </div>
                    
                <button type="button" onclick="addToCart(<%# Eval("PartID") %>)" class="btn-add">
                    <i class="fas fa-plus"></i> Add
                </button>
            </div>
        </div>
    </div>
</ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div id="noResults" class="hidden text-center py-20 bg-white rounded-2xl border border-dashed border-slate-300">
                        <div class="bg-slate-50 w-20 h-20 rounded-full flex items-center justify-center mx-auto mb-4">
                            <i class="fas fa-box-open text-slate-300 text-3xl"></i>
                        </div>
                        <h3 class="text-xl font-bold text-slate-900">No Parts Found</h3>
                        <p class="text-slate-500 mt-1">Try searching with a different keyword or category.</p>
                    </div>
                </div>

            </div>
        </div>
    </div>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script type="text/javascript">
    function addToCart(id) {

        $.ajax({
            type: "POST",
            url: "Parts.aspx/AddToCart",
            data: JSON.stringify({ partId: id }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (res) {

                if (res.d === "Success") {

                    Swal.fire({
                        title: 'Added!',
                        icon: 'success',
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                        timer: 1500
                    });

                    // ✅ REAL FIX (live DB count)
                    if (typeof updateLiveCartCount === "function") {
                        updateLiveCartCount();
                    }

                } else if (res.d === "LoginRequired") {
                    Swal.fire('Please Login', 'Login first', 'warning');
                }
            }
        });
    }

    // Filter function (Same as before)
    function filterParts(category) {
        var search = document.getElementById('partSearch').value.toLowerCase();
        var cards = document.querySelectorAll('.part-card');
        var visible = false;

        cards.forEach(function (card) {
            var name = (card.getAttribute('data-name') || "").toLowerCase();
            var cat = (card.getAttribute('data-category') || "").toLowerCase();
            var matchesSearch = name.includes(search);
            var matchesCat = !category || cat === category.toLowerCase();

            if (matchesSearch && matchesCat) {
                card.style.display = 'flex';
                visible = true;
            } else {
                card.style.display = 'none';
            }
        });
        document.getElementById('noResults').classList.toggle('hidden', visible);
    }
</script>


</asp:Content>