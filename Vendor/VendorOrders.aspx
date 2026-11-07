<%@ Page Title="Manage Orders" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
AutoEventWireup="true" CodeFile="VendorOrders.aspx.cs"
Inherits="Vendor_VendorOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
.vo-page{padding:28px 0 42px;color:#26344a}
.vo-heading{margin-bottom:22px}.vo-kicker{font:700 11px 'Quicksand',sans-serif;letter-spacing:1.2px;text-transform:uppercase;color:#1686a5;margin-bottom:7px}
.vo-heading h2{font:800 27px 'Manrope',sans-serif;color:#26344a;margin:0}.vo-heading p{font-size:14px;color:#7b8798;margin:7px 0 0}
.vo-stats{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:16px;margin-bottom:22px}
.vo-stat{padding:19px;border-radius:17px;background:#edf1f7;box-shadow:7px 7px 16px #d3d9e2,-7px -7px 16px #fff}
.vo-stat-label{font:700 11px 'Quicksand',sans-serif;color:#8290a2;text-transform:uppercase;letter-spacing:.7px}
.vo-stat-value{font:800 25px 'Manrope',sans-serif;color:#26344a;margin-top:7px}
.vo-search{width:100%;max-width:390px;min-height:44px;border:0;border-radius:12px;background:#edf1f7;padding:10px 14px;box-shadow:inset 4px 4px 8px #d5dbe4,inset -4px -4px 8px #fff;outline:none;margin-bottom:18px}
.vo-order-list{display:grid;gap:14px}
.vo-order-card{display:flex;justify-content:space-between;align-items:center;gap:20px;padding:19px 21px;border-radius:17px;background:#edf1f7;box-shadow:7px 7px 16px #d3d9e2,-7px -7px 16px #fff}
.vo-order-main{min-width:0}.vo-order-id{font:800 16px 'Manrope',sans-serif;color:#26344a;margin:0 0 5px}
.vo-order-date{font-size:12px;color:#8994a4;margin-bottom:8px}.vo-order-amount{font:800 17px 'Manrope',sans-serif;color:#147f9e;margin-bottom:9px}
.vo-order-card .actions-btn{display:flex;align-items:center;gap:10px;flex-wrap:wrap}
.vo-order-card .actions-btn button{border:0;border-radius:10px;background:#263b55;color:#fff;padding:10px 14px;font-size:12px;font-weight:700}
.vo-order-card .actions-btn select{min-height:39px;border:0;border-radius:10px;background:#edf1f7;padding:8px 10px;box-shadow:inset 3px 3px 6px #d5dbe4,inset -3px -3px 6px #fff;color:#475569;font-size:12px}
.vo-status{display:inline-block;padding:5px 10px;border-radius:20px;font:700 10px 'Quicksand',sans-serif}
.vo-order-card .bg-yellow-100{background:#fff1c9;color:#8a650c}.vo-order-card .bg-green-100{background:#d9f2e3;color:#176a43}.vo-order-card .bg-red-100{background:#fde1e1;color:#a52b2b}.vo-order-card .bg-blue-100{background:#dcecf8;color:#235b8a}
#orderModal{z-index:1055;padding:18px;display:none}#orderModal.flex{display:flex;align-items:center;justify-content:center;background:rgba(15,23,42,.62)}#orderModal>div{position:relative;width:95%;max-width:48rem;max-height:90vh;overflow:auto;background:#edf1f7;border-radius:21px;padding:25px;box-shadow:12px 12px 28px rgba(0,0,0,.2)}
#orderModal h2{font:800 22px 'Manrope',sans-serif;color:#26344a}
#orderItems>div{background:#f4f6fa!important;border:0!important;border-radius:12px!important}
#orderTotal{color:#147f9e!important}
@media(max-width:850px){.vo-stats{grid-template-columns:repeat(2,minmax(0,1fr))}}
@media(max-width:575px){.vo-page{padding:18px 0 30px}.vo-heading h2{font-size:23px}.vo-stats{gap:10px}.vo-stat{padding:14px}.vo-stat-value{font-size:21px}.vo-order-card{align-items:flex-start;flex-direction:column;padding:16px}.vo-order-card .actions-btn{width:100%}.vo-order-card .actions-btn button,.vo-order-card .actions-btn select{flex:1}#orderModal>div{padding:18px}}
</style>

<div class="container-fluid vo-page">
    <div class="vo-heading">
        <div class="vo-kicker">Sales overview</div>
        <h2>Manage Orders</h2>
        <p>Track customer orders, monitor earnings and update order progress.</p>
    </div>

    <div class="vo-stats">
        <div class="vo-stat"><div class="vo-stat-label">Total Earnings</div><div class="vo-stat-value">₹<asp:Literal ID="litEarn" runat="server" /></div></div>
        <div class="vo-stat"><div class="vo-stat-label">Total Orders</div><div class="vo-stat-value"><asp:Literal ID="litOrders" runat="server" /></div></div>
        <div class="vo-stat"><div class="vo-stat-label">Pending Orders</div><div class="vo-stat-value"><asp:Literal ID="litPending" runat="server" /></div></div>
        <div class="vo-stat"><div class="vo-stat-label">Delivered Orders</div><div class="vo-stat-value"><asp:Literal ID="litDelivered" runat="server" /></div></div>
    </div>

    <input type="text" id="txtSearch" placeholder="Search by Order ID..." class="vo-search" onkeyup="filterOrders()" />

    <div class="vo-order-list">
        <asp:Repeater ID="rptOrders" runat="server">
            <ItemTemplate>
                <div class="vo-order-card">
                    <div class="vo-order-main">
                        <h4 class="vo-order-id">Order #<%# Eval("OrderID") %></h4>
                        <div class="vo-order-date"><%# Eval("CreatedAt", "{0:dd MMM yyyy}") %></div>
                        <div class="vo-order-amount">₹<%# Eval("TotalAmount") %></div>
                        <span class='vo-status <%# GetStatusClass(Eval("OrderStatus").ToString()) %>'><%# Eval("OrderStatus") %></span>
                    </div>
                    <div class="actions-btn">
                        <button type="button" onclick="openOrder(<%# Eval("OrderID") %>)">View Details</button>
                        <select onchange="updateStatus(<%# Eval("OrderID") %>, this)">
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
</div>

<div id="orderModal" class="fixed inset-0 bg-black/60 hidden items-center justify-center">
    <div class="w-[95%] max-w-3xl relative">
        <button onclick="closeModal()" class="absolute top-3 right-4 text-gray-400 hover:text-red-500" aria-label="Close">&times;</button>
        <h2 class="mb-5">Order Details</h2>
        <div id="orderItems" class="space-y-4 max-h-[400px] overflow-y-auto"></div>
        <div class="mt-6 border-t pt-4 flex justify-between text-lg font-black">
            <span>Total</span><span id="orderTotal">₹0</span>
        </div>
    </div>
</div>

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
                let data = res.d.split('|');
                let container = document.getElementById("orderItems");
                container.innerHTML = "";
                let total = 0;
                for (let i = 0; i < data.length - 1; i++) {
                    let row = data[i].split('~');
                    let name = row[0];
                    let qty = parseInt(row[1]) || 0;
                    let price = parseFloat(row[2]) || 0;
                    total += price * qty;
                    let itemDiv = document.createElement("div");
                    itemDiv.className = "flex justify-between items-center bg-slate-50 p-4 rounded-xl border";
                    let leftDiv = document.createElement("div");
                    let pName = document.createElement("p");
                    pName.className = "font-bold text-slate-900"; pName.textContent = name;
                    let pQty = document.createElement("p");
                    pQty.className = "text-xs text-slate-500"; pQty.textContent = "Qty: " + qty;
                    leftDiv.appendChild(pName); leftDiv.appendChild(pQty);
                    let rightDiv = document.createElement("div"); rightDiv.className = "text-right";
                    let pPrice = document.createElement("p"); pPrice.className = "font-bold text-slate-900"; pPrice.textContent = "₹" + price;
                    rightDiv.appendChild(pPrice); itemDiv.appendChild(leftDiv); itemDiv.appendChild(rightDiv); container.appendChild(itemDiv);
                }
                document.getElementById("orderTotal").innerText = "₹" + total;
            }
        });
    }
    function closeModal() {
        document.getElementById("orderModal").classList.add("hidden");
        document.getElementById("orderModal").classList.remove("flex");
    }
    function updateStatus(id, el) {
        $.ajax({
            type: "POST", url: "VendorOrders.aspx/UpdateStatus",
            data: JSON.stringify({ orderId: id, status: el.value }),
            contentType: "application/json",
            success: function () { location.reload(); }
        });
    }
    function filterOrders() {
        let input = document.getElementById("txtSearch").value.toLowerCase();
        let cards = document.querySelectorAll(".vo-order-card");
        cards.forEach(card => { card.style.display = card.innerText.toLowerCase().includes(input) ? "" : "none"; });
    }
</script>

</asp:Content>