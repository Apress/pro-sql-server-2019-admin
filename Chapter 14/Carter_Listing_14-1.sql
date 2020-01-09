CREATE DATABASE Chapter14App1Customers ;
GO

ALTER DATABASE Chapter14App1Customers SET RECOVERY FULL ;
GO

USE Chapter14App1Customers
GO

CREATE TABLE App1Customers
(
ID                INT                PRIMARY KEY        IDENTITY,
FirstName         NVARCHAR(30),
LastName          NVARCHAR(30),
CreditCardNumber  VARBINARY(8000)
) ;
GO

--Populate the table

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

DECLARE @Names TABLE
(
        FirstName        VARCHAR(30),
        LastName         VARCHAR(30)
) ;

INSERT INTO @Names
VALUES('Peter', 'Carter'), 
                 ('Michael', 'Smith'), 
                 ('Danielle', 'Mead'), 
                 ('Reuben', 'Roberts'), 
                 ('Iris', 'Jones'), 
                 ('Sylvia', 'Davies'), 
                 ('Finola', 'Wright'), 
                 ('Edward', 'James'), 
                 ('Marie', 'Andrews'), 
                 ('Jennifer', 'Abraham'),
                 ('Margaret', 'Jones')

INSERT INTO App1Customers(Firstname, LastName, CreditCardNumber)
SELECT  FirstName, LastName, CreditCardNumber FROM
         (SELECT 
                 (SELECT TOP 1 FirstName FROM @Names ORDER BY NEWID()) FirstName
                ,(SELECT TOP 1 LastName FROM @Names ORDER BY NEWID()) LastName
                ,(SELECT CONVERT(VARBINARY(8000)
                ,(SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) 
                  FROM @Numbers 
                  WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
                         (SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) 
                          FROM @Numbers 
                          WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
                         (SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) 
                          FROM @Numbers 
                          WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
                         (SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) 
                         FROM @Numbers 
                         WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()))) CreditCardNumber 
FROM @Numbers a
CROSS JOIN @Numbers b
CROSS JOIN @Numbers c
) d ;

CREATE DATABASE Chapter14App1Sales ;
GO

ALTER DATABASE Chapter14App1Sales SET RECOVERY FULL ;
GO

USE Chapter14App1Sales
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

CREATE DATABASE Chapter14App2Customers ;
GO

ALTER DATABASE Chapter14App2Customers SET RECOVERY FULL ;
GO

USE Chapter14App2Customers
GO

CREATE TABLE App2Customers
(
ID                INT                PRIMARY KEY        IDENTITY,
FirstName         NVARCHAR(30),
LastName          NVARCHAR(30),
CreditCardNumber  VARBINARY(8000)
) ;
GO

--Populate the table

DECLARE @Numbers TABLE
(
        Number        INT
) ;

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
SELECT Number FROM CTE ;

DECLARE @Names TABLE
(
        FirstName        VARCHAR(30),
        LastName        VARCHAR(30)
) ;

INSERT INTO @Names
VALUES('Peter', 'Carter'), 
                 ('Michael', 'Smith'), 
                 ('Danielle', 'Mead'), 
                 ('Reuben', 'Roberts'), 
                 ('Iris', 'Jones'), 
                 ('Sylvia', 'Davies'), 
                 ('Finola', 'Wright'), 
                 ('Edward', 'James'), 
                 ('Marie', 'Andrews'), 
                 ('Jennifer', 'Abraham'),
                 ('Margaret', 'Jones')

INSERT INTO App2Customers(Firstname, LastName, CreditCardNumber)
SELECT  FirstName, LastName, CreditCardNumber FROM
         (SELECT 
                 (SELECT TOP 1 FirstName FROM @Names ORDER BY NEWID()) FirstName
                ,(SELECT TOP 1 LastName FROM @Names ORDER BY NEWID()) LastName
                ,(SELECT CONVERT(VARBINARY(8000)
                ,(SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) 
                  FROM @Numbers 
                  WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
                         (SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) 
                          FROM @Numbers 
                          WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
                         (SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) 
                          FROM @Numbers 
                          WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
                         (SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) 
                         FROM @Numbers 
                         WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()))) CreditCardNumber 
FROM @Numbers a
CROSS JOIN @Numbers b
CROSS JOIN @Numbers c
) d ;
