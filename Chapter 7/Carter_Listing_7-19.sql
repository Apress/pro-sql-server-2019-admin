SELECT 
        m.name DLL
        ,t.name TableName
        ,description 
FROM sys.dm_os_loaded_modules m
INNER JOIN sys.tables t
        ON t.object_id = 
(SELECT SUBSTRING(m.name, LEN(m.name) + 2 - CHARINDEX('_', REVERSE(m.name)), 
len(m.name) - (LEN(m.name) + 2 - CHARINDEX('_', REVERSE(m.name)) + 3) ))
WHERE m.name like '%xtp_t_' + cast(db_id() as varchar(10)) + '%' ; 
