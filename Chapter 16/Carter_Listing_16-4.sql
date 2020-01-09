--Truncate the table

TRUNCATE TABLE Chapter16.dbo.Customers ;

--Allow Identity values to be re-inserted

SET IDENTITY_INSERT Chapter16.dbo.Customers ON ;

--Insert the data

INSERT INTO Chapter16.dbo.Customers(ID, FirstName, LastName, CreditCardNumber)
SELECT *
         FROM Chapter16_ss_0630.dbo.Customers ;

--Turn off IDENTITY_INSERT

SET IDENTITY_INSERT Chapter16.dbo.Customers OFF ;
