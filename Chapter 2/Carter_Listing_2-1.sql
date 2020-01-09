--Create a local temporary table

CREATE TABLE #CaseExample
(
        Name        VARCHAR(20)
)

--Populate values

INSERT INTO #CaseExample
        VALUES('James'), ('james'), ('John'), ('john')

--Count the number of entries for James, with case sensitive collation

SELECT COUNT(*) AS 'Case Sensitive'
FROM #CaseExample
WHERE Name = 'John' COLLATE Latin1_General_CS_AI

--Count the number of entries for James, with case insensitive collation

SELECT COUNT(*) AS 'Case Insensitive'
FROM #CaseExample
WHERE Name = 'John' COLLATE Latin1_General_CI_AI

--DROP temporary table

DROP TABLE #CaseExample
