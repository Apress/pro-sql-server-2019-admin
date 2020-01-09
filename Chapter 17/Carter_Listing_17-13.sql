DECLARE @cntr_value1 BIGINT = (
SELECT cntr_value
FROM sys.dm_os_performance_counters
WHERE counter_name = 'Lock Requests/sec' 
        AND instance_name = '_Total') ;

WAITFOR DELAY '00:01:00'

DECLARE @cntr_value2 BIGINT = (
SELECT cntr_value
FROM sys.dm_os_performance_counters
WHERE counter_name = 'Lock Requests/sec' 
        AND instance_name = '_Total') ;

SELECT (@cntr_value2 - @cntr_value1) / 60 'Lock Requests/sec' ;
