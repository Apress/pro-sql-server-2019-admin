CREATE PROCEDURE UpdateCreditLimitWrapper
AS
BEGIN
        DECLARE @Retries INT = 1 ;

        WHILE @Retries <= 10
        BEGIN
                BEGIN TRY
                        EXEC dbo.UpdateCreditLimit ;
                END TRY
                BEGIN CATCH
                        WAITFOR DELAY '00:00:01' ;
                        SET @Retries = @Retries + 1 ;
                END CATCH
        END
END 
