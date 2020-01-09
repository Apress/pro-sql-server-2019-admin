DECLARE @MemOption1 INT = (SELECT physical_memory_kb/1024 - 2048 FROM sys.dm_os_sys_info)
DECLARE @MemOption2 INT = (SELECT ((physical_Memory_kb/1024)/8) * 7 FROM sys.dm_os_sys_info)

IF @MemOption1 <= 0
BEGIN
        EXEC sys.sp_configure 'min server memory (MB)', @MemOption2
        EXEC sys.sp_configure 'max server memory (MB)', @MemOption2
        RECONFIGURE
END
ELSE IF @MemOption2 < @MemOption1
BEGIN
        EXEC sys.sp_configure 'min server memory (MB)', @MemOption2
        EXEC sys.sp_configure 'max server memory (MB)', @MemOption2
        RECONFIGURE
END
ELSE
BEGIN
        EXEC sys.sp_configure 'min server memory (MB)', @MemOption1
        EXEC sys.sp_configure 'max server memory (MB)', @MemOption1
        RECONFIGURE
END
