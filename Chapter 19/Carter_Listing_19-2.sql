--Retrieve list of predicate comparators

SELECT name
        ,description, 
    (SELECT name 
                FROM sys.dm_xe_packages 
                WHERE guid = xo.package_guid) Package 
FROM sys.dm_xe_objects xo 
WHERE object_type = 'pred_compare' 
ORDER BY name ;

--Retrieve list of predicate sources

SELECT name
        ,description, 
    (SELECT name 
                FROM sys.dm_xe_packages 
                WHERE guid = xo.package_guid) Package 
FROM sys.dm_xe_objects xo 
WHERE object_type = 'pred_source' 
ORDER BY name ;
