-- Create a new database for this example
CREATE DATABASE UpgradeDBExample;
GO
USE UpgradeDBExample;
GO

-- View the current location and of data and log files
SELECT name, physical_name, state_desc
FROM sys.master_files
WHERE database_id = DB_ID(N'UpgradeDBExample');
GO 

-- Detach the database from SQL Server
USE tempdb;
GO
EXEC sp_detach_db @dbname = N'UpgradeDBExample';
GO

-- Explore the Windows file system and relocate database files

-- Attach the database to a new instance 
CREATE DATABASE AttachDBExample 
	ON (FILENAME = 'C:\TempDatabases\UpgradeDBExample.mdf'), 
	(FILENAME = 'C:\TempDatabases\UpgradeDBExample_log.ldf') 
	FOR ATTACH;

SELECT name, physical_name, state_desc
FROM sys.master_files
WHERE database_id = DB_ID(N'AttachDBExample');
GO

USE tempdb
GO
DROP DATABASE AttachDBExample;
GO