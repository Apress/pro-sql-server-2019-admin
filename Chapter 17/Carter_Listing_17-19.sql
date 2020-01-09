DECLARE @Waits1 TABLE
(
wait_type NVARCHAR(128),
wait_time_ms BIGINT
) ;

DECLARE @Waits2 TABLE
(
wait_type NVARCHAR(128),
wait_time_ms BIGINT
) ;

INSERT INTO @waits1
SELECT wait_type
        ,wait_time_ms
FROM sys.dm_os_wait_stats ;

WAITFOR DELAY '00:10:00' ;

INSERT INTO @Waits2
SELECT wait_type
        ,wait_time_ms
FROM sys.dm_os_wait_stats ;

SELECT TOP 5
        w2.wait_type
        ,w2.wait_time_ms - w1.wait_time_ms
FROM @Waits1 w1
INNER JOIN @Waits2 w2
        ON w1.wait_type = w2.wait_type
ORDER BY w2.wait_time_ms - w1.wait_time_ms DESC ;
