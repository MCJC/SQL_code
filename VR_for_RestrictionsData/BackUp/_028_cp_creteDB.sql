USE [master]
GO
/**************************************************************************************************************************************************/
/***                                                                                                                                            ***/
/***      Create working database for GR&SH R                                                                                                   ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
CREATE DATABASE [GRSHRcode];
GO
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
 ALTER DATABASE [GRSHRcode] SET RECOVERY SIMPLE 
GO





/*********************************************************     >>>>>> extract year to be used                                                   ***/
/**************************************************************************************************************************************************/
DECLARE @CrY    varchar( 4)                               /***        declare variable for storing current YEAR (as text)                       ***/
SET     @CrY  =(SELECT STR(MAX(Question_Year)+3, 4,0)     /***        set value to current year ( coded yr + 1[yr to be coded[ + 1[current]     ***/
                FROM  [forum].[dbo].[Pew_Q&A]             /***        extracted frm Q&A lookup table                                            ***/
                WHERE [Pew_Data_Collection]               /***        filtering,,,                                                              ***/
                = 'Global Restriction on Religion Study') /***        restrictions data                                                         ***/
/**************************************************************************************************************************************************/
declare @CODEmain nvarchar(max)                           /***        declare variable for storing the main code to be executed                 ***/
set     @CODEmain =                                       /***        start storing text as part of the main code to be executed                ***/
/*********************************************************     >>>>>> this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the code to be executed                                           ***/
/*********************************************************     >>>>>> extract year to be used                                                   ***/
/**************************************************************************************************************************************************/
DECLARE @CrY    varchar( 4)                               /***        declare variable for storing current YEAR (as text)                       ***/
SET     @CrY  =(SELECT STR(MAX(Question_Year)+3, 4,0)     /***        set value to current year ( coded yr + 1[yr to be coded[ + 1[current]     ***/
                FROM  [forum].[dbo].[Pew_Q&A]             /***        extracted frm Q&A lookup table                                            ***/
                WHERE [Pew_Data_Collection]               /***        filtering,,,                                                              ***/
                = 'Global Restriction on Religion Study') /***        restrictions data                                                         ***/
/**************************************************************************************************************************************************/
declare @CODEmain nvarchar(max)                           /***        declare variable for storing the main code to be executed                 ***/
set     @CODEmain =                                       /***        start storing text as part of the main code to be executed                ***/
/*********************************************************     >>>>>> this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the code to be executed                                           ***/
N'
CREATE DATABASE [GRSHR' + @CrY + '];
 ALTER DATABASE [GRSHR' + @CrY + '] SET RECOVERY SIMPLE 
'
/*********************************************************     <<<<<  this has been the code to be execute                                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
GO


/*********************************************************     >>>>>> extract year to be used                                                   ***/
/**************************************************************************************************************************************************/
DECLARE @CrY    varchar( 4)                               /***        declare variable for storing current YEAR (as text)                       ***/
SET     @CrY  =(SELECT STR(MAX(Question_Year)+3, 4,0)     /***        set value to current year ( coded yr + 1[yr to be coded[ + 1[current]     ***/
                FROM  [forum].[dbo].[Pew_Q&A]             /***        extracted frm Q&A lookup table                                            ***/
                WHERE [Pew_Data_Collection]               /***        filtering,,,                                                              ***/
                = 'Global Restriction on Religion Study') /***        restrictions data                                                         ***/
/**************************************************************************************************************************************************/
declare @CODEmain nvarchar(max)                           /***        declare variable for storing the main code to be executed                 ***/
set     @CODEmain =                                       /***        start storing text as part of the main code to be executed                ***/
/*********************************************************     >>>>>> this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the code to be executed                                           ***/
N'
CREATE DATABASE [GRSHR' + @CrY + '];
 ALTER DATABASE [GRSHR' + @CrY + '] SET RECOVERY SIMPLE 
'
/*********************************************************     <<<<<  this has been the code to be execute                                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
GO


/*********************************************************     >>>>>> extract year to be used                                                   ***/
/**************************************************************************************************************************************************/
DECLARE @CrY    varchar( 4)                               /***        declare variable for storing current YEAR (as text)                       ***/
SET     @CrY  =(SELECT STR(MAX(Question_Year)+3, 4,0)     /***        set value to current year ( coded yr + 1[yr to be coded[ + 1[current]     ***/
                FROM  [forum].[dbo].[Pew_Q&A]             /***        extracted frm Q&A lookup table                                            ***/
                WHERE [Pew_Data_Collection]               /***        filtering,,,                                                              ***/
                = 'Global Restriction on Religion Study') /***        restrictions data                                                         ***/
