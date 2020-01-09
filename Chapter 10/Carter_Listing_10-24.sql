USE Master

GO

CREATE SERVER AUDIT [Audit-ProSQLAdmin]
TO FILE 
(        FILEPATH = N'c:\audit'
        ,MAXSIZE = 512 MB
        ,MAX_ROLLOVER_FILES = 2147483647
        ,RESERVE_DISK_SPACE = OFF
)
WITH
(        QUEUE_DELAY = 1000
        ,ON_FAILURE = CONTINUE
)
WHERE object_name = 'sysadmin' ;
