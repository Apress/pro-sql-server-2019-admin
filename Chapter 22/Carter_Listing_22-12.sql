USE msdb
GO

EXEC msdb.dbo.sp_update_job 
                @job_name=N'BackupAndCheckBrowser', 
                @notify_email_operator_name=N'MSXOperator' ;
GO