/**************************************************************************************************************************************************/
declare @CODEmain nvarchar(max)                           /***        declare variable for storing the main code to be executed                 ***/
set     @CODEmain =                                       /***        start storing text as part of the main code to be executed                ***/
/*********************************************************     >>>>>> this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the code to be executed                                           ***/
N'
CREATE DATABASE [GRSHR' + @CrY + '];
 ALTER DATABASE [GRSHR' + @CrY + '] SET RECOVERY SIMPLE 
'
/*********************************************************     <<<<<  this has been the code to be execute                                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
GO


/*********************************************************     >>>>>> extract year to be used                                                   ***/
/**************************************************************************************************************************************************/
DECLARE @CrY    varchar( 4)                               /***        declare variable for storing current YEAR (as text)                       ***/
SET     @CrY  =(SELECT STR(MAX(Question_Year)+3, 4,0)     /***        set value to current year ( coded yr + 1[yr to be coded[ + 1[current]     ***/
                FROM  [forum].[dbo].[Pew_Q&A]             /***        extracted frm Q&A lookup table                                            ***/
                WHERE [Pew_Data_Collection]               /***        filtering,,,                                                              ***/
                = 'Global Restriction on Religion Study') /***        restrictions data                                                         ***/
/**************************************************************************************************************************************************/
declare @CODEmain nvarchar(max)                           /***        declare variable for storing the main code to be executed                 ***/
set     @CODEmain =                                       /***        start storing text as part of the main code to be executed                ***/
/*********************************************************     >>>>>> this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the code to be executed                                           ***/
N'
CREATE DATABASE [GRSHR' + @CrY + '];
 ALTER DATABASE [GRSHR' + @CrY + '] SET RECOVERY SIMPLE 
'
/*********************************************************     <<<<<  this has been the code to be execute                                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
GO


/*********************************************************     >>>>>> extract year to be used                                                   ***/
/**************************************************************************************************************************************************/
DECLARE @CrY    varchar( 4)                               /***        declare variable for storing current YEAR (as text)                       ***/
SET     @CrY  =(SELECT STR(MAX(Question_Year)+3, 4,0)     /***        set value to current year ( coded yr + 1[yr to be coded[ + 1[current]     ***/
                FROM  [forum].[dbo].[Pew_Q&A]             /***        extracted frm Q&A lookup table                                            ***/
                WHERE [Pew_Data_Collection]               /***        filtering,,,                                                              ***/
                = 'Global Restriction on Religion Study') /***        restrictions data                                                         ***/
/**************************************************************************************************************************************************/
declare @CODEmain nvarchar(max)                           /***        declare variable for storing the main code to be executed                 ***/
set     @CODEmain =                                       /***        start storing text as part of the main code to be executed                ***/
/*********************************************************     >>>>>> this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the code to be executed                                           ***/
N'
CREATE DATABASE [GRSHR' + @CrY + '];
 ALTER DATABASE [GRSHR' + @CrY + '] SET RECOVERY SIMPLE 
'
/*********************************************************     <<<<<  this has been the code to be execute                                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
GO


/*********************************************************     >>>>>> extract year to be used                                                   ***/
/**************************************************************************************************************************************************/
DECLARE @CrY    varchar( 4)                               /***        declare variable for storing current YEAR (as text)                       ***/
SET     @CrY  =(SELECT STR(MAX(Question_Year)+3, 4,0)     /***        set value to current year ( coded yr + 1[yr to be coded[ + 1[current]     ***/
                FROM  [forum].[dbo].[Pew_Q&A]             /***        extracted frm Q&A lookup table                                            ***/
                WHERE [Pew_Data_Collection]               /***        filtering,,,                                                              ***/
                = 'Global Restriction on Religion Study') /***        restrictions data                                                         ***/
