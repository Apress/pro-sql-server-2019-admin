USE Master
GO

RESTORE DATABASE Chapter12 PAGE='3:8' 
        FROM  DISK = N'H:\MSSQL\Backup\Chapter12PageRestore.bak' 
        WITH  FILE = 1
        , NORECOVERY
        ,  STATS = 5 ;

BACKUP LOG Chapter12
        TO  DISK = N'H:\MSSQL\Backup\Chapter12_LogBackup_2012-02-17_16-47-46.bak' 
        WITH NOFORMAT, NOINIT
        , NAME = N'Chapter12_LogBackup_2012-02-17_16-32-46'
        , NOSKIP
        , STATS = 5 ;

RESTORE LOG Chapter12 
        FROM  DISK = N'H:\MSSQL\Backup\Chapter12_LogBackup_2012-02-17_16-47-46.bak' 
        WITH  STATS = 5
              , RECOVERY ;
GO
