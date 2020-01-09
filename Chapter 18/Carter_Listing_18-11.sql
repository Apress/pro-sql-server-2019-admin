CREATE PROCEDURE dbo.UpdateCreditLimit
WITH native_compilation, schemabinding, execute as owner
AS
BEGIN ATOMIC 
        WITH(TRANSACTION ISOLATION LEVEL = SERIALIZABLE, LANGUAGE = 'English')
                UPDATE dbo.CustomersMem
                SET CreditLimit = CreditLimit * 1.1
                WHERE Balance < CreditLimit / 4 ;

                UPDATE dbo.CustomersMem
                SET CreditLimit = CreditLimit * 1.05
                WHERE Balance < CreditLimit / 2 ;
END 