/**************************************************************************************************************************************************/
declare @CODEmain nvarchar(max)                           /***        declare variable for storing the main code to be executed                 ***/
set     @CODEmain =                                       /***        start storing text as part of the main code to be executed                ***/
/*********************************************************     >>>>>> this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the code to be executed                                           ***/
N'
CREATE DATABASE [GRSHR' + @CrY + '];
 ALTER DATABASE [GRSHR' + @CrY + '] SET RECOVERY SIMPLE 
'
/*********************************************************     <<<<<  this has been the code to be execute                                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
GO


/*********************************************************     >>>>>> extract year to be used                                                   ***/
/**************************************************************************************************************************************************/
DECLARE @CrY    varchar( 4)                               /***        declare variable for storing current YEAR (as text)                       ***/
SET     @CrY  =(SELECT STR(MAX(Question_Year)+3, 4,0)     /***        set value to current year ( coded yr + 1[yr to be coded[ + 1[current]     ***/
                FROM  [forum].[dbo].[Pew_Q&A]             /***        extracted frm Q&A lookup table                                            ***/
                WHERE [Pew_Data_Collection]               /***        filtering,,,                                                              ***/
                = 'Global Restriction on Religion Study') /***        restrictions data                                                         ***/
/**************************************************************************************************************************************************/
declare @CODEmain nvarchar(max)                           /***        declare variable for storing the main code to be executed                 ***/
set     @CODEmain =                                       /***        start storing text as part of the main code to be executed                ***/
/*********************************************************     >>>>>> this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the code to be executed                                           ***/
N'
CREATE DATABASE [GRSHR' + @CrY + '];
 ALTER DATABASE [GRSHR' + @CrY + '] SET RECOVERY SIMPLE 
'
/*********************************************************     <<<<<  this has been the code to be execute                                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
GO


N'
CREATE DATABASE [GRSHR' + @CrY + '];
 ALTER DATABASE [GRSHR' + @CrY + '] SET RECOVERY SIMPLE 
'
/*********************************************************     <<<<<  this has been the code to be execute                                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
GO



/*********************************************************     <<<<<  this has been the code to be execute                                      ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEmain                          /***        display the currently stored code (to be executed)                        ***/
	EXEC              (@CODEmain)                         /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
GO









/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  cursor                                                                    ***/
DECLARE @CODEmain1 nvarchar(max)                          /***        declare variable for storing code during each data retreival              ***/
DECLARE @tablename nvarchar(max)                          /***        declare variable for storing data from cursor                             ***/
DECLARE MyCursor   CURSOR FOR                             /*** >>>>   declare cursor to take values from the following select sataement         ***/
/**************************************************************************************************************************************************/
SELECT      [TABLE_NAME]                                  /*** >>>    select table names                                                        ***/
FROM        [INFORMATION_SCHEMA].[TABLES]                 /***        from the system view listing tables & views in the database               ***/
WHERE       [TABLE_TYPE] = 'BASE TABLE'                   /*** <<<    filter to display only tables (excluding views)                           ***/
/**************************************************************************************************************************************************/
OPEN             MyCursor                                 /*** >>>    open cursor by its name                                                   ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @tablename                               /***        store it into the corresponding variable(s)                               ***/
          WHILE  @@FETCH_STATUS = 0                       /***        while the status of the last retreival has been successful                ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
BEGIN                                                     /*** >>     BEGIN the procedures using values of each row of the cursor               ***/



--IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vrc_01_DB_Long_NoAggregated]', N'U') IS NOT NULL

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * ---	INTO [#vrc_01_DB_Long_NoAggregated]
FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
/***  Basic Data: Long NPR ******************************************************************************************/
----------------------------------------------------------------------------------------------------------------------
/*** Set of data at country level ***********************************************************************************/

) AS NPR
/***************************************************************************************************************************************************************/
WHERE
/* filters */
Ctry_EditorialName                                   != 'North Korea'                   /* Excluded from the analysis */
AND
Ctry_EditorialName + '_/_' + STR(Question_Year, 4,0) != 'South Sudan_/_2010'            /* although data are not aggregated for the other part of former Sudan */
/* filters */
AND
                             STR(Question_Year, 4,0)  =               '2013'            /* although data are not aggregated for the other part of former Sudan */
/***************************************************************************************************************************************************************/
GO



CREATE DATABASE [GRSHR2015] ON  PRIMARY 


USE master;
GO
CREATE DATABASE mytest;
GO
-- Verify the database files and sizes
SELECT name, size, size*1.0/128 AS [Size in MBs] 
FROM sys.master_files
WHERE name = N'mytest';
GO


