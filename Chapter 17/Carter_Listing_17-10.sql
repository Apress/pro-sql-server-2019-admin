DECLARE @fixeddrives TABLE
(
Drive        CHAR(1),
MBFree        BIGINT
) ;

INSERT INTO @fixeddrives
EXEC xp_fixeddrives ;

SELECT 
    Drive
    ,SUM([File Space Used (MB)]) TotalSpaceUsed
    , SUM([Next Growth Amount (MB)]) TotalNextGrowth
    , SpaceLeftOnVolume
FROM (
SELECT Drive
        ,size * 1.0 / 128 [File Space Used (MB)]
        ,CASE
                WHEN is_percent_growth = 0
                        THEN growth * 1.0 / 128
                WHEN is_percent_growth = 1
                        THEN (size * 1.0 / 128 * growth / 100)
                END [Next Growth Amount (MB)]
        ,f.MBFree SpaceLeftOnVolume
FROM sys.master_files m
INNER JOIN @fixeddrives f
        ON LEFT(m.physical_name, 1) = f.Drive ) a
GROUP BY Drive, SpaceLeftOnVolume
ORDER BY drive ;        
