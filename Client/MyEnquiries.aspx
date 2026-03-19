<%@ Page Title="My Enquiries" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true" CodeFile="MyEnquiries.aspx.cs"
Inherits="Client_MyEnquiries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script src="https://cdn.tailwindcss.com"></script>

    <section class="account-wrapper bg-gray-50 min-h-screen py-10">
        <div class="account-grid max-w-7xl mx-auto px-4 lg:flex gap-8">
            
            <div class="account-sidebar w-full lg:w-[300px] shrink-0 h-fit sticky top-24 bg-white rounded-3xl shadow-sm border border-gray-100 overflow-hidden">
                <div class="profile-header text-center relative pb-6">
                    <div class="profile-banner h-24 bg-gradient-to-r from-orange-500 to-yellow-400"></div>
                    <div class="absolute left-1/2 -translate-x-1/2 top-12">
                        <img src="/Uploads/user.jpg" class="w-20 h-20 rounded-full border-4 border-white shadow-md object-cover" />
                    </div>
                    <div class="mt-12 px-4">
                        <h3 class="text-lg font-bold text-gray-800">My Account</h3>
                        <p class="text-xs text-gray-500 uppercase tracking-wider font-semibold">Activity Dashboard</p>
                    </div>
                </div>
                <div class="account-menu p-4 flex flex-col gap-1">
                    <a href="MyProfile.aspx" class="flex items-center gap-3 px-4 py-3 rounded-xl hover:bg-gray-50 text-gray-700 transition-all font-medium">👤 Profile</a>
                    <a href="Wishlist.aspx" class="flex items-center gap-3 px-4 py-3 rounded-xl hover:bg-gray-50 text-gray-700 transition-all font-medium">❤️ Wishlist</a>
                    <a href="MyRentals.aspx" class="flex items-center gap-3 px-4 py-3 rounded-xl hover:bg-gray-50 text-gray-700 transition-all font-medium">🛵 My Rentals</a>
                    <a href="MyEnquiries.aspx" class="active flex items-center gap-3 px-4 py-3 rounded-xl bg-red-50 text-red-600 transition-all font-bold">📩 My Enquiries & Orders</a>
                    <hr class="my-3 border-gray-100" />
                    <a href="Logout.aspx" class="flex items-center gap-3 px-4 py-3 rounded-xl text-gray-500 hover:text-red-600 transition-all font-medium">🚪 Logout</a>
                </div>
            </div>

            <div class="account-content flex-1 mt-8 lg:mt-0">
                
                <div class="flex p-1 bg-gray-200/50 rounded-2xl mb-8 w-fit border border-gray-200">
                    <button type="button" onclick="switchTab('enquiries')" id="btnEnq" class="tab-btn active px-8 py-2.5 rounded-xl text-sm font-bold transition-all">My Enquiries</button>
                    <button type="button" onclick="switchTab('orders')" id="btnOrd" class="tab-btn px-8 py-2.5 rounded-xl text-sm font-bold transition-all text-gray-500">My Orders</button>
                </div>

                <div id="tab-enquiries" class="tab-content space-y-4">
                    <h3 class="text-2xl font-black text-gray-900 mb-6">Recent Enquiries</h3>
                    <asp:Repeater ID="rptEnquiries" runat="server">
                        <ItemTemplate>
                            <div class="enquiry-card bg-white p-5 rounded-2xl border border-gray-100 shadow-sm hover:shadow-md transition-all flex flex-col sm:flex-row gap-6 items-center">
                               <img src='/Uploads/Bikes/<%# Eval("Image1") == DBNull.Value || Eval("Image1") == null ? "no-bike.jpg" : Eval("Image1") %>' 
     class="w-32 h-20 object-cover rounded-xl shadow-inner" />
                                <div class="flex-1 text-center sm:text-left">
                                    <h4 class="text-lg font-bold text-gray-800"><%# Eval("ModelName") %></h4>
                                    <p class="text-xs font-bold text-red-500 uppercase"><%# Eval("ShopName") %></p>
                                    <p class="text-sm text-gray-600 mt-2 line-clamp-1 italic text-gray-400">"<%# Eval("Message") %>"</p>
                                    <div class="flex items-center gap-4 mt-3 justify-center sm:justify-start">
                                        <span class="text-[11px] font-bold text-gray-400"><i class="far fa-calendar-alt mr-1"></i> <%# Eval("CreatedAt","{0:dd MMM yyyy}") %></span>
                                       <span class='badge px-3 py-1 rounded-full text-[10px] font-black uppercase <%# Convert.ToBoolean(Eval("IsViewed")) ? "bg-green-100 text-green-700" : "bg-orange-100 text-orange-700" %>'>
    <%# Convert.ToBoolean(Eval("IsViewed")) ? "Seen by Dealer" : "Pending Response" %>
