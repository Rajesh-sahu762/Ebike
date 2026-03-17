<%@ Page Title="E-Bike | Smart Charging Hub" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="ChargingStations.aspx.cs" Inherits="Client_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
     <style>
        body { 
            font-family: 'Outfit', sans-serif; 
            background-color: #f8fafc; 
            color: #1e293b; 
        }
        .premium-card {
            background: white;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .premium-card:hover {
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            border-color: #10b981;
            transform: translateY(-8px);
        }
        .search-shadow {
            box-shadow: 0 10px 15px -3px rgba(16, 185, 129, 0.1);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 

    <div id="form1" runat="server">
    
        <main class="max-w-7xl mx-auto px-6 py-12">
            <div class="text-center mb-16">
                <span class="bg-emerald-100 text-emerald-700 px-4 py-1.5 rounded-full text-sm font-bold tracking-wide uppercase">⚡ Fast Charging Network</span>
                <h1 class="text-5xl font-extrabold text-slate-900 mt-6 mb-4">Charge your ride, <span class="text-emerald-500">anywhere.</span></h1>
                <p class="text-slate-500 text-lg max-w-2xl mx-auto">Access over 5,000+ premium charging points across the country with real-time status updates.</p>
            </div>

            <div class="max-w-4xl mx-auto mb-16">
                <div class="bg-white p-2 rounded-2xl search-shadow flex flex-col md:flex-row gap-2 border border-slate-100">
                   <input type="text" id="txtSearch" runat="server"
placeholder="Enter city or area name..." 
class="flex-1 px-6 py-4 text-slate-700 focus:outline-none rounded-xl bg-slate-50" />

<asp:DropDownList ID="ddlConnector" runat="server"
CssClass="px-6 py-4 bg-slate-50 text-slate-600 rounded-xl outline-none border-none">

</asp:DropDownList>

<asp:Button ID="btnSearch" runat="server"
Text="Find Stations"
OnClick="btnSearch_Click"
CssClass="bg-slate-900 hover:bg-black text-white px-10 py-4 rounded-xl font-bold transition" />
                </div>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                
                <asp:Repeater ID="rptStations" runat="server">
<ItemTemplate>

<div class="premium-card rounded-3xl p-6">

    <div class="flex justify-between items-start mb-6">
        <div class="flex flex-col">

            <!-- STATUS -->
            <span class='<%# Convert.ToBoolean(Eval("IsActive")) ? 
            "text-emerald-600" : "text-amber-600" %> text-xs font-bold uppercase tracking-wider mb-1 flex items-center'>

                <span class='w-2 h-2 <%# Convert.ToBoolean(Eval("IsActive")) ? 
                "bg-emerald-500 animate-pulse" : "bg-amber-500" %> rounded-full mr-2'></span>

                <%# Convert.ToBoolean(Eval("IsActive")) ? "Available" : "2 Min Wait" %>

            </span>

            <h3 class="text-xl font-bold text-slate-800 tracking-tight">
                <%# Eval("StationName") %>
            </h3>

        </div>

        <span class="text-slate-400 text-sm font-medium">
            <%# Eval("City") %>
        </span>
    </div>

    <!-- ADDRESS -->
    <p class="text-slate-500 text-sm mb-6 leading-relaxed">
        <%# Eval("Address") %>
    </p>

    <!-- DETAILS -->
    <div class="grid grid-cols-2 gap-3 mb-8">

        <div class="bg-slate-50 p-3 rounded-2xl border border-slate-100">
            <p class="text-[10px] text-slate-400 uppercase font-bold">Output</p>
            <p class="font-bold text-slate-700">
                <%# Eval("ConnectorType") %>
            </p>
        </div>

        <div class="bg-slate-50 p-3 rounded-2xl border border-slate-100">
            <p class="text-[10px] text-slate-400 uppercase font-bold">Type</p>
            <p class="font-bold text-slate-700">
                EV Charger
            </p>
        </div>

    </div>

   

</div>

</ItemTemplate>
</asp:Repeater>


            </div>
        </main>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" Runat="Server">
</asp:Content>

