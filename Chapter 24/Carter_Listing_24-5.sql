USE MASTER
GO

GRANT EXECUTE ON dbo.Classifier TO public ;
GO

EXECUTE AS LOGIN = 'SalesUser' ;
SELECT dbo.Classifier() AS 'Workload Group' ;
REVERT

EXECUTE AS LOGIN = 'SalesManager' ;
SELECT dbo.Classifier() as 'Workload Group' ;
REVERT

REVOKE EXECUTE ON dbo.Classifier TO public ;
GO
