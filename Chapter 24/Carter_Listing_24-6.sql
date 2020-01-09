--Script Part 1 - To be run in a query windows that is connected using the SalesManager Login

EXECUTE AS LOGIN = 'SalesManager'

DECLARE @i INT = 0 ;

WHILE (@i < 10000)
BEGIN
SELECT DBName = (
        SELECT Name AS [data()]
        FROM sys.databases
        FOR XML PATH('')
) ;

SET @i = @i + 1 ;

END


--Script Part 2 - To be run in a query windows that is connected using the SalesUser Login

EXECUTE AS LOGIN = 'SalesUser'

DECLARE @i INT = 0 ;

WHILE (@i < 10000)
BEGIN
SELECT DBName = (
        SELECT Name AS [data()]
        FROM sys.databases
        FOR XML PATH('')
) ;

SET @i = @i + 1 ;

END
