USE Chapter21
GO

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
SELECT Number FROM CTE;

DECLARE @Names TABLE
(
        FirstName        VARCHAR(30),
        LastName        VARCHAR(30)
);

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
                 ('Jennifer', 'Abraham');

SELECT * INTO #Customers 
FROM
         (SELECT
                 (SELECT TOP 1 FirstName FROM @Names ORDER BY NEWID()) FirstName,
                 (SELECT TOP 1 LastName FROM @Names ORDER BY NEWID()) LastName,
                 (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()) BillingAddressID,
                 (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()) DeliveryAddressID,
                 (SELECT TOP 1 CAST(RAND() * Number AS INT) * 10000 
                  FROM @Numbers 
                  ORDER BY NEWID()) CreditLimit,
                 (SELECT TOP 1 CAST(RAND() * Number AS INT) * 9000 
                  FROM @Numbers 
                  ORDER BY NEWID()) Balance
        FROM @Numbers a
) a;

INSERT INTO dbo.Customers
SELECT * FROM #Customers ;
 
DROP TABLE #Customers
GO 10

SELECT FirstName, LastName
FROM dbo.Customers
WHERE LastName = 'Carter'
GO 100

SELECT COUNT(*)
FROM dbo.Customers c
INNER JOIN dbo.Addresses a
ON c.DeliveryAddressID = a.AddressID
GO 100

SELECT *
FROM dbo.Addresses
GO 100

DELETE FROM dbo.Customers
WHERE LastName = 'Mead'
        OR CustomerID > 1000000
GO 50

SELECT TOP 10 PERCENT *
FROM dbo.Customers
GO 100
