<%@ Page Title="E-Bike Parts" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="Parts.aspx.cs" Inherits="PartsPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

 <style>
    body { background-color: #f1f5f9; font-family: 'Inter', sans-serif; }
    
    /* Compact Card UI */
    .part-card { 
        background: white; 
        border-radius: 12px; 
        overflow: hidden; 
        border: 1px solid #e2e8f0;
        transition: all 0.3s ease;
        height: 100%; /* Height content ke hisab se lega */
        display: flex;
        flex-direction: column;
    }
    
    .part-card:hover { 
        transform: translateY(-5px); 
        box-shadow: 0 10px 20px -5px rgba(0, 0, 0, 0.08); 
        border-color: #3b82f6; 
    }

    /* Fixed Image Box */
    .img-container {
        position: relative;
        width: 100%;
        padding-top: 65%; /* Height kam kar di (Pehele 75% thi) */
        background: #f8fafc;
        border-bottom: 1px solid #f1f5f9;
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
    }

    /* Compact Content */
    .part-title {
        font-size: 1rem;
        font-weight: 700;
        color: #1e293b;
        line-height: 1.3;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        height: 2.6rem; /* Title height adjust ki */
        margin-bottom: 4px;
    }

    .category-badge {
        background: #eff6ff;
        color: #3b82f6;
        font-size: 9px;
        font-weight: 800;
        padding: 2px 8px;
        border-radius: 4px;
        text-transform: uppercase;
    }

    .btn-add {
        background: #1e293b;
        color: white;
        padding: 8px 14px;
        border-radius: 8px;
        font-weight: 600;
        font-size: 13px;
        transition: 0.3s;
    }

    .btn-add:hover { background: #3b82f6; }

    .line-clamp-2 {
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        font-size: 0.8rem;
    }
</style>
    <div class="min-h-screen pb-20">
        <div class="bg-white py-14 border-b border-slate-200">
            <div class="max-w-7xl mx-auto px-6">
                <h1 class="text-4xl font-black text-slate-900 tracking-tight">Spare Parts <span class="text-blue-600">Store</span></h1>
                <p class="mt-2 text-slate-500 text-lg">Genuine components for your electric vehicle.</p>
            </div>
        </div>

        <div class="max-w-7xl mx-auto px-6 mt-10">
            <div class="flex flex-col lg:flex-row gap-10">
                
                <div class="w-full lg:w-72 flex-shrink-0">
                    <div class="bg-white p-6 rounded-2xl border border-slate-200 sticky top-10 shadow-sm">
                        <div class="mb-8">
                            <h3 class="text-sm font-black text-slate-400 uppercase tracking-widest mb-4">Search Part</h3>
                            <div class="relative">
                                <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 text-sm"></i>
                                <input type="text" id="partSearch" onkeyup="filterParts()" placeholder="Type model or name..." 
                                    class="w-full pl-11 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500/20 focus:border-blue-500 transition-all" />
                            </div>
                        </div>

                        <div>
                            <h3 class="text-sm font-black text-slate-400 uppercase tracking-widest mb-4">Categories</h3>
                            <div class="flex flex-wrap lg:flex-col gap-2">
                                <asp:Literal ID="LitCategories" runat="server"></asp:Literal>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="flex-1">
                    <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-8" id="partsGrid">
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
            <p class="text-slate-500 line-clamp-2 mb-4"><%# Eval("Description") %></p>
            
            <div class="mt-auto pt-3 border-t border-slate-50 flex items-center justify-between">
                <div>
                    <p class="text-[9px] font-bold text-slate-400 uppercase">Price</p>
                    <p class="text-xl font-black text-slate-900">₹<%# Eval("Price", "{0:N0}") %></p>
                </div>
                    
                <button type="button" onclick="addToCart(<%# Eval("PartID") %>)" class="btn-add">
                    <i class="fas fa-plus mr-1"></i> Add
                </button>
            </div>
        </div>
    </div>
</ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div id="noResults" class="hidden text-center py-24 bg-white rounded-3xl border border-dashed border-slate-300">
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