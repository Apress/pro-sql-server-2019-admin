:connect drserver\prosqldr


DECLARE @LS_BackupJobId	AS uniqueidentifier 
DECLARE @SP_Add_RetCode	As int 
DECLARE @LS_BackUpScheduleID	AS int 


EXEC @SP_Add_RetCode = master.dbo.sp_add_log_shipping_primary_database 
                @database = N'Chapter15' 
                ,@backup_directory = N'\\primaryserver\logshippingprimary' 
                ,@backup_share = N'\\primaryserver\logshippingprimary' 
                ,@backup_job_name = N'LSBackup_Chapter15' 
                ,@backup_retention_period = 2880
                ,@backup_compression = 2
                ,@backup_threshold = 60 
                ,@threshold_alert_enabled = 1
                ,@history_retention_period = 5760 
                ,@backup_job_id = @LS_BackupJobId OUTPUT 
                ,@overwrite = 1 


EXEC msdb.dbo.sp_add_schedule 
                @schedule_name =N'LSBackupSchedule_DRSERVER\PROSQLDR1' 
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
                ,@schedule_id = @LS_BackUpScheduleID OUTPUT 

EXEC msdb.dbo.sp_attach_schedule 
                @job_id = @LS_BackupJobId 
                ,@schedule_id = @LS_BackUpScheduleID  

EXEC msdb.dbo.sp_update_job 
                @job_id = @LS_BackupJobId 
                ,@enabled = 1 

EXEC master.dbo.sp_add_log_shipping_primary_secondary 
                @primary_database = N'Chapter15' 
                ,@secondary_server = N'primaryserver\prosqladmin' 
                ,@secondary_database = N'Chapter15' 
                ,@overwrite = 1 
                
:connect primaryserver\prosqladmin


DECLARE @LS_Secondary__CopyJobId        AS uniqueidentifier 
DECLARE @LS_Secondary__RestoreJobId        AS uniqueidentifier 
DECLARE @LS_Add_RetCode        As int 
DECLARE @LS_SecondaryCopyJobScheduleID        AS int 
DECLARE @LS_SecondaryRestoreJobScheduleID        AS int 


EXEC @LS_Add_RetCode = master.dbo.sp_add_log_shipping_secondary_primary 
                @primary_server = N'DRSERVER\PROSQLDR' 
                ,@primary_database = N'Chapter15' 
                ,@backup_source_directory = N'\\primaryserver\logshippingprimary' 
                ,@backup_destination_directory = N'\\primaryserver\logshippingprimary' 
                ,@copy_job_name = N'LSCopy_DRSERVER\PROSQLDR_Chapter15' 
                ,@restore_job_name = N'LSRestore_DRSERVER\PROSQLDR_Chapter15' 
                ,@file_retention_period = 2880 
                ,@overwrite = 1 
                ,@copy_job_id = @LS_Secondary__CopyJobId OUTPUT 
                ,@restore_job_id = @LS_Secondary__RestoreJobId OUTPUT 

EXEC msdb.dbo.sp_add_schedule 
                @schedule_name =N'DefaultCopyJobSchedule' 
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
                ,@schedule_id = @LS_SecondaryCopyJobScheduleID OUTPUT 

EXEC msdb.dbo.sp_attach_schedule 
                @job_id = @LS_Secondary__CopyJobId 
                ,@schedule_id = @LS_SecondaryCopyJobScheduleID  


EXEC msdb.dbo.sp_add_schedule 
                @schedule_name =N'DefaultRestoreJobSchedule' 
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
                ,@schedule_id = @LS_SecondaryRestoreJobScheduleID OUTPUT 

EXEC msdb.dbo.sp_attach_schedule 
                @job_id = @LS_Secondary__RestoreJobId 
                ,@schedule_id = @LS_SecondaryRestoreJobScheduleID  


EXEC master.dbo.sp_add_log_shipping_secondary_database 
                @secondary_database = N'Chapter15' 
                ,@primary_server = N'DRSERVER\PROSQLDR' 
                ,@primary_database = N'Chapter15' 
                ,@restore_delay = 10 
                ,@restore_mode = 0 
                ,@disconnect_users	= 0 
                ,@restore_threshold = 30   
                ,@threshold_alert_enabled = 1 
                ,@history_retention_period	= 5760 
                ,@overwrite = 1 

EXEC msdb.dbo.sp_update_job 
                @job_id = @LS_Secondary__CopyJobId 
                ,@enabled = 1 

EXEC msdb.dbo.sp_update_job 
                @job_id = @LS_Secondary__RestoreJobId 
                ,@enabled = 1 
