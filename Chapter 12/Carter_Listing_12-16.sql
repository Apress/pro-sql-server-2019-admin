--Back up the database

BACKUP DATABASE Chapter12
        TO  DISK = N'H:\MSSQL\Backup\Chapter12PageRestore.bak' 
        WITH FORMAT
        , NAME = N'Chapter12-Full Backup'
        , STATS = 10 ;

--Corrupt a page in the Contacts table

ALTER DATABASE Chapter12 SET SINGLE_USER WITH NO_WAIT ;
GO

DECLARE @SQL NVARCHAR(MAX)

SELECT @SQL = 'DBCC WRITEPAGE(' +
(
        SELECT CAST(DB_ID('Chapter12') AS NVARCHAR)
) +
', ' +
(
        SELECT TOP 1 CAST(file_id AS NVARCHAR)
        FROM dbo.Contacts
        CROSS APPLY sys.fn_PhysLocCracker(%%physloc%%)
) +
 ', ' +
(
        SELECT TOP 1 CAST(page_id AS NVARCHAR)
        FROM dbo.Contacts
        CROSS APPLY sys.fn_PhysLocCracker(%%physloc%%)
) +
', 2000, 1, 0x61, 1)' ;

EXEC(@SQL) ;

ALTER DATABASE Chapter12 SET MULTI_USER ;
GO
