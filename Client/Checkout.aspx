<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="CheckoutPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <style>
        body { background-color: #f8fafc; font-family: 'Inter', sans-serif; }
        .input-field { 
            width: 100%; padding: 12px 16px; border-radius: 12px; border: 1px solid #e2e8f0; 
            background: #fdfdfd; transition: 0.3s; outline: none;
        }
        .input-field:focus { border-color: #3b82f6; box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1); }
        .payment-option { 
            border: 2px solid #e2e8f0; border-radius: 16px; padding: 16px; 
            cursor: pointer; transition: 0.3s; display: flex; align-items: center; gap: 12px;
        }
        .payment-radio:checked + .payment-option { border-color: #3b82f6; background-color: #eff6ff; }
        .stepper-item.active { color: #3b82f6; font-weight: 700; }
    </style>

    <div class="max-w-7xl mx-auto px-4 py-12">
        <div class="flex justify-center items-center mb-12 gap-4 md:gap-10">
            <div class="flex items-center gap-2 stepper-item text-slate-400">
                <span class="w-8 h-8 rounded-full bg-slate-200 flex items-center justify-center text-xs">1</span>
                <span class="hidden md:block">Cart</span>
            </div>
            <div class="h-[1px] w-12 bg-slate-200"></div>
            <div class="flex items-center gap-2 stepper-item active">
                <span class="w-8 h-8 rounded-full bg-blue-600 text-white flex items-center justify-center text-xs shadow-lg shadow-blue-200">2</span>
                <span>Checkout</span>
            </div>
            <div class="h-[1px] w-12 bg-slate-200"></div>
            <div class="flex items-center gap-2 stepper-item text-slate-400">
                <span class="w-8 h-8 rounded-full bg-slate-200 flex items-center justify-center text-xs">3</span>
                <span class="hidden md:block">Confirmation</span>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-10">
            <div class="lg:col-span-8 space-y-8">
                <div class="bg-white p-8 rounded-3xl border border-slate-200 shadow-sm">
                    <h3 class="text-xl font-black text-slate-900 mb-6 flex items-center">
                        <i class="fas fa-truck mr-3 text-blue-500"></i> Shipping Address
                    </h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="text-xs font-bold text-slate-400 uppercase mb-2 block">Full Name</label>
                            <input type="text" class="input-field" placeholder="John Doe" />
                        </div>
                        <div>
                            <label class="text-xs font-bold text-slate-400 uppercase mb-2 block">Phone Number</label>
                            <input type="text" class="input-field" placeholder="+91 98765 43210" />
                        </div>
                        <div class="md:col-span-2">
                            <label class="text-xs font-bold text-slate-400 uppercase mb-2 block">Complete Address</label>
                            <textarea class="input-field h-24 resize-none" placeholder="Flat No, Street, Area..."></textarea>
                        </div>
                        <div>
                            <label class="text-xs font-bold text-slate-400 uppercase mb-2 block">City</label>
                            <input type="text" class="input-field" placeholder="Mumbai" />
                        </div>
                        <div>
                            <label class="text-xs font-bold text-slate-400 uppercase mb-2 block">Pincode</label>
                            <input type="text" class="input-field" placeholder="400001" />
                        </div>
                    </div>
                </div>

                <div class="bg-white p-8 rounded-3xl border border-slate-200 shadow-sm">
                    <h3 class="text-xl font-black text-slate-900 mb-6 flex items-center">
                        <i class="fas fa-credit-card mr-3 text-blue-500"></i> Payment Method
                    </h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <label class="relative cursor-pointer">
                            <input type="radio" name="pay" class="hidden payment-radio" checked />
                            <div class="payment-option">
                                <i class="fas fa-university text-blue-600 text-xl"></i>
                                <div>
                                    <p class="font-bold text-slate-900 text-sm">Online Payment</p>
                                    <p class="text-[10px] text-slate-500 uppercase">Cards, UPI, Netbanking</p>
                                </div>
                            </div>
                        </label>
                        <label class="relative cursor-pointer">
                            <input type="radio" name="pay" class="hidden payment-radio" />
                            <div class="payment-option">
                                <i class="fas fa-wallet text-slate-600 text-xl"></i>
                                <div>
                                    <p class="font-bold text-slate-900 text-sm">Cash on Delivery</p>
                                    <p class="text-[10px] text-slate-500 uppercase">Pay when you receive</p>
                                </div>
                            </div>
                        </label>
                    </div>
                </div>
            </div>

            <div class="lg:col-span-4">
                <div class="bg-slate-900 text-white p-8 rounded-3xl sticky top-10 shadow-xl">
                    <h3 class="text-lg font-bold mb-6 border-b border-slate-700 pb-4">Order Summary</h3>
                    
                    <div class="space-y-4 mb-8">
                        <div class="flex justify-between items-center text-sm">
                            <span class="text-slate-400">High-Performance Battery x 1</span>
                            <span class="font-bold">₹18,500</span>
                        </div>
                        <div class="flex justify-between items-center text-sm">
                            <span class="text-slate-400">LED Headlight x 2</span>
                            <span class="font-bold">₹1,900</span>
                        </div>
                        <div class="h-[1px] bg-slate-700 my-4"></div>
                        <div class="flex justify-between items-center text-sm">
                            <span class="text-slate-400">Delivery Charges</span>
                            <span class="text-emerald-400 font-bold uppercase text-[10px]">Free</span>
                        </div>
                        <div class="flex justify-between items-center text-xl pt-4">
                            <span class="font-black">Total</span>
                            <span class="font-black text-blue-400">₹20,400</span>
                        </div>
                    </div>

                    <asp:Button ID="btnPlaceOrder" runat="server" Text="Complete Purchase" 
                        class="w-full bg-blue-600 hover:bg-blue-500 text-white font-black py-4 rounded-2xl transition-all shadow-lg shadow-blue-900/50 cursor-pointer" />
                    
                    <p class="text-[10px] text-slate-500 text-center mt-6">
                        <i class="fas fa-shield-halved mr-1"></i> Secure 256-bit SSL Encrypted Payment
                    </p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>