        100 *
         (
        SELECT cntr_value
        FROM sys.dm_os_performance_counters
        WHERE object_name = 'MSSQL$PROSQLADMIN:Plan Cache'
                AND counter_name = 'Cache hit ratio'
                AND instance_name = '_Total')
        /
         (
        SELECT cntr_value
        FROM sys.dm_os_performance_counters
        WHERE object_name = 'MSSQL$PROSQLADMIN:Plan Cache'
                AND counter_name = 'Cache hit ratio base'
                AND instance_name = '_Total') [Plan cache hit ratio %] ;
