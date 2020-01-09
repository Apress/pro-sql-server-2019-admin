CREATE PROCEDURE dbo.DynamicSnapshot @DBName NVARCHAR(128), @RequiredSnapshots INT
AS
BEGIN

        DECLARE @SQL NVARCHAR(MAX)
        DECLARE @SQLStart NVARCHAR(MAX)
        DECLARE @SQLEnd NVARCHAR(MAX)
        DECLARE @SQLFileList NVARCHAR(MAX)
        DECLARE @DBID INT
        DECLARE @SS_Seq_No INT
        DECLARE @SQLDrop NVARCHAR(MAX)

        SET @DBID = (SELECT DB_ID(@DBName)) ;
        
        --Generate sequence number

        IF (SELECT COUNT(*) FROM sys.databases WHERE source_database_id = @DBID) > 0
                SET @SS_Seq_No = (SELECT TOP 1 CAST(SUBSTRING(name, LEN(Name), 1) AS INT) 
                                  FROM sys.databases 
                                  WHERE source_database_id = @DBID 
                                  ORDER BY create_date DESC) + 1
        ELSE
                SET @SS_Seq_No = 1
                --Generate the first part of the CREATE DATABASE statement

        SET @SQLStart = 'CREATE DATABASE ' 
                         + QUOTENAME(@DBName + CAST(CAST(GETDATE() AS DATE) AS NCHAR(10)) 
                         + '_ss' + CAST(@SS_Seq_No AS NVARCHAR(4))) + ' ON ' ;

        --Generate the file list for the CREATE DATABASE statement

        SELECT @SQLFileList = 
         (
                 SELECT 
                        '(NAME = N''' + mf.name + ''', FILENAME = N''' 
                          + SUBSTRING(mf.physical_name, 1, LEN(mf.physical_name) - 4) 
                          + CAST(@SS_Seq_No AS NVARCHAR(4)) + '.ss' + '''),' AS [data()]
                FROM  sys.master_files mf
                WHERE mf.database_id = @DBID
                        AND mf.type = 0
                FOR XML PATH ('') 
        ) ;

        --Remove the extra comma from the end of the file list

        SET @SQLFileList = SUBSTRING(@SQLFileList, 1, LEN(@SQLFileList) - 2) ;

        --Generate the final part of the CREATE DATABASE statement

        SET @SQLEnd = ') AS SNAPSHOT OF ' + @DBName ;

        --Concatenate the strings and run the completed statement

        SET @SQL = @SQLStart + @SQLFileList + @SQLEnd ;

        EXEC(@SQL) ;

        --Check to see if the requird number of snapshots exists for the database, 
        --and if so, delete the oldest

        IF (SELECT COUNT(*) 
                FROM sys.databases 
                WHERE source_database_id = @DBID) > @RequiredSnapshots
        BEGIN
                SET @SQLDrop = 'DROP DATABASE ' + (
                SELECT TOP 1 
                        QUOTENAME(name)
                FROM sys.databases
                WHERE source_database_id = @DBID
                ORDER BY create_date ASC )
                        EXEC(@SQLDrop)
        END ;

END
