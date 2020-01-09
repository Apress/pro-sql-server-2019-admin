CREATE TABLE dbo.CreditCards 
( 
CardID     INT      IDENTITY     NOT NULL, 
CardType   NVARCHAR(20)  NOT NULL, 
CardNumber NVARCHAR(20)  COLLATE Latin1_General_BIN2 ENCRYPTED WITH (
        COLUMN_ENCRYPTION_KEY = [ColumnEncryptionKey],
        ENCRYPTION_TYPE = Randomized,
        ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256') NOT NULL,
ExpMonth   INT ENCRYPTED WITH (
        COLUMN_ENCRYPTION_KEY = [ColumnEncryptionKey],
        ENCRYPTION_TYPE = Randomized,
        ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256') NOT NULL, 
ExpYear    INT ENCRYPTED WITH (
        COLUMN_ENCRYPTION_KEY = [ColumnEncryptionKey],
        ENCRYPTION_TYPE = Randomized,
        ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256') NOT NULL,
CustomerID INT NOT NULL 
) ;
