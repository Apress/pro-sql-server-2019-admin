--Part 1 - Run in 1st query window

BEGIN TRANSACTION

UPDATE dbo.Customers 
SET LastName = 'Andrews'
WHERE CustomerID = 1


--Part 2 - Run in 2nd query window

BEGIN TRANSACTION

UPDATE dbo.Addresses
SET PostCode = 'SA12 9BD'
WHERE AddressID = 2


--Part 3 - Run in 1st query window

UPDATE dbo.Addresses
SET PostCode = 'SA12 9BD'
WHERE AddressID = 2


--Part 4 - Run in 2nd query window

UPDATE dbo.Customers 
SET LastName = 'Colins'
WHERE CustomerID = 1
