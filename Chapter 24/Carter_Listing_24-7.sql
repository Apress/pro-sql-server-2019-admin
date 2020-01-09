SELECT 
        rp.name ResourcePoolName
        ,wg.name WorkgroupName
        ,rp.total_cpu_usage_ms ResourcePoolCPUUsage
        ,wg.total_cpu_usage_ms WorkloadGroupCPUUsage
        ,CAST(ROUND(CASE
                WHEN rp.total_cpu_usage_ms = 0
                        THEN 100
                ELSE (wg.total_cpu_usage_ms * 1.) 
/ (rp.total_cpu_usage_ms * 1.) * 100 Percentage
                END, 3) AS FLOAT) WorkloadGroupPercentageOfResourcePool
FROM sys.dm_resource_governor_resource_pools rp
INNER JOIN sys.dm_resource_governor_workload_groups wg
        ON rp.pool_id = wg.pool_id
ORDER BY rp.pool_id ;
