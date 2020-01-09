USE Master
GO

--Create Chapter10Audit Database

CREATE DATABASE Chapter10Audit

USE Chapter10Audit
GO

CREATE TABLE dbo.SensitiveData (
    ID    INT    PRIMARY KEY    NOT NULL,
    Data    NVARCHAR(256) NOT NULL
) ;

--Create Server Audit

USE master
GO

CREATE SERVER AUDIT [Audit-Chapter10Audit]
TO FILE 
(        FILEPATH = N'C:\Audit'
        ,MAXSIZE = 512 MB
        ,MAX_ROLLOVER_FILES = 2147483647
        ,RESERVE_DISK_SPACE = OFF
)
WITH
(        QUEUE_DELAY = 1000
        ,ON_FAILURE = CONTINUE
) ;

USE Chapter10Audit
GO

--Create database user from Danielle Login

CREATE USER Danielle FOR LOGIN Danielle WITH DEFAULT_SCHEMA=dbo ;
GO

GRANT SELECT ON dbo.SensitiveData TO Danielle ;
