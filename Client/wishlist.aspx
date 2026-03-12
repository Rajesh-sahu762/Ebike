<%@ Page Title="Wishlist" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true" CodeFile="Wishlist.aspx.cs"
Inherits="Client_Wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<section class="account-section">

<div class="account-grid">

<!-- LEFT SIDEBAR -->

<div class="account-sidebar">

<div class="profile-header">

<div class="profile-banner"></div>

<div class="profile-avatar">
<img src="../Uploads/user.jpg" class="avatar-img"/>
</div>

<div class="profile-info">

<h3>My Account</h3>
<p>Manage your activity</p>

</div>

</div>

<div class="account-menu">

<a href="MyProfile.aspx">👤 Profile</a>

<a href="Wishlist.aspx" class="active">❤️ Wishlist</a>

<a href="MyRentals.aspx">🛵 My Rentals</a>

<a href="MyEnquiries.aspx">📨 My Enquiries</a>

</div>

</div>


<!-- RIGHT CONTENT -->

<div class="account-content">

<div class="wishlist-header">

<h1>My Wishlist</h1>

<p>Save bikes you like and compare later</p>

</div>


<div id="wishlistGrid" runat="server" class="wishlist-grid">

<asp:Repeater ID="rptWishlist" runat="server">

<ItemTemplate>

<div class="wishlist-card">

<div class="wishlist-img">

<img src='/Uploads/Bikes/<%# Eval("Image1") %>' />

<button class="remove-btn"
onclick="removeWishlist(<%# Eval("BikeID") %>,this)">
💔
</button>

</div>

<div class="wishlist-body">

<h3 class="bike-name">
<%# Eval("ModelName") %>
</h3>

<div class="bike-price">
₹ <%# Eval("Price","{0:N0}") %>
</div>

<div class="wishlist-actions">

<a href='BikeDetails.aspx?slug=<%# Eval("Slug") %>'
class="btn-view">
View Details
</a>

<a href='Compare.aspx?b1=<%# Eval("BikeID") %>'
class="btn-compare">
Compare
</a>

</div>

</div>

</div>

</ItemTemplate>

</asp:Repeater>

</div>


<div id="emptyWishlist" runat="server" class="empty-wishlist" visible="false">

<div class="empty-icon">💔</div>

<h3>No bikes saved yet</h3>

<p>Browse electric bikes and save the ones you like</p>

<a href="Bikes.aspx" class="browse-btn">
Browse Bikes
</a>

</div>

</div>

</div>

</section>

<style>

/* PAGE */

/* ACCOUNT LAYOUT */

.account-section{

max-width:1200px;
margin:90px auto;
padding:0 20px;

}

.account-grid{

display:grid;
grid-template-columns:280px 1fr;
gap:30px;

}

/* SIDEBAR */

.account-sidebar{

background:#fff;
border-radius:16px;
box-shadow:0 10px 30px rgba(0,0,0,0.08);
overflow:hidden;

}

.profile-header{

text-align:center;
position:relative;
padding-bottom:20px;

}

