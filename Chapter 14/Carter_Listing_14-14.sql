CREATE DATABASE LinuxDB ;
GO

ALTER DATABASE LinuxDB SET RECOVERY FULL ;
GO

USE LinuxDB
GO

CREATE TABLE [dbo].[Orders](
         [OrderNumber] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
         [OrderDate] [date]  NOT NULL,
         [CustomerID] [int]  NOT NULL,
         [ProductID] [int]   NOT NULL,
         [Quantity] [int]    NOT NULL,
         [NetAmount] [money] NOT NULL,
         [TaxAmount] [money] NOT NULL,
         [InvoiceAddressID] [int] NOT NULL,
         [DeliveryAddressID] [int] NOT NULL,
         [DeliveryDate] [date] NULL,
) ;

DECLARE @Numbers TABLE
(
        Number        INT
)

;WITH CTE(Number)
AS
(
        SELECT 1 Number
        UNION ALL
        SELECT Number + 1
        FROM CTE
        WHERE Number < 100
)
INSERT INTO @Numbers
SELECT Number FROM CTE

--Populate ExistingOrders with data

INSERT INTO Orders
SELECT
         (SELECT CAST(DATEADD(dd,(SELECT TOP 1 Number 
                                  FROM @Numbers 
                                  ORDER BY NEWID()),getdate())as DATE)),
         (SELECT TOP 1 Number -10 FROM @Numbers ORDER BY NEWID()),
         (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
         (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
        500,
        100,
         (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
         (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
         (SELECT CAST(DATEADD(dd,(SELECT TOP 1 Number - 10 
          FROM @Numbers 
          ORDER BY NEWID()),getdate()) as DATE))
FROM @Numbers a
CROSS JOIN @Numbers b
CROSS JOIN @Numbers c ;


--Backup Database

BACKUP DATABASE LinuxDB
   TO DISK = N'/var/opt/mssql/data/LinuxDB.bak';
GO

--Add database to Availability Group

USE master
GO

ALTER AVAILABILITY GROUP Linux_AOAG ADD DATABASE LinuxDB
GO
