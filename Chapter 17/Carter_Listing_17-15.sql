DECLARE @cntr TABLE
(
ID        INT        IDENTITY,
counter_name NVARCHAR(256),
counter_value BIGINT,
[Time] DATETIME
) ;

INSERT INTO @cntr
SELECT 
        counter_name
        ,cntr_value
        ,GETDATE()
        FROM sys.dm_os_performance_counters
        WHERE counter_name IN('Average Latch Wait Time (ms)',
                              'Average Latch Wait Time base') ;
        WAITFOR DELAY '00:01:00' ;

INSERT INTO @cntr
SELECT 
        counter_name
        ,cntr_value
        ,GETDATE()
        FROM sys.dm_os_performance_counters
        WHERE counter_name IN('Average Latch Wait Time (ms)',
                              'Average Latch Wait Time base') ;

IF (SELECT COUNT(DISTINCT counter_value) 
    FROM @cntr 
    WHERE counter_name = 'Average Latch Wait Time (ms)') > 2
BEGIN
SELECT
         (
                 (
                SELECT TOP 1 counter_value
                FROM @cntr
                WHERE counter_name = 'Average Latch Wait Time (ms)'
                ORDER BY [Time] DESC
                )
                -
                 (
                SELECT TOP 1 counter_value
                FROM @cntr
                WHERE counter_name = 'Average Latch Wait Time (ms)'
                ORDER BY [Time] ASC
                )
        )
        /
         (
                 (
                SELECT TOP 1 counter_value
                FROM @cntr
                WHERE counter_name = 'Average Latch Wait Time base'
                ORDER BY [Time] DESC
                )
                -
                 (
                SELECT TOP 1 counter_value
                FROM @cntr
                WHERE counter_name = 'Average Latch Wait Time base'
                ORDER BY [Time] ASC
                )
        ) [Average Latch Wait Time (ms)] ;
END
ELSE 
BEGIN
        SELECT 0 [Average Latch Wait Time (ms)] ;
END
