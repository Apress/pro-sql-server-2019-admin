USE [master];

DECLARE @t TABLE
(
        name varchar(150),
        minimum tinyint,
        maximum tinyint ,
        config_value tinyint ,
        run_value tinyint
)

DECLARE @psinfo TABLE(data  NVARCHAR(100)) ;

INSERT INTO @psinfo
EXEC xp_cmdshell 'Powershell.exe "Get-WMIObject Win32_LogicalDisk -filter "DriveType=3"| Format-Table DeviceID, FreeSpace, Size"'  ;

DELETE FROM @psinfo WHERE data IS NULL  OR data LIKE '%DeviceID%' OR data LIKE '%----%';
UPDATE @psinfo SET data = REPLACE(data,' ',',');

;WITH DriveSpace AS 
(
        SELECT LEFT(data,2)  as [Drive], 
        REPLACE((LEFT((SUBSTRING(data,(PATINDEX('%[0-9]%',data)) 
                , LEN(data))),CHARINDEX(',',
         (SUBSTRING(data,(PATINDEX('%[0-9]%',data)) 
                , LEN(data))))-1)),',','') AS FreeSpace
        , 
        REPLACE(RIGHT((SUBSTRING(data,(PATINDEX('%[0-9]%',data)) 
                , LEN(data))),PATINDEX('%,%', 
         (SUBSTRING(data,(PATINDEX('%[0-9]%',data)) , LEN(data))))) ,',','')
        AS [Size]
        FROM @psinfo
) 
SELECT 
    mf.Drive
    ,CAST(sizeMB as numeric(18,2)) as [File Space Used (MB)]
    ,CAST(growth as numeric(18,2)) as [Next Growth Amount (MB)]
    ,CAST((CAST(FreeSpace as numeric(18,2))
                    /(POWER(1024., 3))) as numeric(6,2)) AS FreeSpaceGB
    ,CAST((CAST(size as numeric(18,2))/(POWER(1024., 3))) as numeric(6,2)) AS TotalSizeGB
    ,CAST(CAST((CAST(FreeSpace as numeric(18,2))/(POWER(1024., 3))) as numeric(6,2)) 
                    / CAST((CAST(size as numeric(18,2))/(POWER(1024., 3))) as numeric(6,2))
                    * 100 AS numeric(5,2)) [Percent Remaining]
FROM DriveSpace
        JOIN
         (        SELECT DISTINCT  LEFT(physical_name, 2) Drive, SUM(size / 128.0) sizeMB
                ,SUM(CASE
                        WHEN is_percent_growth = 0
                                THEN growth / 128.
                        WHEN is_percent_growth = 1
                                THEN (size / 128. * growth / 100)
                        END) growth
                FROM master.sys.master_files
                WHERE db_name(database_id) NOT IN('master','model','msdb')
                GROUP BY LEFT(physical_name, 2)
        )                mf ON DriveSpace.Drive = mf.drive ;
