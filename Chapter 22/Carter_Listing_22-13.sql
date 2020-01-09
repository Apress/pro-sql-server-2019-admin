EXEC msdb.dbo.sp_delete_jobserver 
        @job_name=N'BackupAndCheckBrowser', 
        @server_name = N'SQLSERVER\MASTERSERVER' ;
GO

EXEC msdb.dbo.sp_add_jobserver 
        @job_name=N'BackupAndCheckBrowser', 
        @server_name = N'SQLSERVER\TARGETSERVER1' ;
GO

EXEC msdb.dbo.sp_add_jobserver 
        @job_name=N'BackupAndCheckBrowser', 
        @server_name = N'SQLSERVER\TARGETSERVER2' ;
GO
