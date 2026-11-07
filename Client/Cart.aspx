<%@ Page Title="Your Cart" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="Cart.aspx.cs" Inherits="CartPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <style>
        body { background-color: var(--ep-bg, #F4F8FC); font-family: var(--font-body, 'Inter', sans-serif); }
        .cart-item { transition: all 0.3s ease; border-bottom: 1px solid var(--ep-border, #E2E8F0); }
        .cart-item:last-child { border-bottom: none; }
        .qty-btn { 
            width: 32px; height: 32px; border-radius: 8px; display: flex; 
            align-items: center; justify-content: center; transition: 0.2s;
            background: #F1F5F9; color: var(--ep-text, #334155);
            text-decoration: none !important;
        }
        .qty-btn:hover { background: var(--ep-secondary-cyan, #0891B2); color: white; }
        .stepper-item.active { color: var(--ep-secondary-cyan, #0891B2); font-weight: 700; font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif); }
        .btn-ep-checkout {
            background: linear-gradient(135deg, var(--ep-brand-orange, #F97316), #EA580C);
            color: #FFFFFF !important;
            font-family: var(--font-heading, 'Plus Jakarta Sans', sans-serif);
            font-weight: 700;
            border-radius: 14px;
            box-shadow: 0 6px 18px rgba(249, 115, 22, 0.35);
            transition: all 0.25s ease;
        }
        .btn-ep-checkout:hover {
            background: linear-gradient(135deg, #FB923C, var(--ep-brand-orange, #F97316));
            transform: translateY(-2px);
            box-shadow: 0 10px 24px rgba(249, 115, 22, 0.45);
        }
    </style>

    <div class="max-w-7xl mx-auto px-4 py-12">
        <div class="flex justify-center items-center mb-12 gap-4 md:gap-10">
            <div class="flex items-center gap-2 stepper-item active">
                <span class="w-8 h-8 rounded-full bg-cyan-700 text-white flex items-center justify-center text-xs font-bold shadow-md shadow-cyan-200">1</span>
                <span>Cart</span>
            </div>
            <div class="h-[2px] w-12 bg-cyan-600"></div>
            <div class="flex items-center gap-2 stepper-item text-slate-400">
                <span class="w-8 h-8 rounded-full bg-slate-200 flex items-center justify-center text-xs font-bold">2</span>
                <span class="hidden md:block">Checkout</span>
            </div>
            <div class="h-[1px] w-12 bg-slate-200"></div>
            <div class="flex items-center gap-2 stepper-item text-slate-400">
                <span class="w-8 h-8 rounded-full bg-slate-200 flex items-center justify-center text-xs font-bold">3</span>
                <span class="hidden md:block">Confirmation</span>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-10">
            <div class="lg:col-span-8">
                <div class="bg-white rounded-3xl border border-slate-200 shadow-sm overflow-hidden">
                    <div class="p-6 border-b border-slate-100 flex justify-between items-center">
                        <h3 class="text-xl font-black text-slate-900 font-['Plus_Jakarta_Sans']">Shopping Cart (<asp:Literal ID="litCartCount" runat="server">0</asp:Literal>)</h3>
                        <asp:LinkButton ID="btnClearCart" runat="server" OnClick="ClearCart_Click" class="text-xs font-bold text-red-500 hover:text-red-700 uppercase tracking-wider">Clear All</asp:LinkButton>
                    </div>

                    <div class="divide-y divide-slate-100">
                        <asp:Repeater ID="rptCartItems" runat="server" OnItemCommand="rptCartItems_ItemCommand">
                            <ItemTemplate>
                                <div class="cart-item p-6 flex flex-col sm:flex-row items-center gap-6">
                                    <div class="w-24 h-24 bg-slate-50 rounded-2xl flex-shrink-0 p-2 border border-slate-100">
                                        <img src='/Uploads/Parts/<%# Eval("Image1") %>' class="w-full h-full object-contain mix-blend-multiply" />
                                    </div>
                                    
                                    <div class="flex-1 text-center sm:text-left">
                                        <p class="text-[10px] font-bold text-cyan-600 uppercase tracking-widest mb-1"><%# Eval("Category") %></p>
                                        <h4 class="text-lg font-bold text-slate-900 leading-tight mb-1 font-['Plus_Jakarta_Sans']"><%# Eval("PartName") %></h4>
                                        <p class="text-slate-500 text-xs font-medium">Unit Price: &#8377;<%# Eval("Price", "{0:N0}") %></p>
                                    </div>

                                    <div class="flex items-center gap-4 bg-slate-50 p-2 rounded-xl border border-slate-100">
                                        <asp:LinkButton ID="btnMinus" runat="server" CommandName="Minus" CommandArgument='<%# Eval("PartID") %>' class="qty-btn"><i class="fas fa-minus text-[10px]"></i></asp:LinkButton>
                                        <span class="font-bold text-slate-900 w-6 text-center text-sm"><%# Eval("Qty") %></span>
                                        <asp:LinkButton ID="btnPlus" runat="server" CommandName="Plus" CommandArgument='<%# Eval("PartID") %>' class="qty-btn"><i class="fas fa-plus text-[10px]"></i></asp:LinkButton>
                                    </div>

                                    <div class="text-right flex flex-col items-end gap-2">
                                        <span class="text-lg font-black text-slate-900 font-['Plus_Jakarta_Sans']">&#8377;<%# (Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Qty"))).ToString("N0") %></span>
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
                            <i class="fas fa-shopping-basket text-3xl text-slate-300"></i>
                        </div>
                        <h3 class="text-xl font-bold text-slate-900 mb-2 font-['Plus_Jakarta_Sans']">Your cart is empty</h3>
                        <p class="text-slate-500 mb-8">Looks like you haven't added any spare parts yet.</p>
                        <a href="Parts.aspx" class="inline-block bg-[#071A2F] hover:bg-[#0891B2] text-white px-8 py-3 rounded-xl font-bold transition shadow-md">Browse Parts</a>
                    </asp:Panel>
                </div>
            </div>

            <div class="lg:col-span-4">
                <div class="bg-white p-8 rounded-3xl border border-slate-200 shadow-sm sticky top-10">
                    <h3 class="text-xl font-black text-slate-900 mb-6 font-['Plus_Jakarta_Sans']">Order Total</h3>
                    
                    <div class="space-y-4 mb-8">
                        <div class="flex justify-between text-sm">
                            <span class="text-slate-500 font-medium">Subtotal</span>
                            <span class="font-bold text-slate-900">&#8377;<asp:Literal ID="litSubtotal" runat="server">0</asp:Literal></span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-slate-500 font-medium">Tax</span>
                            <span class="font-bold text-slate-900">&#8377;<asp:Literal ID="litTax" runat="server">0</asp:Literal></span>
                        </div>
                        <div class="flex justify-between text-sm">
                            <span class="text-slate-500 font-medium">Shipping</span>
                            <span class="text-emerald-500 font-bold uppercase text-[10px]">Free</span>
                        </div>
                        <div class="h-[1px] bg-slate-100 my-4"></div>
                        <div class="flex justify-between items-center text-2xl">
                            <span class="font-black text-slate-900 font-['Plus_Jakarta_Sans']">Total</span>
                            <span class="font-black text-slate-900 font-['Plus_Jakarta_Sans']">&#8377;<asp:Literal ID="litTotal" runat="server">0</asp:Literal></span>
                        </div>
                    </div>

                    <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" OnClick="btnCheckout_Click"
                        class="w-full btn-ep-checkout text-white font-black py-4 rounded-2xl transition-all shadow-xl cursor-pointer mb-4" />
                    
                    <a href="Parts.aspx" class="block text-center text-slate-400 text-xs font-bold hover:text-slate-600 uppercase tracking-widest transition">
                        <i class="fas fa-arrow-left mr-2"></i>Continue Shopping
                    </a>
                </div>
            </div>
        </div>
    </div>
                    
                    <a href="Parts.aspx" class="block text-center text-slate-400 text-xs font-bold hover:text-slate-600 uppercase tracking-widest transition">
                        <i class="fas fa-arrow-left mr-2"></i>Continue Shopping
                    </a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>