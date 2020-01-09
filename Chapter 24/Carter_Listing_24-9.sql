ALTER RESOURCE POOL [Default] WITH(AFFINITY SCHEDULER = (0)) ;

ALTER RESOURCE GOVERNOR RECONFIGURE ;

SELECT 
        rp.name ResourcePoolName
        ,pa.scheduler_mask
FROM sys.dm_resource_governor_resource_pool_affinity pa
INNER JOIN sys.dm_resource_governor_resource_pools rp
        ON pa.pool_id = rp.pool_id ;
