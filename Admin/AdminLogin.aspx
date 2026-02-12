<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AdminLogin.aspx.cs" Inherits="AdminLogin" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - EBikes Duniya</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        body {
            background: linear-gradient(135deg, #6d28d9, #06b6d4);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI';
        }

        .login-card {
            background: #1e1b4b;
            padding: 40px;
            border-radius: 20px;
            width: 380px;
            color: white;
            box-shadow: 0 15px 40px rgba(0,0,0,0.4);
        }

        .form-control {
            background: #25215a;
            border: none;
            color: white;
        }

        .form-control:focus {
            background: #25215a;
            color: white;
            box-shadow: none;
        }

        .btn-custom {
            background: #7c3aed;
            border: none;
        }

        .btn-custom:hover {
            background: #6d28d9;
        }
    </style>
</head>

<body>
<form id="Form1" runat="server">

    <div class="login-card">
        <h3 class="text-center mb-4">Admin Login</h3>

        <asp:Label ID="lblMsg" runat="server" CssClass="text-danger"></asp:Label>

        <div class="mb-3">
            <label>Email</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-3">
            <label>Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
        </div>

        <asp:Button ID="btnLogin" runat="server" Text="Login"
            CssClass="btn btn-custom w-100 mt-3"
            OnClick="btnLogin_Click" />
    </div>

</form>
</body>
</html>
