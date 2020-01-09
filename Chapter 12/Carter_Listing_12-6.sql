BACKUP LOG Chapter12
        TO  DISK = 'H:\MSSQL\Backup\Chapter12.bak' 
        WITH  RETAINDAYS = 90
        , NOINIT
        , MEDIANAME = 'Chapter12'
        , NAME = 'Chapter12-Log Backup'
        , COMPRESSION ;
GO
