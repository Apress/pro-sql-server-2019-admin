CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Pa$$w0rd' ;
GO

CREATE CERTIFICATE aoag_certificate
    FROM FILE = '/var/opt/mssql/data/aoag_certificate.cer'
    WITH PRIVATE KEY (
		FILE = '/var/opt/mssql/data/aoag_certificate.pvk',
		DECRYPTION BY PASSWORD = 'Pa$$w0rd'
    ) ;
GO
