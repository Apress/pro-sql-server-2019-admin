USE master
GO

--Back Up the tail of the log

BACKUP LOG Chapter12 
TO  DISK = N'H:\MSSQL\Backup\Chapter12_LogBackup_2012-02-16_12-17-49.bak' 
        WITH NOFORMAT, 
             NAME = N'Chapter12_LogBackup_2012-02-16_12-17-49', 
             NORECOVERY ,  
             STATS = 5 ;

--Restore the full backup

RESTORE DATABASE Chapter12 
FROM  DISK = N'H:\MSSQL\Backup\Chapter12.bak' 
         WITH  FILE = 1,  
               NORECOVERY, 
               STATS = 5 ;

--Restore the differential

RESTORE DATABASE Chapter12 
FROM  DISK = N'H:\MSSQL\Backup\Chapter12.bak' 
          WITH  FILE = 2,  
          NORECOVERY,  
          STATS = 5 ;

--Restore the transaction log

RESTORE LOG Chapter12 
FROM  DISK = N'H:\MSSQL\Backup\Chapter12.bak' 
           WITH  FILE = 3,  
                 STATS = 5 ;

GO
