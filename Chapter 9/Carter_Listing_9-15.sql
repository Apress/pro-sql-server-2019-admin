SELECT  
    is_not_trusted
FROM sys.check_constraints
WHERE name = ‘chkBadConstraint’ ;

ALTER TABLE dbo.BadConstraint WITH CHECK CHECK CONSTRAINT chkDadConstraint ;
