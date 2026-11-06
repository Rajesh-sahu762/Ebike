-- ============================================================================
-- EBikes Duniya - Security & Performance Database Migration Script
-- Target DBMS: Microsoft SQL Server 2012+ / Azure SQL Database
-- Description:
--   1. Creates UserAuthTokens table for cryptographically secure server-validated
--      Remember-Me tokens with cascading deletion.
--   2. Adds optional OTP audit and cooldown columns to Users table.
--   3. Adds high-performance covering and foreign key indexes for Bikes,
--      Leads, RentalBookings, OrderItems, Cart, and Wishlist tables.
-- IDEMPOTENCY:
--   Safe to run multiple times without error or data loss (checks IF NOT EXISTS).
-- ============================================================================

PRINT 'Starting EBikes Duniya Security and Performance Migration...';
GO

-- ============================================================================
-- STEP 1: CREATE UserAuthTokens TABLE
-- ============================================================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserAuthTokens]') AND type in (N'U'))
BEGIN
    PRINT 'Creating table [dbo].[UserAuthTokens]...';
    CREATE TABLE [dbo].[UserAuthTokens] (
        [TokenID]    INT IDENTITY(1,1) NOT NULL,
        [UserID]     INT NOT NULL,
        [TokenHash]  NVARCHAR(64) NOT NULL,
        [ExpiresAt]  DATETIME NOT NULL,
        [CreatedAt]  DATETIME NOT NULL CONSTRAINT [DF_UserAuthTokens_CreatedAt] DEFAULT (GETDATE()),
        [UserAgent]  NVARCHAR(255) NULL,
        [IPAddress]  NVARCHAR(50) NULL,
        CONSTRAINT [PK_UserAuthTokens] PRIMARY KEY CLUSTERED ([TokenID] ASC),
        CONSTRAINT [FK_UserAuthTokens_Users] FOREIGN KEY ([UserID])
            REFERENCES [dbo].[Users] ([UserID]) ON DELETE CASCADE
    );
    PRINT 'Table [dbo].[UserAuthTokens] created successfully.';
END
ELSE
BEGIN
    PRINT 'Table [dbo].[UserAuthTokens] already exists. Skipping creation.';
END
GO

-- Indexes for UserAuthTokens table
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[UserAuthTokens]') AND name = N'IX_UserAuthTokens_TokenHash')
BEGIN
    PRINT 'Creating index [IX_UserAuthTokens_TokenHash]...';
    CREATE NONCLUSTERED INDEX [IX_UserAuthTokens_TokenHash]
        ON [dbo].[UserAuthTokens] ([TokenHash])
        INCLUDE ([UserID], [ExpiresAt]);
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[UserAuthTokens]') AND name = N'IX_UserAuthTokens_UserID')
BEGIN
    PRINT 'Creating index [IX_UserAuthTokens_UserID]...';
    CREATE NONCLUSTERED INDEX [IX_UserAuthTokens_UserID]
        ON [dbo].[UserAuthTokens] ([UserID]);
END
GO

-- ============================================================================
-- STEP 2: ADD OTP AUDIT COLUMNS TO Users (IDEMPOTENT)
-- ============================================================================
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND name = N'OTPAttempts')
BEGIN
    PRINT 'Adding [OTPAttempts] column to [dbo].[Users]...';
    ALTER TABLE [dbo].[Users] ADD [OTPAttempts] INT NULL CONSTRAINT [DF_Users_OTPAttempts] DEFAULT ((0));
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND name = N'OTPLastSent')
BEGIN
    PRINT 'Adding [OTPLastSent] column to [dbo].[Users]...';
    ALTER TABLE [dbo].[Users] ADD [OTPLastSent] DATETIME NULL;
END
GO

-- Ensure PasswordHash column width supports PBKDF2 hash format
-- PBKDF2 format: PBKDF2$100000$<salt_b64>$<hash_b64> is ~88 chars, fits well within nvarchar(500)
IF EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND name = N'PasswordHash' AND max_length < 500 AND max_length > 0)
BEGIN
    PRINT 'Expanding [PasswordHash] column width to NVARCHAR(500)...';
    ALTER TABLE [dbo].[Users] ALTER COLUMN [PasswordHash] NVARCHAR(500) NULL;
END
GO

-- ============================================================================
-- STEP 3: PERFORMANCE INDEXES (IDEMPOTENT)
-- ============================================================================

-- 3.1 Users table index for fast authentication and role lookups
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND name = N'IX_Users_Email_Role')
BEGIN
    PRINT 'Creating index [IX_Users_Email_Role]...';
    CREATE NONCLUSTERED INDEX [IX_Users_Email_Role]
        ON [dbo].[Users] ([Email], [Role])
        INCLUDE ([UserID], [FullName], [PasswordHash], [IsActive], [IsApproved], [IsEmailVerified]);
