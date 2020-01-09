USE Chapter18
GO

BEGIN TRANSACTION
        UPDATE dbo.Customers
        SET DeliveryAddressID = 1
        WHERE CustomerID = 10 ;
COMMIT WITH (DELAYED_DURABILITY = ON)
