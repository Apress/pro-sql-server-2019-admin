USE [Chapter7]
GO

CREATE TABLE dbo.OrdersMem(
        OrderNumber int IDENTITY(1,1) NOT NULL PRIMARY KEY NONCLUSTERED HASH 
                                                   WITH (BUCKET_COUNT= 2000000),
        OrderDate date NOT NULL,
        CustomerID int NOT NULL,
        ProductID int NOT NULL,
        Quantity int NOT NULL,
        NetAmount money NOT NULL,
        TaxAmount money NOT NULL,
        InvoiceAddressID int NOT NULL,
        DeliveryAddressID int NOT NULL,
        DeliveryDate date NULL,
)WITH (MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA) ;


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

--Populate ExistingOrders with data

INSERT INTO dbo.OrdersMem
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