END
GO

-- 3.2 Bikes table index for catalog browsing (Bikes.aspx, UsedBikes.aspx, Rental.aspx)
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Bikes]') AND name = N'IX_Bikes_IsApproved_Filters')
BEGIN
    PRINT 'Creating index [IX_Bikes_IsApproved_Filters]...';
    CREATE NONCLUSTERED INDEX [IX_Bikes_IsApproved_Filters]
        ON [dbo].[Bikes] ([IsApproved], [IsUsed], [IsForRent])
        INCLUDE ([BikeID], [BrandID], [ModelName], [Price], [Image1], [Slug], [CreatedAt], [DealerID]);
END
GO

-- 3.3 Bikes table index for vendor lookups and management
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Bikes]') AND name = N'IX_Bikes_DealerID')
BEGIN
    PRINT 'Creating index [IX_Bikes_DealerID]...';
    CREATE NONCLUSTERED INDEX [IX_Bikes_DealerID]
        ON [dbo].[Bikes] ([DealerID])
        INCLUDE ([BikeID], [BrandID], [ModelName], [Price], [IsApproved], [IsForRent]);
END
GO

-- 3.4 Leads table index for vendor lead retrieval & unviewed counts
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Leads]') AND name = N'IX_Leads_BikeID_IsViewed')
BEGIN
    PRINT 'Creating index [IX_Leads_BikeID_IsViewed]...';
    CREATE NONCLUSTERED INDEX [IX_Leads_BikeID_IsViewed]
        ON [dbo].[Leads] ([BikeID], [IsViewed])
        INCLUDE ([LeadID], [CustomerID], [CreatedAt], [LeadAmount]);
END
GO

-- 3.5 RentalBookings table indexes for dealer and customer lookups
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RentalBookings]') AND name = N'IX_RentalBookings_DealerID_Status')
BEGIN
    PRINT 'Creating index [IX_RentalBookings_DealerID_Status]...';
    CREATE NONCLUSTERED INDEX [IX_RentalBookings_DealerID_Status]
        ON [dbo].[RentalBookings] ([DealerID], [Status])
        INCLUDE ([RentalID], [BikeID], [CustomerID], [StartDate], [EndDate], [RentAmount], [IsSettled]);
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RentalBookings]') AND name = N'IX_RentalBookings_CustomerID_Status')
BEGIN
    PRINT 'Creating index [IX_RentalBookings_CustomerID_Status]...';
    CREATE NONCLUSTERED INDEX [IX_RentalBookings_CustomerID_Status]
        ON [dbo].[RentalBookings] ([CustomerID], [Status]);
END
GO

-- 3.6 OrderItems table index for vendor order fulfillment and line item isolation
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OrderItems]') AND name = N'IX_OrderItems_VendorID_OrderID')
BEGIN
    PRINT 'Creating index [IX_OrderItems_VendorID_OrderID]...';
    CREATE NONCLUSTERED INDEX [IX_OrderItems_VendorID_OrderID]
        ON [dbo].[OrderItems] ([VendorID], [OrderID])
        INCLUDE ([ItemID], [PartID], [Price], [Qty]);
END
GO

-- 3.7 Cart and Wishlist indexes for fast client navbar badge count & lookup
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Cart]') AND name = N'IX_Cart_UserID')
BEGIN
    PRINT 'Creating index [IX_Cart_UserID]...';
    CREATE NONCLUSTERED INDEX [IX_Cart_UserID]
        ON [dbo].[Cart] ([UserID])
        INCLUDE ([PartID], [Qty]);
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Wishlist]') AND name = N'IX_Wishlist_CustomerID_BikeID')
BEGIN
    PRINT 'Creating index [IX_Wishlist_CustomerID_BikeID]...';
    CREATE NONCLUSTERED INDEX [IX_Wishlist_CustomerID_BikeID]
        ON [dbo].[Wishlist] ([CustomerID], [BikeID]);
END
GO

-- ============================================================================
-- STEP 4: CLEANUP EXPIRED TOKENS ROUTINE (OPTIONAL HELPER PROCEDURE)
-- ============================================================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_PurgeExpiredAuthTokens]') AND type in (N'P', N'PC'))
BEGIN
    PRINT 'Creating stored procedure [dbo].[sp_PurgeExpiredAuthTokens]...';
    EXEC('
    CREATE PROCEDURE [dbo].[sp_PurgeExpiredAuthTokens]
    AS
    BEGIN
        SET NOCOUNT ON;
        DELETE FROM [dbo].[UserAuthTokens]
        WHERE [ExpiresAt] < GETDATE();
    END
    ');
END
GO

PRINT '============================================================================';
PRINT 'EBikes Duniya Security & Performance Migration completed successfully.';
PRINT '============================================================================';
GO
