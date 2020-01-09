:connect primaryserver\prosqladmin

USE [msdb]
GO

--Disable backup job

EXEC msdb.dbo.sp_update_job @job_name = 'LSBackup_Chapter15', 
                 @enabled=0 ;
GO

:connect drserver\prosqldr

USE [msdb]
GO

--Diable copy job

EXEC msdb.dbo.sp_update_job @job_name='LSCopy_primaryserver\prosqladmin_Chapter15', 
                 @enabled=0 ;
GO

--Disable restore job

EXEC msdb.dbo.sp_update_job @job_name='LSRestore_primaryserver\prosqladmin_Chapter15', 
                 @enabled=0 ;
GO
