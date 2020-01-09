USE Master 
GO

--Create a database with three files in the primary filegroup.

CREATE DATABASE [Chapter6]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Chapter6', FILENAME = N'F:\MSSQL\MSSQL15.PROSQLADMIN\MSSQL\DATA\Chapter6.mdf'),
( NAME = N'Chapter6_File2', 
        FILENAME = N'F:\MSSQL\MSSQL15.PROSQLADMIN\MSSQL\DATA\Chapter6_File2.ndf'),
( NAME = N'Chapter6_File3', 
        FILENAME = N'F:\MSSQL\MSSQL15.PROSQLADMIN\MSSQL\DATA\Chapter6_File3.ndf')
 LOG ON 
( NAME = N'Chapter6_log', 
        FILENAME = N'E:\MSSQL\MSSQL15.PROSQLADMIN\MSSQL\DATA\Chapter6_log.ldf');
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') 
        ALTER DATABASE [Chapter6] MODIFY FILEGROUP [PRIMARY] DEFAULT;
GO

USE Chapter6
GO

--Create a table in the new database. The table contains a wide, fixed-length column 
--to increase the number of allocations.

CREATE TABLE dbo.RoundRobinTable
(
        ID              INT          IDENTITY        PRIMARY KEY,
        DummyTxt        NCHAR(1000),
);
GO

--Create a Numbers table that will be used to assist the population of the table.

DECLARE @Numbers TABLE
(
        Number        INT
)

--Populate the Numbers table.

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

--Populate the example table with 100 rows of dummy text.

INSERT INTO dbo.RoundRobinTable
SELECT 'DummyText'
FROM @Numbers a
CROSS JOIN @Numbers b;

--Select all the data from the table, plus the details of the row’s physical location. 
--Then group the row count. 
--by file ID

SELECT b.file_id, COUNT(*) AS [RowCount]
FROM
(
        SELECT ID, DummyTxt, a.file_id
        FROM dbo.RoundRobinTable
        CROSS APPLY sys.fn_PhysLocCracker(%%physloc%%) a
) b
GROUP BY b.file_id;
