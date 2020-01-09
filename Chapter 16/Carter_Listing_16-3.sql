USE Chapter16
GO

CREATE PROCEDURE dbo.usp_Dynamic_Snapshot_Query
AS
BEGIN
         DECLARE @LatestSnashot NVARCHAR(128)
         DECLARE @SQL NVARCHAR(MAX)

         SET @LatestSnashot = (
            SELECT TOP 1 name from sys.databases
            WHERE source_database_id = DB_ID('Chapter16')
            ORDER BY create_date DESC ) ;

         SET @SQL = 'SELECT * FROM ' + @LatestSnashot + '.dbo.Customers' ;

         EXEC(@SQL) ;
END

EXEC dbo.usp_Dynamic_Snapshot_Query ;
