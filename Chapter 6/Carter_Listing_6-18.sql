--Create a variable to store the results of DBCC LOGINFO

DECLARE @DBCCLogInfo TABLE
(
RecoveryUnitID        TINYINT
,FieldID                TINYINT
,FileSize                BIGINT
,StartOffset        BIGINT
,FseqNo                INT
,Status                TINYINT
,Parity                TINYINT
,CreateLSN        NUMERIC
);

--Populate the table variable with the results of DBCC LOGINFO

INSERT INTO @DBCCLogInfo
EXEC('DBCC LOGINFO');

--Display the size of the log file, combined with the number of VLFs and a VLFs to GB ratio

SELECT
         name
        ,[Size in MBs]
        ,[Number of VLFs]
        ,[Number of VLFs] / ([Size in MBs] / 1024) 'VLFs per GB'
FROM
(
         SELECT 
                  name
                  ,size * 1.0 / 128 'Size in MBs'
                  ,(SELECT COUNT(*) 
                           FROM @DBCCLogInfo) 'Number of VLFs'
         FROM sys.database_files
         WHERE type = 1
 ) a;
