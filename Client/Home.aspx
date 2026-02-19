<%@ Page Language="C#" AutoEventWireup="true"
    CodeFile="Home.aspx.cs"
    Inherits="Home" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title>EBikes Duniya</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

<style>

html { scroll-behavior:smooth; }

body{
    margin:0;
    font-family:'Segoe UI';
    background:#f1f5f9;
}

/* ===== NAVBAR ===== */

.navbar-custom{
    background:rgba(255,255,255,0.8);
    backdrop-filter:blur(10px);
    position:fixed;
    width:100%;
    z-index:1000;
    padding:15px 40px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 5px 20px rgba(0,0,0,0.05);
}

.navbar-custom a{
    margin:0 15px;
    text-decoration:none;
    color:#0f172a;
    font-weight:600;
    position:relative;
}

.navbar-custom a::after{
    content:'';
    height:2px;
    width:0;
    background:#2dd4bf;
    position:absolute;
    left:0;
    bottom:-5px;
    transition:0.3s;
}

.navbar-custom a:hover::after{
    width:100%;
}

/* ===== HERO ===== */

.hero{
    height:100vh;
    display:flex;
    align-items:center;
    padding:0 80px;
    background:linear-gradient(135deg,#e0f2fe,#ccfbf1);
}

.hero h1{
    font-size:60px;
    font-weight:800;
}

.gradient-btn{
    background:linear-gradient(45deg,#2dd4bf,#0ea5e9);
    border:none;
    padding:12px 30px;
    color:white;
    border-radius:30px;
    font-weight:600;
    transition:0.4s;
}

.gradient-btn:hover{
    transform:translateY(-3px);
    box-shadow:0 10px 25px rgba(0,0,0,0.15);
}

/* ===== CARD ===== */

.bike-card{
    border-radius:20px;
    overflow:hidden;
    background:white;
    transition:0.4s;
    box-shadow:0 10px 30px rgba(0,0,0,0.05);
}

.bike-card:hover{
    transform:translateY(-8px);
    box-shadow:0 20px 40px rgba(0,0,0,0.1);
}

.bike-card img{
    height:200px;
    width:100%;
    object-fit:cover;
    transition:0.4s;
}

.bike-card:hover img{
    transform:scale(1.08);
}

.fade-in{
    opacity:0;
    transform:translateY(40px);
    transition:all 0.8s ease;
}

.fade-in.show{
    opacity:1;
    transform:translateY(0);
}

</style>

</head>

<body>

<form id="Form1" runat="server">

<!-- NAVBAR -->
<div class="navbar-custom">
    <div>
        <i class="fa fa-motorcycle"></i>
        <strong>EBikes Duniya</strong>
    </div>

    <div>
        <a href="#">Home</a>
        <a href="#bikes">Bikes</a>
        <a href="#">Sell</a>
        <a href="#">Rental</a>
        <a href="Vendor/VendorLogin.aspx">Dealer</a>
    </div>
</div>


<!-- HERO -->
<div class="hero">
    <div class="row w-100">
        <div class="col-md-6">
            <h1>LET'S RIDE THE FUTURE</h1>
            <p class="mt-3">Explore premium electric bikes near you.</p>
            <asp:Button ID="btnExplore" runat="server"
                Text="Explore Bikes"
                CssClass="gradient-btn mt-3" />
        </div>

        <div class="col-md-6 text-center">
            <img src="Images/hero-bike.png"
                 style="width:80%; animation:float 3s infinite alternate;" />
        </div>
    </div>
</div>


<!-- FEATURED BIKES -->
<div id="bikes" class="container py-5">

    <h3 class="mb-4">Featured Bikes</h3>

    <div class="row">

        <asp:Repeater ID="rptBikes" runat="server">
            <ItemTemplate>

                <div class="col-md-4 mb-4 fade-in">

                    <div class="bike-card">

                        <img src='<%# Eval("Image1") %>' />

                        <div class="p-3">

                            <h5><%# Eval("BrandName") %> <%# Eval("ModelName") %></h5>

                            <p>₹ <%# Eval("Price") %></p>

                            <asp:HyperLink ID="lnkDetails"
                                NavigateUrl='<%# "BikeDetails.aspx?slug=" + Eval("Slug") %>'
                                runat="server"
                                CssClass="btn btn-sm gradient-btn">
                                View Details
                            </asp:HyperLink>

                        </div>

                    </div>

                </div>

            </ItemTemplate>
        </asp:Repeater>

    </div>

</div>

</form>

<script>

    window.addEventListener("scroll",function(){
        document.querySelectorAll(".fade-in").forEach(el=>{
            if(el.getBoundingClientRect().top < window.innerHeight-100){
                el.classList.add("show");
    }
    });
    });

</script>

</body>
</html>
