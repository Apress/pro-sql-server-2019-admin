:connect sqlserver\targetserver1

CREATE CREDENTIAL WinUserCredential 
        WITH IDENTITY = N'PROSQLADMIN\WinUser', SECRET = N'Pa$$w0rd' ;
GO

EXEC msdb.dbo.sp_add_proxy 
                @proxy_name=N'PowerShellProxy',
                @credential_name=N'WinUserCredential', 
                @enabled=1, 
                @description=N'Proxy to check Browser Service status' ;
GO

EXEC msdb.dbo.sp_grant_proxy_to_subsystem 
                @proxy_name=N'PowerShellProxy', 
                @subsystem_id=12 ;
GO

:connect sqlserver\targetserver2

CREATE CREDENTIAL WinUserCredential 
        WITH IDENTITY = N'PROSQLADMIN\WinUser', SECRET = N'Pa$$w0rd' ;
GO

EXEC msdb.dbo.sp_add_proxy 
                @proxy_name=N'PowerShellProxy',
                @credential_name=N'WinUserCredential', 
                @enabled=1, 
                @description=N'Proxy to check Browser Service status' ;
GO

EXEC msdb.dbo.sp_grant_proxy_to_subsystem 
                @proxy_name=N'PowerShellProxy', 
                @subsystem_id=12 ;
GO
