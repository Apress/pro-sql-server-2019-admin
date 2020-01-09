CREATE TABLE #CaseExample
(
        Name        VARCHAR(20)
)

--Populate values

INSERT INTO #CaseExample
        VALUES('James'), ('james'), ('John'), ('john')


--Select all rows with a case sensitive collation

SELECT name as [Case Sensitive]
FROM #CaseExample
Order by Name COLLATE Latin1_General_CS_AI

--Select all rows, with a case insensitive collation

SELECT name as [Case Insensitive]
FROM #CaseExample
Order by Name COLLATE  Latin1_General_CI_AI

SELECT name as [binary]
FROM #CaseExample
Order by Name COLLATE  Latin1_General_BIN2

--DROP temporary table

DROP TABLE #CaseExample
