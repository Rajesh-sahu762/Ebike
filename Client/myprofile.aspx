<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true" CodeFile="MyProfile.aspx.cs"
Inherits="Client_MyProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<section class="account-wrapper">

<div class="account-grid">

<!-- LEFT SIDEBAR -->

<div class="account-sidebar">

<div class="profile-header">

<div class="profile-banner"></div>

<div class="profile-avatar">

<asp:Image ID="imgProfile" runat="server" ImageUrl="~/Uploads/user.jpg" CssClass="avatar-img"/>

</div>

<div class="profile-info">

<h3><asp:Literal ID="litName" runat="server"></asp:Literal></h3>

<p><asp:Literal ID="litEmail" runat="server"></asp:Literal></p>

</div>

</div>


<div class="account-menu">

<a href="MyProfile.aspx" class="active">
👤 Profile
</a>

<a href="Wishlist.aspx">
❤️ Wishlist
</a>

<a href="MyRentals.aspx">🛵 My Rentals</a>


<a href="Compare.aspx">
⚖ Compare
</a>

</div>

</div>


<!-- RIGHT CONTENT -->

<div class="account-content">

<!-- STATS -->

<div class="stats-grid">

<div class="stat-card">
<h2><asp:Literal ID="litWishlistCount" runat="server"></asp:Literal></h2>
<p>Wishlist Bikes</p>
</div>

<div class="stat-card">
<h2><asp:Literal ID="litEnquiryCount" runat="server"></asp:Literal></h2>
<p>Enquiries</p>
</div>

<div class="stat-card">
<h2><asp:Literal ID="litReviewCount" runat="server"></asp:Literal></h2>
<p>Reviews</p>
</div>

</div>


<!-- PROFILE FORM -->

<div class="form-card">

<h3>Edit Profile</h3>

<label>Full Name</label>
<asp:TextBox ID="txtName" runat="server" CssClass="input"></asp:TextBox>

<label>Email</label>
<asp:TextBox ID="txtEmail" runat="server" CssClass="input"></asp:TextBox>

<label>Mobile</label>
<asp:TextBox ID="txtMobile" runat="server" CssClass="input"></asp:TextBox>

<label>City</label>
<asp:TextBox ID="txtCity" runat="server" CssClass="input"></asp:TextBox>

<asp:Button ID="btnSave"
runat="server"
Text="Update Profile"
CssClass="btn-primary"
OnClick="btnSave_Click"/>

</div>


<!-- PASSWORD -->

<div class="form-card">

<h3>Change Password</h3>

<asp:TextBox ID="txtOldPass"
runat="server"
CssClass="input"
TextMode="Password"
placeholder="Old Password"/>

<asp:TextBox ID="txtNewPass"
runat="server"
CssClass="input"
TextMode="Password"
placeholder="New Password"/>

<asp:TextBox ID="txtConfirmPass"
runat="server"
CssClass="input"
TextMode="Password"
placeholder="Confirm Password"/>

<asp:Button ID="btnChangePass"
runat="server"
Text="Change Password"
CssClass="btn-primary"
OnClick="btnChangePass_Click"/>

</div>

</div>

</div>

</section>


<style>

/* PAGE */

.account-wrapper{

max-width:1200px;
margin:80px auto;
padding:0 20px;

}

.account-grid{

display:grid;
grid-template-columns:250px 1fr;
gap:30px;

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

</asp:Content>