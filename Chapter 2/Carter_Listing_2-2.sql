--Create a temporary table

CREATE TABLE #SortOrderExample
(
        Food        VARCHAR(20)
)

--Populate the table
 
INSERT INTO #SortOrderExample
VALUES ('Coke'), ('Chips'), ('Crisps'), ('Cake')

--Select food using Latin1_General collation

SELECT Food AS 'Latin1_General collation'
FROM #SortOrderExample
ORDER BY Food
COLLATE Latin1_General_CI_AI


--Select food using Traditional_Spanish collation

SELECT Food AS 'Traditional_Spanish colation'
FROM #SortOrderExample
ORDER BY Food
COLLATE Traditional_Spanish_CI_AI
