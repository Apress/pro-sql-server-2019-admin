:connect monitorserver\prosqlmonitor

EXEC msdb.dbo.sp_processlogshippingmonitorsecondary
                 @mode = 1 
                ,@secondary_server = N'drserver\prosqldr' 
                ,@secondary_database = N'Chapter15' 
                ,@secondary_id = N'' 
                ,@primary_server = N'primaryserver\prosqladmin' 
                ,@primary_database = N'Chapter15' 
                ,@restore_threshold = 30   
                ,@threshold_alert = 14420 
                ,@threshold_alert_enabled = 1 
                ,@history_retention_period        = 5760 
                ,@monitor_server = N'monitorserver.prosqladmin.com\prosqlmonitor' 
                ,@monitor_server_security_mode = 1
