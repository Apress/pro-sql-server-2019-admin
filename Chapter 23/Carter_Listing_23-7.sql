SELECT status_desc
FROM sys.dm_server_services
WHERE servicename LIKE 'SQL Server Agent%' ;
