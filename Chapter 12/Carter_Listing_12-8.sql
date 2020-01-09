BACKUP DATABASE Chapter12
        TO  DISK = 'H:\MSSQL\Backup\Chapter12Stripe1.bak',
            DISK = 'G:\MSSQL\Backup\Chapter12Stripe2.bak'
        WITH  RETAINDAYS = 90
        , FORMAT
        , INIT
        , MEDIANAME = 'Chapter12Stripe'
        , NAME = 'Chapter12-Full Database Backup-Stripe'
        , COMPRESSION ;
GO
