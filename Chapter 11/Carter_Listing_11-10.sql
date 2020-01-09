--Create the duplicate Database

CREATE DATABASE Chapter11CellEncrypted ;
GO

USE Chapter11CellEncrypted
GO

--Create the table

CREATE TABLE dbo.SensitiveData
(
ID                INT                PRIMARY KEY        IDENTITY,
FirstName        NVARCHAR(30),
LastName        NVARCHAR(30),
CreditCardNumber        VARBINARY(8000)
)
GO

--Populate the table

SET identity_insert dbo.SensitiveData ON

INSERT INTO dbo.SensitiveData(id, firstname, lastname, CreditCardNumber)
SELECT id
,firstname
,lastname
,CreditCardNumber
FROM  Chapter11Encrypted.dbo.SensitiveData

SET identity_insert dbo.SensitiveData OFF


--Create Database Master Key

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Pa$$w0rd';
GO

--Create Certificate

CREATE CERTIFICATE CreditCardCert
   WITH SUBJECT = 'Credit Card Numbers';
GO

--Create Symmetric Key

CREATE SYMMETRIC KEY CreditCardKey
    WITH ALGORITHM = AES_128
    ENCRYPTION BY CERTIFICATE CreditCardCert;
GO

--Open Symmetric Key

OPEN SYMMETRIC KEY CreditCardKey
   DECRYPTION BY CERTIFICATE CreditCardCert;

--Encrypt the CreditCardNumber column

UPDATE SensitiveData
SET CreditCardNumber = ENCRYPTBYKEY(KEY_GUID('CreditCardKey'), CreditCardNumber);
GO

CLOSE SYMMETRIC KEY CreditCardKey --Close the key so it cannot be used again, unless reopened
