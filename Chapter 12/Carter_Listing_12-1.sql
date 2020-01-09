CREATE DATABASE Chapter12
 ON  PRIMARY 
( NAME = 'Chapter12', FILENAME = 'C:\MSSQL\DATA\Chapter12.mdf'), 
 FILEGROUP FileGroupA
( NAME = 'Chapter12FileA', FILENAME = 'C:\MSSQL\DATA\Chapter12FileA.ndf' ), 
 FILEGROUP FileGroupB 
( NAME = 'Chapter12FileB', FILENAME = 'C:\MSSQL\DATA\Chapter12FileB.ndf' )
 LOG ON 
( NAME = 'Chapter12_log', FILENAME = 'C:\MSSQL\DATA\Chapter12_log.ldf' ) ;
GO

ALTER DATABASE [Chapter12] SET RECOVERY FULL ;
GO

USE Chapter12
GO

CREATE TABLE dbo.Contacts
(
ContactID        INT        NOT NULL        IDENTITY        PRIMARY KEY,
FirstName        NVARCHAR(30),
LastName        NVARCHAR(30),
AddressID        INT
) ON FileGroupA ;

CREATE TABLE dbo.Addresses
(
AddressID        INT        NOT NULL        IDENTITY        PRIMARY KEY,
AddressLine1        NVARCHAR(50),
AddressLine2        NVARCHAR(50),
AddressLine3        NVARCHAR(50),
PostCode        NCHAR(8)
) ON FileGroupB ;
