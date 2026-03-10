<%@ Page Title="Wishlist" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true" CodeFile="Wishlist.aspx.cs"
Inherits="Client_Wishlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.page-title{
font-size:30px;
font-weight:700;
margin-bottom:30px;
}

.wishlist-grid{
display:grid;
grid-template-columns:repeat(auto-fill,minmax(280px,1fr));
gap:25px;
}

/* CARD */

.wishlist-card{
background:#fff;
border-radius:14px;
overflow:hidden;
box-shadow:0 10px 30px rgba(0,0,0,0.06);
transition:.3s;
position:relative;
}

.wishlist-card:hover{
transform:translateY(-6px);
box-shadow:0 20px 40px rgba(0,0,0,0.12);
}

/* IMAGE */

.wishlist-img{
background:#f9fafb;
padding:20px;
text-align:center;
}

.wishlist-img img{
max-height:180px;
object-fit:contain;
}

/* REMOVE BUTTON */

.remove-btn{
position:absolute;
top:12px;
right:12px;
background:#fff;
border-radius:50%;
width:34px;
height:34px;
display:flex;
align-items:center;
justify-content:center;
cursor:pointer;
box-shadow:0 5px 15px rgba(0,0,0,0.1);
font-size:16px;
color:#ef4444;
}

.remove-btn:hover{
background:#ef4444;
color:#fff;
}

/* BODY */

.wishlist-body{
padding:18px;
}

.wishlist-name{
font-size:17px;
font-weight:600;
margin-bottom:6px;
}

.wishlist-price{
font-size:18px;
font-weight:700;
color:#ef4444;
margin-bottom:15px;
}

/* BUTTON */

.btn-view{
width:100%;
padding:10px;
border:none;
border-radius:8px;
background:#111827;
color:#fff;
font-weight:500;
cursor:pointer;
transition:.2s;
}

.btn-view:hover{
background:#ef4444;
}

/* EMPTY STATE */

.empty-box{
text-align:center;
padding:120px 0;
}

.empty-box h3{
font-size:22px;
margin-top:15px;
}

.empty-box p{
color:#6b7280;
}

/* MOBILE */

@media(max-width:768px){

.page-title{
font-size:24px;
}

.wishlist-grid{
grid-template-columns:1fr;
}

}

</style>

<div class="page-title">My Wishlist</div>

<div id="wishlistContainer" class="wishlist-grid"></div>

<script>

    $(document).ready(function () {

        loadWishlist();

    });

    function loadWishlist() {

        $.ajax({

            type: "POST",

            url: "Wishlist.aspx/GetWishlist",

            contentType: "application/json; charset=utf-8",

            dataType: "json",

            success: function (res) {

                $("#wishlistContainer").html(res.d);

            }

        });

    }

    function removeWishlist(bikeId) {

        if (!confirm("Remove this bike from wishlist?"))
            return;

        $.ajax({

            type: "POST",

            url: "Wishlist.aspx/RemoveWishlist",

            data: JSON.stringify({ bikeId: bikeId }),

            contentType: "application/json; charset=utf-8",

            dataType: "json",

            success: function (res) {

                loadWishlist();

            }

        });

    }

</script>

</asp:Content>