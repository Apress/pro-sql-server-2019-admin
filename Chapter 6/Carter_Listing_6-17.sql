--Create Chapter6LogFragmentation database

CREATE DATABASE [Chapter6LogFragmentation]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Chapter6LogFragmentation', FILENAME = N'F:\MSSQL\MSSQL15.PROSQLADMIN\MSSQL\DATA\Chapter6LogFragmentation.mdf' , SIZE = 5120KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Chapter6LogFragmentation_log', FILENAME = N'E:\MSSQL\MSSQL15.PROSQLADMIN\MSSQL\DATA\Chapter6LogFragmentation_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%);
GO

USE Chapter6LogFragmentation
GO

--Create Inserts table

CREATE TABLE dbo.Inserts
(ID                INT                IDENTITY,
DummyText        NVARCHAR(50)
);

--Create a Numbers table that will be used to assit the population of the table

DECLARE @Numbers TABLE
(
	Number	INT
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

--Populate the example table with 100 rows of dummy text

INSERT INTO dbo.Inserts
SELECT 'DummyText'
FROM @Numbers a
CROSS JOIN @Numbers b
CROSS JOIN @Numbers c;
