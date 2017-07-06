-- Create a new database for this example
CREATE DATABASE StoredProcDB;
GO
USE StoredProcDB;
GO
-- Create a table
CREATE TABLE dbo.Orders (
	OrderNumber int PRIMARY KEY);
GO

-- Create a stored procedure to insert values 
CREATE PROCEDURE dbo.InsertRecords
AS 
DECLARE @i int
SET @i = 100
WHILE @i > 0
	BEGIN  
		INSERT dbo.Orders VALUES (@i)
		SET @i -= 1
	END;
GO

EXECUTE dbo.InsertRecords;
GO

-- View the contents of the table
SELECT * FROM dbo.Orders;

-- Clean up the instance
USE tempdb;
GO
DROP DATABASE StoredProcDB;
GO
