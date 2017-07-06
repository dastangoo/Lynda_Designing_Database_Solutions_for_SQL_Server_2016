-- Create a new database for this example
CREATE DATABASE TableExpressionsDB;
GO
USE TableExpressionsDB;
GO
-- Create a table and populate values
CREATE TABLE Sales (
	EmployeeName nvarchar(100) NOT NULL,
	SalesYear smallint,
	SalesAmount smallmoney
);
GO
INSERT Sales
	VALUES ('Malcolm', '2012', 15648),
		   ('Rory', '2012', 48094),
		   ('Malcolm', '2013', 89048),
		   ('Rory', '2013', 80460),
		   ('Brianne', '2013', 26047),
		   ('Malcolm', '2014', 90596),
		   ('Rory', '2014', 65044),
		   ('Brianne', '2014', 90504),
		   ('Malcolm', '2015', 60507),
		   ('Rory', '2015', 14425),
		   ('Brianne', '2015', 84287),
		   ('Malcolm', '2016', 21461),
		   ('Rory', '2016', 84205),
		   ('Brianne', '2016', 54852)
;
GO
SELECT * FROM Sales;
GO

-- Find the average sales amount for each year
SELECT SalesYear, AVG(SalesAmount) AS AverageSales
FROM Sales
GROUP BY SalesYear;
GO

-- Use those values in a common table expression
WITH TotalSales_CTE (SalesYear, AverageSales)
AS
(
	SELECT SalesYear, AVG(SalesAmount)
	FROM Sales
	GROUP BY SalesYear
)
SELECT Sales.EmployeeName, Sales.SalesYear, Sales.SalesAmount, TotalSales_CTE.AverageSales,
	(Sales.SalesAmount - TotalSales_CTE.AverageSales) AS Difference
FROM Sales
	INNER JOIN TotalSales_CTE
	ON Sales.SalesYear = TotalSales_CTE.SalesYear
ORDER BY Sales.SalesYear DESC, Sales.EmployeeName;
GO