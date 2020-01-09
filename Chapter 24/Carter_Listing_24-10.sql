ALTER RESOURCE POOL [default] WITH(
                min_iops_per_volume=50, 
                max_iops_per_volume=100) ;

ALTER RESOURCE GOVERNOR RECONFIGURE ;

SELECT 
        rp.name ResourcePoolName
        ,pv.volume_name 
        ,pv.read_io_stall_total_ms
        ,pv.write_io_stall_total_ms
        ,pv.read_io_stall_queued_ms
        ,pv.write_io_stall_queued_ms
        ,(pv.read_io_stall_total_ms + pv.write_io_stall_total_ms) 
            - (pv.read_io_stall_queued_ms + pv.write_io_stall_queued_ms) GovernorLatency
FROM sys.dm_resource_governor_resource_pool_volumes pv
RIGHT JOIN sys.dm_resource_governor_resource_pools rp
        ON pv.pool_id = rp.pool_id ;
