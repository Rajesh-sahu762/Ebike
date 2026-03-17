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


CREATE TABLE SubscriptionPlans
(
PlanID INT IDENTITY PRIMARY KEY,
PlanName NVARCHAR(50),
Price DECIMAL(18,2),
DurationDays INT,
MaxBikes INT,
IsActive BIT DEFAULT 1
)


CREATE TABLE DealerSubscriptionRequests
(
RequestID INT IDENTITY PRIMARY KEY,

DealerID INT,
PlanName NVARCHAR(50),

BikeLimit INT,
FeaturedLimit INT,

Amount DECIMAL(18,2),

Status NVARCHAR(20) DEFAULT 'Pending',
-- Pending / Approved / Rejected

CreatedAt DATETIME DEFAULT GETDATE(),
ApprovedAt DATETIME NULL
)

ALTER TABLE Bikes ADD
IsUsed BIT DEFAULT 0 ,
OwnerType NVARCHAR(10)


select * from Users


CREATE TABLE DealerSubscriptions(
SubscriptionID INT IDENTITY PRIMARY KEY,
DealerID INT,
PlanName NVARCHAR(50),
StartDate DATETIME,
EndDate DATETIME,
MaxBikes INT,
IsActive BIT
)


CREATE TABLE FeaturedBikes(
FeatureID INT IDENTITY PRIMARY KEY,
BikeID INT,
DealerID INT,
StartDate DATETIME,
EndDate DATETIME,
IsActive BIT
)

CREATE TABLE EnquiryLogs(
LogID INT IDENTITY PRIMARY KEY,
UserID INT,
BikeID INT,
IP NVARCHAR(50),
CreatedAt DATETIME
)


CREATE TABLE Brands (
    BrandID INT PRIMARY KEY IDENTITY(1,1),
    BrandName NVARCHAR(100) NOT NULL,
    IsActive BIT DEFAULT 1
);

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


ALTER TABLE Bikes ADD
KMDriven INT NULL,
ManufactureYear INT NULL,
OwnerNumber INT NULL,
BikeCondition NVARCHAR(50) NULL,
BatteryHealth NVARCHAR(50) NULL;

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


CREATE TABLE BikeReviews (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),

    BikeID INT FOREIGN KEY REFERENCES Bikes(BikeID),
    CustomerID INT FOREIGN KEY REFERENCES Users(UserID),

    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewTitle NVARCHAR(200),
    ReviewText NVARCHAR(2000),

    IsVerified BIT DEFAULT 1,
    IsApproved BIT DEFAULT 1,

    CreatedAt DATETIME DEFAULT GETDATE()
);

SELECT name
FROM sys.default_constraints
WHERE parent_object_id = OBJECT_ID('BikeReviews')
AND parent_column_id = COLUMNPROPERTY(OBJECT_ID('BikeReviews'),'IsApproved','ColumnId')

ALTER TABLE BikeReviews
DROP CONSTRAINT DF__BikeRevie__IsApp__73BA3083

ALTER TABLE BikeReviews
ADD DEFAULT 0 FOR IsApproved

ALTER TABLE BikeReviews
ADD CONSTRAINT UQ_User_BikeReview
UNIQUE(CustomerID,BikeID)

INSERT INTO BikeReviews (BikeID, CustomerID, Rating, ReviewTitle, ReviewText)
VALUES
(1, 4, 5, 'Best EV Scooter',
 'Amazing pickup and smooth ride. Battery backup is excellent and charging time is decent.'),

(2, 4, 4, 'Great Performance',
 'Good range and solid build quality. Suspension could be better but overall worth the price.'),

(3, 4, 5, 'Super Comfortable',
 'Very comfortable for city rides. Low maintenance and stylish look.'),

(1, 4, 3, 'Average Experience',
 'Range is good but charging takes longer than expected. Could improve on service network.');

 SELECT COUNT(*) FROM Bikes WHERE IsApproved = 1


INSERT INTO Users (Role, FullName, Email, Mobile, PasswordHash, IsApproved)
VALUES ('Admin', 'Super Admin', 'admin@ebikes.com', '9999999999', 'admin123', 1);

UPDATE Bikes SET IsForRent = 0 WHERE IsForRent IS NULL;

ALTER TABLE RentalBookings
ADD IsSettled BIT DEFAULT 0,
SettlementID INT NULL;

CREATE INDEX IX_Bikes_Price ON Bikes(Price);
CREATE INDEX IX_Bikes_Brand ON Bikes(BrandID);
CREATE INDEX IX_Bikes_Approved ON Bikes(IsApproved);
CREATE INDEX IX_Users_Role ON Users(Role);
CREATE INDEX IX_Users_Approved ON Users(IsApproved);

ALTER TABLE Leads ADD IsSpam BIT DEFAULT 0;


UPDATE Bikes
SET IsUsed = 0
WHERE IsUsed IS NULL

ALTER TABLE Leads ADD LeadAmount DECIMAL(18,2) DEFAULT 0;


ALTER TABLE Bikes ADD
IsForRent BIT DEFAULT 0,
RentPerDay DECIMAL(18,2) NULL,
RentPerWeek DECIMAL(18,2) NULL,
RentPerMonth DECIMAL(18,2) NULL;


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



