--Enable EKM

sp_configure 'show advanced', 1
GO

RECONFIGURE
GO

sp_configure 'EKM provider enabled', 1
GO

RECONFIGURE
GO

--Register provider

CREATE CRYPTOGRAPHIC PROVIDER nCipher_Provider FROM FILE =
 'C:\Program Files\nCipher\nfast\bin\ncsqlekm64.dll'
