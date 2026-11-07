<%@ Page Title="Vendor Profile" Language="C#" MasterPageFile="~/Vendor/VendorMaster.master"
    AutoEventWireup="true" CodeFile="VendorProfile.aspx.cs"
    Inherits="Vendor_VendorProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<style>
.vp-page{color:#263650}.vp-head{margin-bottom:24px}.vp-eyebrow{font-size:11px;letter-spacing:1.4px;text-transform:uppercase;color:#8290a6;font-weight:800;margin-bottom:6px}.vp-title{font:800 25px 'Manrope',sans-serif;color:#24334e;margin:0}.vp-subtitle{font-size:13px;color:#8290a6;margin:7px 0 0}.vp-message{display:block;margin-bottom:16px;padding:10px 14px;border-radius:12px;background:#dff4e9;color:#19734f;font-size:12px;font-weight:700}.vp-layout{display:grid;grid-template-columns:minmax(250px, .78fr) minmax(0,2fr);gap:22px;align-items:start}.vp-card{padding:22px;border-radius:20px;background:#e8edf5;box-shadow:7px 7px 16px #cbd2dd,-7px -7px 16px #fff;margin-bottom:20px}.vp-profile-card{text-align:center}.vp-avatar-wrap{width:142px;height:142px;padding:8px;border-radius:50%;margin:4px auto 16px;background:#e8edf5;box-shadow:inset 5px 5px 10px #cbd2dd,inset -5px -5px 10px #fff}.vp-avatar{width:100%;height:100%;object-fit:cover;border-radius:50%;border:3px solid #e8edf5}.vp-vendor-title{font:800 17px 'Manrope',sans-serif;color:#293954;margin-bottom:4px}.vp-vendor-caption{font-size:11px;color:#8a97aa;margin-bottom:17px}.vp-statuses{display:flex;justify-content:center;gap:8px;flex-wrap:wrap;margin:15px 0}.vp-statuses span{display:inline-flex;align-items:center;padding:6px 10px;border-radius:20px;font-size:10px;font-weight:800;background:#dcefe7;color:#197650}.vp-upload{padding:13px;border-radius:13px;background:#e8edf5;box-shadow:inset 4px 4px 8px #cbd2dd,inset -4px -4px 8px #fff;margin-top:16px;text-align:left}.vp-upload-label{font-size:10px;text-transform:uppercase;letter-spacing:.8px;color:#7e8ba1;font-weight:800;margin-bottom:8px;display:block}.vp-section-head{display:flex;align-items:center;gap:10px;margin-bottom:18px}.vp-section-icon{width:36px;height:36px;border-radius:12px;display:flex;align-items:center;justify-content:center;color:#fff;background:linear-gradient(135deg,#4b86e8,#285bb8);box-shadow:0 5px 12px rgba(40,91,184,.18)}.vp-section-title{font:800 15px 'Manrope',sans-serif;color:#293954;margin:0}.vp-section-caption{font-size:10px;color:#8996aa;margin:4px 0 0}.vp-form-grid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:15px 17px}.vp-field{min-width:0}.vp-field.full{grid-column:1/-1}.vp-label{display:block;font-size:10px;text-transform:uppercase;letter-spacing:.7px;color:#75839a;font-weight:800;margin:0 0 7px}.vp-input{width:100%;border:0!important;border-radius:11px!important;padding:11px 13px!important;background:#e8edf5!important;color:#34445f!important;box-shadow:inset 4px 4px 8px #cbd2dd,inset -4px -4px 8px #fff!important;font-size:12px!important;outline:none!important}.vp-input:focus{box-shadow:inset 2px 2px 5px #cbd2dd,inset -2px -2px 5px #fff,0 0 0 2px rgba(52,120,223,.18)!important}.vp-input:disabled{opacity:.65;cursor:not-allowed}.vp-input::placeholder{color:#a0aabd}.vp-textarea{min-height:88px;resize:vertical}.vp-actions{display:flex;justify-content:flex-end;margin-top:18px}.vp-btn{border:0!important;border-radius:11px!important;padding:11px 18px!important;font-size:12px!important;font-weight:800!important;background:linear-gradient(135deg,#477fe5,#2859b7)!important;color:#fff!important;box-shadow:0 6px 13px rgba(44,96,185,.22)!important}.vp-btn:hover{transform:translateY(-1px)}.vp-btn-secondary{width:100%;margin-top:10px}.vp-password-grid{display:grid;grid-template-columns:repeat(3,minmax(0,1fr));gap:13px}.vp-hint{font-size:10px;color:#8b97aa;margin-top:10px}.vp-file{width:100%;font-size:11px;color:#7d8aa0}.vp-file::file-selector-button{border:0;border-radius:8px;padding:8px 10px;margin-right:9px;background:#dce5f3;color:#315b9e;font-size:10px;font-weight:800}@media(max-width:900px){.vp-layout{grid-template-columns:1fr}.vp-profile-card{max-width:none}.vp-password-grid{grid-template-columns:1fr}}@media(max-width:600px){.vp-title{font-size:22px}.vp-card{padding:16px}.vp-form-grid{grid-template-columns:1fr;gap:13px}.vp-field.full{grid-column:auto}.vp-actions .vp-btn{width:100%}}
</style>

<div class="vp-page">
    <div class="vp-head">
        <div class="vp-eyebrow">Vendor workspace / Account</div>
        <h3 class="vp-title">My Profile</h3>
        <p class="vp-subtitle">Keep your dealership information up to date and manage your account security.</p>
    </div>

    <asp:Label ID="lblMsg" runat="server" CssClass="vp-message"></asp:Label>

    <div class="vp-layout">
        <aside>
            <section class="vp-card vp-profile-card">
                <div class="vp-avatar-wrap">
                    <asp:Image ID="imgProfile" runat="server" CssClass="vp-avatar" AlternateText="Vendor profile photo" />
                </div>
                <div class="vp-vendor-title"><asp:Label ID="txtNameDisplay" runat="server" Text="Vendor Account"></asp:Label></div>
                <div class="vp-vendor-caption">Dealership profile</div>
                <div class="vp-statuses">
                    <asp:Label ID="lblApproval" runat="server"></asp:Label>
                    <asp:Label ID="lblActive" runat="server"></asp:Label>
                </div>
                <div class="vp-upload">
                    <label class="vp-upload-label"><i class="fas fa-camera"></i> Update profile photo</label>
                    <asp:FileUpload ID="fuProfile" runat="server" CssClass="vp-file" />
                    <asp:Button ID="btnUploadImage" runat="server" Text="Upload Photo" CssClass="vp-btn vp-btn-secondary" OnClick="btnUploadImage_Click" />
                </div>
            </section>
        </aside>

        <div>
            <section class="vp-card">
                <div class="vp-section-head">
                    <div class="vp-section-icon"><i class="fas fa-store"></i></div>
                    <div><h5 class="vp-section-title">Business Information</h5><p class="vp-section-caption">Your personal and dealership details</p></div>
                </div>
                <div class="vp-form-grid">
                    <div class="vp-field"><label class="vp-label" for="<%= txtName.ClientID %>">Full name</label><asp:TextBox ID="txtName" runat="server" CssClass="vp-input" placeholder="Enter your full name"></asp:TextBox></div>
                    <div class="vp-field"><label class="vp-label" for="<%= txtEmail.ClientID %>">Email address · Locked</label><asp:TextBox ID="txtEmail" runat="server" CssClass="vp-input" Enabled="false"></asp:TextBox></div>
                    <div class="vp-field"><label class="vp-label" for="<%= txtMobile.ClientID %>">Mobile number</label><asp:TextBox ID="txtMobile" runat="server" CssClass="vp-input" placeholder="Enter mobile number"></asp:TextBox></div>
                    <div class="vp-field"><label class="vp-label" for="<%= txtShop.ClientID %>">Shop / dealership name</label><asp:TextBox ID="txtShop" runat="server" CssClass="vp-input" placeholder="Enter business name"></asp:TextBox></div>
                    <div class="vp-field"><label class="vp-label" for="<%= txtGST.ClientID %>">GST number</label><asp:TextBox ID="txtGST" runat="server" CssClass="vp-input" placeholder="Enter GST number"></asp:TextBox></div>
                    <div class="vp-field"><label class="vp-label" for="<%= txtCity.ClientID %>">City</label><asp:TextBox ID="txtCity" runat="server" CssClass="vp-input" placeholder="Enter city"></asp:TextBox></div>
                    <div class="vp-field full"><label class="vp-label" for="<%= txtAddress.ClientID %>">Business address</label><asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" CssClass="vp-input vp-textarea" placeholder="Enter complete business address"></asp:TextBox></div>
                </div>
                <div class="vp-actions"><asp:Button ID="btnUpdateProfile" runat="server" Text="Save Changes" CssClass="vp-btn" OnClick="btnUpdateProfile_Click" /></div>
            </section>

            <section class="vp-card">
                <div class="vp-section-head">
                    <div class="vp-section-icon"><i class="fas fa-shield-alt"></i></div>
                    <div><h5 class="vp-section-title">Change Password</h5><p class="vp-section-caption">Use a strong password to protect your vendor account</p></div>
                </div>
                <div class="vp-password-grid">
                    <div class="vp-field"><label class="vp-label" for="<%= txtOldPass.ClientID %>">Current password</label><asp:TextBox ID="txtOldPass" runat="server" TextMode="Password" CssClass="vp-input" placeholder="Current password"></asp:TextBox></div>
                    <div class="vp-field"><label class="vp-label" for="<%= txtNewPass.ClientID %>">New password</label><asp:TextBox ID="txtNewPass" runat="server" TextMode="Password" CssClass="vp-input" placeholder="New password"></asp:TextBox></div>
                    <div class="vp-field"><label class="vp-label" for="<%= txtConfirmPass.ClientID %>">Confirm password</label><asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="vp-input" placeholder="Confirm new password"></asp:TextBox></div>
                </div>
                <p class="vp-hint"><i class="fas fa-info-circle"></i> Password must contain at least 6 characters.</p>
                <div class="vp-actions"><asp:Button ID="btnChangePassword" runat="server" Text="Update Password" CssClass="vp-btn" OnClick="btnChangePassword_Click" /></div>
            </section>
        </div>
    </div>
</div>
</asp:Content>