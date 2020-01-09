USE Chapter6LogFragmentation
GO

DBCC SHRINKFILE ('Chapter6LogFragmentation _log' , 0, TRUNCATEONLY);
GO

ALTER DATABASE Chapter6LogFragmentation MODIFY FILE ( NAME = 'Chapter6LogFragmentation _log', SIZE = 512000KB );
GO
