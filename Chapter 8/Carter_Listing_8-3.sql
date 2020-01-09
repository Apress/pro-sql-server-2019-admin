USE Chapter8
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
SELECT Number FROM CTE ;

--Create and populate name pieces

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
                 ('Jennifer', 'Abraham') ;

--Create and populate Customers table

CREATE TABLE dbo.CustomersDisc
(
        CustomerID           INT                NOT NULL    IDENTITY    PRIMARY KEY,
        FirstName            VARCHAR(30)        NOT NULL,
        LastName             VARCHAR(30)        NOT NULL,
        BillingAddressID     INT                NOT NULL,
        DeliveryAddressID    INT                NOT NULL,
        CreditLimit          MONEY              NOT NULL,
        Balance              MONEY              NOT NULL
) ;

SELECT * INTO #CustomersDisc 
FROM
         (SELECT
                 (SELECT TOP 1 FirstName FROM @Names ORDER BY NEWID()) FirstName,
                 (SELECT TOP 1 LastName FROM @Names ORDER BY NEWID()) LastName,
                 (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()) BillingAddressID,
                 (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()) DeliveryAddressID,
                 (SELECT TOP 1 
                      CAST(RAND() * Number AS INT) * 10000 
                      FROM @Numbers 
                      ORDER BY NEWID()) CreditLimit,
                 (SELECT TOP 1 
                      CAST(RAND() * Number AS INT) * 9000
                      FROM @Numbers 
                      ORDER BY NEWID()) Balance
        FROM @Numbers a
        CROSS JOIN @Numbers b
) a ;

INSERT INTO dbo.CustomersDisc
SELECT * FROM #CustomersDisc ;
GO

--Create Numbers table

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

--Create the Orders table

CREATE TABLE dbo.OrdersDisc
         (
        OrderNumber     INT      NOT NULL        IDENTITY        PRIMARY KEY,
        OrderDate       DATE     NOT NULL,
        CustomerID      INT      NOT NULL,
        ProductID       INT      NOT NULL,
        Quantity        INT      NOT NULL,
        NetAmount       MONEY    NOT NULL,
        DeliveryDate    DATE        NULL
        )  ON [PRIMARY] ;

--Populate Orders with data

SELECT * INTO #OrdersDisc 
FROM
         (SELECT
                 (SELECT CAST(DATEADD(dd,(SELECT TOP 1 Number 
                                              FROM @Numbers 
                                              ORDER BY NEWID()),GETDATE())as DATE)) OrderDate,
                 (SELECT TOP 1 CustomerID FROM CustomersDisc ORDER BY NEWID()) CustomerID,
                 (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()) ProductID,
                 (SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()) Quantity,
                 (SELECT TOP 1 CAST(RAND() * Number AS INT) +10 * 100 
                      FROM @Numbers 
                      ORDER BY NEWID()) NetAmount,
                 (SELECT CAST(DATEADD(dd,(SELECT TOP 1 Number - 10 
                                            FROM @Numbers 
                                            ORDER BY NEWID()),GETDATE()) as DATE)) DeliveryDate
        FROM @Numbers a
        CROSS JOIN @Numbers b
        CROSS JOIN @Numbers c
) a ;

INSERT INTO OrdersDisc
SELECT * FROM #OrdersDisc ;

--Clean-up Temp Tables

DROP TABLE #CustomersDisc ;

DROP TABLE #OrdersDisc ;

--Add foreign key on CustomerID

ALTER TABLE dbo.OrdersDisc ADD CONSTRAINT
        FK_OrdersDisc_CustomersDisc FOREIGN KEY
         (
        CustomerID
        ) REFERENCES dbo.CustomersDisc
         (
        CustomerID
        ) ON UPDATE  NO ACTION 
         ON DELETE  NO ACTION ;

--Create a nonclustered index on Balance

CREATE NONCLUSTERED INDEX NCI_Balance ON dbo.CustomersDisc(Balance) ;
