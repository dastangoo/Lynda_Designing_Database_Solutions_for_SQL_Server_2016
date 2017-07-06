-- Create a new database for this example
CREATE DATABASE EncryptDataDB;
GO
USE EncryptDataDB;
GO

-- Create a basic table
CREATE TABLE Employees (
	EmployeeID int IDENTITY(1000,1) PRIMARY KEY,
	Name nvarchar(100) NOT NULL,
	Phone nvarchar(8) NULL,
	SocialSecurityNumber char(11)
);
GO
INSERT Employees
	VALUES ('Malcolm', '555-0123', '123-00-9812'),
		   ('Rory', '555-1234', '123-00-2154'),
		   ('Brianne', '555-7890', '123-00-5081');
GO
SELECT * FROM Employees;
GO

-- Encrypt data in Object Explorer

-- View unencrypted data with certificate 

-- Clean up the instance
 
