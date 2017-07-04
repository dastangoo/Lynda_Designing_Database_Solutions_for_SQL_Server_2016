-- Create a new database for this example
CREATE DATABASE MoveFileExample;
GO

USE MoveFileExample;
GO 

-- View the current location of data and log files 
SELECT name, physical_name, state_desc
FROM sys.master_files
WHERE database_id = DB_ID(N'MoveFileExample')
GO

-- Explore the Windows file system
-- Create a new location at C:\TempDatabases and move .mdf data file 
-- Specify a new location for the data file 

ALTER DATABASE MoveFileExample SET OFFLINE;
GO

ALTER DATABASE MoveFileExample MODIFY FILE ( NAME = 'MoveFileExample', FILENAME = 'C:\TempDatabases\MoveFileExample.mdf');
GO 

ALTER DATABASE MoveFileExample SET ONLINE;
GO 

-- Verify the new location of the data file 
SELECT name, physical_name AS CurrentLocation, state_desc
FROM sys.master_files
WHERE database_id = DB_ID(N'MoveFileExample');
GO

-- Review Windows file system
-- clean up the instance 
USE tempdb;
GO 
DROP DATABASE MoveFileExample;
GO 