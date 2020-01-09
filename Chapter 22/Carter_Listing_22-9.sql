USE Master
GO

EXEC xp_regwrite
  @rootkey = N'HKEY_LOCAL_MACHINE'
 ,@key = N'Software\Microsoft\Microsoft SQL Server\MasterServer\SQL Server Agent'
 ,@value_name = N'AllowDownloadedJobsToMatchProxyName'
 ,@type = N'REG_DWORD'
 ,@value = 1 ;

EXEC xp_regwrite
  @rootkey='HKEY_LOCAL_MACHINE',
  @key='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL15.TARGETSERVER1\SQLServerAgent',
  @value_name='MsxEncryptChannelOptions',
  @type='REG_DWORD',
  @value=0 ;

EXEC xp_regwrite
  @rootkey='HKEY_LOCAL_MACHINE',
  @key='SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL15.TARGETSERVER2\SQLServerAgent',
  @value_name='MsxEncryptChannelOptions',
  @type='REG_DWORD',
  @value=0 ;

GO
