<%@ Page Title="Manage Orders" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
AutoEventWireup="true" CodeFile="VendorOrders.aspx.cs"
Inherits="Vendor_VendorOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="p-6">
    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-6">
        <div class="bg-white p-4 rounded-xl shadow">💰 Earnings <br /><b>₹<asp:Literal ID="litEarn" runat="server" /></b></div>
        <div class="bg-white p-4 rounded-xl shadow">📦 Orders <br /><b><asp:Literal ID="litOrders" runat="server" /></b></div>
        <div class="bg-white p-4 rounded-xl shadow">🚚 Pending <br /><b><asp:Literal ID="litPending" runat="server" /></b></div>
        <div class="bg-white p-4 rounded-xl shadow">✅ Delivered <br /><b><asp:Literal ID="litDelivered" runat="server" /></b></div>
    </div>

    <input type="text" id="txtSearch" placeholder="Search Order ID..."
        class="w-full p-3 mb-4 border rounded-xl" onkeyup="filterOrders()" />

    <asp:Repeater ID="rptOrders" runat="server">
        <ItemTemplate>
            <div class="order-card bg-white p-4 rounded-xl shadow mb-4 flex justify-between items-center">
                <div>
                    <h4 class="font-bold">Order #<%# Eval("OrderID") %></h4>
                    <p class="text-sm text-gray-500"><%# Eval("CreatedAt", "{0:dd MMM yyyy}") %></p>
                    <p class="font-bold text-blue-600">₹<%# Eval("TotalAmount", "{0:N2}") %></p>
                    <span class='<%# GetStatusClass(Eval("OrderStatus").ToString()) %> px-3 py-1 text-xs rounded-full'>
                        <%#: Eval("OrderStatus") %>
                    </span>
                </div>
                <div class="actions-btn flex gap-2">
                    <button type="button" onclick="openOrder(<%# Eval("OrderID") %>)"
                        class="bg-slate-900 hover:bg-blue-600 text-white px-4 py-2 rounded-xl text-xs font-bold transition">View Details</button>
                    <select onchange="updateStatus(<%# Eval("OrderID") %>, this)"
                        class="p-2 border rounded-lg">
                        <option value="Pending" <%# Eval("OrderStatus").ToString()=="Pending"?"selected":"" %>>Pending</option>
                        <option value="Shipped" <%# Eval("OrderStatus").ToString()=="Shipped"?"selected":"" %>>Shipped</option>
                        <option value="Delivered" <%# Eval("OrderStatus").ToString()=="Delivered"?"selected":"" %>>Delivered</option>
                        <option value="Cancelled" <%# Eval("OrderStatus").ToString()=="Cancelled"?"selected":"" %>>Cancelled</option>
                    </select>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>

<div id="orderModal" class="fixed inset-0 bg-black/60 hidden items-center justify-center z-50">
    <div class="bg-white w-[95%] max-w-3xl rounded-3xl shadow-2xl p-6 relative">
        <button type="button" onclick="closeModal()" class="absolute top-4 right-4 text-gray-400 hover:text-red-500">Close</button>
        <h2 class="text-2xl font-black text-slate-900 mb-6">Order Details</h2>
        <div id="orderItems" class="space-y-4 max-h-[400px] overflow-y-auto"></div>
        <div class="mt-6 border-t pt-4 flex justify-between text-lg font-black">
            <span>Total</span><span id="orderTotal" class="text-blue-600">₹0</span>
        </div>
    </div>
</div>

<script>
function openOrder(id) {
    const modal = document.getElementById("orderModal");
    modal.classList.remove("hidden");
    modal.classList.add("flex");
    const container = document.getElementById("orderItems");
    container.replaceChildren();
    document.getElementById("orderTotal").textContent = "Loading...";

    $.ajax({
        type: "POST",
        url: "VendorOrders.aspx/GetOrderItems",
        data: JSON.stringify({ orderId: id }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (res) {
            const rows = Array.isArray(res.d) ? res.d : [];
            let total = 0;
            container.replaceChildren();
            rows.forEach(function (item) {
                const qty = Number(item.Qty) || 0;
                const price = Number(item.Price) || 0;
                total += qty * price;

                const card = document.createElement("div");
                card.className = "flex justify-between items-center bg-slate-50 p-4 rounded-xl border";
                const details = document.createElement("div");
                const name = document.createElement("p");
                name.className = "font-bold text-slate-900";
                name.textContent = item.PartName || "";
                const quantity = document.createElement("p");
                quantity.className = "text-xs text-slate-500";
                quantity.textContent = "Qty: " + qty;
                details.append(name, quantity);

                const amount = document.createElement("p");
                amount.className = "font-bold text-slate-900";
                amount.textContent = "₹" + price.toFixed(2);
                card.append(details, amount);
                container.appendChild(card);
            });
            document.getElementById("orderTotal").textContent = "₹" + total.toFixed(2);
        },
        error: function () {
            document.getElementById("orderTotal").textContent = "Could not load order items.";
        }
    });
}

function closeModal() {
    const modal = document.getElementById("orderModal");
    modal.classList.add("hidden");
    modal.classList.remove("flex");
}

function updateStatus(id, el) {
    const selected = el.value;
    $.ajax({
        type: "POST",
        url: "VendorOrders.aspx/UpdateStatus",
        data: JSON.stringify({ orderId: id, status: selected }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (res) {
            if (res.d !== "Order status updated.") {
                alert(res.d || "Unable to update order.");
                location.reload();
                return;
            }
            location.reload();
        },
        error: function () {
            alert("Unable to update order status.");
            location.reload();
        }
    });
}

function filterOrders() {
    const input = document.getElementById("txtSearch").value.toLowerCase();
    document.querySelectorAll(".order-card").forEach(function (card) {
        card.style.display = card.innerText.toLowerCase().includes(input) ? "" : "none";
    });
}
</script>
</asp:Content>
