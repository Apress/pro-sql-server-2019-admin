--Check if already enabled

IF EXISTS (
        SELECT name
                ,snapshot_isolation_state_desc
                ,is_read_committed_snapshot_on 
        FROM sys.databases 
        WHERE name = 'Chapter18' 
                AND snapshot_isolation_state_desc = 'OFF' 
                AND is_read_committed_snapshot_on = 0 )
BEGIN
        --Kill any existing sessions

        IF EXISTS(
        SELECT * FROM sys.dm_exec_sessions where database_id = DB_id('Chapter18')
        )
        BEGIN
                PRINT 'Killing Sessions to Chapter18 database'
                DECLARE @SQL NVARCHAR(MAX)
                SET @SQL = (SELECT 'KILL ' + CAST(Session_id AS NVARCHAR(3)) + '; ' [data()] 
                                        FROM sys.dm_exec_sessions 
                                        WHERE database_id = DB_id('Chapter18')
                                        FOR XML PATH('')
                                        )
                EXEC(@SQL)
        END
        
        PRINT 'Enabling Snapshot and Read Committed Sanpshot Isolation'

        ALTER DATABASE Chapter18
        SET ALLOW_SNAPSHOT_ISOLATION ON ;

        ALTER DATABASE Chapter18
        SET READ_COMMITTED_SNAPSHOT ON ;
END
ELSE
        PRINT 'Snapshot Isolation already enabled' 
