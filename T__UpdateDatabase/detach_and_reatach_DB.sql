-----------------------------------------------------------------------------------------------------------------------------------------------
-- Detach/Attach a database
-- that is currently not in use
-- from a server instance
-- to from a server instance
-- optionally UPDATE STATISTICS on all tables before detaching.
-----------------------------------------------------------------------------------------------------------------------------------------------
USE master;
-----------------------------------------------------------------------------------------------------------------------------------------------
-- Detaching a database requires exclusive access to the database
-- Set the database to SINGLE_USER mode to obtain exclusive access
-- (after all current users disconnect from the database)
ALTER DATABASE                            for_d
SET SINGLE_USER
WITH ROLLBACK IMMEDIATE;                              -- force current users out of the database immediately
GO
-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------
-- Syntax
EXEC 
sp_detach_db   @dbname                 = 'for_d'      -- (is a sysname value) name of the database to be detached
             , @skipchecks             = 'true'       -- skip UPDATE STATISTIC
--           , @keepfulltextindexfile  = 'true'       -- default 'true' and can be set to 'false' (removed in future version of SQL Server)
-----------------------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------------------------------------
-- Syntax (removed in future version of SQL Server)
EXEC 
sp_attach_db   @dbname                 = 'for_d'      -- name of the database to be attached: must be unique
             , @filename1              = 'F:\data\for_d.mdf'     -- physical name, including path, of a database file.
             , @filename2              = 'F:\data\for_d_log.ldf' -- physical name, including path, of a database file.
             ;
/*
The detached files can be reattached by using CREATE DATABASE (with the FOR ATTACH or FOR ATTACH_REBUILD_LOG option).
The files can be moved to another server and attached there. 
Permissions: Requires membership in the sysadmin fixed server role. 

--=====================================
-- Attach database template
--=====================================
IF NOT EXISTS(
  SELECT *
    FROM sys.databases
   WHERE name = N'<database_name, sysname, your_database_name>'
)
	CREATE DATABASE <database_name, sysname, your_database_name>
		ON PRIMARY (FILENAME = '<database_primary_file_path,,C:\Program files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\your_database_name.MDF>')
		FOR ATTACH
GO
*/