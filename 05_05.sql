-- Create a new database for this example
CREATE DATABASE StoreProcedureParameterDB;
GO
USE StoreProcedureParameterDB;
GO

-- Create a disk based table
CREATE TABLE dbo.Orders (
	OrderNumber int);
GO

-- Create a stored precedure with an input parameter
CREATE PROCEDURE dbo.InsertVariableRecords
	@paramQuantity smallint
AS  
DECLARE @i int = @paramQuantity
WHILE @i > 0
	BEGIN 
		INSERT dbo.Orders VALUES (@i)
		SET @i -= 1
	END;
GO

EXECUTE dbo.InsertVariableRecords 2;
GO

SELECT * FROM dbo.Orders
ORDER BY OrderNumber;
GO

-- Create a stroed procedure with input and output parameters
CREATE PROCEDURE dbo.CountRecords
	@OrderNumber int,
	@CountOfOrders int OUTPUT
AS
	SELECT @CountOfOrders = COUNT(OrderNumber)
	FROM dbo.Orders
	WHERE OrderNumber = @OrderNumber;
RETURN;
GO

-- Declare the variable to receive the output value of the procedure
DECLARE @ViewOutput int;
EXECUTE dbo.CountRecords 5, @CountOfOrders = @ViewOutput OUTPUT;
PRINT @ViewOutput;
GO

-- Clean up the instance
USE tempdb;
GO
DROP DATABASE StoreProcedureParameterDB;
GO
