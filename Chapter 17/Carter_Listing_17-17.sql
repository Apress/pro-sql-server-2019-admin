SELECT *
       , wait_time_ms - signal_wait_time_ms ResourceWaits
FROM sys.dm_os_wait_stats
ORDER BY wait_time_ms - signal_wait_time_ms DESC ;
