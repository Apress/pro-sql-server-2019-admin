USE master
GO

RESTORE DATABASE Chapter12 
        FROM  DISK = N'H:\MSSQL\Backup\Chapter12PointinTime.bak' 
        WITH  FILE = 1
        ,  NORECOVERY
        ,  STATS = 5
        , REPLACE ;

RESTORE LOG Chapter12 
        FROM  DISK = N'H:\MSSQL\Backup\Chapter12PointinTime.bak' 
        WITH  FILE = 2
        ,  NORECOVERY
        ,  STATS = 5
        , REPLACE ;

RESTORE LOG Chapter12 
        FROM  DISK = N'H:\MSSQL\Backup\Chapter12PointinTime.bak' 
        WITH  FILE = 3
        ,  STATS = 5
        , STOPBEFOREMARK = 'lsn:35000000036000001'
        , RECOVERY
        , REPLACE ;
