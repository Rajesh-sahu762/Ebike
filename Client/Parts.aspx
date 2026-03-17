<%@ Page Title="E-Bike Parts" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="Parts.aspx.cs" Inherits="PartsPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <style>
        body { background-color: #f1f5f9; font-family: 'Inter', sans-serif; }
        
        /* Fixed Card Aspect & Quality */
        .part-card { 
            background: white; 
            border-radius: 16px; 
            overflow: hidden; 
            border: 1px solid #e2e8f0;
            transition: all 0.4s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        
        .part-card:hover { 
            transform: translateY(-10px); 
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1); 
            border-color: #3b82f6; 
        }

        /* Image Container Fix */
        .img-container {
            position: relative;
            width: 100%;
            padding-top: 75%; /* 4:3 Aspect Ratio */
            background: #f8fafc;
            overflow: hidden;
        }

        .img-container img {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            max-width: 85%;
            max-height: 85%;
            object-fit: contain;
            transition: transform 0.5s ease;
        }
        
        .part-card:hover .img-container img {
            transform: translate(-50%, -50%) scale(1.1);
        }

        /* Typography & Buttons */
        .part-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #1e293b;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 3rem;
        }

        .category-badge {
            background: #eff6ff;
            color: #3b82f6;
            font-size: 10px;
            font-weight: 800;
            padding: 4px 10px;
            border-radius: 6px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .btn-add {
            background: #1e293b;
            color: white;
            padding: 10px 18px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 14px;
            transition: 0.3s;
        }

        .btn-add:hover {
            background: #3b82f6;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.4);
        }

        /* Scrollbar hide */
        .no-scrollbar::-webkit-scrollbar { display: none; }
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
                                        
                                        <div class="absolute top-4 left-4">
                                            <%# GetStockBadge(Eval("Stock")) %>
                                        </div>
                                    </div>

                                    <div class="p-6 flex flex-col flex-1">
                                        <div class="mb-3">
                                            <span class="category-badge"><%# Eval("Category") %></span>
                                        </div>
                                        
                                        <h3 class="part-title mb-2"><%# Eval("PartName") %></h3>
                                        <p class="text-slate-500 text-sm line-clamp-2 mb-6 leading-relaxed"><%# Eval("Description") %></p>
                                        
                                        <div class="mt-auto pt-5 border-t border-slate-100 flex items-center justify-between">
                                            <div>
                                                <p class="text-[10px] font-bold text-slate-400 uppercase">Best Price</p>
                                                <p class="text-2xl font-black text-slate-900">₹<%# Eval("Price", "{0:N0}") %></p>
                                            </div>
                                            <button type="button" class="btn-add">
                                                <i class="fas fa-plus mr-2"></i>Add
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

    <script>
        function filterParts(category) {
            const search = document.getElementById('partSearch').value.toLowerCase();
            const cards = document.querySelectorAll('.part-card');
            let hasVisible = false;

            // Simple visual active state for category buttons
            const pills = document.querySelectorAll('.category-pill');
            pills.forEach(p => p.classList.remove('ring-2', 'ring-blue-500', 'bg-blue-50'));

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