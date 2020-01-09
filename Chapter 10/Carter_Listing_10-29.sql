USE Chapter10Audit
GO

CREATE DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification-Chapter10-SensitiveData]
FOR SERVER AUDIT [Audit-Chapter10]
ADD (INSERT ON OBJECT::dbo.SensitiveData BY public),
ADD (SELECT ON OBJECT::dbo.SensitiveData BY Danielle) ;
