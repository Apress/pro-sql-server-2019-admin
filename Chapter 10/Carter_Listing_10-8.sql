--Set Up the Role

CREATE ROLE db_ReadOnlyUsers AUTHORIZATION dbo ;
GO

ALTER ROLE db_ReadOnlyUsers ADD MEMBER Danielle ;

GRANT SELECT ON dbo.SensitiveData TO db_ReadOnlyUsers ;

DENY DELETE ON dbo.SensitiveData TO db_ReadOnlyUsers ;

DENY INSERT ON dbo.SensitiveData TO db_ReadOnlyUsers ;

DENY UPDATE ON dbo.SensitiveData TO db_ReadOnlyUsers ;
GO
