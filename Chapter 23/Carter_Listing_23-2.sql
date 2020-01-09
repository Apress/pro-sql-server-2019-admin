SELECT 
       name ,
           'Yes' AS on_demand,
       CASE
           WHEN (CONVERT(BIT, execution_mode & 4)) = 1 
           THEN 'Yes'
           ELSE 'No' 
           END  AS on_schedule,
           CASE
           WHEN (CONVERT(BIT, execution_mode & 2)) = 1 
           THEN 'Yes'
           ELSE 'No' 
           END  AS on_change_log,
       CASE
           WHEN (CONVERT(BIT, execution_mode & 1)) = 1 
           THEN 'Yes'
           ELSE 'No' 
           END  AS on_change_prevent
FROM msdb.dbo.syspolicy_management_facets ;
