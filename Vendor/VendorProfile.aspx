<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="VendorProfile.aspx.cs"
    Inherits="Vendor_VendorProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h4 class="mb-4">Vendor Profile</h4>

<asp:Label ID="lblMsg" runat="server" CssClass="text-success"></asp:Label>

<div class="row">

    <!-- LEFT SIDE -->
    <div class="col-md-4">

        <div class="card p-3 text-center shadow-sm">

            <asp:Image ID="imgProfile" runat="server"
                Width="150px" Height="150px"
                Style="border-radius:50%; object-fit:cover;" />

            <br />

            <asp:FileUpload ID="fuProfile" runat="server" CssClass="form-control mt-2" />

            <asp:Button ID="btnUploadImage" runat="server"
                Text="Update Image"
                CssClass="btn btn-primary mt-2"
                OnClick="btnUploadImage_Click" />

            <hr />

            <asp:Label ID="lblApproval" runat="server"></asp:Label>
            <asp:Label ID="lblActive" runat="server"></asp:Label>

        </div>

    </div>

    <!-- RIGHT SIDE -->
    <div class="col-md-8">

        <div class="card p-4 shadow-sm">

            <div class="row">

                <div class="col-md-6 mb-3">
                    <label>Full Name</label>
                    <asp:TextBox ID="txtName" runat="server"
                        CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Email (Locked)</label>
                    <asp:TextBox ID="txtEmail" runat="server"
                        CssClass="form-control"
                        Enabled="false"></asp:TextBox>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Mobile</label>
                    <asp:TextBox ID="txtMobile" runat="server"
                        CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-md-6 mb-3">
                    <label>Shop Name</label>
                    <asp:TextBox ID="txtShop" runat="server"
                        CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-md-6 mb-3">
                    <label>GST No</label>
                    <asp:TextBox ID="txtGST" runat="server"
                        CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-md-6 mb-3">
                    <label>City</label>
                    <asp:TextBox ID="txtCity" runat="server"
                        CssClass="form-control"></asp:TextBox>
                </div>

                <div class="col-md-12 mb-3">
                    <label>Address</label>
                    <asp:TextBox ID="txtAddress" runat="server"
                        TextMode="MultiLine"
                        Rows="3"
                        CssClass="form-control"></asp:TextBox>
                </div>

            </div>

            <asp:Button ID="btnUpdateProfile" runat="server"
                Text="Save Changes"
                CssClass="btn btn-success"
                OnClick="btnUpdateProfile_Click" />

        </div>

        <!-- CHANGE PASSWORD -->
        <div class="card p-4 shadow-sm mt-4">

            <h6>Change Password</h6>

            <asp:TextBox ID="txtOldPass" runat="server"
                TextMode="Password"
                CssClass="form-control mb-2"
                placeholder="Old Password"></asp:TextBox>

            <asp:TextBox ID="txtNewPass" runat="server"
                TextMode="Password"
                CssClass="form-control mb-2"
                placeholder="New Password"></asp:TextBox>

            <asp:TextBox ID="txtConfirmPass" runat="server"
                TextMode="Password"
                CssClass="form-control mb-3"
                placeholder="Confirm Password"></asp:TextBox>

            <asp:Button ID="btnChangePassword" runat="server"
                Text="Change Password"
                CssClass="btn btn-warning"
                OnClick="btnChangePassword_Click" />

        </div>

    </div>

</div>

</asp:Content>
