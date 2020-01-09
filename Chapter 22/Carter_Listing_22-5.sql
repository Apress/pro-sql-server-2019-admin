BACKUP DATABASE Chapter22
        TO DISK = 
            N'C:\Microsoft SQL Server\MSSQL15.PROSQLADMIN\MSSQL\Backup\Chapter22.bak'
        WITH NOINIT
        ,NAME = N'Chapter22-Full Database Backup'
        ,SKIP
        ,STATS = 10 ;
