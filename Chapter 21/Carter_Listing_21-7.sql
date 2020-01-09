USE Chapter21
GO

CREATE INDEX IDX_Customers_LastName ON dbo.Customers(LastName) INCLUDE(FirstName) ;
GO

CREATE INDEX IDX_Customers_AddressID ON dbo.Customers(DeliveryAddressID) ;
GO

CREATE INDEX IDX_Addresses_AddressID ON dbo.Addresses(AddressID) ;
GO

CREATE INDEX IDX_Customers_LastName_CustomerID ON dbo.Customers(LastName, CustomerID) ;
GO
