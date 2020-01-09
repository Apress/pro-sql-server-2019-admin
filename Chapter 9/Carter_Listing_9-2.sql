DECLARE @SQL NVARCHAR(MAX)

SELECT @SQL =
(
SELECT 
        'ALTER DATABASE ' + QUOTENAME(Name) + 
                               ' SET PAGE_VERIFY CHECKSUM WITH NO_WAIT; ' AS [data()] 
FROM sys.databases
WHERE page_verify_option_desc <> 'CHECKSUM'
FOR XML PATH('')
) ;

BEGIN TRY
    EXEC(@SQL) ;
END TRY
BEGIN CATCH
    SELECT 'Failure executing the following SQL statement ' + CHAR(13) +CHAR(10) + @SQL ;
END CATCH
