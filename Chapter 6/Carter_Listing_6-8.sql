--Create a Numbers table that will be used to assit the population of the table

DECLARE @Numbers TABLE
(
        Number        INT
)

--Populate the Numbers table

;WITH CTE(Number)
AS
(
        SELECT 1 Number
        UNION ALL
        SELECT Number +1
        FROM CTE
        WHERE Number <= 99
)
INSERT INTO @Numbers
SELECT *
FROM CTE;

--Populate the example table with 10000 rows of dummy text

INSERT INTO dbo.RoundRobinTable
SELECT 'DummyText'
FROM @Numbers a
CROSS JOIN @Numbers b;

--Select all the data from the table, plus the details of the rows’ physical location. 
--Then group the row count 
--by file ID
SELECT b.file_id, COUNT(*)
FROM
(
        SELECT ID, DummyTxt, a.file_id
        FROM dbo.RoundRobinTable
        CROSS APPLY sys.fn_PhysLocCracker(%%physloc%%) a
) b
GROUP BY b.file_id;
