--Create Chapter10 database

CREATE DATABASE Chapter10 ;
GO

USE Chapter10
GO

--Create SensitiveData table

CREATE TABLE dbo.SensitiveData
(
ID    INT    PRIMARY KEY    IDENTITY,
SensitiveText        NVARCHAR(100)
) ;

--Populate SensitiveData table

DECLARE @Numbers TABLE
(
ID        INT
)

;WITH CTE(Num)
AS
(
SELECT 1 AS Num
UNION ALL
SELECT Num + 1
FROM CTE
WHERE Num < 100
) 

INSERT INTO @Numbers
SELECT Num
FROM CTE ;

INSERT INTO dbo.SensitiveData
SELECT 'SampleData'
FROM @Numbers ;
