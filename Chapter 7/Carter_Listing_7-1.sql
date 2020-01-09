USE Master
GO

--Create Database Chapter7 using default settings from Model

CREATE DATABASE Chapter7 ;
GO

USE Chapter7
GO

--Create Partition Function

CREATE PARTITION FUNCTION PartFunc(Date)
AS RANGE LEFT
FOR VALUES('2017-01-01', '2019-01-01') ;
