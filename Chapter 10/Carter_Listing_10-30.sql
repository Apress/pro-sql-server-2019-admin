USE Chapter10Audit
GO

ALTER DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification-Chapter10-SensitiveData]
WITH (STATE = ON) ;
GO

USE Master
GO

ALTER SERVER AUDIT [Audit-Chapter10] WITH (STATE = ON) ;
