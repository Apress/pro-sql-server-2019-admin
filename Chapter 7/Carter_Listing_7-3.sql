CREATE TABLE dbo.Orders
        (
        OrderNumber int         NOT NULL,
        OrderDate date          NOT NULL,
        CustomerID int          NOT NULL,
        ProductID int           NOT NULL,
        Quantity int            NOT NULL,
        NetAmount money         NOT NULL,
        TaxAmount money         NOT NULL,
        InvoiceAddressID int    NOT NULL,
        DeliveryAddressID int   NOT NULL,
        DeliveryDate date       NULL
        )  ON PartScheme(OrderDate)  ;
GO

ALTER TABLE dbo.Orders ADD CONSTRAINT
        PK_Orders PRIMARY KEY CLUSTERED 
         (
        OrderNumber,
        OrderDate
        ) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
                    ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON PartScheme(OrderDate) ;

GO
