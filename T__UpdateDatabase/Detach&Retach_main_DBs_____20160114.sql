/***************************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
/***     The following is a SQLCMD script which requires SQLCMD scripting mode to be enabled (from the toolbar icon or the Query menu)                       ***/
/***     Once SQLCMD scripting mode is enabled, this lists all files in the corresponding folder                                                             ***/
--	  !!dir/B /O "E:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA"
/***************************************************************************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*
               [forum]
               [forum_ResAnal]
               [RLS]
               [Stacy's]
               [XLSX]
                                                                                                                                                               */
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/
/* ---------------------------------------------------------------------------------------------------- */
/* ---------------------------------------------------------------------------------------------------- */
USE master;
GO
/* ---------------------------------------------------------------------------------------------------- */
/* ---------------------------------------------------------------------------------------------------- */
--ALTER DATABASE forum
--SET SINGLE_USER
--WITH ROLLBACK IMMEDIATE;
--GO
--EXEC sp_detach_db @dbname = N'forum';
--GO
/* ---------------------------------------------------------------------------------------------------- */
--ALTER DATABASE forum_ResAnal
--SET SINGLE_USER
--WITH ROLLBACK IMMEDIATE;
--GO
--EXEC sp_detach_db @dbname = N'forum_ResAnal';
--GO
/* ---------------------------------------------------------------------------------------------------- */
--ALTER DATABASE RLS
--SET SINGLE_USER
--WITH ROLLBACK IMMEDIATE;
--GO
--EXEC sp_detach_db @dbname = N'RLS';
--GO
/* ---------------------------------------------------------------------------------------------------- */
--ALTER DATABASE [Stacy's]
--SET SINGLE_USER
--WITH ROLLBACK IMMEDIATE;
--GO
--EXEC sp_detach_db @dbname = N'Stacy''s';
--GO
/* ---------------------------------------------------------------------------------------------------- */
--ALTER DATABASE XLSX
--SET SINGLE_USER
--WITH ROLLBACK IMMEDIATE;
--GO
--EXEC sp_detach_db @dbname = N'XLSX';
--GO
/* ---------------------------------------------------------------------------------------------------- */
/* ---------------------------------------------------------------------------------------------------- */
/* manually copy files */
/*
EXEC master.dbo.xp_cmdshell
'COPY E:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\forum.mdf       N:\JCEO_data\F2014\forum.mdf'
EXEC master.dbo.xp_cmdshell
'COPY E:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\forum_Log.ldf   N:\JCEO_data\F2014\forum_Log.ldf'
*/
/* ---------------------------------------------------------------------------------------------------- */
/* ---------------------------------------------------------------------------------------------------- */
--CREATE DATABASE [forum]
--    ON (FILENAME = 'E:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\forum.mdf')
--      ,(FILENAME = 'E:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\forum_Log.ldf')
--    FOR ATTACH; 
--GO
--ALTER DATABASE [forum]
--SET MULTI_USER;
--GO
/* ---------------------------------------------------------------------------------------------------- */
--CREATE DATABASE [forum_ResAnal]
--    ON (FILENAME = 'E:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\forum_ResAnal.mdf')
--      ,(FILENAME = 'E:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\forum_ResAnal_Log.ldf') 
--    FOR ATTACH; 
--GO
--ALTER DATABASE [forum_ResAnal]
--SET MULTI_USER;
--GO
/* ---------------------------------------------------------------------------------------------------- */
--CREATE DATABASE [RLS]
--    ON (FILENAME = 'E:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\RLS.mdf')
--      ,(FILENAME = 'E:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\RLS_Log.ldf') 
--    FOR ATTACH; 
--GO
--ALTER DATABASE [RLS]
--SET MULTI_USER;
--GO
/* ---------------------------------------------------------------------------------------------------- */
--CREATE DATABASE [Stacy's]
--    ON (FILENAME = 'E:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Stacy''s.mdf')
--      ,(FILENAME = 'E:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Stacy''s_log.ldf') 
--    FOR ATTACH; 
--GO
--ALTER DATABASE [Stacy's]
--SET MULTI_USER;
--GO
/* ---------------------------------------------------------------------------------------------------- */
--CREATE DATABASE [XLSX]
--    ON (FILENAME = 'E:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\XLSX.mdf')
--      ,(FILENAME = 'E:\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\XLSX_log.ldf') 
--    FOR ATTACH; 
--GO
--ALTER DATABASE [XLSX]
--SET MULTI_USER;
--GO
/* ---------------------------------------------------------------------------------------------------- */

