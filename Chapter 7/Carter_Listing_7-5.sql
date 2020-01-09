--Drop Clustered Index

ALTER TABLE dbo.ExistingOrders DROP CONSTRAINT PK_ExistingOrders ;
GO

--Re-created clustered index on PartScheme

ALTER TABLE dbo.ExistingOrders ADD  CONSTRAINT PK_ExistingOrders PRIMARY KEY CLUSTERED 
(
        OrderNumber ASC,
        OrderDate ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, 
            IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, 
            ALLOW_PAGE_LOCKS = ON) ON PartScheme(OrderDate) ;
GO
