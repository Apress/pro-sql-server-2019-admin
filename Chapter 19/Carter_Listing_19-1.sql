SELECT DISTINCT map_value AS Category
FROM sys.dm_xe_map_values map
WHERE map.name = 'keyword_map'
ORDER BY map.map_value
