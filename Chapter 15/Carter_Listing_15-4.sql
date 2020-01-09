:connect drserver\prosqldr

DECLARE @LS_Secondary__CopyJobId        AS uniqueidentifier 
DECLARE @LS_Secondary__RestoreJobId        AS uniqueidentifier 
DECLARE @LS_SecondaryCopyJobScheduleID        AS int 
DECLARE @LS_SecondaryRestoreJobScheduleID        AS int 

--Configure the secondary server

EXEC master.dbo.sp_add_log_shipping_secondary_primary 
                 @primary_server = N'primaryserver\prosqladmin' 
                 primary_database = N'Chapter15' 
                ,@backup_source_directory = N'\\primaryserver\logshippingprimary' 
                ,@backup_destination_directory = N'\\drserver\logshippingdr' 
                ,@copy_job_name = N'LSCopy_primaryserver\prosqladmin_Chapter15' 
                ,@restore_job_name = N'LSRestore_primaryserver\prosqladmin_Chapter15' 
                ,@file_retention_period = 2880 
                ,@monitor_server = N'monitorserver.prosqladmin.com\prosqlmonitor' 
                ,@monitor_server_security_mode = 1 
                ,@copy_job_id = @LS_Secondary__CopyJobId OUTPUT 
                ,@restore_job_id = @LS_Secondary__RestoreJobId OUTPUT ;

--Create the schedule for the copy job

EXEC msdb.dbo.sp_add_schedule 
                 @schedule_name =N'DefaultCopyJobSchedule' 
                ,@enabled = 1 
                ,@freq_type = 4 
                ,@freq_interval = 1 
                ,@freq_subday_type = 4 
                ,@freq_subday_interval = 15 
                ,@freq_recurrence_factor = 0 
                ,@active_start_date = 20190517 
                ,@active_end_date = 99991231 
                ,@active_start_time = 0 
                ,@active_end_time = 235900 
                ,@schedule_id = @LS_SecondaryCopyJobScheduleID OUTPUT ;

--Attach the schedule to the copy job

EXEC msdb.dbo.sp_attach_schedule 
                 @job_id = @LS_Secondary__CopyJobId 
                ,@schedule_id = @LS_SecondaryCopyJobScheduleID  ;

--Create the job schedule for the restore job

EXEC msdb.dbo.sp_add_schedule 
                 @schedule_name =N'DefaultRestoreJobSchedule' 
                ,@enabled = 1 
                ,@freq_type = 4 
                ,@freq_interval = 1 
                ,@freq_subday_type = 4 
                ,@freq_subday_interval = 15 
                ,@freq_recurrence_factor = 0 
                ,@active_start_date = 20190517 
                ,@active_end_date = 99991231 
                ,@active_start_time = 0 
                ,@active_end_time = 235900 
                ,@schedule_id = @LS_SecondaryRestoreJobScheduleID OUTPUT ;

--Attch the schedule to the restore job

EXEC msdb.dbo.sp_attach_schedule 
                 @job_id = @LS_Secondary__RestoreJobId 
                ,@schedule_id = @LS_SecondaryRestoreJobScheduleID  ;

--Enable the jobs

EXEC msdb.dbo.sp_update_job 
                 @job_id = @LS_Secondary__CopyJobId 
                ,@enabled = 1 ;

EXEC msdb.dbo.sp_update_job 
                 @job_id = @LS_Secondary__RestoreJobId 
                ,@enabled = 1 ;
