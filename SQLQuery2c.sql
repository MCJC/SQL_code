-- =============================================
-- Create database template
-- =============================================
USE master
GO

CREATE DATABASE fortest

CONTAINMENT = NONE

ON

   PRIMARY
   (  NAME           = N'fortest_d',
	  FILENAME       = N'<W:\data\fortest_d.mdf',
          SIZE       = 10MB,
          MAXSIZE    = UNLIMITED,
          FILEGROWTH = 35%
   )

   LOG ON
   (  NAME           = N'fortest_l',
	  FILENAME       = N'<W:\data\fortest_l.ldf',
          SIZE       = 10MB,
          MAXSIZE    = UNLIMITED,
          FILEGROWTH = 35%
   )

GO

