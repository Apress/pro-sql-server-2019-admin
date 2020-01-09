:connect primaryserver\prosqladmin

EXEC master.dbo.sp_add_log_shipping_primary_secondary 
                 @primary_database = N'Chapter15' 
                ,@secondary_server = N'drserver\prosqldr' 
                ,@secondary_database = N'Chapter15'
