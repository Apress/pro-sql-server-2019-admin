EXEC sp_configure 'show advanced options', 1 ;
GO

RECONFIGURE
GO

EXEC sp_configure 'Database Mail XPs', 1 ;
GO
RECONFIGURE
GO
