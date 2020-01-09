:connect drserver\prosqldr

EXEC master.dbo.sp_add_log_shipping_secondary_database 
                 @secondary_database = N'Chapter15' 
                ,@primary_server = N'primaryserver\prosqladmin' 
                ,@primary_database = N'Chapter15' 
                ,@restore_delay = 10 
                ,@restore_mode = 0 
                ,@disconnect_users	= 0 
                ,@restore_threshold = 30   
                ,@threshold_alert_enabled = 1 
                ,@history_retention_period	= 5760 
                ,@ignoreremotemonitor = 1
