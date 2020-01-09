:connect drserver\prosqldr

USE msdb
GO

EXEC master.dbo.sp_change_log_shipping_secondary_database 
        @secondary_database = N'database_name', 
        @threshold_alert_enabled = 0 ;
GO

:connect primaryserver\prosqladmin

USE msdb
GO

EXEC master.dbo.sp_change_log_shipping_primary_database 
        @database=N'database_name', 
        @threshold_alert_enabled = 0 ;
GO
