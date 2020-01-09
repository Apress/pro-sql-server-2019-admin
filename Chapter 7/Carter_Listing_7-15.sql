USE [Chapter7]
GO

CREATE TABLE dbo.OrdersDisc(
        OrderNumber int NOT NULL,
        OrderDate date NOT NULL,
        CustomerID int NOT NULL,
        ProductID int NOT NULL,
        Quantity int NOT NULL,
        NetAmount money NOT NULL,
        TaxAmount money NOT NULL,
        InvoiceAddressID int NOT NULL,
        DeliveryAddressID int NOT NULL,
        DeliveryDate date NULL,
 CONSTRAINT [PK_OrdersDisc] PRIMARY KEY CLUSTERED 
(
         [OrderNumber] ASC,
         [OrderDate] ASC
)
) ;

INSERT INTO dbo.OrdersDisc
        SELECT *
        FROM dbo.OrdersMem ;
