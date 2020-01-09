CREATE EVENT SESSION [LogFileIO] ON SERVER 
ADD EVENT sqlos.async_io_completed(
    ACTION(sqlserver.database_name)
    WHERE ([sqlserver].[database_name]=N'Chapter19')),
ADD EVENT sqlos.async_io_requested(
    ACTION(sqlserver.database_name)
    WHERE ([sqlserver].[database_name]=N'Chapter19')),
ADD EVENT sqlos.spinlock_backoff(
    ACTION(sqlserver.database_name,sqlserver.sql_text)
    WHERE (([package0].[equal_uint64]([type],(85))) AND ([sqlserver].[database_name]=N'Chapter19'))),
ADD EVENT sqlos.wait_completed(
    ACTION(sqlserver.database_name)
    WHERE ([sqlserver].[database_name]=N'Chapter19')),
ADD EVENT sqlos.wait_info(
ACTION(sqlserver.client_app_name,sqlserver.database_name,sqlserver.is_system,sqlserver.session_id)
    WHERE ((([package0].[equal_uint64]([opcode],(1))) AND ([package0].[equal_uint64]([wait_type],(182)))) AND ([sqlserver].[database_name]=N'Chapter19'))),
ADD EVENT sqlserver.databases_log_flush(
    ACTION(sqlserver.database_name)
    WHERE ([sqlserver].[database_name]=N'Chapter19')),
ADD EVENT sqlserver.databases_log_flush_wait(
    ACTION(sqlserver.database_name)
    WHERE ([sqlserver].[database_name]=N'Chapter19')),
ADD EVENT sqlserver.file_write_completed(SET collect_path=(1)
    ACTION(sqlserver.database_name)
    WHERE (([package0].[equal_uint64]([file_id],(2))) AND ([sqlserver].[database_name]=N'Chapter19'))),
ADD EVENT sqlserver.file_written(SET collect_path=(1)
    ACTION(sqlserver.database_name)
    WHERE (([package0].[equal_uint64]([file_id],(2))) AND ([sqlserver].[database_name]=N'Chapter19')))
ADD TARGET package0.event_file(SET filename=N'C:\Logs\LogFileIO.xel',max_file_size=(512)),
ADD TARGET package0.histogram(SET filtering_event_name=N'sqlos.spinlock_backoff',source=N'sqlserver.sql_text'),
ADD TARGET package0.ring_buffer
WITH (MAX_MEMORY=4096 KB, EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB, MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=ON)

GO
