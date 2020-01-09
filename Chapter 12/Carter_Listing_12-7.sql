BACKUP DATABASE Chapter12 FILEGROUP = 'FileGroupA'
        TO  DISK = 'H:\MSSQL\Backup\Chapter12FGA.bak' 
        WITH  RETAINDAYS = 90
        , FORMAT
        , INIT
        , MEDIANAME = 'Chapter12FG'
        , NAME = 'Chapter12-Full Database Backup-FilegroupA'
        , COMPRESSION ;
GO
