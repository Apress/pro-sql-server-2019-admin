SELECT ISNULL(wait_type, 'Overal Percentage:') wait_type
        ,PercentageSignalWait
FROM (
                SELECT wait_type
                         ,CAST(100. * SUM(signal_wait_time_ms) 
                               / SUM(wait_time_ms) AS NUMERIC(20,2)) PercentageSignalWait
                FROM sys.dm_os_wait_stats
                WHERE wait_time_ms > 0
                GROUP BY wait_type WITH ROLLUP) a ;
