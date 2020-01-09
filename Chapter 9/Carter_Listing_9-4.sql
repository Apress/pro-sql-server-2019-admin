SELECT 
    DB_NAME(sp.database_id) [Database]
    ,mf.name 
    ,sp.page_id
    ,CASE sp.event_type
        WHEN 1 THEN '823 or 824 or Torn Page'
        WHEN 2 THEN 'Bad Checksum'
        WHEN 3 THEN 'Torn Page'
        WHEN 4 THEN 'Restored'
        WHEN 5 THEN 'Repaired (DBCC)'
        WHEN 7 THEN 'Deallocated (DBCC)'
    END AS [Event]
    ,sp.error_count
    ,sp.last_update_date
FROM msdb.dbo.suspect_pages sp
INNER JOIN sys.master_files mf
        ON sp.database_id = mf.database_id
                AND sp.file_id = mf.file_id ;
