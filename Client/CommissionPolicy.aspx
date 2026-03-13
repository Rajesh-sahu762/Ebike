<%@ Page Title="Commission Policy" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true" CodeFile="CommissionPolicy.aspx.cs"
Inherits="Client_CommissionPolicy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<style>

.policy-wrapper{
max-width:900px;
margin:80px auto;
padding:20px;
background:#fff;
border-radius:14px;
box-shadow:0 10px 30px rgba(0,0,0,0.06);
}

.policy-wrapper h1{
margin-bottom:10px;
}

.policy-wrapper h2{
margin-top:25px;
font-size:18px;
}

.policy-wrapper p{
color:#374151;
line-height:1.7;
}

.updated{
color:#6b7280;
font-size:13px;
}

</style>


<div class="policy-wrapper">

<h1>Dealer Commission Policy</h1>

<h2>1. Lead Marketplace Model</h2>

<p>
Dealers receive verified customer leads through the platform.
A commission fee may apply per lead.
</p>

<h2>2. Rental Commission</h2>

<p>
For rental bookings, the platform charges a service commission
from the total rental amount.
</p>

<h2>3. Payment Settlement</h2>

<p>
Dealer earnings are settled after successful booking completion.
Settlement requests can be submitted through the dealer dashboard.
</p>

<h2>4. Fraud Prevention</h2>

<p>
The platform reserves the right to suspend accounts involved
in fraudulent activities.
</p>

<h2>5. Commission Changes</h2>

<p>
Commission rates may be updated based on platform policies.
</p>

</div>

</asp:Content>