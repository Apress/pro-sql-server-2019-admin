SELECT 
  OBJECT_SCHEMA_NAME(HIS.OBJECT_ID) + '.' + OBJECT_NAME(HIS.OBJECT_ID) 'Table Name',
  I.name as 'Index Name', 
  HIS.total_bucket_count,
  HIS.empty_bucket_count,
  FLOOR((CAST(empty_bucket_count AS FLOAT)/total_bucket_count) * 100) 'Empty Bucket Percentage',
  total_bucket_count - empty_bucket_count 'Used Bucket Count',
  HIS.avg_chain_length, 
  HIS.max_chain_length
FROM sys.dm_db_xtp_hash_index_stats AS HIS
INNER JOIN sys.indexes AS I 
        ON HIS.object_id = I.object_id 
                AND HIS.index_id = I.index_id ;
