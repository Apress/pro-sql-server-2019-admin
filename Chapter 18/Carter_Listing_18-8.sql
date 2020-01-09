BEGIN TRANSACTION
        SELECT *
        FROM dbo.Customers C
        INNER JOIN dbo.CustomersMem CM
                ON C.CustomerID = CM.CustomerID ;
COMMIT TRANSACTION
