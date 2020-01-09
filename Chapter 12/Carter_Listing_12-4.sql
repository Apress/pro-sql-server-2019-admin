BACKUP DATABASE Chapter12
        TO  DISK = 'H:\MSSQL\Backup\Chapter12.bak' 
        WITH  RETAINDAYS = 90
        , FORMAT
        , INIT
        , MEDIANAME = 'Chapter12'
        , NAME = 'Chapter12-Full Database Backup'
        , COMPRESSION ;
GO
