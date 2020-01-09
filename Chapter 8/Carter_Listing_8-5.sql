CREATE NONCLUSTERED INDEX NonDeliveredItems ON dbo.OrdersDisc(DeliveryDate) 
        WHERE DeliveryDate IS NULL ;
