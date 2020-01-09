SELECT 
    file_id
    ,unallocated_extent_page_count * 1.0 / 128 'Free Space (MB)'
FROM sys.dm_db_file_space_usage;
