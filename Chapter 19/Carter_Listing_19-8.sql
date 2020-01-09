CREATE EVENT SESSION Statements_with_Perf_Counters
ON SERVER 
--Add the Events and Actions relating to each Event
ADD EVENT sqlserver.error_reported(
    ACTION(sqlserver.client_app_name,sqlserver.database_id,sqlserver.query_hash,sqlserver.session_id)
    WHERE ([package0].[greater_than_uint64]([sqlserver].[database_id],(4)) AND 
[package0].[equal_boolean]([sqlserver].[is_system],(0)))),
ADD EVENT sqlserver.module_end(SET collect_statement=(1)
    ACTION(sqlserver.client_app_name,sqlserver.database_id,sqlserver.query_hash,sqlserver.session_id)
    WHERE ([package0].[greater_than_uint64]([sqlserver].[database_id],(4)) AND 
[package0].[equal_boolean]([sqlserver].[is_system],(0)))),
ADD EVENT sqlserver.perfobject_processor,
ADD EVENT sqlserver.rpc_completed(
    ACTION(sqlserver.client_app_name,sqlserver.database_id,sqlserver.query_hash,sqlserver.session_id)
    WHERE ([package0].[greater_than_uint64]([sqlserver].[database_id],(4)) AND 
[package0].[equal_boolean]([sqlserver].[is_system],(0)))),
ADD EVENT sqlserver.sp_statement_completed(SET collect_object_name=(1)
    ACTION(sqlserver.client_app_name,sqlserver.database_id,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.session_id)
    WHERE ([package0].[greater_than_uint64]([sqlserver].[database_id],(4)) AND [package0].[equal_boolean]([sqlserver].[is_system],(0)))),
ADD EVENT sqlserver.sql_batch_completed(
    ACTION(sqlserver.client_app_name,sqlserver.database_id,sqlserver.query_hash,sqlserver.session_id)
    WHERE ([package0].[greater_than_uint64]([sqlserver].[database_id],(4)) AND 
[package0].[equal_boolean]([sqlserver].[is_system],(0)))),
ADD EVENT sqlserver.sql_statement_completed(
    ACTION(sqlserver.client_app_name,sqlserver.database_id,sqlserver.query_hash,sqlserver.query_plan_hash,sqlserver.session_id)
    WHERE ([package0].[greater_than_uint64]([sqlserver].[database_id],(4)) AND 
[package0].[equal_boolean]([sqlserver].[is_system],(0)))) 
--Add the Targets
ADD TARGET package0.event_file(SET filename=N'C:\MSSQL\StatementsAndProcessorUtilization.xel'),
ADD TARGET package0.etw_classic_sync_target(SET default_etw_session_logfile_path=N'C:\MSSQL\StatementsWithPerfCounters.etl')
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=ON,STARTUP_STATE=OFF) ; 
GO

--Start the instance
ALTER EVENT SESSION Statements_with_Perf_Counters
ON SERVER
STATE = start;
