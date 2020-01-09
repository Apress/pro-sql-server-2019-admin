BACKUP DATABASE Chapter12
        FILEGROUP = N'PRIMARY',  FILEGROUP = N'FileGroupA',  FILEGROUP = N'FileGroupB' 
        TO  DISK = N'H:\MSSQL\Backup\Chapter12Piecemeal.bak' 
        WITH FORMAT
        , NAME = N'Chapter12-Fiegroup Backup'
        , STATS = 10 ;

BACKUP LOG Chapter12
        TO  DISK = N'H:\MSSQL\Backup\Chapter12Piecemeal.bak' 
        WITH NOFORMAT, NOINIT
        ,  NAME = N'Chapter12-Full Database Backup'
        ,  STATS = 10 ;
