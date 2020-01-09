BACKUP DATABASE Chapter12
           TO  DISK = 'H:\MSSQL\Backup\Chapter12Stripe1.bak',
               DISK = 'G:\MSSQL\Backup\Chapter12Stripe2.bak'
           MIRROR TO DISK = 'J:\MSSQL\Backup\Chapter12Mirror1.bak',
                     DISK = 'K:\MSSQL\Backup\Chapter12Mirror2.bak'
           WITH  RETAINDAYS = 90
           , FORMAT
           , INIT
           , MEDIANAME = 'Chapter12Mirror'
           , NAME = 'Chapter12-Full Database Backup-Mirror'
           , COMPRESSION ;
GO
