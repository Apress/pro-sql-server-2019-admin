SELECT 
        COUNT(*) 'Number of Rows'
        ,$PARTITION.PartFunc(OrderDate) 'Partition'
FROM dbo.ExistingOrders
GROUP BY $PARTITION.PartFunc(OrderDate) ;
