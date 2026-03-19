<%@ Page Title="Order Details" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="OrderDetails.aspx.cs" Inherits="Client_OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<script src="https://cdn.tailwindcss.com"></script>

<div class="bg-gray-50 min-h-screen py-10">
    <div class="max-w-5xl mx-auto px-4">
        
        <div class="flex items-center gap-4 mb-6">
            <a href="MyEnquiries.aspx" class="bg-white p-2 rounded-full shadow-sm hover:bg-gray-100 transition-all">
                <i class="fas fa-arrow-left text-gray-600"></i>
            </a>
            <div>
                <h1 class="text-2xl font-black text-gray-800">Order Details</h1>
                <p class="text-sm text-gray-500">Order <asp:Label ID="lblOrderNo" runat="server" /> • Placed on <asp:Label ID="lblDate" runat="server" /></p>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            
            <div class="lg:col-span-2 space-y-6">
                
                <div class="bg-white p-6 rounded-2xl border border-gray-100 shadow-sm">
                    <h3 class="font-bold text-gray-800 mb-6">Order Status: <span class="text-blue-600"><asp:Label ID="lblStatus" runat="server" /></span></h3>
                    <div class="flex items-center justify-between relative px-4">
                        <div class="absolute top-1/2 left-0 w-full h-1 bg-gray-100 -translate-y-1/2 z-0"></div>
                        <div class="absolute top-1/2 left-0 w-1/2 h-1 bg-green-500 -translate-y-1/2 z-0"></div>
                        
                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-8 h-8 bg-green-500 rounded-full flex items-center justify-center text-white text-xs"><i class="fas fa-check"></i></div>
                            <span class="text-[10px] font-bold mt-2 text-gray-800 uppercase">Confirmed</span>
                        </div>
                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-8 h-8 bg-green-500 rounded-full flex items-center justify-center text-white text-xs"><i class="fas fa-shipping-fast"></i></div>
                            <span class="text-[10px] font-bold mt-2 text-gray-800 uppercase">Shipped</span>
                        </div>
                        <div class="relative z-10 flex flex-col items-center">
                            <div class="w-8 h-8 bg-gray-200 rounded-full flex items-center justify-center text-white text-xs"><i class="fas fa-home"></i></div>
                            <span class="text-[10px] font-bold mt-2 text-gray-400 uppercase">Delivered</span>
                        </div>
                    </div>
                </div>

                <div class="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
                    <div class="p-4 border-b border-gray-50 bg-gray-50/50">
                        <h3 class="font-bold text-gray-700">Items Ordered</h3>
                    </div>
                    <asp:Repeater ID="rptOrderItems" runat="server">
                        <ItemTemplate>
                            <div class="p-5 flex gap-6 border-b border-gray-100 last:border-0 hover:bg-gray-50/50 transition-all">
                                <img src='/Uploads/Parts/<%# Eval("Image1") %>' class="w-20 h-20 object-cover rounded-xl border border-gray-100" />
                                <div class="flex-1">
                                    <h4 class="font-bold text-gray-800"><%# Eval("PartName") %></h4>
                                    <p class="text-xs text-gray-500 mt-1">Quantity: <span class="font-bold text-gray-700"><%# Eval("Qty") %></span></p>
                                    <p class="text-sm font-black text-gray-900 mt-2">₹<%# Eval("Price", "{0:N0}") %></p>
                                </div>
                                <div class="hidden sm:block">
                                    <a href='ProductDetails.aspx?id=<%# Eval("PartID") %>' class="text-xs font-bold text-blue-600 hover:underline">Buy Again</a>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <div class="space-y-6">
                <div class="bg-white p-6 rounded-2xl border border-gray-100 shadow-sm">
                    <h3 class="font-bold text-gray-800 mb-4 border-b pb-2">Price Details</h3>
                    <div class="space-y-3">
                        <div class="flex justify-between text-sm text-gray-600">
                            <span>Selling Price</span>
                            <span><asp:Label ID="lblTotal" runat="server" /></span>
                        </div>
                        <div class="flex justify-between text-sm text-gray-600">
                            <span>Shipping Fee</span>
                            <span class="text-green-600 font-bold text-xs uppercase">Free</span>
                        </div>
                        <hr class="border-dashed border-gray-200" />
                        <div class="flex justify-between font-black text-lg text-gray-900">
                            <span>Total Amount</span>
                            <span><asp:Label ID="lblTotal2" runat="server" /></span>
                        </div>
                    </div>
                </div>

                <div class="bg-blue-600 p-6 rounded-2xl shadow-lg shadow-blue-100 text-white">
                    <h3 class="font-bold mb-2">Need Help?</h3>
                    <p class="text-xs opacity-80 mb-4">Facing issues with your order or payment? Contact our support.</p>
                    <a href="Contact.aspx" class="block text-center bg-white text-blue-600 py-2 rounded-xl text-xs font-bold">Contact Support</a>
                </div>
            </div>
        </div>
    </div>
</div>
</asp:Content>