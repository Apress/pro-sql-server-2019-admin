SELECT * 
FROM sys.dm_os_performance_counters
WHERE counter_name = 'Memory Grants Pending' ;
