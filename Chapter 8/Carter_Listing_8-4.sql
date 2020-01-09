CREATE NONCLUSTERED INDEX NCI_Balance ON dbo.CustomersDisc(Balance) 
    INCLUDE(LastName, FirstName) 
    WITH(DROP_EXISTING = ON) ;