/****** Object:  Database [GRSHR2015]    Script Date: 08/04/2015 16:45:30 ******/
CREATE DATABASE [GRSHR2015] ON  PRIMARY 
( NAME = N'GRSHR2015', FILENAME = N'E:\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\GRSHR2015.mdf' , SIZE = 218112KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'GRSHR2015_log', FILENAME = N'E:\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\GRSHR2015_log.ldf' , SIZE = 12352KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [GRSHR2015] SET COMPATIBILITY_LEVEL = 100
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GRSHR2015].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [GRSHR2015] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [GRSHR2015] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [GRSHR2015] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [GRSHR2015] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [GRSHR2015] SET ARITHABORT OFF 
GO

ALTER DATABASE [GRSHR2015] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [GRSHR2015] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [GRSHR2015] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [GRSHR2015] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [GRSHR2015] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [GRSHR2015] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [GRSHR2015] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [GRSHR2015] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [GRSHR2015] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [GRSHR2015] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [GRSHR2015] SET  DISABLE_BROKER 
GO

ALTER DATABASE [GRSHR2015] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [GRSHR2015] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [GRSHR2015] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [GRSHR2015] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [GRSHR2015] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [GRSHR2015] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [GRSHR2015] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [GRSHR2015] SET  READ_WRITE 
GO

ALTER DATABASE [GRSHR2015] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [GRSHR2015] SET  MULTI_USER 
GO

ALTER DATABASE [GRSHR2015] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [GRSHR2015] SET DB_CHAINING OFF 
GO












/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/***                                                                                                                                            ***/
/***     >>>>>         This is the script used to remove all tables & set all views to [a] = a from the database  [GRSHRYYYY]         <<<<<     ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
/*                                                                                                                                                */
/*  REFERENCE to 2015 appears JUST ONCE in the script                                                                                             */
/*                                                                                                                                                */
/**************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==> remove all tables & set all views to [a]                                                 --- '
/**************************************************************************************************************************************************/
USE              [GRSHR2015]
GO
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>> these are general variables to be used                                    ***/
/**************************************************************************************************************************************************/
DECLARE @CrDt varchar( 8)                                 /***        declare variable for storing current date (as text)                       ***/
SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))       /***        set value to current date in the format YYYYMMDD                          ***/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  cursor                                                                    ***/
DECLARE @CODEmain1 nvarchar(max)                          /***        declare variable for storing code during each data retreival              ***/
DECLARE @tablename nvarchar(max)                          /***        declare variable for storing data from cursor                             ***/
DECLARE MyCursor   CURSOR FOR                             /*** >>>>   declare cursor to take values from the following select sataement         ***/
/**************************************************************************************************************************************************/
SELECT      [TABLE_NAME]                                  /*** >>>    select table names                                                        ***/
FROM        [INFORMATION_SCHEMA].[TABLES]                 /***        from the system view listing tables & views in the database               ***/
WHERE       [TABLE_TYPE] = 'BASE TABLE'                   /*** <<<    filter to display only tables (excluding views)                           ***/
/**************************************************************************************************************************************************/
OPEN             MyCursor                                 /*** >>>    open cursor by its name                                                   ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @tablename                               /***        store it into the corresponding variable(s)                               ***/
          WHILE  @@FETCH_STATUS = 0                       /***        while the status of the last retreival has been successful                ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
BEGIN                                                     /*** >>     BEGIN the procedures using values of each row of the cursor               ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
SET     @CODEmain1 =                                      /*** >      the code to be stored as string (for each row of the cursor) begins here: ***/
--   N'SELECT * INTO [_bk_forum]..[XR_'+@tablename+'_'+@CrDt+']' /*        selection into backup table                                            */
-- + CHAR(10)                                                    /*         add CR (& spaces)                                                     */
-- + N'    FROM                      ['+@tablename+']'           /*        from table to be deleted                                               */
-- + CHAR(10)                                                    /*         add CR                                                                */
   + N'   DROP TABLE                 ['+@tablename+']'           /*        drop the table to be deleted                                           */
                                                          /*** <      the code to be stored as string ends here                                 ***/
	PRINT  (@CODEmain1)                                   /***        display the currently stored code (to be executed)                        ***/
	EXEC   (@CODEmain1)                                   /***        execute the code that has been stored as text                             ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                                          /*** <<     ENDING of the procedures using values of each row of the cursor           ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @tablename                               /***        store it into the corresponding variable(s)                               ***/
           END                                            /***        and end when last row has been retreived                                  ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
   CLOSE         MyCursor                                 /*** <<<    close cursor by its name                                                  ***/
