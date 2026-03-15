<%@ Page Title="My Rentals" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true" CodeFile="MyRentals.aspx.cs"
Inherits="Client_MyRentals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>

.rental-wrapper{
max-width:1200px;
/*margin:60px auto;*/
/*padding:20px;*/
}

.rental-header{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:25px;
}

.rental-title{
font-size:26px;
font-weight:700;
}

.rental-filter select{
padding:8px 12px;
border-radius:6px;
border:1px solid #ddd;
}

.rental-grid{
display:grid;
grid-template-columns:repeat(auto-fill,minmax(320px,1fr));
gap:20px;
}

.rental-card{
background:#fff;
border-radius:12px;
box-shadow:0 8px 20px rgba(0,0,0,0.06);
overflow:hidden;
display:flex;
flex-direction:column;
}

.rental-img{
height:180px;
overflow:hidden;
}

.rental-img img{
width:100%;
height:100%;
object-fit:cover;
}

.rental-body{
padding:18px;
flex:1;
display:flex;
flex-direction:column;
}

.rental-name{
font-size:18px;
font-weight:600;
margin-bottom:8px;
}

.rental-dates{
font-size:13px;
color:#6b7280;
margin-bottom:10px;
}

.rental-price{
font-size:16px;
font-weight:700;
margin-bottom:10px;
}

.status{
display:inline-block;
padding:5px 10px;
border-radius:20px;
font-size:12px;
font-weight:600;
}

.status-pending{background:#fff3cd;color:#856404;}
.status-approved{background:#d4edda;color:#155724;}
.status-active{background:#d1ecf1;color:#0c5460;}
.status-completed{background:#e2e3e5;color:#383d41;}
.status-cancelled{background:#f8d7da;color:#721c24;}

.rental-actions{
margin-top:auto;
display:flex;
gap:10px;
}

.btn-cancel{
padding:7px 12px;
border:none;
background:#ef4444;
color:#fff;
border-radius:6px;
cursor:pointer;
font-size:12px;
}

.empty{
text-align:center;
padding:60px;
color:#888;
font-size:18px;
}

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

position:sticky;
top:90px;
align-self:start;
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

    .account-content{
display:flex;
flex-direction:column;
gap:25px;
}



</style>



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

<a href="Wishlist.aspx">❤️ Wishlist</a>

<a href="MyRentals.aspx" class="active">🛵 My Rentals</a>

<a href="MyEnquiries.aspx">📨 My Enquiries</a>

    <hr />

<a href="Logout.aspx" class="logout-btn">
🚪 Logout
</a>

<a href="#" class="delete-account" onclick="deleteAccount()">
❌ Delete Account
</a>

</div>

</div>


<!-- RIGHT CONTENT -->

<div class="account-content">

<div class="rental-wrapper">

<div class="rental-header">

<div class="rental-title">
My Rentals
</div>

<div class="rental-filter">

<select id="statusFilter" onchange="loadRentals()">

<option value="">All</option>
<option value="Pending">Pending</option>
<option value="Approved">Approved</option>
<option value="Active">Active</option>
<option value="Completed">Completed</option>
<option value="Cancelled">Cancelled</option>

</select>

</div>

</div>

<div id="rentalContainer" class="rental-grid"></div>

</div>

</div>

</div>

</section>

    <script>

        function deleteAccount() {

            if (confirm("Are you sure you want to permanently delete your account?")) {

                window.location = "DeleteAccount.aspx";

            }

        }

</script>

<script>

    function loadRentals() {

        $.ajax({

            type: "POST",
            url: "MyRentals.aspx/GetRentals",

            data: JSON.stringify({

                status: $("#statusFilter").val()

            }),

            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (res) {

                $("#rentalContainer").html(res.d);

            }

        });

    }

    function cancelRental(id) {

        if (!confirm("Cancel this rental booking?"))
            return;

        $.ajax({

            type: "POST",
            url: "MyRentals.aspx/CancelRental",

            data: JSON.stringify({ rentalId: id }),

            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (res) {

                alert(res.d);
                loadRentals();

            }

        });

    }

    $(document).ready(function () {

        loadRentals();

    });

</script>

</asp:Content>