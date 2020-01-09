SELECT 
        CAST(
            CAST(
                CONVERT(VARBINARY, '0x' 
                        + RIGHT(REPLICATE('0', 8) 
                        + SUBSTRING([Current LSN], 1, 8), 8), 1
                ) AS INT
            ) AS VARCHAR(11)
        ) +
        RIGHT(REPLICATE('0', 10) + 
        CAST(
            CAST(
                CONVERT(VARBINARY, '0x' 
                        + RIGHT(REPLICATE('0', 8) 
                        + SUBSTRING([Current LSN], 10, 8), 8), 1
                ) AS INT
              ) AS VARCHAR(10)), 10) +
        RIGHT(REPLICATE('0',5) + 
        CAST(
            CAST(CONVERT(VARBINARY, '0x' 
                         + RIGHT(REPLICATE('0', 8) 
                         + SUBSTRING([Current LSN], 19, 4), 8), 1
                 ) AS INT
             ) AS VARCHAR
        ), 5) AS ConvertedLSN
        ,*
FROM
    sys.fn_dump_dblog (
        NULL, NULL, N'DISK', 3, N'H:\MSSQL\Backup\Chapter12PointinTime.bak'
        DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT,
        DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT,
        DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT,
        DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT,
        DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT,
        DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT,
        DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT,
        DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT,
        DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT)
WHERE [Transaction Name] = 'TRUNCATE TABLE' ;
