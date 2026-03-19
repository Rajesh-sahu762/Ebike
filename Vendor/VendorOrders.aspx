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

                <!-- ADD BUTTON -->
<button onclick="openOrder(<%# Eval("OrderID") %>)"
class="bg-black text-white px-4 py-2 rounded-lg text-xs font-bold">
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

        </ItemTemplate>
    </asp:Repeater>

</div>

    <!-- POPUP -->
<div id="orderModal" class="fixed inset-0 bg-black/50 hidden items-center justify-center z-50">
    
    <div class="bg-white w-[90%] max-w-2xl rounded-2xl p-6 relative">

        <button onclick="closeModal()" class="absolute top-3 right-3 text-gray-500">✖</button>

        <h3 class="text-xl font-bold mb-4">Order Details</h3>

        <div id="orderItems"></div>

    </div>
</div>

<script>

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


    function openOrder(id) {

        document.getElementById("orderModal").classList.remove("hidden");
        document.getElementById("orderModal").classList.add("flex");

        $.ajax({
            type: "POST",
            url: "VendorOrders.aspx/GetOrderItems",
            data: JSON.stringify({ orderId: id }),
            contentType: "application/json",
            success: function (res) {

                let data = JSON.parse(res.d);
                let html = "";

                data.forEach(item => {
                    html += `
                    <div class="flex justify-between border-b py-2">
                        <div>
                            <p class="font-bold">${item.PartName}</p>
                            <p class="text-xs text-gray-500">Qty: ${item.Qty}</p>
                        </div>
                        <div class="font-bold">₹${item.Price}</div>
                    </div>`;
            });

        document.getElementById("orderItems").innerHTML = html;
    }
    });
    }

    function closeModal() {
        document.getElementById("orderModal").classList.add("hidden");
    }

</script>

</asp:Content>