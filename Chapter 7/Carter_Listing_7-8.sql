--Create the OldOrders table

CREATE TABLE dbo.OldOrdersStaging(
        [OrderNumber] [int] IDENTITY(1,1) NOT NULL,
         [OrderDate] [date] NOT NULL,
         [CustomerID] [int] NOT NULL,
         [ProductID] [int] NOT NULL,
         [Quantity] [int] NOT NULL,
         [NetAmount] [money] NOT NULL,
         [TaxAmount] [money] NOT NULL,
         [InvoiceAddressID] [int] NOT NULL,
         [DeliveryAddressID] [int] NOT NULL,
         [DeliveryDate] [date] NULL,
 CONSTRAINT PK_OldOrdersStaging PRIMARY KEY CLUSTERED 
(
        OrderNumber ASC,
        OrderDate ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, 
           ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
) ;
GO

--Calculate the lowest boundary point value

DECLARE @LowestBoundaryPoint DATE = (
        SELECT TOP 1 CAST(value  AS DATE)
        FROM sys.partition_functions pf
        INNER JOIN sys.partition_range_values prv 
                ON pf.function_id = prv.function_id
        WHERE pf.name = 'PartFuncWeek'
        ORDER BY value ASC) ;

--Calculate the newest boundary point value

DECLARE @HighestboundaryPoint DATE = (
SELECT TOP 1 CAST(value  AS DATE)
        FROM sys.partition_functions pf
        INNER JOIN sys.partition_range_values prv 
                ON pf.function_id = prv.function_id
        WHERE pf.name = 'PartFuncWeek'
        ORDER BY value DESC) ;

--Add 7 days to the newest boundary point value to determine the new boundary point

DECLARE @NewSplitRange DATE = (
        SELECT DATEADD(dd,7,@HighestboundaryPoint)) ;

--Switch the oldest partition to the OldOrders table

ALTER TABLE ExistingOrders
        SWITCH PARTITION 1 TO OldOrdersStaging PARTITION 2 ;

--Remove the oldest partition

ALTER PARTITION FUNCTION PartFuncWeek()
        MERGE RANGE(@LowestBoundaryPoint) ;

--Create the new partition

ALTER PARTITION FUNCTION PartFuncWeek()
        SPLIT RANGE(@NewSplitRange) ;
GO

--Re-run $PARTITION to assess new spread of rows

SELECT 
        COUNT(*) 'Number of Rows'
        ,$PARTITION.PartFuncWeek(OrderDate) 'Partition'
FROM dbo.ExistingOrders
GROUP BY $PARTITION.PartFuncWeek(OrderDate) ;

SELECT name, value FROM SYS.partition_functions PF
INNER JOIN SYS.partition_range_values PFR ON PF.function_id = PFR.function_id
WHERE name = 'PARTFUNCWEEK' ;
