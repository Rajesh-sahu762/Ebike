<%@ Page Title="E-Bike Parts" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="Parts.aspx.cs" Inherits="PartsPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <style>
        body { background-color: #f8fafc; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .part-card { transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); border: 1px solid #e2e8f0; background: white; }
        .part-card:hover { transform: translateY(-8px); box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05); border-color: #3b82f6; }
        .category-pill { transition: 0.2s; cursor: pointer; white-space: nowrap; }
        .category-pill:hover { background-color: #eff6ff; color: #1e40af; }
        .badge-stock { font-size: 10px; padding: 2px 8px; border-radius: 99px; font-weight: 700; }
        .line-clamp-2 { display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
    </style>

    <div class="min-h-screen">
        <div class="bg-white border-b border-slate-200 py-12 mb-8">
            <div class="max-w-7xl mx-auto px-4 text-center">
                <h1 class="text-3xl md:text-4xl font-black text-slate-900 mb-3">Genuine E-Bike Spare Parts</h1>
                <p class="text-slate-500 max-w-xl mx-auto">High-quality batteries, motors, and accessories to keep your ride running smooth.</p>
            </div>
        </div>

        <div class="max-w-7xl mx-auto px-4 flex flex-col md:flex-row gap-8 pb-20">
            <div class="w-full md:w-64 flex-shrink-0">
                <div class="bg-white p-6 rounded-2xl border border-slate-200 sticky top-5">
                    <h3 class="font-bold text-slate-900 mb-4 flex items-center">
                        <i class="fas fa-filter mr-2 text-blue-500"></i> Filters
                    </h3>
                    
                    <div class="mb-6">
                        <label class="text-xs font-bold text-slate-400 uppercase tracking-wider mb-2 block">Search</label>
                        <input type="text" id="partSearch" onkeyup="filterParts()" placeholder="Search parts..." 
                            class="w-full px-4 py-2 bg-slate-50 border border-slate-200 rounded-lg focus:outline-none focus:border-blue-500 text-sm" />
                    </div>

                    <div>
                        <label class="text-xs font-bold text-slate-400 uppercase tracking-wider mb-3 block">Categories</label>
                        <div class="space-y-1">
                            <asp:Literal ID="LitCategories" runat="server"></asp:Literal>
                        </div>
                    </div>
                </div>
            </div>

            <div class="flex-1">
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6" id="partsGrid">
                    <asp:Repeater ID="rptParts" runat="server">
                        <ItemTemplate>
                            <div class="part-card rounded-2xl overflow-hidden flex flex-col h-full" 
                                 data-category='<%# Eval("Category") %>' data-name='<%# Eval("PartName") %>'>
                                
                                <div class="relative h-48 bg-slate-100 flex items-center justify-center p-4">
                                    <img src='/Uploads/Parts/<%# Eval("Image1") %>' class="max-h-full max-w-full object-contain mix-blend-multiply" 
                                         onerror="this.src='/Uploads/Parts/no-image.png';" />
                                    <div class="absolute top-3 left-3">
                                        <%# GetStockBadge(Eval("Stock")) %>
                                    </div>
                                </div>

                                <div class="p-5 flex flex-col flex-1">
                                    <span class="text-[10px] font-bold text-blue-600 uppercase tracking-widest mb-1"><%# Eval("Category") %></span>
                                    <h3 class="text-lg font-bold text-slate-900 mb-2 leading-tight h-14 overflow-hidden"><%# Eval("PartName") %></h3>
                                    <p class="text-slate-500 text-xs line-clamp-2 mb-4"><%# Eval("Description") %></p>
                                    
                                    <div class="mt-auto flex items-center justify-between">
                                        <div>
                                            <span class="text-xs text-slate-400 block">Price</span>
                                            <span class="text-xl font-black text-slate-900">₹<%# Eval("Price", "{0:N0}") %></span>
                                        </div>
                                        <button type="button" class="bg-slate-900 hover:bg-blue-600 text-white w-10 h-10 rounded-xl transition flex items-center justify-center shadow-lg shadow-slate-200">
                                            <i class="fas fa-shopping-cart text-sm"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div id="noResults" class="hidden text-center py-20 bg-white rounded-3xl border border-dashed border-slate-300">
                    <img src="https://cdn-icons-png.flaticon.com/512/7486/7486744.png" class="w-20 mx-auto opacity-20 mb-4" />
                    <h3 class="text-xl font-bold text-slate-400">No parts found matching your criteria</h3>
                </div>
            </div>
        </div>
    </div>

    <script>
        function filterParts(category) {
            const search = document.getElementById('partSearch').value.toLowerCase();
            const cards = document.querySelectorAll('.part-card');
            let hasVisible = false;

            cards.forEach(card => {
                const catName = card.getAttribute('data-category').toLowerCase();
                const partName = card.getAttribute('data-name').toLowerCase();
                
                const matchesSearch = partName.includes(search);
                const matchesCat = !category || catName === category.toLowerCase();

            if (matchesSearch && matchesCat) {
                card.style.display = 'flex';
                hasVisible = true;
            } else {
                card.style.display = 'none';
            }
        });

        document.getElementById('noResults').style.display = hasVisible ? 'none' : 'block';
        }
    </script>
</asp:Content>