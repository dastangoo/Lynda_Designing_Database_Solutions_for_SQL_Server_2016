-- Create a new database for this example
CREATE DATABASE ErrorHandlingDB;
GO
USE ErrorHandlingDB;
GO 

-- Create a table
CREATE TABLE Products (
	ProductID int PRIMARY KEY,
	ProductName char(20),
	ExpirationDate Datetime
	CHECK (ExpirationDate >= '2017-01-01')
); 
GO

-- Create a stored procedure with an input parameter
CREATE PROCEDURE InsertProducts
	@paramID int,
	@paramName char(20),
	@paramExpiration datetime
AS
	INSERT Products
	VALUES (@paramID, @paramName, @paramExpiration);
GO

-- use procedure to insert a product
EXECUTE InsertProducts 10, 'Salted Peanuts', '2017-01-02';
GO

-- View the contents of the table
SELECT * FROM Products;
GO

-- Attempt insert of second product with errors:
-- Duplicate key
EXECUTE InsertProducts 10, 'Roasted Almonds', '2017-01-02';
-- Failed check constraint
EXECUTE InsertProducts 20, 'Roasted Almonds', '2016-01-02';

-- Alter stored procedure to incorporate error handling
ALTER PROCEDURE InsertProducts
	@paramID int,
	@paramName char(20),
	@paramExpiration datetime
AS
BEGIN TRY
	INSERT Products
	VALUES (@paramID, @paramName, @paramExpiration);
END TRY
BEGIN CATCH
	IF ERROR_NUMBER() = 2627 PRINT 'Dupblicate ProdcutID found'
	ELSE IF ERROR_NUMBER() = 547 PRINT 'The Expiration Date must be after Jan 1, 2016'
	ELSE PRINT 'An unknown error occured. Please check your values and try again.'
END CATCH
GO

-- Clean up the instance
USE tempdb;
GO
DROP DATABASE ErrorHandlingDB;
GO