CREATE PROCEDURE ObfuscatedProc
WITH ENCRYPTION
AS
BEGIN
        SELECT *
        FROM sys.tables
END
