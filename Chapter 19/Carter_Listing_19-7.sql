--Run the update procedures

EXEC UpdateCustomersWithoutPageSplits ;
GO

EXEC UpdateCustomerWithPageSplits ;
GO

--Wait 30 seconds to allow for the XE buffers to be flushed to the target

WAITFOR DELAY '00:00:30' ;

--Query the XE Target

SELECT c.procedurename, d.pagesplits
 FROM
 (
        SELECT
                correlationid,
                COUNT(*) -1 PageSplits -- -1 to remove the count of the module_start event
        FROM 
        (
               SELECT CapturedEvent, 
                        xml_data.value('(/event/data[@name=''object_name'']/value)[1]', 'nvarchar(max)') procedurename,  --extract procedure name
                        xml_data.value('(/event/action[@name=''attach_activity_id'']/value)[1]', 'uniqueidentifier') correlationid --extract Correlation ID
                FROM
                 (
--Query the fn_xe_file_target_read_file function, to extract the raw XML                        
                                SELECT 
                                OBJECT_NAME CapturedEvent,
                                CAST(event_data AS XML) xml_data
                                FROM 
sys.fn_xe_file_target_read_file('C:\mssql\pagesplits*.xel', NULL , NULL, NULL) as XE ) a
                ) b
                GROUP BY correlationid
        ) d
INNER JOIN --Self join, to allow the count of page splits
(
        SELECT CapturedEvent, 
                xml_data.value('(/event/data[@name=''object_name'']/value)[1]', 'nvarchar(max)') procedurename,  
                xml_data.value('(/event/action[@name=''attach_activity_id'']/value)[1]', 'uniqueidentifier') correlationid
        FROM
         (
                SELECT object_name CapturedEvent,
                CAST(event_data AS XML) xml_data
                FROM 
                sys.fn_xe_file_target_read_file('C:\mssql\pagesplits*.xel', NULL , NULL, NULL) as XE ) a
        ) c
ON c.correlationid = d.correlationid 
        AND c.procedurename IS NOT NULL ;
