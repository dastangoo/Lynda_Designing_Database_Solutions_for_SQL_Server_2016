-- Enable contained database on the server
sp_configure 'contained database authentication', 1;
GO 
RECONFIGURE;
GO

-- Create a new database for this example
CREATE DATABASE ContainedUserDB;
GO
USE ContainedUserDB;
GO

-- Create a basic table
CREATE TABLE Products(
	ProdcutID int
);
GO

USE master;
GO
ALTER DATABASE ContainedUserDB SET CONTAINMENT = PARTIAL;
GO

-- Create user
USE ContainedUserDB;
GO

CREATE USER Foxtrot
	with PASSWORD = 'abc123';
GO

-- Login to the instance as the contained user

-- Return as dbo
-- Clean up the instance 


USE tempdb;
GO
DROP DATABASE ContainedUserDB;
GO
sp_configure 'contained database authentication', 0;
GO
RECONFIGURE;
GO


