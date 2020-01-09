SELECT 
	  object_name
	, counter_name
FROM msdb.dbo.sysalerts_performance_counters_view
ORDER BY object_name
