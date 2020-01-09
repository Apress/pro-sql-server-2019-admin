SELECT *
FROM (
        SELECT 
        CASE
                WHEN value_name = 'tcport' AND value_data <> ''
                        THEN value_data
                WHEN value_name = 'tcpport' AND value_data = ''
                        THEN (
                                SELECT value_data 
                                FROM sys.dm_server_registry 
                                WHERE registry_key LIKE '%ipall' 
                                        AND value_name = 'tcpdynamicports' )
        END PortNumber
        FROM sys.dm_server_registry
        WHERE registry_key LIKE '%IPAll' ) a
WHERE a.PortNumber IS NOT NULL ;
