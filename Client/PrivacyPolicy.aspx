<%@ Page Title="Privacy Policy" Language="C#" MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true" CodeFile="PrivacyPolicy.aspx.cs"
Inherits="Client_PrivacyPolicy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="policy-wrapper">

<h1>Privacy Policy</h1>

<p class="updated">Last Updated: <%= DateTime.Now.ToString("dd MMM yyyy") %></p>

<h2>1. Information We Collect</h2>

<p>
We collect personal information such as name, email address,
mobile number, and location when you register or submit an enquiry.
</p>

<h2>2. How We Use Your Information</h2>

<ul>
<li>To connect buyers with dealers</li>
<li>To improve our platform</li>
<li>To respond to enquiries</li>
<li>To send important updates</li>
</ul>

<h2>3. Data Protection</h2>

<p>
We implement security measures to protect your personal data.
Your information is never sold to third parties.
</p>

<h2>4. Cookies</h2>

<p>
Our platform may use cookies to improve user experience
and analyze website traffic.
</p>

<h2>5. Contact Us</h2>

<p>
If you have questions regarding this policy please contact us.
</p>

</div>

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

</asp:Content>