--Part 1 - Run in 1st query window

BEGIN TRANSACTION
UPDATE Customers
SET CreditLimit = CreditLimit ;

--Part 2 - Run in 2nd query window

SELECT creditlimit 
FROM dbo.Customers (SERIALIZABLE) ;

--Part 3 - Run in 3rd query window

SELECT 
        DB_NAME(tl.resource_database_id) DatabaseName
        ,tl.resource_type
        ,tl.resource_subtype
        ,tl.resource_description
        ,tl.request_mode
        ,tl.request_status
        ,os.session_id BlockedSession
        ,os.blocking_session_id BlockingSession
        ,os.resource_description
       ,OBJECT_NAME(
                    CAST(
                         SUBSTRING(os.resource_description,
                                    CHARINDEX('objid=',os.resource_description,0)+6,9) 
                        AS INT)
            ) LockedTable
FROM sys.dm_os_waiting_tasks os 
INNER JOIN sys.dm_tran_locks tl 
        ON os.session_id = tl.request_session_id 
WHERE tl.request_owner_type IN ('TRANSACTION', 'SESSION', 'CURSOR') ;
