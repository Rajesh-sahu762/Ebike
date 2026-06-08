<div align="center">

# ⚡ EBikes Duniya

### Multi-Vendor Electric Bike Marketplace Platform

Discover • Compare • Enquire • Manage

Built with ASP.NET Web Forms, C#, SQL Server

---

![ASP.NET](https://img.shields.io/badge/ASP.NET-WebForms-blue)
![C#](https://img.shields.io/badge/C%23-.NET-green)
![SQL Server](https://img.shields.io/badge/SQL%20Server-Database-red)
![Status](https://img.shields.io/badge/Status-Active-success)
![License](https://img.shields.io/badge/License-MIT-orange)

</div>

---

# 📖 Overview

EBikes Duniya is a complete multi-vendor electric bike marketplace designed to connect customers and electric bike dealers on a single platform.

The platform allows users to explore electric bikes, compare specifications, calculate EMI, save favorites, and send enquiries directly to dealers.

Dealers can manage their inventory, receive leads, and grow their business through a dedicated vendor dashboard.

Administrators have full control over users, dealers, bikes, approvals, and marketplace operations.

---

# ✨ Key Features

## 👤 Customer Module

- User Registration & Login
- Email Verification
- OTP Verification
- Browse Electric Bikes
- Advanced Bike Search
- Brand Filtering
- Bike Comparison
- Wishlist System
- Recently Viewed Bikes
- EMI Calculator
- Lead Enquiry System
- Responsive Design

---

## 🏍 Bike Management

- Dynamic Bike Listings
- Detailed Bike Pages
- Multiple Bike Images
- Bike Specifications
- Feature Highlights
- Compare Bikes
- SEO Friendly URLs
- Performance Scoring

---

## 🏪 Dealer Panel

- Dealer Registration
- Dealer Approval Workflow
- Add New Bikes
- Manage Bike Inventory
- Lead Management
- Dealer Dashboard
- Profile Management

---

## 🛠 Admin Panel

- Admin Authentication
- Dealer Approval System
- Bike Approval System
- User Management
- Brand Management
- Lead Monitoring
- Site Settings Management

---

# 🚀 Advanced Features

### 🔍 Smart Search

- AJAX Based Search
- Instant Suggestions
- Dynamic Filtering

### ❤️ Wishlist

- Save Favorite Bikes
- User Specific Wishlist

### ⚖ Bike Comparison

- Side-by-Side Bike Comparison
- Performance Scoring
- Feature Analysis

### 📈 Lead Management

- Customer Enquiries
- Dealer Notifications
- Lead Tracking

### 🔒 Security

- Password Hashing
- Session Management
- Role Based Authorization
- Input Validation
- Duplicate Bike Prevention

---

# 🖥 Screenshots

## Homepage

![Homepage](/Uploads/images/admin.png)

---

## Bike Details

![Bike Details](/Uploads/images/bike.png)

---

## Spare Parts

![Spare Parts](/Uploads/images/parts.png)

---

## Dealer Dashboard

![Dealer Dashboard](/Uploads/images/dealer.png)

## Admin Dashboard

![Admin Dashboard](/Uploads/images/admin.png)


---

# 🏗 System Architecture

```text
Users
│
├── Customer Panel
│   ├── Browse Bikes
│   ├── Wishlist
│   ├── Compare
│   └── Enquiries
│
├── Dealer Panel
│   ├── Add Bikes
│   ├── Manage Bikes
│   └── View Leads
│
└── Admin Panel
    ├── Approvals
    ├── Users
    ├── Dealers
    └── Settings
```

# 🗄 Database Design

## Core Tables

### Users

```sql
Users
├── UserID
├── FullName
├── Email
├── Mobile
├── PasswordHash
├── IsActive
└── CreatedAt
```

### Dealers

```sql
Dealers
├── DealerID
├── UserID
├── ShopName
├── GSTNo
└── IsApproved
```

### Bikes

```sql
Bikes
├── BikeID
├── DealerID
├── BrandID
├── ModelName
├── Slug
├── Price
├── RangeKM
├── TopSpeed
├── BatteryType
└── Images
```

### Leads

```sql
Leads
├── LeadID
├── BikeID
├── UserID
├── Message
└── CreatedAt
```

# ⚙ Technology Stack

## Frontend

- HTML5
- CSS3
- JavaScript
- jQuery
- Bootstrap

## Backend

- ASP.NET Web Forms
- C#

## Database

- SQL Server

## Server

- IIS

# 📂 Project Structure

```text
EBikes-Duniya
│
├── Admin
├── Client
├── Dealer
├── Uploads
├── App_Code
├── CSS
├── JS
├── Images
│
├── Web.config
└── Database Scripts
```

# 🎯 Business Model

EBikes Duniya supports:

### Lead Marketplace

Customers submit enquiries and dealers receive leads.

### Bike Rental Marketplace (Planned)

Users can rent electric bikes.

### Used Bike Marketplace (Planned)

Dealers and users can sell used electric bikes.

# 🔮 Future Enhancements

- Online Bike Booking
- Payment Gateway
- Rental System
- Used Bike Marketplace
- Dealer Subscription Plans
- AI Bike Recommendation Engine
- Mobile Application

# 👨‍💻 Developer

## Rajesh Sahu

ASP.NET Developer

### Skills

- ASP.NET Web Forms
- C#
- SQL Server
- JavaScript
- HTML/CSS

# ⭐ Support

If you found this project useful, please consider giving it a star.

---

Made with ❤️ by Rajesh Sahu