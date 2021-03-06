--Create the Database

CREATE DATABASE Chapter11Encrypted ;
GO

USE Chapter11Encrypted
GO

--Create the table

CREATE TABLE dbo.SensitiveData
(
ID                INT                PRIMARY KEY        IDENTITY,
FirstName        NVARCHAR(30),
LastName        NVARCHAR(30),
CreditCardNumber        VARBINARY(8000)
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
                 ('Margaret', 'Jones') ;

INSERT INTO dbo.SensitiveData(Firstname, LastName, CreditCardNumber)
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

USE Master
GO

--Create the Database Master Key 

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Pa$$w0rd';
GO

--Create the Server Certificate

CREATE CERTIFICATE TDECert WITH SUBJECT = 'Certificate For TDE';
GO
