USE Chapter9
GO

--Create the BadConstraint table

CREATE TABLE dbo.BadConstraint
(
ID        INT PRIMARY KEY
) ;

--Insert a negative value into the BadConstraint table

INSERT INTO dbo.BadConstraint
VALUES(-1) ;

--Create a CHECK constraint, which enforces positive values in the ID column

ALTER TABLE dbo.BadConstraint WITH NOCHECK ADD CONSTRAINT chkBadConstraint CHECK (ID > 0) ;
GO

--Run DBCC CHECKCONSTRAINTS against the table

DBCC CHECKCONSTRAINTS('dbo.BadConstraint') ;
