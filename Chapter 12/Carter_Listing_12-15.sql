USE master
GO

RESTORE DATABASE Chapter12 FILE = N'Chapter12FileA' 
        FROM  DISK = N'H:\MSSQL\Backup\Chapter12FileRestore.bak' 
        WITH  FILE = 1
        , NORECOVERY
        , STATS = 10
        , REPLACE ;
GO

BACKUP LOG Chapter12
        TO  DISK = N'H:\MSSQL\Backup\Chapter12_LogBackup_2012-02-17_12-26-09.bak' 
        WITH NOFORMAT
        , NOINIT
        ,  NAME = N'Chapter12_LogBackup_2012-02-17_12-26-09'
        , NOSKIP
        , NORECOVERY 
              ,  STATS = 5 ;

RESTORE LOG Chapter12
        FROM  DISK = N'H:\MSSQL\Backup\Chapter12FileRestore.bak' 
        WITH  FILE = 2
        , STATS = 10
        , NORECOVERY ;

RESTORE LOG Chapter12
        FROM  DISK = N'H:\MSSQL\Backup\Chapter12_LogBackup_2012-02-17_12-26-09.bak' 
        WITH FILE = 1
        , STATS = 10
        , RECOVERY ;
GO
