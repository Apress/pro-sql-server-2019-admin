CREATE NONCLUSTERED COLUMNSTORE INDEX NCCI_FirstName_LastName_Balance_CustomerID 
    ON dbo.CustomersDisc(FirstName,LastName,Balance,CustomerID) ;
