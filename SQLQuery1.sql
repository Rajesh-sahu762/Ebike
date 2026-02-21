CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),

    -- Role system (No separate Roles table)
    Role NVARCHAR(20) NOT NULL,  -- Admin / Dealer / Customer

    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Mobile NVARCHAR(15),
    PasswordHash NVARCHAR(500),

    -- Dealer specific fields (NULL for others)
    ShopName NVARCHAR(150) NULL,
    GSTNo NVARCHAR(50) NULL,
    City NVARCHAR(100) NULL,
    Address NVARCHAR(500) NULL,

    -- Approval system (for Dealer)
    IsApproved BIT DEFAULT 1,  -- Dealer default 0, Admin auto 1
    ApprovedAt DATETIME NULL,

    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE()
);






ALTER TABLE Users ADD
IsEmailVerified BIT DEFAULT 0,
OTPCode NVARCHAR(10),
OTPExpiry DATETIME,
FailedLoginAttempts INT DEFAULT 0,
LockoutEndTime DATETIME NULL;


select * from Users

delete from Users where UserID=3



CREATE TABLE Brands (
    BrandID INT PRIMARY KEY IDENTITY(1,1),
    BrandName NVARCHAR(100) NOT NULL,
    IsActive BIT DEFAULT 1
);

select * from Brands


ALTER TABLE Brands ADD LogoPath NVARCHAR(300), CreatedAt DATETIME DEFAULT GETDATE()

ALTER TABLE Users ADD ProfileImage NVARCHAR(300) NULL;



CREATE TABLE SiteSettings
(
    SettingID INT PRIMARY KEY,
    SiteTitle NVARCHAR(200),
    Tagline NVARCHAR(300),
    AdminEmail NVARCHAR(150),
    SupportPhone NVARCHAR(20),
    LogoPath NVARCHAR(300),
    SMTPHost NVARCHAR(150),
    SMTPPort INT,
    SMTPEmail NVARCHAR(150),
    SMTPPassword NVARCHAR(200),
    EnableSSL BIT,
    LeadPrice DECIMAL(18,2),
    CommissionPercent DECIMAL(5,2),
    MaintenanceMode BIT,
    MaintenanceMessage NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE()
)

INSERT INTO SiteSettings (SettingID)
VALUES (1)




CREATE TABLE Bikes (
    BikeID INT PRIMARY KEY IDENTITY(1,1),
    DealerID INT FOREIGN KEY REFERENCES Users(UserID),
    BrandID INT FOREIGN KEY REFERENCES Brands(BrandID),
    ModelName NVARCHAR(150) NOT NULL,
    Slug NVARCHAR(200) UNIQUE,  -- SEO Friendly URL
    Price DECIMAL(18,2),
    RangeKM INT,
    BatteryType NVARCHAR(100),
    MotorPower NVARCHAR(100),
    TopSpeed INT,
    ChargingTime NVARCHAR(50),
    Description NVARCHAR(MAX),
    Image1 NVARCHAR(300),
    Image2 NVARCHAR(300),
    Image3 NVARCHAR(300),
    IsApproved BIT DEFAULT 0,
    ApprovedAt DATETIME NULL,
	CreatedAt DATETIME DEFAULT GETDATE()
);



UPDATE Bikes SET Image1 = 'RoadsterX+.jpg', Image2 = 'RoadsterX+front.jpg', Image3 = 'RoadsterX+front.jpg' WHERE BikeID = 11;




ALTER TABLE Bikes ALTER COLUMN BatteryType NVARCHAR(255);
ALTER TABLE Bikes ALTER COLUMN MotorPower NVARCHAR(255);
ALTER TABLE Bikes ALTER COLUMN ChargingTime NVARCHAR(255);
ALTER TABLE Bikes ALTER COLUMN Slug NVARCHAR(255);


ALTER TABLE Bikes
ADD CONSTRAINT UQ_Dealer_Bike UNIQUE (DealerID, BrandID, ModelName);


CREATE TABLE Leads (
    LeadID INT PRIMARY KEY IDENTITY(1,1),

    BikeID INT FOREIGN KEY REFERENCES Bikes(BikeID),
    CustomerID INT FOREIGN KEY REFERENCES Users(UserID),

    Message NVARCHAR(1000),
    CreatedAt DATETIME DEFAULT GETDATE(),
    IsViewed BIT DEFAULT 0
);


ALTER TABLE Leads ADD
IsSettled BIT DEFAULT 0,
SettlementRequested BIT DEFAULT 0,
SettlementDate DATETIME NULL,
SettlementApprovedBy INT NULL,
SettlementApprovedAt DATETIME NULL;

ALTER TABLE Leads ADD CommissionAmount DECIMAL(18,2) NULL;



CREATE TABLE Wishlist (
    WishlistID INT PRIMARY KEY IDENTITY(1,1),

    CustomerID INT FOREIGN KEY REFERENCES Users(UserID),
    BikeID INT FOREIGN KEY REFERENCES Bikes(BikeID),

    CreatedAt DATETIME DEFAULT GETDATE()
);


CREATE TABLE DealerRatings (
    RatingID INT PRIMARY KEY IDENTITY(1,1),

    DealerID INT FOREIGN KEY REFERENCES Users(UserID),
    CustomerID INT FOREIGN KEY REFERENCES Users(UserID),

    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Review NVARCHAR(1000),
    CreatedAt DATETIME DEFAULT GETDATE()
);


INSERT INTO Users (Role, FullName, Email, Mobile, PasswordHash, IsApproved)
VALUES ('Admin', 'Super Admin', 'admin@ebikes.com', '9999999999', 'admin123', 1);



CREATE INDEX IX_Bikes_Price ON Bikes(Price);
CREATE INDEX IX_Bikes_Brand ON Bikes(BrandID);
CREATE INDEX IX_Bikes_Approved ON Bikes(IsApproved);
CREATE INDEX IX_Users_Role ON Users(Role);
CREATE INDEX IX_Users_Approved ON Users(IsApproved);

ALTER TABLE Leads ADD IsSpam BIT DEFAULT 0;

ALTER TABLE Leads ADD LeadAmount DECIMAL(18,2) DEFAULT 0;



CREATE TABLE Settlements (
    SettlementID INT PRIMARY KEY IDENTITY(1,1),

    DealerID INT FOREIGN KEY REFERENCES Users(UserID),

    TotalRevenue DECIMAL(18,2),
    CommissionAmount DECIMAL(18,2),
    NetAmount DECIMAL(18,2),

    IsApproved BIT DEFAULT 0,
    ApprovedBy INT NULL,  -- AdminID
    ApprovedAt DATETIME NULL,

    CreatedAt DATETIME DEFAULT GETDATE()
);
