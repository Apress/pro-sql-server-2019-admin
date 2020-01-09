SELECT
        mid.statement TableName
        ,ISNULL(mid.equality_columns, '') 
            + ',' 
            + ISNULL(mid.inequality_columns, '') IndexKeyColumns
        ,mid.included_columns
        ,migs.unique_compiles
        ,migs.user_seeks
        ,migs.user_scans
        ,migs.avg_total_user_cost
        ,migs.avg_user_impact
FROM sys.dm_db_missing_index_details mid
INNER JOIN sys.dm_db_missing_index_groups mig
        ON mid.index_handle = mig.index_handle
        INNER JOIN sys.dm_db_missing_index_group_stats migs
                ON mig.index_group_handle = migs.group_handle ; 
