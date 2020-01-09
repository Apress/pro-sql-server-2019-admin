--Create the ExistingOrders table

CREATE TABLE dbo.ExistingOrders
        (
        OrderNumber int         IDENTITY        NOT NULL,
        OrderDate date           NOT NULL,
        CustomerID int            NOT NULL,
        ProductID int               NOT NULL,
        Quantity int                  NOT NULL,
        NetAmount money      NOT NULL,
        TaxAmount money      NOT NULL,
        InvoiceAddressID int   NOT NULL,
        DeliveryAddressID int  NOT NULL,
        DeliveryDate date        NULL
        )  ON [PRIMARY] ;
GO

ALTER TABLE dbo.ExistingOrders ADD CONSTRAINT
        PK_ExistingOrders PRIMARY KEY CLUSTERED 
         (
        OrderNumber,
        OrderDate
        ) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
                    ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY] ;

GO

--We will now populate the data with data so that we can view the storage properties 
--and then partition the table when the data already exists.

--Build a numbers table for the data population

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
        WHERE Number < 20
)
INSERT INTO @Numbers
SELECT Number FROM CTE ;

--Populate ExistingOrders with data

INSERT INTO dbo.ExistingOrders
SELECT
         (SELECT CAST(DATEADD(dd,(SELECT TOP 1 Number 
                                  FROM @Numbers 
                                  ORDER BY NEWID(), a.Number, b.Number),GETDATE()) AS DATE)),
         (SELECT TOP 1 Number -10 FROM @Numbers ORDER BY NEWID()),
         (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
         (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
        500,
        100,
         (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
         (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
         (SELECT CAST(DATEADD(dd,(SELECT TOP 1 Number - 10 
                                  FROM @Numbers 
                                  ORDER BY NEWID(), a.Number, b.Number),GETDATE()) as DATE))
FROM @Numbers a
CROSS JOIN @Numbers b ;
