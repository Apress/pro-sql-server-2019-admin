USE Chapter10Audit
GO

GRANT INSERT, UPDATE ON dbo.sensitiveData TO Danielle ;
GO

INSERT INTO dbo.SensitiveData (SensitiveText) 
VALUES ('testing') ;
GO

UPDATE dbo.SensitiveData
SET SensitiveText = 'Boo'
WHERE ID = 2 ;
GO

EXECUTE AS USER ='Danielle'
GO

INSERT dbo.SensitiveData (SensitiveText) 
VALUES ('testing again') ;
GO

UPDATE dbo.SensitiveData
SET SensitiveText = 'Boo'
WHERE ID = 1 ;
GO

REVERT
