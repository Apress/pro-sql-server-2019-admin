--Create and populate temp table

SELECT * INTO #OrdersMemHash
FROM dbo.OrdersMemHash ;

--Drop existing table

DROP TABLE dbo.OrdersMemHash ;

--Re-create the table with the new index

CREATE TABLE dbo.OrdersMemHash
(
        OrderNumber     INT     NOT NULL    IDENTITY    PRIMARY KEY    
                                      NONCLUSTERED HASH WITH(BUCKET_COUNT = 4000000),
        OrderDate       DATE    NOT NULL        INDEX NCI_OrderDate NONCLUSTERED,
        CustomerID      INT     NOT NULL,
        ProductID       INT     NOT NULL,
        Quantity        INT     NOT NULL,
        NetAmount       MONEY   NOT NULL,
        DeliveryDate    DATE    NULL,
) WITH(MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA) ;
GO

--Allow values to be inserted into the identity column

SET IDENTITY_INSERT OrdersMemHash ON ;
GO

--Repopulate the table

INSERT INTO 
dbo.OrdersMemHash(OrderNumber,OrderDate,CustomerID,ProductID,Quantity,NetAmount,DeliveryDate)
SELECT *
FROM #OrdersMemHash ;

--Stop further inserts to the identity column and clean up temp table

SET IDENTITY_INSERT OrdersMemHash OFF ;

DROP TABLE #OrdersMemHash ;
