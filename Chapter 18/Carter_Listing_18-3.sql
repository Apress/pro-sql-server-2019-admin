SELECT COUNT(*) InitialCustomerCount FROM dbo.Customers ;

SELECT COUNT(*) InitialAddressesCount FROM dbo.Addresses ;

BEGIN TRANSACTION 

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


--Populate Customers table

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
) a;

INSERT INTO dbo.Customers
SELECT * FROM #Customers;

SAVE TRANSACTION CustomerInsert

BEGIN TRY
--Populate Addresses table - Will fail, due to length of Post Code

INSERT INTO dbo.Addresses
VALUES('1 Apress Towers', 'Hedge End', 'Southampton', 'SA206 2BQ') ;
END TRY
BEGIN CATCH
        ROLLBACK TRANSACTION CustomerInsert
END CATCH


COMMIT TRANSACTION

SELECT COUNT(*) FinalCustomerCount FROM dbo.Customers ;

SELECT COUNT(*) FinalAddressesCount FROM dbo.Addresses ;
