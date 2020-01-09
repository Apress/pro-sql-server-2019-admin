SELECT m.name
        ,m.physical_name
        ,CAST(fsu.total_page_count / 128. AS NUMERIC(12,4)) [Fie Size (MB)]
        ,CAST(fsu.unallocated_extent_page_count / 128. AS NUMERIC(12,4)) [Free Space (MB)]
        ,vfs.io_stall_read_ms
        ,vfs.io_stall_write_ms
FROM sys.dm_db_file_space_usage fsu
CROSS APPLY sys.dm_io_virtual_file_stats(fsu.database_id, fsu.file_id) vfs
INNER JOIN sys.master_files m
        ON fsu.database_id = m.database_id
                AND fsu.file_id = m.file_id ;
