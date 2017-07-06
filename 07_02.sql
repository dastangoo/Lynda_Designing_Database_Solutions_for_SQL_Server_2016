-- Create a new database for this example
CREATE DATABASE ConsoleCommandsDB;
GO
USE ConsoleCommandsDB;
GO
-- Create a basic table
CREATE TABLE dbo.Products (
	ProductID int IDENTITY(1,1) PRIMARY KEY,
	ProductName nvarchar(100) NOT NULL
);
GO

INSERT dbo.Products
	VALUES ('Mixed Nuts'),
		   ('Shelled Peanuts'),
		   ('Roasted Almonds');
GO
SELECT * FROM dbo.Products;
GO

-- Informational statements
DBCC USEROPTIONS;
GO

CREATE STATISTICS Products_ProductName
ON dbo.Products (ProductName);
GO
DBCC SHOW_STATISTICS ('dbo.Products', Products_ProductName);
GO
-- Validation statement
DBCC CHECKDB;
GO

-- Clean up the instance
USE tempdb;
GO 
DROP DATABASE ConsoleCommandsDB;
GO