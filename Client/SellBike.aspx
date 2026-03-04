<%@ Page Title="Sell Your Bike"
Language="C#"
MasterPageFile="~/Client/ClientMaster.master"
AutoEventWireup="true"
CodeFile="SellBike.aspx.cs"
Inherits="Client_SellBike" %>

<asp:Content ID="Content1"
ContentPlaceHolderID="ContentPlaceHolder1"
runat="server">

<style>

.sell-wrapper{
max-width:1000px;
margin:110px auto;
background:#fff;
padding:40px;
border-radius:16px;
box-shadow:0 15px 40px rgba(0,0,0,0.08);
}

.sell-title{
font-size:28px;
font-weight:700;
margin-bottom:10px;
}

.sell-sub{
color:#6b7280;
margin-bottom:25px;
}

.form-label{
font-weight:600;
}

.form-control{
border-radius:10px;
padding:10px;
}

.img-preview{
width:100%;
height:160px;
background:#f3f4f6;
border-radius:10px;
display:flex;
align-items:center;
justify-content:center;
overflow:hidden;
}

.img-preview img{
max-width:100%;
max-height:100%;
}

.btn-sell{
background:#ef4444;
color:#fff;
border:none;
padding:14px;
border-radius:10px;
width:100%;
font-weight:600;
margin-top:15px;
}

.btn-sell:hover{
background:#dc2626;
}

@media(max-width:768px){

.sell-wrapper{
margin:90px 15px;
padding:25px;
}

}

</style>

<div class="sell-wrapper">

<div class="sell-title">Sell Your Used Bike</div>
<div class="sell-sub">
List your bike for free and connect with buyers instantly.
</div>

<div class="row">

<div class="col-md-6 mb-3">

<label class="form-label">Bike Brand</label>

<asp:TextBox ID="txtBrand"
runat="server"
CssClass="form-control"
placeholder="Example: Ola, Ather, Hero Electric"></asp:TextBox>

</div>

<div class="col-md-6 mb-3">
<label class="form-label">Model Name</label>
<asp:TextBox ID="txtModel" runat="server"
CssClass="form-control"></asp:TextBox>
</div>

<div class="col-md-4 mb-3">
<label class="form-label">Manufacture Year</label>
<asp:TextBox ID="txtYear" runat="server"
CssClass="form-control"></asp:TextBox>
</div>

<div class="col-md-4 mb-3">
<label class="form-label">KM Driven</label>
<asp:TextBox ID="txtKM" runat="server"
CssClass="form-control"></asp:TextBox>
</div>

<div class="col-md-4 mb-3">
<label class="form-label">Owner</label>
<asp:DropDownList ID="ddlOwner" runat="server"
CssClass="form-control">
<asp:ListItem Value="1">First Owner</asp:ListItem>
<asp:ListItem Value="2">Second Owner</asp:ListItem>
<asp:ListItem Value="3">Third Owner</asp:ListItem>
</asp:DropDownList>
</div>

<div class="col-md-6 mb-3">
<label class="form-label">Bike Condition</label>
<asp:DropDownList ID="ddlCondition"
runat="server"
CssClass="form-control">

<asp:ListItem>Excellent</asp:ListItem>
<asp:ListItem>Good</asp:ListItem>
<asp:ListItem>Average</asp:ListItem>

</asp:DropDownList>
</div>

<div class="col-md-6 mb-3">
<label class="form-label">Battery Health</label>

<asp:DropDownList ID="ddlBattery"
runat="server"
CssClass="form-control">

<asp:ListItem>90%+</asp:ListItem>
<asp:ListItem>80%+</asp:ListItem>
<asp:ListItem>70%+</asp:ListItem>

</asp:DropDownList>

</div>

<div class="col-md-6 mb-3">
<label class="form-label">Price</label>
<asp:TextBox ID="txtPrice"
runat="server"
CssClass="form-control"></asp:TextBox>
</div>

<div class="col-md-12 mb-3">
<label class="form-label">Description</label>

<asp:TextBox ID="txtDesc"
runat="server"
TextMode="MultiLine"
Rows="4"
CssClass="form-control"></asp:TextBox>

</div>

<!-- Images -->

<div class="col-md-4 mb-3">

<label>Image 1 *</label>
<asp:FileUpload ID="fu1"
runat="server"
CssClass="form-control"/>

</div>

<div class="col-md-4 mb-3">

<label>Image 2</label>
<asp:FileUpload ID="fu2"
runat="server"
CssClass="form-control"/>

</div>

<div class="col-md-4 mb-3">

<label>Image 3</label>
<asp:FileUpload ID="fu3"
runat="server"
CssClass="form-control"/>

</div>

</div>

<asp:Button ID="btnSubmit"
runat="server"
Text="Submit Bike Listing"
CssClass="btn-sell"
OnClick="btnSubmit_Click"/>

<br/><br/>

<asp:Label ID="lblMsg"
runat="server"></asp:Label>

</div>

</asp:Content>