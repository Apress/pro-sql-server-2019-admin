--Compress partition 1 with ROW compression

ALTER TABLE ExistingOrders
    REBUILD PARTITION = 1 WITH (DATA_COMPRESSION = ROW) ;
GO

--Remove compression from the whole table

ALTER TABLE ExistingOrders
    REBUILD WITH (DATA_COMPRESSION = NONE) ;
