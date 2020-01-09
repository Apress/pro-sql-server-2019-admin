OPEN SYMMETRIC KEY CreditCardKey
   DECRYPTION BY CERTIFICATE CreditCardCert;

--Encrypt the CreditCardNumber column

UPDATE SensitiveData
SET CreditCardNumber = ENCRYPTBYKEY(Key_GUID('CreditCardKey')
                       ,CreditCardNumber
                       ,1
                       ,HASHBYTES('SHA1', CONVERT(VARBINARY(8000), ID)));
GO

CLOSE SYMMETRIC KEY CreditCardKey ;
