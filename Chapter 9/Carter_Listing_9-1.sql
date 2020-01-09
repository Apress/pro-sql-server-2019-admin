--Create the Chapter9 database

CREATE DATABASE Chapter9 ;
GO

--View page verify option, for all databases on the instance

SELECT 
        name
        ,page_verify_option_desc
FROM sys.databases ;
