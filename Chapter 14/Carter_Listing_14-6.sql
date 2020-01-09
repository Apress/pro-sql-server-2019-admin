CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Pa$$w0rd';
GO

CREATE CERTIFICATE aoag_certificate WITH SUBJECT = 'AvailabilityGroups';
GO

BACKUP CERTIFICATE aoag_certificate
	TO FILE = '/var/opt/mssql/data/aoag_certificate.cer'
	WITH PRIVATE KEY (
           FILE = '/var/opt/mssql/data/aoag_certificate.pvk',
           ENCRYPTION BY PASSWORD = 'Pa$$w0rd'
       );
GO
