USE Chapter6
GO

--Create a clustered index on RoundRobinTable
CREATE UNIQUE CLUSTERED INDEX CIX_RoundRobinTable ON dbo.RoundRobinTable(ID);
GO

--Examine Fragmentation on new index
SELECT * FROM sys.dm_db_index_physical_stats(DB_ID('Chapter6'),OBJECT_ID('dbo.RoundRobinTable'),1,NULL,'DETAILED')
WHERE index_level = 0;

--Shrink the database
DBCC SHRINKDATABASE(N'Chapter6', NOTRUNCATE);
GO

--Re-examine index fragmentation
SELECT * FROM sys.dm_db_index_physical_stats(DB_ID('Chapter6'),OBJECT_ID('dbo.RoundRobinTable'),1,NULL,'DETAILED')
WHERE index_level = 0;
GO
