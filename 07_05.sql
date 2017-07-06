SELECT * FROM sys.dm_os_wait_stats
ORDER BY wait_time_ms DESC; 

DBCC SQLPERF ('sys.dm_os_wait_stats', CLEAR)