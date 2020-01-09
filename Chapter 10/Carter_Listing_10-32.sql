USE Chapter10Audit
GO

ALTER DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification-Chapter10-SensitiveData]
WITH (STATE=OFF) ;
GO

ALTER DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification-Chapter10-SensitiveData]
ADD (AUDIT_CHANGE_GROUP) ;
GO

ALTER DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification-Chapter10-SensitiveData]
WITH(STATE = ON) ;
GO 
