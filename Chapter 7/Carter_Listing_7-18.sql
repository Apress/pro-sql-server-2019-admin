SET STATISTICS TIME ON

--Tear down the plan cache

DBCC FREEPROCCACHE

--Tear down the buffer cache

DBCC DROPCLEANBUFFERS

--Run the benchmarks

SELECT SUM(NetAmount)
FROM dbo.OrdersMem
WHERE OrderNumber > 950000 ;

SELECT SUM(NetAmount)
FROM dbo.OrdersDisc
WHERE OrderNumber > 950000 ;
