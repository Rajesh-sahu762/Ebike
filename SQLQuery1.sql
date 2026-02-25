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



select * from Wishlist




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



UPDATE Users SET IsEmailVerified = 1, IsApproved =1  WHERE UserID = 4;




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



ALTER TABLE RentalBookings
ADD IsSettled BIT DEFAULT 0,
SettlementID INT NULL;

CREATE INDEX IX_Bikes_Price ON Bikes(Price);
CREATE INDEX IX_Bikes_Brand ON Bikes(BrandID);
CREATE INDEX IX_Bikes_Approved ON Bikes(IsApproved);
CREATE INDEX IX_Users_Role ON Users(Role);
CREATE INDEX IX_Users_Approved ON Users(IsApproved);

ALTER TABLE Leads ADD IsSpam BIT DEFAULT 0;

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