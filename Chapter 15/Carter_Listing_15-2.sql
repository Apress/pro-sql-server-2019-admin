:connect primaryserver\prosqladmin

DECLARE @LS_BackupJobId         UNIQUEIDENTIFIER 
DECLARE @LS_BackUpScheduleID        INT 

--Configure Chapter15 database as the Primary for Log Shipping

EXEC master.dbo.sp_add_log_shipping_primary_database 
                @database = N'Chapter15' 
                ,@backup_directory = N'c:\logshippingprimary' 
                ,@backup_share = N'\\primaryserver\logshippingprimary' 
                ,@backup_job_name = N'LSBackup_Chapter15' 
                ,@backup_retention_period = 2880
                ,@backup_compression = 2
                ,@monitor_server = N'monitorserver.prosqladmin.com\prosqlmonitor' 
                ,@monitor_server_security_mode = 1 
                ,@backup_threshold = 60 
                ,@threshold_alert_enabled = 1
                ,@history_retention_period = 5760 ;
                ,@backup_job_id = @LS_BackupJobId OUTPUT ;
                --Create a job schedule for the backup job

EXEC msdb.dbo.sp_add_schedule 
                 @schedule_name =N'LSBackupSchedule_primaryserver\prosqladmin1' 
                ,@enabled = 1 
                ,@freq_type = 4 
                ,@freq_interval = 1 
                ,@freq_subday_type = 4 
                ,@freq_subday_interval = 5 
                ,@freq_recurrence_factor = 0 
                ,@active_start_date = 20190517 
                ,@active_end_date = 99991231 
                ,@active_start_time = 0 
                ,@active_end_time = 235900 
                ,@schedule_id = @LS_BackUpScheduleID OUTPUT ;

--Attach the job schedule to the job

EXEC msdb.dbo.sp_attach_schedule 
                 @job_id = @LS_BackupJobId 
                ,@schedule_id = @LS_BackUpScheduleID  ;

--Enable the backup job
EXEC msdb.dbo.sp_update_job 
                 @job_id = @LS_BackupJobId 
                ,@enabled = 1 ;
