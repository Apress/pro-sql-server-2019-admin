BACKUP DATABASE Chapter12
        TO  DISK = 'H:\MSSQL\Backup\Chapter12.bak' 
        WITH  DIFFERENTIAL
        , RETAINDAYS = 90
        , NOINIT
        , MEDIANAME = 'Chapter12'
        , NAME = 'Chapter12-Diff Database Backup'
        , COMPRESSION ;
GO
