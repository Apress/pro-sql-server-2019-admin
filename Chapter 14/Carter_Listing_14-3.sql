BACKUP DATABASE Chapter14App1Customers 
TO  DISK = N'C:\Backups\Chapter14App1Customers.bak' 
WITH NAME = N'Chapter14App1Customers-Full Database Backup' ;
GO

BACKUP DATABASE Chapter14App1Sales 
TO  DISK = N'C:\Backups\Chapter14App1Sales.bak' 
WITH NAME = N'Chapter14App1Sales-Full Database Backup' ;
GO
