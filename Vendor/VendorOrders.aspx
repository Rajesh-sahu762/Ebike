<%@ Page Title="Manage Orders" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
AutoEventWireup="true" CodeFile="VendorOrders.aspx.cs"
Inherits="Vendor_VendorOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="p-6">

    <!-- TOP CARDS -->
    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
        <div class="bg-white p-4 rounded-xl shadow">💰 Earnings <br /><b>₹<asp:Literal ID="litEarn" runat="server" /></b></div>
        <div class="bg-white p-4 rounded-xl shadow">📦 Orders <br /><b><asp:Literal ID="litOrders" runat="server" /></b></div>
        <div class="bg-white p-4 rounded-xl shadow">🚚 Pending <br /><b><asp:Literal ID="litPending" runat="server" /></b></div>
        <div class="bg-white p-4 rounded-xl shadow">✅ Delivered <br /><b><asp:Literal ID="litDelivered" runat="server" /></b></div>
    </div>

    <!-- SEARCH -->
    <input type="text" id="txtSearch" placeholder="Search Order ID..."
        class="w-full p-3 mb-4 border rounded-xl" onkeyup="filterOrders()" />

    <!-- ORDERS -->
    <asp:Repeater ID="rptOrders" runat="server">
        <ItemTemplate>

            <div class="bg-white p-4 rounded-xl shadow mb-4 flex justify-between items-center">

                <div>
                    <h4 class="font-bold">Order #<%# Eval("OrderID") %></h4>
                    <p class="text-sm text-gray-500"><%# Eval("CreatedAt", "{0:dd MMM yyyy}") %></p>
                    <p class="font-bold text-blue-600">₹<%# Eval("TotalAmount") %></p>

                    <!-- STATUS BADGE -->
                    <span class='<%# GetStatusClass(Eval("OrderStatus").ToString()) %> px-3 py-1 text-xs rounded-full'>
                        <%# Eval("OrderStatus") %>
                    </span>
                </div>

   
                <div class="actions-btn">
                               <button type="button" onclick="openOrder(<%# Eval("OrderID") %>)"
class="bg-slate-900 hover:bg-blue-600 text-white px-4 py-2 rounded-xl text-xs font-bold transition">
View Details
</button>
         
                <!-- STATUS UPDATE -->
                <select onchange="updateStatus(<%# Eval("OrderID") %>, this)"
                    class="p-2 border rounded-lg">
                    <option <%# Eval("OrderStatus").ToString()=="Pending"?"selected":"" %>>Pending</option>
                    <option <%# Eval("OrderStatus").ToString()=="Shipped"?"selected":"" %>>Shipped</option>
                    <option <%# Eval("OrderStatus").ToString()=="Delivered"?"selected":"" %>>Delivered</option>
                    <option <%# Eval("OrderStatus").ToString()=="Cancelled"?"selected":"" %>>Cancelled</option>
                </select>
                           </div>
            </div>

        </ItemTemplate>
    </asp:Repeater>

</div>


    <!-- PREMIUM MODAL -->
<div id="orderModal" class="fixed inset-0 bg-black/60 hidden items-center justify-center z-50">

    <div class="bg-white w-[95%] max-w-3xl rounded-3xl shadow-2xl p-6 relative animate-fadeIn">

        <!-- CLOSE -->
        <button onclick="closeModal()" class="absolute top-4 right-4 text-gray-400 hover:text-red-500">
            <i class="fas fa-times text-lg"></i>
        </button>

        <!-- HEADER -->
        <h2 class="text-2xl font-black text-slate-900 mb-6">Order Details</h2>

        <!-- ITEMS -->
        <div id="orderItems" class="space-y-4 max-h-[400px] overflow-y-auto"></div>

        <!-- TOTAL -->
        <div class="mt-6 border-t pt-4 flex justify-between text-lg font-black">
            <span>Total</span>
            <span id="orderTotal" class="text-blue-600">₹0</span>
        </div>

    </div>
</div>

<style>
@keyframes fadeIn {
    from { opacity: 0; transform: scale(0.95); }
    to { opacity: 1; transform: scale(1); }
}
.animate-fadeIn {
    animation: fadeIn 0.3s ease;
}
</style>

<script>


    function openOrder(id) {

        document.getElementById("orderModal").classList.remove("hidden");
        document.getElementById("orderModal").classList.add("flex");

        $.ajax({
            type: "POST",
            url: "VendorOrders.aspx/GetOrderItems",
            data: JSON.stringify({ orderId: id }),
            contentType: "application/json",
            success: function (res) {

                let data = res.d.split('|'); // simple string split
                let html = "";
                let total = 0;

                for (let i = 0; i < data.length - 1; i++) {

                    let row = data[i].split('~');

                    let name = row[0];
                    let qty = parseInt(row[1]);
                    let price = parseFloat(row[2]);

                    total += price * qty;

                    html += `
                    <div class="flex justify-between items-center bg-slate-50 p-4 rounded-xl border">
                    
                        <div>
                            <p class="font-bold text-slate-900">${name}</p>
                            <p class="text-xs text-slate-500">Qty: ${qty}</p>
                        </div>

                        <div class="text-right">
                            <p class="font-bold text-slate-900">₹${price}</p>
                        </div>

                    </div>`;
                }

                document.getElementById("orderItems").innerHTML = html;
                document.getElementById("orderTotal").innerText = "₹" + total;

            }
        });
    }

    function closeModal() {
        document.getElementById("orderModal").classList.add("hidden");
    }


    function updateStatus(id, el) {
        $.ajax({
            type: "POST",
            url: "VendorOrders.aspx/UpdateStatus",
            data: JSON.stringify({ orderId: id, status: el.value }),
            contentType: "application/json",
            success: function () {
                location.reload();
            }
        });
    }

    function filterOrders() {
        let input = document.getElementById("txtSearch").value.toLowerCase();
        let cards = document.querySelectorAll(".bg-white");

        cards.forEach(card => {
            card.style.display = card.innerText.toLowerCase().includes(input) ? "" : "none";
    });
    }

</script>

</asp:Content>