.profile-banner{

height:110px;
background:linear-gradient(135deg,#ff7a18,#ffb347);

}

.profile-avatar{

position:absolute;
left:50%;
transform:translateX(-50%);
top:60px;

}

.avatar-img{

width:90px;
height:90px;
border-radius:50%;
border:4px solid #fff;

}

.profile-info{

margin-top:60px;

}

.profile-info h3{

font-size:18px;

}

.profile-info p{

font-size:13px;
color:#6b7280;

}

/* MENU */

.account-menu{

display:flex;
flex-direction:column;
padding:15px;
gap:6px;

}

.account-menu a{

padding:10px;
border-radius:8px;
text-decoration:none;
color:#374151;
font-size:14px;

}

.account-menu a:hover{

background:#f3f4f6;

}

.account-menu a.active{

background:#ffe4e6;
color:#ef4444;
font-weight:600;

}

/* RIGHT CONTENT */

.account-content{

min-height:400px;

}

.empty-wishlist{

text-align:center;

padding:80px 20px;

background:#fff;

border-radius:14px;

box-shadow:0 8px 25px rgba(0,0,0,0.05);

}

.empty-icon{

font-size:48px;

margin-bottom:10px;

}


.empty-wishlist h3{

font-size:22px;

margin-bottom:5px;

}

.empty-wishlist p{

color:#6b7280;

margin-bottom:20px;

}

.browse-btn{

background:#ef4444;

color:#fff;

padding:10px 22px;

border-radius:8px;

text-decoration:none;

display:inline-block;

}

.browse-btn:hover{

background:#dc2626;

}





.wishlist-section{

max-width:1200px;
margin:90px auto;
padding:0 20px;

}

/* HEADER */

.wishlist-header{

margin-bottom:30px;

}

.wishlist-header h1{

font-size:32px;
font-weight:700;

}

.wishlist-header p{

color:#6b7280;
margin-top:5px;

}

/* GRID */

.wishlist-grid{

display:grid;

grid-template-columns:
repeat(auto-fill,minmax(260px,1fr));

gap:25px;

}

/* CARD */

.wishlist-card{

background:#fff;

border-radius:14px;

overflow:hidden;

box-shadow:0 8px 25px rgba(0,0,0,0.06);

transition:0.3s;

}

.wishlist-card:hover{

transform:translateY(-6px);

box-shadow:0 14px 40px rgba(0,0,0,0.12);

}

/* IMAGE */

.wishlist-img{

height:170px;

background:#f3f4f6;

display:flex;

align-items:center;

justify-content:center;

position:relative;

padding:15px;

}

.wishlist-img img{

max-width:100%;
max-height:100%;
object-fit:contain;

}

/* REMOVE BUTTON */

.remove-btn{

position:absolute;

top:12px;
right:12px;

background:#fff;

border:none;

width:34px;
height:34px;

border-radius:50%;

font-size:16px;

cursor:pointer;

box-shadow:0 4px 12px rgba(0,0,0,0.15);

}

.remove-btn:hover{

background:#0f172a;
color:#fff;

}

/* BODY */

.wishlist-body{

padding:16px;

}

.bike-name{

font-size:16px;
font-weight:600;

margin-bottom:6px;

}

.bike-price{

font-size:18px;

font-weight:700;

color:#ef4444;

margin-bottom:12px;

}

/* ACTIONS */

.wishlist-actions{

display:flex;

gap:8px;

}

.btn-view{

flex:1;

text-align:center;

padding:8px;

background:#111827;

color:#fff;

border-radius:6px;

font-size:13px;

text-decoration:none;

}

.btn-view:hover{

background:#ef4444;

}

.btn-compare{

flex:1;

text-align:center;

padding:8px;

border:2px solid #111827;

border-radius:6px;

font-size:13px;

text-decoration:none;

color:#111827;

}

.btn-compare:hover{

border-color:#ef4444;
color:#ef4444;

}

/* MOBILE */

@media(max-width:600px){

.wishlist-header h1{

font-size:24px;

}

}

    #wishlistBtn{

cursor:pointer;

}

#wishlistBtn.active{

color:#ef4444;

font-weight:600;

}

/* ===============================
   MOBILE ACCOUNT TABS FIX
================================ */

@media (max-width:900px){

.account-grid{

grid-template-columns:1fr;
gap:15px;

}

/* SIDEBAR */

.account-sidebar{

border-radius:12px;

}

/* MENU -> HORIZONTAL */

.account-menu{

display:flex;
flex-direction:row;
overflow-x:auto;
gap:8px;
padding:10px;

}

/* SCROLL BAR HIDE */

.account-menu::-webkit-scrollbar{

display:none;

}

/* TAB STYLE */

.account-menu a{

flex:0 0 auto;

padding:10px 14px;

font-size:13px;

border-radius:8px;

background:#f3f4f6;

white-space:nowrap;

}

.account-menu a.active{

background:#ef4444;
color:#fff;

}

}

@media(max-width:600px){

.profile-banner{

height:80px;

}

.avatar-img{

width:70px;
height:70px;

}

}


</style>

<script>

    function removeWishlist(id, btn) {

        $.ajax({

            type: "POST",

            url: "Wishlist.aspx/Remove",

            data: JSON.stringify({ bikeId: id }),

            contentType: "application/json; charset=utf-8",

            dataType: "json",

            success: function (res) {

                // reload page to sync UI with database
                location.reload();

            },

            error: function () {

                alert("Something went wrong");

            }

        });

    }

</script>

</asp:Content>