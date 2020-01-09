USE Chapter19
GO


--Create and populate numbers table

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

--Create and populate name pieces

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

--Insert to Customers 

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
        CROSS JOIN @Numbers b
        CROSS JOIN @Numbers c
) a;

INSERT INTO dbo.Customers
SELECT * FROM #Customers;
GO
