USE MSDB
GO

EXEC msdb.dbo.sp_update_jobstep 
                @job_name=N'BackupAndCheckBrowser', 
                @step_id=1 , 
                @database_user_name=N'' ;
GO
