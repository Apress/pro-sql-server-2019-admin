USE Chapter16
GO

--Find logins connected to the Chapter16 database

SELECT login_name
FROM sys.dm_exec_sessions
WHERE database_id = DB_ID('Chapter16') ;

--Return details of the data pages storing the Chapter16.dbo.Customers table

SELECT * 
FROM sys.dm_db_database_page_allocations(DB_ID('Chapter16'),
                                         OBJECT_ID('dbo.Customers'),
                                         NULL,
                                         NULL,
                                         'DETAILED') ;
