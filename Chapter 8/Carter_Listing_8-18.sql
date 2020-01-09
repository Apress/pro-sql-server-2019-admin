DECLARE @Action NVARCHAR(6) = 'Resume'

IF (@Action = 'Resume')
BEGIN
	ALTER INDEX NCI_CustomerID ON dbo.OrdersDisc RESUME
END
ELSE
BEGIN
	ALTER INDEX NCI_CustomerID ON dbo.OrdersDisc ABORT
END