DEALLOCATE       MyCursor                                 /*** <<<<   remove reference and relase from memory by cursor name                    ***/
/*********************************************************     <<<<<  cursor                                                                    ***/
/**************************************************************************************************************************************************/
GO

/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  cursor                                                                    ***/
DECLARE @CODEmain2 nvarchar(max)                          /***        declare variable for storing code during each data retreival              ***/
DECLARE @viewname  nvarchar(max)                          /***        declare variable for storing data from cursor                             ***/
DECLARE MyCursor   CURSOR FOR                             /*** >>>>   declare cursor to take values from the following select sataement         ***/
/**************************************************************************************************************************************************/
SELECT      [TABLE_NAME]                                  /*** >>>    select view names                                                         ***/
FROM        [INFORMATION_SCHEMA].[TABLES]                 /***        from the system view listing tables & views in the database               ***/
WHERE       [TABLE_TYPE] = 'VIEW'                         /*** <<<    filter to display only views (excluding tables)                           ***/
/**************************************************************************************************************************************************/
OPEN             MyCursor                                 /*** >>>    open cursor by its name                                                   ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @viewname                                /***        store it into the corresponding variable(s)                               ***/
          WHILE  @@FETCH_STATUS = 0                       /***        while the status of the last retreival has been successful                ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
BEGIN                                                     /*** >>     BEGIN the procedures using values of each row of the cursor               ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
SET     @CODEmain2 =                                      /*** >      the code to be stored as string (for each row of the cursor) begins here: ***/
N'ALTER VIEW [' + @viewname + '] AS SELECT [a] = ''a'' '        /*         set the view to be blanked to "a"                                      */
                                                          /*** <      the code to be stored as string ends here                                 ***/
PRINT  (@CODEmain2)                                       /***        display the currently stored code (to be executed)                        ***/
EXEC   (@CODEmain2)                                       /***        execute the code that has been stored as text                             ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
                                                          /*** <<     ENDING of the procedures using values of each row of the cursor           ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
FETCH NEXT FROM  MyCursor                                 /***        retrieve the next row from cursor                                         ***/
           INTO  @viewname                                /***        store it into the corresponding variable(s)                               ***/
           END                                            /***        and end when last row has been retreived                                  ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
   CLOSE         MyCursor                                 /*** <<<    close cursor by its name                                                  ***/
DEALLOCATE       MyCursor                                 /*** <<<<   remove reference and relase from memory by cursor name                    ***/
/*********************************************************     <<<<<  cursor                                                                    ***/
/**************************************************************************************************************************************************/
GO







SELECT
           entity      = 'Ctry'
      ,    link_fk     = KN.[Nation_answer_pk]
      ,    Nation_fk   = N.[Nation_pk]
      ,    Locality_fk = NULL
      ,    Religion_fk = NULL
      ,    Region5     = N.[Region]
      ,    Region6     = N.[SubRegion6]
      , N.[Ctry_EditorialName]
      ,    Locality    = 'not detailed'
      ,    Religion    = ''
      , Q.[Question_Year]
   --  GET QS_fk  --- for coding process
      ,    QA_std      = Q.[Question_abbreviation_std]
      ,    QW_std      = Q.[Question_short_wording_std]
      , Q.[Answer_value]
      , Q.[answer_wording]
      , Q.[answer_wording_std]
      , Q.[Question_fk]
      , Q.[Answer_fk]
      , Q.[Notes]
  FROM [forum].[dbo].[Pew_Q&A]               Q
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Nation_Answer]     KN
WHERE Q.[Answer_fk]           = KN.[Answer_fk]
  AND N.[Nation_pk]           = KN.[Nation_fk]
                                /* Pull only data on Restrictions */
  AND Q.[Pew_Data_Collection] = 'Global Restriction on Religion Study'
