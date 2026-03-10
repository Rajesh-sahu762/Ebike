<%@ Page Title="My Rentals" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true" CodeFile="MyRentals.aspx.cs"
Inherits="Client_MyRentals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>

.rental-wrapper{
max-width:1200px;
margin:80px auto;
padding:20px;
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

</style>

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