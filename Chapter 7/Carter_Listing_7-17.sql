SET STATISTICS TIME ON

--Tear down the plan cache

DBCC FREEPROCCACHE

--Tear down the buffer cache

DBCC DROPCLEANBUFFERS

--Run the benchmarks

SELECT COUNT(*)
FROM dbo.OrdersMem ;

SELECT COUNT(*)
FROM dbo.OrdersDisc ;
