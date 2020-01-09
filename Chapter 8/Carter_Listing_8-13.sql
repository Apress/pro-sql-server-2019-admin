USE Chapter8
GO

SELECT 
i.name
,IPS.index_type_desc
,IPS.index_level
,IPS.avg_fragmentation_in_percent
,IPS.avg_page_space_used_in_percent
,i.fill_factor
,CASE 
    WHEN i.fill_factor = 0 
        THEN 100-IPS.avg_page_space_used_in_percent 
    ELSE i.fill_factor-ips.avg_page_space_used_in_percent 
END Internal_Frag_With_Fillfactor_Offset
,IPS.fragment_count
,IPS.avg_fragment_size_in_pages
FROM sys.dm_db_index_physical_stats(DB_ID('Chapter8'),OBJECT_ID('dbo.OrdersDisc'),NULL,NULL,'DETAILED') IPS
INNER JOIN sys.indexes i
        ON IPS.Object_id = i.object_id
                AND IPS.index_id = i.index_id ;
