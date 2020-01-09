USE Chapter8
GO

--Create multicolumn statistic on FirstName and LastName

CREATE STATISTICS Stat_FirstName_LastName ON dbo.CustomersDisc(FirstName, LastName) ;
GO

--Create filtered statistic on NetAmount

CREATE STATISTICS Stat_NetAmount_Filter_OrderDate ON dbo.OrdersDisc(NetAmount)
WHERE OrderDate > '2019-01-01' ;
GO
