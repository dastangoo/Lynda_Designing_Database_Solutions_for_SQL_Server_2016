-- Create a new database for this example
CREATE DATABASE ActivityMonitorDB;
GO
USE ActivityMonitorDB;
GO
-- Create a basic table and enter records
CREATE TABLE dbo.Products (
	ProductID int IDENTITY(1,1) PRIMARY KEY,
	ProductName nvarchar(100) NOT NULL
);
GO

DECLARE @i int
SET @i = 500
WHILE @i > 0
BEGIN
	INSERT dbo.Products
		VALUES ('Mixed Nuts'),
			   ('Shelled Peanuts'),
			   ('Roasted Almonds')
	SET @i -= 1
END;
GO

SELECT * FROM dbo.Products
WHERE ProductName = 'Roasted Almonds' OR ProductName = 'MixedNuts'
ORDER BY ProductName DESC
GO