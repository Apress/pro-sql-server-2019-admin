USE Chapter9
GO

--Create the table that we will corrupt

CREATE TABLE dbo.CorruptTable
(
ID    INT    NOT NULL    PRIMARY KEY CLUSTERED    IDENTITY,
SampleText NVARCHAR(50)
) ;

--Populate the table

DECLARE @Numbers TABLE
(ID        INT)

;WITH CTE(Num)
AS
(
SELECT 1 Num
UNION ALL
SELECT Num + 1
FROM CTE
WHERE Num <= 100
) 
INSERT INTO @Numbers
SELECT Num
FROM CTE ;

INSERT INTO dbo.CorruptTable
SELECT 'SampleText'
FROM @Numbers a
CROSS JOIN @Numbers b ;

--DBCC WRITEPAGE will be used to corrupt a page in the table. This requires the 
--database to be placed in single user mode. 
--THIS IS VERY DANGEROUS – DO NOT EVER USE THIS IN A PRODUCTION ENVIRONMENT

ALTER DATABASE Chapter9 SET  SINGLE_USER WITH NO_WAIT ;
GO

DECLARE @SQL NVARCHAR(MAX) ;

SELECT @SQL = 'DBCC WRITEPAGE(' +
(
        SELECT CAST(DB_ID('Chapter9') AS NVARCHAR)
) +
', 1, ' +
(
        SELECT TOP 1 CAST(page_id AS NVARCHAR)
        FROM dbo.CorruptTable
        CROSS APPLY sys.fn_PhysLocCracker(%%physloc%%)
) +
', 2000, 1, 0x61, 1)' ;

EXEC(@SQL) ;

ALTER DATABASE Chapter9 SET  MULTI_USER WITH NO_WAIT ;
GO

SELECT * 
FROM dbo.CorruptTable ;
