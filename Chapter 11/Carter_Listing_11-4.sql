BACKUP MASTER KEY TO FILE = 'c:\keys\Chapter11_master_key'
    ENCRYPTION BY PASSWORD = 'Pa$$w0rd';

RESTORE MASTER KEY 
    FROM FILE = 'c:\keys\Chapter11_master_key'
    DECRYPTION BY PASSWORD = 'Pa$$w0rd' --The password in the backup file
    ENCRYPTION BY PASSWORD = 'Pa$$w0rd'; --The password it will be encrypted within the database
