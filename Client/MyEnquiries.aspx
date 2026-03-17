<%@ Page Title="My Enquiries" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true" CodeFile="MyEnquiries.aspx.cs"
Inherits="Client_MyEnquiries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<section class="account-wrapper">

<div class="account-grid">

<!-- LEFT SIDEBAR -->

<div class="account-sidebar">

<div class="profile-header">

<div class="profile-banner"></div>

<div class="profile-avatar">
<img src="/Uploads/user.jpg" class="avatar-img" />
</div>

<div class="profile-info">
<h3>My Account</h3>
<p>Manage your activity</p>
</div>

</div>

<div class="account-menu">

<a href="MyProfile.aspx">👤 Profile</a>

<a href="Wishlist.aspx">❤️ Wishlist</a>

<a href="MyRentals.aspx">🛵 My Rentals</a>

<a href="MyEnquiries.aspx" class="active">📩 My Enquiries</a>


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

<h3 class="page-title">My Enquiries</h3>

<asp:Repeater ID="rptEnquiries" runat="server">

<ItemTemplate>

<div class="enquiry-card">

<div class="enquiry-bike">

<img src='/Uploads/Bikes/<%# Eval("Image1") ?? "no-bike.jpg" %>' />

</div>

<div class="enquiry-info">

<h4><%# Eval("ModelName") %></h4>

<p class="dealer">
Dealer: <%# Eval("ShopName") %>
</p>

<p class="msg">
Message: <%# Eval("Message") %>
</p>

<div class="meta">

<span class="date">
<%# Eval("CreatedAt","{0:dd MMM yyyy}") %>
</span>

<span class="status">

<asp:Label 
runat="server"
Text='<%# Convert.ToBoolean(Eval("IsViewed")) ? "Viewed" : "Pending" %>'
CssClass='<%# Convert.ToBoolean(Eval("IsViewed")) ? "badge viewed" : "badge pending" %>'>
</asp:Label>

</span>

</div>

</div>

<div class="enquiry-actions">

<a href='BikeDetails.aspx?slug=<%# Eval("Slug") %>'
class="btn-view">View Bike</a>

<button type="button"
class="btn-delete"
onclick="deleteEnquiry(<%# Eval("LeadID") %>,this)">
Delete
</button>

</div>

</div>

</ItemTemplate>

</asp:Repeater>

<div id="emptyBox" runat="server" visible="false" class="empty">

📭 No enquiries yet

<br />

<a href="Bikes.aspx" class="browse-btn">
Browse Bikes
</a>

</div>

</div>

</div>

</section>

<style>

.account-grid{
display:grid;
grid-template-columns:250px 1fr;
gap:30px;
max-width:1200px;
margin:60px auto;
padding:0 20px;
}

.account-menu a{
display:block;
padding:10px;
border-radius:8px;
text-decoration:none;
color:#374151;
margin-bottom:6px;
}

.account-menu a.active{
background:#ef4444;
color:white;
}

.page-title{
margin-bottom:20px;
}

.enquiry-card{
display:flex;
background:white;
padding:18px;
border-radius:12px;
box-shadow:0 10px 30px rgba(0,0,0,0.05);
margin-bottom:15px;
gap:20px;
align-items:center;
}

.enquiry-bike img{
width:100px;
height:70px;
object-fit:cover;
border-radius:6px;
}

.enquiry-info{
flex:1;
}

.enquiry-info h4{
margin:0;
font-size:18px;
}

.dealer{
font-size:13px;
color:#6b7280;
}

.msg{
font-size:13px;
margin-top:6px;
}

.meta{
margin-top:8px;
font-size:12px;
color:#6b7280;
display:flex;
gap:15px;
}

.badge{
padding:3px 8px;
border-radius:20px;
font-size:11px;
}

.pending{
background:#fef3c7;
color:#92400e;
}

.viewed{
background:#dcfce7;
color:#166534;
}

.enquiry-actions{
display:flex;
flex-direction:column;
gap:8px;
}

.btn-view{
background:#111827;
color:white;
padding:6px 10px;
border-radius:6px;
text-decoration:none;
font-size:12px;
}

.btn-delete{
background:#ef4444;
border:none;
color:white;
padding:6px 10px;
border-radius:6px;
font-size:12px;
cursor:pointer;
}

.empty{
text-align:center;
padding:60px;
font-size:18px;
color:#6b7280;
}

.browse-btn{
display:inline-block;
margin-top:10px;
padding:8px 18px;
background:#ef4444;
color:white;
border-radius:6px;
text-decoration:none;
}

@media(max-width:900px){

.account-grid{
grid-template-columns:1fr;
}

}

    /* SIDEBAR */

.account-sidebar{

background:#fff;

border-radius:16px;

overflow:hidden;

box-shadow:0 10px 30px rgba(0,0,0,0.08);

}

/* HEADER */

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

object-fit:cover;

}

.profile-info{

margin-top:60px;

}

.profile-info h3{

margin:0;

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

transition:0.2s;

}

.account-menu a:hover{

background:#f3f4f6;

}

.account-menu a.active{

background:#ffe4e6;

color:#ef4444;

font-weight:600;

}

@media(max-width:900px){

.account-grid{

grid-template-columns:1fr;

}

.account-menu{

flex-direction:row;

justify-content:space-between;

border-top:1px solid #eee;

}

.account-menu a{

flex:1;

text-align:center;

font-size:13px;

padding:12px 6px;

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
}

/* CONTENT */

.account-content{

display:flex;
flex-direction:column;
gap:25px;

}

/* STATS */

.stats-grid{

display:grid;
grid-template-columns:repeat(3,1fr);
gap:20px;

}

.stat-card{

background:#fff;
padding:20px;
border-radius:12px;
text-align:center;
box-shadow:0 6px 18px rgba(0,0,0,0.05);

}

.stat-card h2{

color:#ef4444;
margin-bottom:5px;

}

/* FORMS */

.form-card{

background:#fff;
padding:25px;
border-radius:14px;
box-shadow:0 10px 30px rgba(0,0,0,0.06);

}

.form-card h3{

margin-bottom:15px;

}

.input{

width:100%;
padding:10px;
border:1px solid #e5e7eb;
border-radius:6px;
margin-bottom:12px;

}

.btn-primary{

background:#ef4444;
color:#fff;
border:none;
padding:10px 18px;
border-radius:6px;
cursor:pointer;

}

.btn-primary:hover{

background:#dc2626;

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

.account-sidebar{

background:#fff;
position:sticky;
top:90px;

border-radius:16px;

overflow:hidden;

box-shadow:0 10px 30px rgba(0,0,0,0.08);

align-self:start;   /* ADD THIS */

}

/* MOBILE */

@media(max-width:900px){

.account-grid{

grid-template-columns:1fr;

}

.stats-grid{

grid-template-columns:1fr;

}

}

</style>

<script>

    function deleteEnquiry(id, btn) {

        if (!confirm("Delete this enquiry?")) return;

        $.ajax({

            type: "POST",
            url: "MyEnquiries.aspx/DeleteEnquiry",

            data: JSON.stringify({ id: id }),

            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function () {

                $(btn).closest(".enquiry-card").fadeOut(200, function () {
                    $(this).remove();
                });

            }

        });

    }

    function deleteAccount() {

        if (confirm("Are you sure to delete account permanently?")) {

            window.location = "DeleteAccount.aspx";

        }

    }

</script>

</asp:Content>