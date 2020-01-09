SELECT SUM(c.creditlimit) TotalExposure, SUM(o.netamount) ‘TotalOrdersValue’
FROM dbo.CustomersDisc c
INNER JOIN dbo.OrdersDisc o 
        ON c.CustomerID = o.CustomerID ;
