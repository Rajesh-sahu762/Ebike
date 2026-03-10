<%@ Page Language="C#" AutoEventWireup="true"
CodeFile="DealerRentalRequests.aspx.cs"
Inherits="Dealer_DealerRentalRequests"
MasterPageFile="~/Vendor/VendorMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
/* PAGE */

.page-header{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:25px;
}

.page-title{
font-size:28px;
font-weight:700;
}

/* FILTERS */

.filters{
display:flex;
gap:10px;
flex-wrap:wrap;
margin-bottom:25px;
}

.filter-btn{
padding:8px 16px;
border-radius:30px;
border:1px solid #e5e7eb;
background:#fff;
cursor:pointer;
font-size:13px;
transition:0.2s;
}

.filter-btn:hover{
background:#f3f4f6;
}

.filter-btn.active{
background:#111827;
color:#fff;
border-color:#111827;
}

/* GRID */

.rentals-grid{
display:grid;
grid-template-columns:repeat(auto-fill,minmax(380px,1fr));
gap:20px;
}

/* CARD */

.rental-card{
background:#fff;
border-radius:14px;
box-shadow:0 10px 25px rgba(0,0,0,0.06);
overflow:hidden;
display:flex;
flex-direction:column;
transition:0.25s;
}

.rental-card:hover{
transform:translateY(-4px);
box-shadow:0 15px 35px rgba(0,0,0,0.12);
}

/* IMAGE */

.rental-img{
background:#f9fafb;
padding:15px;
text-align:center;
}

.rental-img img{
max-height:150px;
object-fit:contain;
}

/* BODY */

.rental-body{
padding:18px;
display:flex;
flex-direction:column;
gap:6px;
}

.rental-title{
font-size:18px;
font-weight:600;
}

.rental-customer{
font-size:14px;
color:#6b7280;
}

.rental-dates{
font-size:13px;
color:#6b7280;
}

.rental-price{
font-weight:600;
margin-top:4px;
}

/* STATUS */

.status{
display:inline-block;
padding:5px 12px;
border-radius:30px;
font-size:12px;
font-weight:600;
margin-top:6px;
}

.status-pending{
background:#fef3c7;
color:#92400e;
}

.status-approved{
background:#dbeafe;
color:#1e40af;
}

.status-active{
background:#dcfce7;
color:#166534;
}

.status-completed{
background:#e5e7eb;
color:#374151;
}

.status-rejected{
background:#fee2e2;
color:#991b1b;
}

/* ACTIONS */

.actions{
margin-top:12px;
display:flex;
gap:8px;
}

.btn{
flex:1;
padding:8px;
border-radius:6px;
border:none;
font-size:13px;
cursor:pointer;
transition:0.2s;
}

.btn:hover{
opacity:.9;
}

.btn-approve{background:#22c55e;color:#fff;}
.btn-reject{background:#ef4444;color:#fff;}
.btn-start{background:#3b82f6;color:#fff;}
.btn-complete{background:#6b7280;color:#fff;}

/* MOBILE */

@media(max-width:768px){

.rentals-grid{
grid-template-columns:1fr;
}

.actions{
flex-direction:column;
}

}

    </style>

<div class="page-header">

<div class="page-title">
Rental Requests
</div>

</div>

<div class="filters">

<button class="filter-btn active" type="button" onclick="loadRentals('',this)">All</button>
<button class="filter-btn" type="button" onclick="loadRentals('Pending',this)">Pending</button>

<button class="filter-btn" type="button" onclick="loadRentals('Approved',this)">Approved</button>

<button class="filter-btn" type="button" onclick="loadRentals('Active',this)">Active</button>

<button class="filter-btn" type="button" onclick="loadRentals('Completed',this)">Completed</button>

<button class="filter-btn" type="button" onclick="loadRentals('Rejected',this)">Rejected</button>

</div>

<div id="rentalsContainer" class="rentals-grid"></div>

<script>

    $(document).ready(function () {

        loadRentals("");

    });

    function loadRentals(status, btn) {

        $(".filter-btn").removeClass("active");

        if (btn)
            btn.classList.add("active");

        $.ajax({

            type: "POST",

            url: "DealerRentalRequests.aspx/GetRentals",

            data: JSON.stringify({ status: status }),

            contentType: "application/json; charset=utf-8",

            dataType: "json",

            success: function (res) {

                $("#rentalsContainer").html(res.d);

            }

        });

    }

    function updateStatus(id, status) {

        $.ajax({

            type: "POST",

            url: "DealerRentalRequests.aspx/UpdateStatus",

            data: JSON.stringify({ rentalId: id, status: status }),

            contentType: "application/json; charset=utf-8",

            dataType: "json",

            success: function (res) {

                alert(res.d);

                loadRentals("");

            }

        });

    }

</script>

</asp:Content>