CREATE TABLE RentalBookings (
    RentalID INT PRIMARY KEY IDENTITY(1,1),

    BikeID INT FOREIGN KEY REFERENCES Bikes(BikeID),
    CustomerID INT FOREIGN KEY REFERENCES Users(UserID),
    DealerID INT FOREIGN KEY REFERENCES Users(UserID),

    StartDate DATE,
    EndDate DATE,
    TotalDays INT,

    RentAmount DECIMAL(18,2),
    CommissionAmount DECIMAL(18,2),

    Status NVARCHAR(20) DEFAULT 'Pending', 
    -- Pending / Approved / Rejected / Active / Completed / Cancelled

    IsViewed BIT DEFAULT 0,

    CreatedAt DATETIME DEFAULT GETDATE()
);


SELECT * FROM SiteSettings



CREATE TABLE ChargingStations
(
    StationID INT IDENTITY PRIMARY KEY,

    VendorID INT NULL,   -- NULL = Admin Added

    StationName NVARCHAR(150),
    Phone NVARCHAR(20),

    City NVARCHAR(100),
    Address NVARCHAR(250),

    Latitude DECIMAL(9,6) NULL,
    Longitude DECIMAL(9,6) NULL,

    ConnectorType NVARCHAR(100),

    IsApproved BIT DEFAULT 0,
    IsActive BIT DEFAULT 1,

    CreatedAt DATETIME DEFAULT GETDATE()
)

CREATE TABLE ServiceCenters
(
    ServiceID INT IDENTITY PRIMARY KEY,

    VendorID INT NULL,

    CenterName NVARCHAR(150),
    Phone NVARCHAR(20),

    City NVARCHAR(100),
    Address NVARCHAR(250),

    ServiceType NVARCHAR(200),

    IsApproved BIT DEFAULT 0,
    IsActive BIT DEFAULT 1,

    CreatedAt DATETIME DEFAULT GETDATE()
)


CREATE TABLE Parts
(
    PartID INT IDENTITY PRIMARY KEY,

    VendorID INT,
    PartName NVARCHAR(150),
    Category NVARCHAR(100),

    Price DECIMAL(10,2),
    Stock INT,

    Description NVARCHAR(MAX),
    Image1 NVARCHAR(200),

    IsApproved BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE()
)


select *from Parts


delete from Parts


INSERT INTO Parts (VendorID, PartName, Category, Price, Stock, Description, Image1, IsApproved)
VALUES 
(1, 'High-Performance Lithium Battery (60V 30Ah)', 'Battery', 18500.00, 12, 'Long-range lithium-ion battery pack with BMS protection and 2-year warranty.', 'https://images.unsplash.com/photo-1595115203358-1830495f5431?auto=format&fit=crop&w=500&q=80', 1),

(1, 'Digital Smart LCD Display Control Unit', 'Electronics', 3200.00, 25, 'Waterproof LCD display showing speed, battery level, and ODO meter. Compatible with most controllers.', 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?auto=format&fit=crop&w=500&q=80', 1),

(2, '250W Brushless DC Hub Motor (Rear)', 'Motor', 7500.00, 8, 'Quiet and efficient 250W BLDC motor for smooth city riding and uphill assistance.', 'https://images.unsplash.com/photo-1620311109405-f938a44d7003?auto=format&fit=crop&w=500&q=80', 1),

(2, 'Hydraulic Disc Brake Kit (Front & Rear)', 'Brakes', 4500.00, 15, 'High-stopping power hydraulic brakes for maximum safety during high-speed rides.', 'https://images.unsplash.com/photo-1507133351264-39817f3bd70e?auto=format&fit=crop&w=500&q=80', 1),

(3, 'Anti-Theft Intelligent Alarm System', 'Accessories', 1200.00, 50, 'Remote-controlled alarm system with motion sensor and wheel lock feature.', 'https://images.unsplash.com/photo-1558089687-f282ffca1265?auto=format&fit=crop&w=500&q=80', 1),

(3, 'Puncture Resistant E-Bike Tire (2.4 inch)', 'Tires', 2200.00, 4, 'Extra-thick rubber compound with puncture-proof lining for rough terrains.', 'https://images.unsplash.com/photo-1582234053223-997656910793?auto=format&fit=crop&w=500&q=80', 1),

(1, 'Fast Charger 5A (For Lithium Battery)', 'Charger', 2800.00, 20, 'Rapid charging technology with auto-cut off and overheat protection.', 'https://images.unsplash.com/photo-1585032226651-759b368d7246?auto=format&fit=crop&w=500&q=80', 1),

(2, 'Ergonomic Comfort Gel Saddle', 'Accessories', 1500.00, 18, 'Extra soft gel padding for long-distance comfort and shock absorption.', 'https://images.unsplash.com/photo-1618341147551-64d8583487c6?auto=format&fit=crop&w=500&q=80', 1),

(3, 'LED Headlight with Integrated Horn', 'Electronics', 950.00, 0, 'Ultra-bright 12V LED light with high decibel horn for night safety.', 'https://images.unsplash.com/photo-1485965120184-e220f721d03e?auto=format&fit=crop&w=500&q=80', 1);