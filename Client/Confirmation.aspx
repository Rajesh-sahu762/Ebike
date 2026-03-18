<%@ Page Title="Order Confirmed" Language="C#" MasterPageFile="~/Client/ClientMaster.master" AutoEventWireup="true" CodeFile="Confirmation.aspx.cs" Inherits="ConfirmationPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />

    <style>
        body { background-color: #ffffff; font-family: 'Inter', sans-serif; }
        
        /* Success Animation */
        .success-checkmark {
            width: 80px; height: 80px; margin: 0 auto;
            background: #ecfdf5; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            animation: scaleIn 0.5s cubic-bezier(0.12, 0, 0.39, 0) forwards;
        }
        
        @keyframes scaleIn {
            from { transform: scale(0); opacity: 0; }
            to { transform: scale(1); opacity: 1; }
        }

        .order-card {
            border: 1px solid #f1f5f9;
            background: #f8fafc;
            border-radius: 24px;
        }
    </style>

    <div class="min-h-[80vh] flex items-center justify-center px-4">
        <div class="max-w-md w-full text-center">
            
            <div class="success-checkmark mb-6">
                <i class="fas fa-check text-3xl text-emerald-500"></i>
            </div>

            <h1 class="text-3xl font-black text-slate-900 mb-2">Order Confirmed!</h1>
            <p class="text-slate-500 mb-8">Hooray! Your e-bike parts are on the way. We've sent the receipt to your email.</p>

            <div class="order-card p-6 mb-8 text-left">
                <div class="flex justify-between items-center mb-4">
                    <span class="text-xs font-bold text-slate-400 uppercase tracking-widest">Order Number</span>
                    <span class="font-black text-blue-600">#<asp:Literal ID="litOrderID" runat="server"></asp:Literal></span>
                </div>
                <div class="flex justify-between items-center mb-4">
                    <span class="text-xs font-bold text-slate-400 uppercase tracking-widest">Estimated Delivery</span>
                    <span class="font-bold text-slate-900">3-5 Business Days</span>
                </div>
                <div class="h-[1px] bg-slate-200 my-4"></div>
                <div class="flex items-center gap-3">
                    <div class="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center">
                        <i class="fas fa-truck-fast text-blue-600 text-sm"></i>
                    </div>
                    <div>
                        <p class="text-xs font-bold text-slate-900">Standard Shipping</p>
                        <p class="text-[10px] text-slate-500">Safe & Tracked Delivery</p>
                    </div>
                </div>
            </div>

            <div class="space-y-3">
                <a href="Orders.aspx" class="block w-full bg-slate-900 text-white font-bold py-4 rounded-2xl hover:bg-slate-800 transition shadow-xl shadow-slate-200">
                    Track Your Order
                </a>
                <a href="Parts.aspx" class="block w-full bg-white border border-slate-200 text-slate-600 font-bold py-4 rounded-2xl hover:bg-slate-50 transition">
                    Continue Shopping
                </a>
            </div>

            <p class="mt-10 text-xs text-slate-400">
                Need help? <a href="#" class="text-blue-500 font-bold underline">Contact Support</a>
            </p>
        </div>
    </div>
</asp:Content>