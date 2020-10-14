EXEC sp_configure 'CONTAINED DATABASE AUTHENTICATION', 1
GO
RECONFIGURE
GO
CREATE DATABASE db;
GO
USE [master]
GO
ALTER DATABASE [db] SET CONTAINMENT = PARTIAL
GO
ALTER DATABASE db
    SET ALLOW_SNAPSHOT_ISOLATION ON
ALTER DATABASE db
    SET READ_COMMITTED_SNAPSHOT ON
GO

USE db;
GO
CREATE SCHEMA reproducer
GO
CREATE USER app_reproducer WITH PASSWORD='abcABC123'
GO
ALTER USER app_reproducer WITH DEFAULT_SCHEMA = reproducer

GRANT SELECT, UPDATE, DELETE, INSERT, REFERENCES ON SCHEMA::reproducer TO app_reproducer
GRANT CREATE TABLE TO app_reproducer
GRANT CREATE VIEW TO app_reproducer
GRANT ALTER ON SCHEMA::reproducer TO app_reproducer
GRANT SHOWPLAN TO app_reproducer

SELECT is_read_committed_snapshot_on, snapshot_isolation_state_desc, snapshot_isolation_state FROM sys.databases WHERE name = 'db'
GO
