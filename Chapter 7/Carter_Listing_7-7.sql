--Create new partition function
CREATE PARTITION FUNCTION PartFuncWeek(DATE)
AS RANGE LEFT
FOR VALUES ('2019-03-7','2019-03-14','2019-03-21','2019-03-28') ;

--Assess spread of rows
SELECT 
        COUNT(*) 'Number of Rows'
        ,$PARTITION.PartFuncWeek(OrderDate) 'Partition'
FROM dbo.ExistingOrders
GROUP BY $PARTITION.PartFuncWeek(OrderDate) ;
