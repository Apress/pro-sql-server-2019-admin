DECLARE @DB_PageTotals TABLE
(
CachedPages INT,
Database_name NVARCHAR(128),
database_id INT
) ;

INSERT INTO @DB_PageTotals
SELECT COUNT(*) CachedPages
        ,CASE 
                WHEN database_id = 32767 
                        THEN 'ResourceDb'
                ELSE DB_NAME(database_id)
        END Database_name
        ,database_id
FROM sys.dm_os_buffer_descriptors a
GROUP BY DB_NAME(database_id) 
                ,database_id ;

DECLARE @Total FLOAT = (SELECT SUM(CachedPages) FROM @DB_PageTotals) ;

SELECT      Database_name, 
            CachedPages, 
            SUM(cachedpages) over(partition by database_name) 
                    / @total * 100 AS RunningPercentage
FROM        @DB_PageTotals a
ORDER BY    CachedPages DESC ;
