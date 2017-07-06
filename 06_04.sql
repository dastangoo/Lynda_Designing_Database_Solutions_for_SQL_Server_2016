-- Create a new database for this example
CREATE DATABASE OwnershipDB;
GO
USE OwnershipDB;
GO

-- Create a schema 
CREATE SCHEMA Inventory AUTHORIZATION dbo;
GO

-- Create a basic table
CREATE TABLE Inventory.Products (
	ProductID int IDENTITY(1,1) PRIMARY KEY,
	ProductName nvarchar(100) NOT NULL
);
GO

INSERT Inventory.Products
	VALUES ('Mixed Nuts'),
		   ('Shelled Peanuts'),
		   ('Roasted Almonds');
GO

SELECT * FROM Inventory.Products;
GO

-- Create user and switch security context
CREATE USER Charlie WITHOUT LOGIN;
GO

-- Access objects 
EXECUTE AS USER = 'Charlie';
GO
SELECT USER_NAME();
GO
SELECT * FROM Inventory.Products;
GO
-- Return to dbo
REVERT;
GO
SELECT USER_NAME();
GO

-- Translate ownership of schema to Charlie
ALTER AUTHORIZATION ON SCHEMA::Inventory TO Charlie;
GO
-- Verify ownership
SELECT schema_name, schema_owner
FROM information_schema.SCHEMATA;
GO

-- Test ownership permissions
EXECUTE AS USER = 'Charlie';
GO
SELECT USER_NAME();
GO
SELECT * FROM Inventory.Products;
GO

INSERT Inventory.Products
	VALUES ('Salted Cashews');
GO

SELECT * FROM Inventory.Products;
GO


-- Return to dbo
REVERT;
GO
DENY SELECT ON Inventory.Products TO Charlie;
GO

-- Clean up the instance
REVERT;
GO
USE tempdb;
GO
DROP DATABASE OwnershipDB;
GO
