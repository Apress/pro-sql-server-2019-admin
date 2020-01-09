SELECT OrderNumber, OrderDate
FROM dbo.ExistingOrders 
WHERE CAST(OrderDate AS DATETIME2) BETWEEN '2019-03-01' AND '2019-03-31' ;
