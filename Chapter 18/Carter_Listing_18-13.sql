SELECT
        name
        ,transaction_begin_time
        ,CASE transaction_type
        WHEN 1 THEN 'Read/Write'
        WHEN 2 THEN 'Read-Only'
        WHEN 3 THEN 'System'
        WHEN 4 THEN 'Distributed'
        END TransactionType,
        CASE transaction_state
        WHEN 0 THEN 'Initializing'
        WHEN 1 THEN 'Initialized But Not Started'
        WHEN 2 THEN 'Active'
        WHEN 3 THEN 'Ended'
        WHEN 4 THEN 'Committing'
        WHEN 5 THEN 'Prepared'
        WHEN 6 THEN 'Committed'
        WHEN 7 THEN 'Rolling Back'
        WHEN 8 THEN 'Rolled Back'
    END State
        ,SUSER_SNAME(es.security_id) LoginRunningTransaction
        ,es.memory_usage * 8 MemUsageKB
        ,es.reads
        ,es.writes
        ,es.cpu_time
 FROM sys.dm_tran_active_transactions at
        INNER JOIN sys.dm_tran_session_transactions st
                ON at.transaction_id = st.transaction_id
                INNER JOIN sys.dm_exec_sessions es
                        ON st.session_id = es.session_id
 WHERE st.is_user_transaction = 1 
 AND at.transaction_begin_time < DATEADD(MINUTE,-10,GETDATE()) ;
