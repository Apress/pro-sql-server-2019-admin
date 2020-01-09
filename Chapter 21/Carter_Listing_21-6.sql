--Part 1 - To be run on the controller

BACKUP DATABASE Chapter21 
TO  DISK = N'F:\MSSQL\Backup\Chapter21.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'Chapter21-Full Database Backup', SKIP,  STATS = 10
GO

--Part 2 - To be run on the client, after moving the backup file across

RESTORE DATABASE Chapter21 
FROM  DISK = N'F:\MSSQL\Backup\Chapter21.bak' 
WITH  FILE = 1, STATS = 5
GO
