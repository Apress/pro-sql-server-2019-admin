--Create Chapter8 Database

CREATE DATABASE Chapter8
 ON  PRIMARY 
( NAME = N'Chapter8', FILENAME = 
    N'F:\Program Files\Microsoft SQL Server\MSSQL15.PROSQLADMIN\MSSQL\DATA\Chapter8.mdf'), 
 FILEGROUP [MEM] CONTAINS MEMORY_OPTIMIZED_DATA  DEFAULT
( NAME = N'MEM', FILENAME = N'H:\DATA\CH08')
 LOG ON 
( NAME = N'Chapter8_log', FILENAME = 
    N'E:\Program Files\Microsoft SQL Server\MSSQL15.PROSQLADMIN\MSSQL\DATA\Chapter8_log.ldf') ;
GO

USE Chapter8
GO

--Create CIDemo table

CREATE TABLE dbo.CIDemo
(
        ID                INT                IDENTITY,
        DummyText        VARCHAR(30)
) ;
GO

--Create clustered index

CREATE UNIQUE CLUSTERED INDEX CI_CIDemo ON dbo.CIDemo([ID]) ;
GO
