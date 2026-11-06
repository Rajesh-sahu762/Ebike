/*
EBikes Duniya - security hardening migration.
Run against a BACKUP / staging database first. Do not run against production until reviewed.
Legacy PasswordHash values are upgraded after a successful login by the application.
*/
IF OBJECT_ID(N'dbo.RememberMeTokens', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.RememberMeTokens
    (
        TokenID BIGINT IDENTITY(1,1) NOT NULL CONSTRAINT PK_RememberMeTokens PRIMARY KEY,
        UserID INT NOT NULL,
        TokenHash VARBINARY(32) NOT NULL,
        CreatedAtUtc DATETIME2(0) NOT NULL CONSTRAINT DF_RememberMeTokens_CreatedAtUtc DEFAULT SYSUTCDATETIME(),
        ExpiresAtUtc DATETIME2(0) NOT NULL,
        RevokedAtUtc DATETIME2(0) NULL,
        CONSTRAINT FK_RememberMeTokens_Users FOREIGN KEY (UserID) REFERENCES dbo.Users(UserID)
    );
    CREATE UNIQUE INDEX UX_RememberMeTokens_TokenHash
        ON dbo.RememberMeTokens(TokenHash);
    CREATE INDEX IX_RememberMeTokens_User_Expiry
        ON dbo.RememberMeTokens(UserID, ExpiresAtUtc) INCLUDE (RevokedAtUtc);
END;
GO

IF COL_LENGTH('dbo.Users', 'PasswordHash') IS NULL
    THROW 50001, 'Users.PasswordHash was not found; migration stopped.', 1;
GO
