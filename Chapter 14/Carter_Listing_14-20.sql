--DISABLE LOGINS

DECLARE @AOAGDBs TABLE
(
DBName NVARCHAR(128)
) ;

INSERT INTO @AOAGDBs
SELECT database_name 
FROM sys.availability_groups AG
INNER JOIN sys.availability_databases_cluster ADC
        ON AG.group_id = ADC.group_id
WHERE AG.name = 'App2' ;

DECLARE @Mappings TABLE
(
        LoginName NVARCHAR(128),
    DBname NVARCHAR(128),
    Username NVARCHAR(128), 
    AliasName NVARCHAR(128)
) ;

INSERT INTO @Mappings
EXEC sp_msloginmappings ;

DECLARE @SQL NVARCHAR(MAX)

SELECT DISTINCT @SQL = 
(
        SELECT 'ALTER LOGIN [' + LoginName + '] DISABLE; ' AS [data()]
        FROM @Mappings M
        INNER JOIN @AOAGDBs A
                ON M.DBname = A.DBName
        WHERE LoginName <> SUSER_NAME()
        FOR XML PATH ('')
) 

EXEC(@SQL)
GO

--SWITCH TO SYNCHRONOUS COMMIT MODE

ALTER AVAILABILITY GROUP App2
MODIFY REPLICA ON N'CLUSTERNODE3\ASYNCDR' WITH (AVAILABILITY_MODE = SYNCHRONOUS_COMMIT) ;
GO

--FAIL OVER

ALTER AVAILABILITY GROUP App2 FAILOVER
GO

--SWITCH BACK TO ASYNCHRONOUS COMMIT MODE

ALTER AVAILABILITY GROUP App2
MODIFY REPLICA ON N'CLUSTERNODE3\ASYNCDR' WITH (AVAILABILITY_MODE = ASYNCHRONOUS_COMMIT) ;
GO

--ENABLE LOGINS

DECLARE @AOAGDBs TABLE
(
DBName NVARCHAR(128)
) ;

INSERT INTO @AOAGDBs
SELECT database_name 
FROM sys.availability_groups AG
INNER JOIN sys.availability_databases_cluster ADC
        ON AG.group_id = ADC.group_id
WHERE AG.name = 'App2' ;

DECLARE @Mappings TABLE
(
        LoginName NVARCHAR(128),
    DBname NVARCHAR(128),
    Username NVARCHAR(128), 
    AliasName NVARCHAR(128)
) ;

INSERT INTO @Mappings
EXEC sp_msloginmappings 

DECLARE @SQL NVARCHAR(MAX)

SELECT DISTINCT @SQL = 
(
        SELECT 'ALTER LOGIN [' + LoginName + '] ENABLE; ' AS [data()]
        FROM @Mappings M
        INNER JOIN @AOAGDBs A
                ON M.DBname = A.DBName
        WHERE LoginName <> SUSER_NAME()
        FOR XML PATH ('')
) ;

EXEC(@SQL)
