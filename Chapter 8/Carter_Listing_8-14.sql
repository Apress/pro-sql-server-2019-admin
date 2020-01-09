--Create the index that will be used in the examples, for the following sections

CREATE NONCLUSTERED INDEX NCI_CustomerID ON dbo.OrdersDisc(CustomerID) ;
GO

--Reorganize the index

ALTER INDEX NCI_CustomerID ON dbo.OrdersDisc REORGANIZE ; 
