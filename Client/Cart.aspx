<%@ Page Title="Your Cart" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="Cart.aspx.cs" Inherits="CartPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <style>
        body { background-color: #f8fafc; font-family: 'Inter', sans-serif; }
        .cart-item { transition: all 0.3s ease; border-bottom: 1px solid #f1f5f9; }
        .cart-item:last-child { border-bottom: none; }
        .qty-btn { 
            width: 32px; height: 32px; border-radius: 8px; display: flex; 
            align-items: center; justify-content: center; transition: 0.2s;
            background: #f1f5f9; color: #1e293b;
        }
        .qty-btn:hover { background: #3b82f6; color: white; }
        .stepper-item.active { color: #3b82f6; font-weight: 700; }
    </style>

    <div class="max-w-7xl mx-auto px-4 py-12">
        <div class="flex justify-center items-center mb-12 gap-4 md:gap-10">
            <div class="flex items-center gap-2 stepper-item active">
                <span class="w-8 h-8 rounded-full bg-blue-600 text-white flex items-center justify-center text-xs shadow-lg shadow-blue-200">1</span>
                <span>Cart</span>
            </div>
            <div class="h-[1px] w-12 bg-slate-200"></div>
            <div class="flex items-center gap-2 stepper-item text-slate-400">
                <span class="w-8 h-8 rounded-full bg-slate-200 flex items-center justify-center text-xs">2</span>
                <span class="hidden md:block">Checkout</span>
            </div>
            <div class="h-[1px] w-12 bg-slate-200"></div>
            <div class="flex items-center gap-2 stepper-item text-slate-400">
                <span class="w-8 h-8 rounded-full bg-slate-200 flex items-center justify-center text-xs">3</span>
                <span class="hidden md:block">Confirmation</span>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-10">
            <div class="lg:col-span-8">
                <div class="bg-white rounded-3xl border border-slate-200 shadow-sm overflow-hidden">
                    <div class="p-6 border-b border-slate-100 flex justify-between items-center">
                        <h3 class="text-xl font-black text-slate-900">Shopping Cart (<asp:Literal ID="litCartCount" runat="server">0</asp:Literal>)</h3>
                        <asp:LinkButton ID="btnClearCart" runat="server" OnClick="ClearCart_Click" class="text-xs font-bold text-red-500 hover:text-red-700 uppercase">Clear All</asp:LinkButton>
                    </div>

                    <div class="divide-y divide-slate-100">
                        <asp:Repeater ID="rptCartItems" runat="server" OnItemCommand="rptCartItems_ItemCommand">
                            <ItemTemplate>
                                <div class="cart-item p-6 flex flex-col sm:flex-row items-center gap-6">
                                    <div class="w-24 h-24 bg-slate-50 rounded-2xl flex-shrink-0 p-2 border border-slate-100">
                                        <img src='/Uploads/Parts/<%# Eval("Image1") %>' class="w-full h-full object-contain mix-blend-multiply" />
                                    </div>
                                    
                                    <div class="flex-1 text-center sm:text-left">
                                        <p class="text-[10px] font-bold text-blue-500 uppercase tracking-widest mb-1"><%# Eval("Category") %></p>
                                        <h4 class="text-lg font-bold text-slate-900 leading-tight mb-1"><%# Eval("PartName") %></h4>
                                        <p class="text-slate-500 text-xs font-medium">Unit Price: ₹<%# Eval("Price", "{0:N0}") %></p>
                                    </div>

                                    <div class="flex items-center gap-4 bg-slate-50 p-2 rounded-xl border border-slate-100">
                                        <asp:LinkButton ID="btnMinus" runat="server" CommandName="Minus" CommandArgument='<%# Eval("PartID") %>' class="qty-btn"><i class="fas fa-minus text-[10px]"></i></asp:LinkButton>
                                        <span class="font-bold text-slate-900 w-6 text-center text-sm"><%# Eval("Qty") %></span>
                                        <asp:LinkButton ID="btnPlus" runat="server" CommandName="Plus" CommandArgument='<%# Eval("PartID") %>' class="qty-btn"><i class="fas fa-plus text-[10px]"></i></asp:LinkButton>
                                    </div>

                                    <div class="text-right flex flex-col items-end gap-2">
                                        <span class="text-lg font-black text-slate-900">₹<%# (Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Qty"))).ToString("N0") %></span>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Remove" CommandArgument='<%# Eval("PartID") %>' class="text-slate-300 hover:text-red-500 transition-colors">
                                            <i class="fas fa-trash-alt text-sm"></i>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false" class="p-20 text-center">
                        <div class="w-20 h-20 bg-slate-50 rounded-full flex items-center justify-center mx-auto mb-6">
                            <i class="fas fa-shopping-basket text-3xl text-slate-200"></i>
                        </div>
                        <h3 class="text-xl font-bold text-slate-900 mb-2">Your cart is empty</h3>
                        <p class="text-slate-500 mb-8">Looks like you haven't added any parts yet.</p>
                        <a href="Parts.aspx" class="inline-block bg-blue-600 text-white px-8 py-3 rounded-xl font-bold hover:bg-blue-700 transition shadow-lg shadow-blue-200">Browse Parts</a>
                    </asp:Panel>
                </div>
            </div>

            <div class="lg:col-span-4">
                <div class="bg-white p-8 rounded-3xl border border-slate-200 shadow-sm sticky top-10">
                    <h3 class="text-xl font-black text-slate-900 mb-6">Order Total</h3>
                    
                    <div class="space-y-4 mb-8">
                        <div class="flex justify-between text-sm">
                            <span class="text-slate-500 font-medium">Subtotal</span>
                            <span class="font-bold text-slate-900">₹<asp:Literal ID="litSubtotal" runat="server">0</asp:Literal></span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-slate-500 font-medium">Tax (GST 18%)</span>
                            <span class="font-bold text-slate-900">₹<asp:Literal ID="litTax" runat="server">0</asp:Literal></span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-slate-500 font-medium">Shipping</span>
                            <span class="text-emerald-500 font-bold uppercase text-[10px]">Free</span>
                        </div>
                        <div class="h-[1px] bg-slate-100 my-4"></div>
                        <div class="flex justify-between items-center text-2xl">
                            <span class="font-black text-slate-900">Total</span>
                            <span class="font-black text-blue-600">₹<asp:Literal ID="litTotal" runat="server">0</asp:Literal></span>
                        </div>
                    </div>

                    <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" OnClick="btnCheckout_Click"
                        class="w-full bg-slate-900 hover:bg-blue-600 text-white font-black py-4 rounded-2xl transition-all shadow-xl shadow-slate-200 cursor-pointer mb-4" />
                    
                    <a href="Parts.aspx" class="block text-center text-slate-400 text-xs font-bold hover:text-slate-600 uppercase tracking-widest transition">
                        <i class="fas fa-arrow-left mr-2"></i>Continue Shopping
                    </a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>