</span>
                                    </div>
                                </div>
                                <div class="flex flex-row sm:flex-col gap-2 w-full sm:w-fit">
                                    <a href='BikeDetails.aspx?slug=<%# Eval("Slug") %>' class="flex-1 sm:w-28 text-center bg-gray-900 text-white py-2 rounded-xl text-xs font-bold hover:bg-gray-800 transition-all">View Info</a>
                                    <button type="button" onclick='deleteEnquiry(<%# Eval("LeadID") %>, this)' class="flex-1 sm:w-28 bg-red-50 text-red-500 py-2 rounded-xl text-xs font-bold hover:bg-red-500 hover:text-white transition-all">Remove</button>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div id="emptyEnq" runat="server" visible="false" class="py-20 text-center bg-white rounded-3xl border border-dashed border-gray-200">
                        <p class="text-gray-400 font-medium">No enquiries found</p>
                    </div>
                </div>

                <div id="tab-orders" class="tab-content hidden space-y-4">
                    <h3 class="text-2xl font-black text-gray-900 mb-6">Spare Parts Orders</h3>
                    <asp:Repeater ID="rptOrders" runat="server">
                        <ItemTemplate>
                            <div class="order-card bg-white p-5 rounded-2xl border border-gray-100 shadow-sm flex flex-col sm:flex-row gap-6 items-center border-l-4 border-l-blue-500">
                                <div class="bg-blue-50 w-20 h-20 rounded-2xl flex items-center justify-center text-blue-600">
                                    <i class="fas fa-box-open text-3xl"></i>
                                </div>
                                <div class="flex-1 text-center sm:text-left">
                                    <div class="flex justify-between items-start">
                                        <h4 class="text-lg font-black text-gray-800">Order #<%# Eval("OrderNumber") %></h4>
                                        <span class="text-lg font-black text-blue-600">₹<%# Eval("TotalAmount", "{0:N0}") %></span>
                                    </div>
                                    <p class="text-xs text-gray-500 mt-1">Order Date: <%# Eval("CreatedAt", "{0:dd MMM yyyy}") %></p>
                                    <div class="flex items-center gap-3 mt-4 justify-center sm:justify-start">
                                        <span class="px-3 py-1 rounded-full text-[10px] font-black uppercase bg-blue-100 text-blue-700">
                                            Status: <%# Eval("Status") %>
                                        </span>
                                        <span class="text-xs font-medium text-gray-600"><%# Eval("TotalItems") %> Items Ordered</span>
                                    </div>
                                </div>
                                
                                <div class="w-full sm:w-fit flex flex-col gap-2">
    <a href='<%# "OrderDetails.aspx?id=" + Eval("OrderID") %>' class="block text-center bg-blue-600 text-white px-6 py-3 rounded-xl text-sm font-bold hover:bg-blue-700 shadow-lg shadow-blue-200 transition-all">Track Order</a>
    
    <%# Eval("OrderStatus").ToString() == "Pending" ? "<button type='button' onclick='cancelOrder(" + Eval("OrderID") + ", this)' class='block text-center bg-red-50 text-red-500 px-6 py-2 rounded-xl text-xs font-bold hover:bg-red-500 hover:text-white transition-all'>Cancel Order</button>" : "" %>
</div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div id="emptyOrd" runat="server" visible="false" class="py-20 text-center bg-white rounded-3xl border border-dashed border-gray-200">
                         <p class="text-gray-400 font-medium">You haven't ordered any parts yet</p>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <style>
        .tab-btn.active { background: white; color: #ef4444; box-shadow: 0 4px 12px rgba(0,0,0,0.05); }
        .line-clamp-1 { display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; }
    </style>

    <script>
        function switchTab(type) {
            // Content Toggle
            document.getElementById('tab-enquiries').classList.toggle('hidden', type !== 'enquiries');
            document.getElementById('tab-orders').classList.toggle('hidden', type !== 'orders');

            // Button Toggle
            document.getElementById('btnEnq').classList.toggle('active', type === 'enquiries');
            document.getElementById('btnEnq').classList.toggle('text-gray-500', type !== 'enquiries');
            document.getElementById('btnOrd').classList.toggle('active', type === 'orders');
            document.getElementById('btnOrd').classList.toggle('text-gray-500', type !== 'orders');
        }

        function deleteEnquiry(id, btn) {
            if (!confirm("Delete this enquiry?")) return;
            $.ajax({
                type: "POST",
                url: "MyEnquiries.aspx/DeleteEnquiry",
                data: JSON.stringify({ id: id }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function () {
                    $(btn).closest(".enquiry-card").fadeOut(300, function () { $(this).remove(); });
                }
            });
        }


        function cancelOrder(id, btn) {
            if (!confirm("Are you sure you want to cancel this order?")) return;

            $.ajax({
                type: "POST",
                url: "MyEnquiries.aspx/CancelOrder", // Backend function ka naam
                data: JSON.stringify({ orderId: id }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (res) {
                    if (res.d === "ok") {
                        alert("Order cancelled successfully!");
                        // Card ko gayab karne ke bajaye status text update kar sakte ho ya page reload
                        location.reload();
                    } else {
                        alert("Error: " + res.d);
                    }
                },
                error: function (xhr) {
                    console.error(xhr.responseText);
                }
            });
        }
    </script>
</asp:Content>