/*********************************************************************************** Set of data at country level ***/
UNION
/*** Set of data at country/religious group level *******************************************************************/
SELECT
           entity      = 'RGrp'
      ,    link_fk     = KR.[Nation_religion_answer_pk]
      ,    Nation_fk   = N.[Nation_pk]
      ,    Locality_fk = NULL
      ,    Religion_fk = G.[Religion_group_pk]
      ,    Region5     = N.[Region]
      ,    Region6     = N.[SubRegion6]
      , N.[Ctry_EditorialName]
      ,    Locality    = 'not detailed'
      ,    Religion    = G.[Pew_religion]
      , Q.[Question_Year]
   --  GET QS_fk  --- for coding process
      ,    QA_std      = Q.[Question_abbreviation_std]
      ,    QW_std      = Q.[Question_short_wording_std]
      , Q.[Answer_value]
      , Q.[answer_wording]
      , Q.[answer_wording_std]
      , Q.[Question_fk]
      , Q.[Answer_fk]
      , Q.[Notes]
  FROM [forum].[dbo].[Pew_Q&A]                      Q
      ,[forum].[dbo].[Pew_Nation]                   N
      ,[forum].[dbo].[Pew_Religion_Group]           G
      ,[forum].[dbo].[Pew_Nation_Religion_Answer]   KR
WHERE Q.[Answer_fk]           = KR.[Answer_fk]
  AND KR.[Religion_group_fk]  =  G.[Religion_group_pk]
  AND  N.[Nation_pk]          = KR.[Nation_fk]
                                /* Pull only data on Restrictions */
  AND Q.[Pew_Data_Collection] = 'Global Restriction on Religion Study'
/******************************************************************* Set of data at country/religious group level ***/
UNION
/*** Set of data at country/province level **************************************************************************/
SELECT
           entity             = 'Prov'
      ,    link_fk     = KL.[Locality_answer_pk]
      ,    Nation_fk   = N.[Nation_pk]
      ,    Locality_fk = L.[Locality_pk]
      ,    Religion_fk = NULL
      ,    Region5     = N.[Region]
      ,    Region6     = N.[SubRegion6]
      , N.[Ctry_EditorialName]
      ,    Locality    = L.Locality
      ,    Religion    = ''
      , Q.[Question_Year]
   --  GET QS_fk  --- for coding process
      ,    QA_std      = Q.[Question_abbreviation_std]
      ,    QW_std      = Q.[Question_short_wording_std]
      , Q.[Answer_value]
      , Q.[answer_wording]
      , Q.[answer_wording_std]
      , Q.[Question_fk]
      , Q.[Answer_fk]
      , Q.[Notes]
  FROM [forum].[dbo].[Pew_Q&A]               Q
      ,[forum].[dbo].[Pew_Locality]          L
      ,[forum].[dbo].[Pew_Nation]            N
      ,[forum].[dbo].[Pew_Locality_Answer]   KL
WHERE Q.[Answer_fk]   = KL.[Answer_fk]
  AND L.[Locality_pk] = KL.[Locality_fk]
  AND N.[Nation_pk]   =
                                /* In order to keep consistent to previuos years 
                                   Data by Province currently belonging to South Sudan
                                   should considered data for Sudan before 2010: */
                     CASE 
                            WHEN L.[Nation_fk]     = 237 
                             AND Q.[Question_Year] < 2010 
                            THEN                           197
                            ELSE                           L.[Nation_fk]
                     END 
                                /* In order to avoid changing the final set,
                                   Data previously used for Northern Cyprus
                                   should be excluded: ????                                 */
                                /* Although we have REAL data by province for North Korea,
                                   we will not use them in this analysis: ????              */
                                /* Pull only data on Restrictions */
  AND Q.[Pew_Data_Collection] = 'Global Restriction on Religion Study'
/************************************************************************** Set of data at country/province level ***/
----------------------------------------------------------------------------------------------------------------------
/******************************************************************************************  Basic Data: Long NPR ***/
) AS NPR
/***************************************************************************************************************************************************************/
WHERE
/* filters */
Ctry_EditorialName                                   != 'North Korea'                   /* Excluded from the analysis */
AND
Ctry_EditorialName + '_/_' + STR(Question_Year, 4,0) != 'South Sudan_/_2010'            /* although data are not aggregated for the other part of former Sudan */
/* filters */
AND
                             STR(Question_Year, 4,0)  =               '2013'            /* although data are not aggregated for the other part of former Sudan */
/***************************************************************************************************************************************************************/
GO




