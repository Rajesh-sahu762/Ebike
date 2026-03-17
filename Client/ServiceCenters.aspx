<%@ Page Title="Service Centers" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="ServiceCenters.aspx.cs" Inherits="ServiceCenters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <style>
        .service-card { transition: all 0.3s ease; border: 1px solid #e5e7eb; }
        .service-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1); border-color: #3b82f6; }
        .search-box:focus { ring: 2px; ring-color: #3b82f6; border-color: transparent; }
        .no-scrollbar::-webkit-scrollbar { display: none; }
    </style>

    <div class="bg-slate-50 min-h-screen pb-20">
        <div class="bg-white border-b border-slate-200 py-16 mb-10">
            <div class="max-w-6xl mx-auto px-4 text-center">
                <h1 class="text-4xl font-extrabold text-slate-900 mb-4">Authorized Service Centers</h1>
                <p class="text-slate-600 text-lg max-w-2xl mx-auto">Expert care for your E-Bike. Find a certified service station near your location for maintenance and repairs.</p>
            </div>
        </div>

        <div class="max-w-6xl mx-auto px-4">
            <div class="bg-white p-4 rounded-2xl shadow-sm border border-slate-200 flex flex-col md:flex-row gap-4 mb-10 items-center">
                <div class="relative flex-1 w-full">
                    <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-slate-400"></i>
                    <input type="text" id="centerSearch" onkeyup="filterCenters()" placeholder="Search by name or area..." 
                        class="w-full pl-12 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 transition" />
                </div>
               <div class="w-full md:w-auto">
    <select id="ddlCity" onchange="filterCenters(this.value)"
        class="px-5 py-3 bg-slate-50 border border-slate-200 rounded-xl text-sm font-bold text-slate-700 focus:outline-none focus:ring-2 focus:ring-blue-500">

        <asp:Literal ID="CityFilters" runat="server"></asp:Literal>

    </select>
</div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8" id="centersGrid">
                <asp:Repeater ID="rptServiceCenters" runat="server">
                    <ItemTemplate>
                        <div class="service-card bg-white rounded-2xl p-6 flex flex-col justify-between" data-city='<%# Eval("City") %>'
data-name='<%# Eval("CenterName") %>'>
                            <div>
                                <div class="flex justify-between items-start mb-4">
                                    <div class="w-12 h-12 bg-blue-50 text-blue-600 rounded-xl flex items-center justify-center text-xl">
                                        <i class="fas fa-tools"></i>
                                    </div>
                                    <span class="bg-emerald-100 text-emerald-700 text-[10px] font-bold px-3 py-1 rounded-full uppercase">Open Now</span>
                                </div>
                                <h3 class="text-xl font-bold text-slate-900 mb-2"><%# Eval("CenterName") %></h3>
                                <p class="text-slate-500 text-sm mb-4 line-clamp-2">
                                    <i class="fas fa-location-dot mr-2"></i><%# Eval("Address") %>
                                </p>
                                
                                <div class="space-y-2 mb-6">
                                    <div class="flex items-center text-sm text-slate-600">
                                        <i class="fas fa-phone w-6 text-blue-500"></i>
                                        <span><%# Eval("Phone") %></span>
                                    </div>
                                    <div class="flex items-center text-sm text-slate-600">
                                        <i class="fas fa-clock w-6 text-blue-500"></i>
                                        <span>09:00 AM - 07:00 PM</span>
                                    </div>
                                </div>
                            </div>

                            <div class="flex gap-3 border-t border-slate-100 pt-5">
                                <a href='tel:<%# Eval("Phone") %>' class="flex-1 bg-blue-600 hover:bg-blue-700 text-white text-center py-2.5 rounded-lg text-sm font-bold transition">
                                    <i class="fas fa-phone mr-2"></i>Call
                                </a>
                                <a href='https://www.google.com/maps/search/?api=1&query=<%# Eval("CenterName") %> <%# Eval("Address") %>' target="_blank" 
                                   class="flex-1 bg-slate-100 hover:bg-slate-200 text-slate-700 text-center py-2.5 rounded-lg text-sm font-bold transition">
                                    <i class="fas fa-directions mr-2"></i>Map
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div id="noResults" class="hidden text-center py-20">
                <i class="fas fa-search text-5xl text-slate-200 mb-4"></i>
                <h3 class="text-xl font-bold text-slate-400">No centers found in this location</h3>
            </div>
        </div>
    </div>

    <script>
        function filterCenters(city) {
            const search = document.getElementById('centerSearch').value.toLowerCase();
            const cards = document.querySelectorAll('.service-card');
            let hasVisible = false;

            cards.forEach(card => {
                const cityName = card.getAttribute('data-city').toLowerCase();
                const centerName = card.getAttribute('data-name').toLowerCase();
                
                const matchesSearch = centerName.includes(search);
                const matchesCity = !city || cityName === city.toLowerCase();

            if (matchesSearch && matchesCity) {
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