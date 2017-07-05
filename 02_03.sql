-- Create a new database for this example
CREATE DATABASE TopSecretDB;
GO
USE master;
GO
-- Create master key and certificate 
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '1StrongPassword';
GO

CREATE CERTIFICATE TopSecretDBCert
	WITH SUBJECT = 'TopSecretDB Backup Certificate';
GO 

BACKUP CERTIFICATE TopSecretDBCert TO FILE = 'C:\TempDatabases\TopSecretDBCert.cert'
WITH PRIVATE KEY (
FILE = 'C:\TempDatabases\TopSecretDBCert.key',
ENCRYPTION BY PASSWORD = 'abc123')

-- Backup database with encryption
BACKUP DATABASE TopSecretDB
TO DISK = 'C:\TempDatabases\TopSecretDB.bak'
WITH ENCRYPTION (ALGORITHM = AES_256, SERVER CERTIFICATE = TopSecretDBCert)

-- Clean up the instance
DROP DATABASE TopSecretDB;
GO
DROP CERTIFICATE TopSecretDBCert;
GO

-- Restore the database from backup
RESTORE DATABASE TopSecretDB
FROM DISK = 'C:\TempDatabases\TopSecretDB.bak'; 
GO

CREATE CERTIFICATE TopSecretDBCert
FROM FILE = 'C:\TempDatabases\TopSecretDBCert.cert'
WITH PRIVATE KEY (FILE = 'C:\TempDatabases\TopSecretDBCert.key',
DECRYPTION BY PASSWORD = 'abc123');
GO

-- Attempt the restore again

-- Clean up the instance
DROP DATABASE TopSecretDB;
GO
DROP CERTIFICATE TopSecretDBCert;
GO
