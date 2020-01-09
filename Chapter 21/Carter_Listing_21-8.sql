CREATE EVENT SESSION DReplay 
ON SERVER 
ADD EVENT sqlserver.assembly_load(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.attention(
    ACTION(package0.event_sequence,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.request_id,sqlserver.session_id)),

ADD EVENT sqlserver.begin_tran_completed(SET collect_statement=(1)
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.begin_tran_starting(SET collect_statement=(1)
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.commit_tran_completed(SET collect_statement=(1)
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.commit_tran_starting(SET collect_statement=(1)
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.cursor_close(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.sql_text,sqlserver.transaction_id)),

ADD EVENT sqlserver.cursor_execute(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.sql_text,sqlserver.transaction_id)),

ADD EVENT sqlserver.cursor_implicit_conversion(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.sql_text,sqlserver.transaction_id)),

ADD EVENT sqlserver.cursor_open(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.sql_text,sqlserver.transaction_id)),

ADD EVENT sqlserver.cursor_prepare(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.sql_text,sqlserver.transaction_id)),

ADD EVENT sqlserver.cursor_recompile(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.sql_text,sqlserver.transaction_id)),

ADD EVENT sqlserver.cursor_unprepare(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.sql_text,sqlserver.transaction_id)),

ADD EVENT sqlserver.database_file_size_change(SET collect_database_name=(1)
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.dtc_transaction(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.exec_prepared_sql(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.existing_connection(SET collect_database_name=(1),collect_options_text=(1)
    ACTION(package0.event_sequence,sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.nt_username,sqlserver.request_id,sqlserver.server_instance_name,sqlserver.server_principal_name,sqlserver.session_id,sqlserver.session_nt_username,sqlserver.session_resource_group_id,sqlserver.session_resource_pool_id,sqlserver.session_server_principal_name,sqlserver.username)),

ADD EVENT sqlserver.login(SET collect_database_name=(1),collect_options_text=(1)
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.nt_username,sqlserver.plan_handle,sqlserver.request_id,sqlserver.server_instance_name,sqlserver.server_principal_name,sqlserver.session_id,sqlserver.session_nt_username,sqlserver.session_resource_group_id,sqlserver.session_resource_pool_id,sqlserver.session_server_principal_name,sqlserver.transaction_id,sqlserver.username)),

ADD EVENT sqlserver.logout(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.client_app_name,sqlserver.client_hostname,sqlserver.client_pid,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.nt_username,sqlserver.plan_handle,sqlserver.request_id,sqlserver.server_instance_name,sqlserver.server_principal_name,sqlserver.session_id,sqlserver.session_nt_username,sqlserver.session_resource_group_id,sqlserver.session_resource_pool_id,sqlserver.session_server_principal_name,sqlserver.transaction_id,sqlserver.username)),

ADD EVENT sqlserver.prepare_sql(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.promote_tran_completed(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.promote_tran_starting(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.rollback_tran_completed(SET collect_statement=(1)
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.rollback_tran_starting(SET collect_statement=(1)
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.rpc_completed(SET collect_data_stream=(1),collect_output_parameters=(1),collect_statement=(0)
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.rpc_starting(SET collect_data_stream=(1),collect_statement=(0)
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.save_tran_completed(SET collect_statement=(1)
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.save_tran_starting(SET collect_statement=(1)
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.server_memory_change(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.sql_batch_completed(SET collect_batch_text=(1)
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.sql_batch_starting(SET collect_batch_text=(1)
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.sql_transaction(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.trace_flag_changed(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)),

ADD EVENT sqlserver.unprepare_sql(
    ACTION(package0.collect_current_thread_id,package0.event_sequence,sqlos.cpu_id,sqlos.scheduler_id,sqlos.system_thread_id,sqlos.task_address,sqlos.worker_address,sqlserver.database_id,sqlserver.database_name,sqlserver.is_system,sqlserver.plan_handle,sqlserver.request_id,sqlserver.session_id,sqlserver.transaction_id)) 

ADD TARGET package0.event_file(SET filename=N'C:\MSSQL\DReplay.xel')
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=ON,STARTUP_STATE=ON) ;
GO

ALTER EVENT SESSION DReplay
ON SERVER
STATE = start;
GO
