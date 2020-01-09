--Restore the first transaction log

RESTORE LOG Chapter15 
FROM  DISK = N'C:\LogShippingDR\Chapter15.trn' 
WITH  FILE = 1,  NORECOVERY,  STATS = 10 ;
GO

--Restore the tail end of the log

RESTORE LOG Chapter15 
FROM  DISK = N'C:\LogShippingDR\Chapter15_tail.trn' 
WITH  FILE = 1,  RECOVERY, STATS = 10 ;
GO
