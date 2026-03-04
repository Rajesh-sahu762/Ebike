<%@ Page Title="Send Enquiry" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true" CodeFile="Enquiry.aspx.cs" Inherits="Client_Enquiry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>

.enquiry-wrapper{
max-width:1200px;
margin:70px auto;
padding:0 20px;
}

.enquiry-card{
display:grid;
grid-template-columns:380px 1fr 260px;
gap:25px;
}

/* LEFT BIKE CARD */

.bike-card{
background:#fff;
border-radius:14px;
padding:25px;
box-shadow:0 10px 30px rgba(0,0,0,0.07);
text-align:center;
}

.bike-card img{
width:100%;
max-height:220px;
object-fit:contain;
}

.bike-name{
font-size:20px;
font-weight:700;
margin-top:10px;
}

.bike-price{
font-size:22px;
font-weight:700;
color:#ef4444;
margin-top:5px;
}

.bike-specs{
margin-top:12px;
font-size:14px;
color:#374151;
}

/* FORM */

.form-card{
background:#fff;
border-radius:14px;
padding:30px;
box-shadow:0 10px 30px rgba(0,0,0,0.07);
}

.form-title{
font-size:22px;
font-weight:700;
margin-bottom:10px;
}

.lead-badge{
background:#ecfeff;
color:#0891b2;
padding:8px 12px;
border-radius:8px;
font-size:13px;
display:inline-block;
margin-bottom:15px;
}

.form-group{
margin-bottom:15px;
}

.form-group label{
font-weight:600;
font-size:14px;
display:block;
margin-bottom:4px;
}

.form-group input,
.form-group textarea{
width:100%;
padding:11px;
border-radius:8px;
border:1px solid #e5e7eb;
}

.form-group textarea{
height:90px;
resize:none;
}

.send-btn{
background:#ef4444;
color:#fff;
border:none;
padding:14px;
width:100%;
border-radius:10px;
font-weight:700;
font-size:16px;
cursor:pointer;
}

.send-btn:hover{
background:#dc2626;
}

.success-box{
background:#ecfdf5;
border:1px solid #10b981;
color:#065f46;
padding:12px;
border-radius:8px;
margin-top:15px;
display:none;
}

/* TRUST BOX */

.trust-box{
background:#fff;
border-radius:14px;
padding:20px;
box-shadow:0 10px 30px rgba(0,0,0,0.07);
font-size:14px;
}

.trust-item{
margin-bottom:10px;
}

/* DEALER */

.dealer-box{
margin-top:20px;
background:#fff7ed;
padding:15px;
border-radius:10px;
}

@media(max-width:900px){

.enquiry-card{
grid-template-columns:1fr;
}

}

</style>

<div class="enquiry-wrapper">

<div class="enquiry-card">

<!-- BIKE PREVIEW -->

<div class="bike-card">

<asp:Image ID="imgBike" runat="server"/>

<div class="bike-name">
<asp:Literal ID="litBikeName" runat="server"></asp:Literal>
</div>

<div class="bike-price">
₹ <asp:Literal ID="litPrice" runat="server"></asp:Literal>
</div>

<div class="bike-specs">
Range: <asp:Literal ID="litRange" runat="server"></asp:Literal><br/>
Top Speed: <asp:Literal ID="litSpeed" runat="server"></asp:Literal><br/>
Charging: <asp:Literal ID="litCharge" runat="server"></asp:Literal>
</div>

</div>

<!-- FORM -->

<div class="form-card">

<div class="form-title">Send Enquiry</div>

<div class="lead-badge">
⚡ Get Best Deal From Verified Dealer
</div>

<div class="form-group">
<label>Name</label>
<input type="text" id="name"/>
</div>

<div class="form-group">
<label>Phone</label>
<input type="text" id="phone"/>
</div>

<div class="form-group">
<label>City</label>
<input type="text" id="city"/>
</div>

<div class="form-group">
<label>Message</label>
<textarea id="msg">I am interested in this bike. Please contact me.</textarea>
</div>

<button type="button" class="send-btn" onclick="sendEnquiry()">
Send Enquiry
</button>

<div class="success-box" id="successBox">
Enquiry sent successfully. Dealer will contact you shortly.
</div>

<div class="dealer-box">

<strong>Dealer Information</strong><br/>

<asp:Literal ID="litDealerName" runat="server"></asp:Literal><br/>

📞 <asp:Literal ID="litDealerPhone" runat="server"></asp:Literal><br/>

📍 <asp:Literal ID="litDealerCity" runat="server"></asp:Literal>

</div>

</div>

<!-- TRUST -->

<div class="trust-box">

<strong>Why Enquire With Us?</strong>

<div class="trust-item">✔ Verified Electric Bike Dealers</div>
<div class="trust-item">✔ Best Price Guarantee</div>
<div class="trust-item">✔ EMI Assistance</div>
<div class="trust-item">✔ Quick Dealer Response</div>

</div>

</div>

</div>

<script>

    function sendEnquiry() {

        var message = $("#msg").val();

        $.ajax({

            type: "POST",
            url: "/Client/Enquiry.aspx/SubmitLead",

            data: JSON.stringify({ message: message }),

            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (res) {

                if (res.d == "login") {
                    alert("Please login first");
                    return;
                }

                if (res.d == "exists") {
                    alert("You already sent enquiry for this bike");
                    return;
                }

                $("#successBox").fadeIn();

            }

        });

    }

</script>

</asp:Content>