<%@ Page Language="C#" AutoEventWireup="true"
CodeFile="DealerRentalRequests.aspx.cs"
Inherits="Dealer_DealerRentalRequests"
MasterPageFile="~/Vendor/VendorMaster.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<style>
.rr-page{padding:28px 0 42px;color:#26344a}.rr-kicker{font:700 11px 'Quicksand',sans-serif;letter-spacing:1.2px;text-transform:uppercase;color:#1686a5;margin-bottom:7px}
.rr-heading{margin-bottom:22px}.rr-heading h2{font:800 27px 'Manrope',sans-serif;color:#26344a;margin:0}.rr-heading p{font-size:14px;color:#7b8798;margin:7px 0 0}
.rr-toolbar{display:flex;gap:9px;flex-wrap:wrap;margin-bottom:20px;padding:12px;border-radius:15px;background:#edf1f7;box-shadow:inset 4px 4px 8px #d5dbe4,inset -4px -4px 8px #fff}
.rr-filter{border:0;border-radius:10px;background:#edf1f7;color:#64748b;padding:9px 15px;font:700 12px 'Quicksand',sans-serif;box-shadow:4px 4px 8px #d3d9e2,-4px -4px 8px #fff;transition:.2s}
.rr-filter:hover,.rr-filter.active{background:#263b55;color:#fff;box-shadow:inset 2px 2px 5px rgba(0,0,0,.12)}
#rentalsContainer.rentals-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(min(100%,330px),1fr));gap:18px;align-items:stretch}
#rentalsContainer .rental-card{min-width:0;overflow:hidden;display:flex;flex-direction:column;border:0;border-radius:19px;background:#edf1f7;box-shadow:8px 8px 17px #d3d9e2,-8px -8px 17px #fff;transition:transform .2s,box-shadow .2s}
#rentalsContainer .rental-card:hover{transform:translateY(-2px);box-shadow:10px 10px 20px #d0d7e1,-8px -8px 18px #fff}
#rentalsContainer .rental-img{height:175px;padding:15px;background:#e9eef5;display:flex;align-items:center;justify-content:center}
#rentalsContainer .rental-img img{max-width:100%;max-height:145px;object-fit:contain}
#rentalsContainer .rental-body{padding:19px;display:flex;flex:1;flex-direction:column;gap:8px}
#rentalsContainer .rental-title{font:800 17px 'Manrope',sans-serif;color:#26344a}
#rentalsContainer .rental-customer,#rentalsContainer .rental-dates{font-size:12px;line-height:1.5;color:#718096;overflow-wrap:anywhere}
#rentalsContainer .rental-price{font:800 16px 'Manrope',sans-serif;color:#147f9e;margin-top:3px}
#rentalsContainer .status{align-self:flex-start;display:inline-block;padding:6px 11px;border-radius:20px;font:700 10px 'Quicksand',sans-serif;margin-top:2px}
#rentalsContainer .status-pending{background:#fff1c9;color:#8a650c}
#rentalsContainer .status-approved{background:#dcecf8;color:#235b8a}
#rentalsContainer .status-active{background:#d9f2e3;color:#176a43}
#rentalsContainer .status-completed{background:#e1e6ed;color:#536174}
#rentalsContainer .status-rejected{background:#fde1e1;color:#a52b2b}
#rentalsContainer .status-cancelled{background:#fde1e1;color:#a52b2b}
#rentalsContainer .actions{display:flex;gap:9px;margin-top:auto;padding-top:12px}
#rentalsContainer .btn{flex:1;border:0;border-radius:10px;padding:10px 12px;font:700 11px 'Nunito Sans',sans-serif;cursor:pointer;transition:filter .2s}
#rentalsContainer .btn:hover{filter:brightness(.96)}
#rentalsContainer .btn-approve{background:#d8f0e3;color:#176a43}
#rentalsContainer .btn-reject{background:#f9dddd;color:#9b3030}
#rentalsContainer .btn-start{background:#dcecf8;color:#235b8a}
#rentalsContainer .btn-complete{background:#e1e6ed;color:#536174}
@media(max-width:575px){.rr-page{padding:18px 0 30px}.rr-heading h2{font-size:23px}.rr-toolbar{gap:8px}.rr-filter{flex:1;min-width:90px;padding:9px 10px}#rentalsContainer .rental-img{height:155px}#rentalsContainer .rental-body{padding:16px}}
</style>

<div class="container-fluid rr-page">
    <div class="rr-heading">
        <div class="rr-kicker">Rental management</div>
        <h2>Rental Requests</h2>
        <p>Review booking requests and manage each rental through its lifecycle.</p>
    </div>

    <div class="rr-toolbar">
        <button class="rr-filter active" type="button" onclick="loadRentals('',this)">All Requests</button>
        <button class="rr-filter" type="button" onclick="loadRentals('Pending',this)">Pending</button>
        <button class="rr-filter" type="button" onclick="loadRentals('Approved',this)">Approved</button>
        <button class="rr-filter" type="button" onclick="loadRentals('Active',this)">Active</button>
        <button class="rr-filter" type="button" onclick="loadRentals('Completed',this)">Completed</button>
        <button class="rr-filter" type="button" onclick="loadRentals('Rejected',this)">Rejected</button>
    </div>

    <div id="rentalsContainer" class="rentals-grid"></div>
</div>

<script>
    $(document).ready(function () {
        loadRentals("");
    });

    function loadRentals(status, btn) {
        $(".rr-filter").removeClass("active");
        if (btn) btn.classList.add("active");

        $.ajax({
            type: "POST",
            url: "DealerRentalRequests.aspx/GetRentals",
            data: JSON.stringify({ status: status }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (res) {
                $("#rentalsContainer").html(res.d);
            },
            error: function () {
                $("#rentalsContainer").html("<div class='rr-empty'>Unable to load rental requests. Please refresh and try again.</div>");
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
                $(".rr-filter").removeClass("active").first().addClass("active");
            },
            error: function () {
                alert("Unable to update rental status. Please try again.");
            }
        });
    }
</script>

</asp:Content>