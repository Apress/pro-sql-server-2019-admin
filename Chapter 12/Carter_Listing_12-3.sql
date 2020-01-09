EXEC sp_addumpdevice  @devtype = 'disk', 
                      @logicalname = 'Chapter12Backup', 
                      @physicalname = 'C:\MSSQL\Backup\Chapter12Backup.bak' ;
GO
