-- Create a new database for this example
CREATE DATABASE TailLogDB;
GO
USE TailLogDB;
GO 
-- Insert some data
CREATE TABLE People (
	PersonID int IDENTITY(1000, 1) PRIMARY KEY NOT NULL,
	PersonValue int
);
GO
CREATE PROCEDURE InsertPeople
AS 
DECLARE @i int
SET @i = 100
WHILE @i > 0
	BEGIN
		INSERT People (PersonValue) VALUES (@i)
		SET @i -= 1
	END
EXECUTE InsertPeople;
GO
SELECT * FROM People;
GO

-- Create a full backup
BACKUP DATABASE TailLogDB
TO DISK = 'C:\TempDatabases\TailLogDB_FULL.bak'

-- Take TailLogDB offline
-- Delete .mdf data file from the hard drive

USE master;
GO

-- Create a tail-log backup
BACKUP LOG TailLogDB
TO DISK = 'C:\TempDatabases\TailLogDB.log'
WITH CONTINUE_AFTER_ERROR;
GO

-- Attempt to take TailLogDB online

-- Restore the database
USE master
RESTORE DATABASE TailLogDB
FROM DISK = 'C:\TempDatabases\TailLogDB_FULL.bak'
WITH NORECOVERY;
GO

RESTORE LOG TailLogDB
FROM DISK = 'C:\TempDatabases\TailLogDB.log';
GO

USE TailLogDB
SELECT * FROM People;
GO

USE tempdb;
GO
DROP DATABASE TailLogDB;
GO