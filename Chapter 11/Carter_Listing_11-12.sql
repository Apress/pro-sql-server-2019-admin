--Open Key

OPEN SYMMETRIC KEY CreditCardKey
    DECRYPTION BY CERTIFICATE CreditCardCert;

--Read the Data using DECRYPTBYKEY()

SELECT 
         FirstName
        ,LastName
        ,CreditCardNumber AS [Credit Card Number Encrypted]
        ,CONVERT(VARCHAR(30), DECRYPTBYKEY(CreditCardNumber)) AS [Credit Card Number Decrypted]
        ,CONVERT(VARCHAR(30), CreditCardNumber) 
                                    AS [Credit Card Number Converted Without Decryption]
FROM dbo.SensitiveData ;

--Close the Key

CLOSE SYMMETRIC KEY CreditCardKey ;
