USE $(DBName)
GO

DECLARE @SQL NVARCHAR(MAX)

SET @SQL = 
(
        SELECT 'ALTER INDEX ' 
                   + i.name 
                   + ' ON ' + s.name 
                   + '.' 
                   + OBJECT_NAME(i.object_id) 
                   + ' REBUILD ; '
        FROM sys.dm_db_index_physical_stats(DB_ID('$(DBName)'),NULL,NULL,NULL,'DETAILED') ps
        INNER JOIN sys.indexes i
                ON ps.object_id = i.object_id
                        AND ps.index_id = i.index_id
        INNER JOIN sys.objects o
                ON ps.object_id = o.object_id
                INNER JOIN sys.schemas s
                        ON o.schema_id = s.schema_id
        WHERE index_level = 0
                AND avg_fragmentation_in_percent > 25
                FOR XML PATH('')
) ;

EXEC(@SQL) ;
