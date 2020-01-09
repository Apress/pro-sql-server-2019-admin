CREATE TABLE dbo.OrdersMemHash
(
        OrderNumber    INT    NOT NULL    IDENTITY    PRIMARY KEY    
                                 NONCLUSTERED HASH WITH(BUCKET_COUNT = 4000000),
        OrderDate      DATE    NOT NULL,
        CustomerID     INT     NOT NULL,
        ProductID      INT     NOT NULL,
        Quantity       INT     NOT NULL,
        NetAmount      MONEY   NOT NULL,
        DeliveryDate   DATE    NULL, 
) WITH(MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA) ;


INSERT INTO dbo.OrdersMemHash(OrderDate,CustomerID,ProductID,Quantity,NetAmount,DeliveryDate)
SELECT OrderDate
        ,CustomerID
        ,ProductID
        ,Quantity
        ,NetAmount
        ,DeliveryDate
FROM dbo.OrdersDisc ;
