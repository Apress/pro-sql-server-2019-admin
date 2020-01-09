CREATE DATABASE Chapter17
GO

ALTER DATABASE Chapter17
SET RECOVERY FULL
GO

USE Chapter17
GO

CREATE TABLE dbo.CriticalData (
	ID	INT	IDENTITY	PRIMARY KEY	NOT NULL,
	ImportantData	NVARCHAR(128) NOT NULL
)

INSERT INTO dbo.CriticalData(ImportantData)
VALUES('My Very Important Value')
GO

SELECT MAX(page_info.page_lsn)
FROM dbo.CriticalData c
CROSS APPLY sys.fn_PageResCracker(%%physloc%%) AS r
CROSS APPLY sys.dm_db_page_info(DB_ID(), r.file_id, r.page_id, 'DETAILED') AS page_info
