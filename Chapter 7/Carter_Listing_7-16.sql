SET STATISTICS TIME ON

--Tear down the plan cache

DBCC FREEPROCCACHE

--Tear down the buffer cache

DBCC DROPCLEANBUFFERS

--Run the benchmarks

SELECT *
FROM dbo.OrdersMem ;

SELECT *
FROM dbo.OrdersDisc ;
