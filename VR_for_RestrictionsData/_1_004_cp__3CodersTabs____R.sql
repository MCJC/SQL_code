/***************************************************************************************************************************************************************/
Print '--- '+CONVERT(VARCHAR(19),SYSDATETIME())+' ==>  script 1.004    ---------------------------------------------------------------------------------------- '
/***************************************************************************************************************************************************************/
/***                                                                                                                                            ***/
/***     >>>>>   This is the script used to create the tables:                                                                        <<<<<     ***/
/***                                                           [GRSHRYYYY].[dbo].[GRI_Ctry]                                                     ***/
/***                                                           [GRSHRYYYY].[dbo].[SHI_Ctry]                                                     ***/
/***                                                           [GRSHRYYYY].[dbo].[Sources]                                                      ***/
/***                                                       =>  (working tables for coding values & corresponding descriptions in current year)  ***/
/***                                                                                                                                            ***/
/***                           * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *                          ***/
/***                           * NOTICE: This script should be excecuted before coders start enetering data          *                          ***/
/***                           *         after data entering starts this & previous scripts SHOULD NOT BE EXCECUTED! *                          ***/
/***                           * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *                          ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
USE              [GRSHRcode]
GO
--/**************************************************************************************************************************************************/
--/***  BackUp current tables  **********************************************************************************************************************/
--  DECLARE @CrDt    varchar(13)
--  DECLARE @TofI    varchar(50)
--  SET     @CrDt    =           (CONVERT(VARCHAR(8),GETDATE(),112))                                      /***      - date: YYYYMMDD              ***/
--              + '_' + (REPLACE((CONVERT(VARCHAR(5),GETDATE(),114)), ':', ''))                           /***      - time:         _hhmm         ***/
--  DECLARE MyCursor CURSOR FOR                                                                           /***      cursor to take values from... ***/
--/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--                 SELECT   'GRI_Ctry'
--           UNION SELECT   'SHI_Ctry'
--           UNION SELECT   'Sources'
--/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--   OPEN            MyCursor                    -- cursor name
--   FETCH NEXT FROM MyCursor
--              INTO @TofI
--			 WHILE  @@FETCH_STATUS = 0
--   BEGIN
--/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--EXEC ( ' IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
--              WHERE       [TABLE_NAME] = ''' + @TofI               + '''  ) = 1
--            SELECT * INTO                 [' + @TofI + '_' + @CrDt + ']
--                     FROM                 [' + @TofI               + ']'           )
--/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--   FETCH NEXT FROM MyCursor
--              INTO @TofI
--   END
--   CLOSE           MyCursor
--   DEALLOCATE      MyCursor
--/*------------------------------------------------------------------------------------------------------------------------------------------------*/
--GO
--/**********************************************************************************************************************  BackUp current tables  ***/
--/**************************************************************************************************************************************************/


/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'GRI_Ctry'                          ) = 1
DROP              TABLE         [GRI_Ctry]
/**************************************************************************************************************************************************/
/***  Government Restrictions table to ENTER data:  ***********************************************************************************************/
/**************************************************************************************************************************************************/
declare @CODEGRI nvarchar(max)
set     @CODEGRI = 
/**************************************************************************************************************************************************/
                                                                   /*** >>     ordered selection of GRI variables                               ***/
 N'
      SELECT
               [RowID]
             , [Nation_fk]
             , [Ctry_EditorialName]
             , [Question_Year]
             ' +
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
(    SELECT  ', ' + [QAS]
       FROM         [AT_Qs]
      WHERE         [QTable]  = 'GR'                                  /***        include GR coded questions                                       ***/
        AND         [QClass] != 'PERSI'                               /***        does not include persisted field                                 ***/

    for xml path('')  )                                            /*** <      End of the selection, nesting all cells into an XML string cell  ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
+N'
    INTO      [GRI_Ctry]
    FROM      [GRSH_C]
    WHERE     [Question_Year] = ( SELECT DISTINCT MAX([Question_Year]) FROM [GRSH_C] )  '
                                                                   /*** >>>    store ordered GRI variables in wide shape                        ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODEGRI                                    /***        display the currently stored code (to be executed)               ***/
	EXEC              (@CODEGRI)                                   /***        execute the code that has been stored as text                    ***/
/**************************************************************************************************************************************************/
GO
/**************************************************************************************************************************************************/

/***  manual setting ******************************************************************************************************************************/
/***         By default the SQL Server Agent does not set QUOTED_IDENTIFIER:                                                                    ***/
/***         in the Transact-SQL command you must add the needed SET OPTIONS                                                                    ***/
SET QUOTED_IDENTIFIER ON
GO
/**************************************************************************************************************************************************/

/***  IDs as PKs & Computed Fields ****************************************************************************************************************/
ALTER TABLE [GRI_Ctry]
ADD   CONSTRAINT GR_pk PRIMARY KEY(RowID)
GO
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
ALTER TABLE [GRI_Ctry]
ADD GRI_19_x         AS
                          GRI_19_b
                        + GRI_19_c
                        + GRI_19_d
                        + GRI_19_e
                        + GRI_19_f   PERSISTED
/**************************************************************************************************************************************************/
GO
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/


/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'SHI_Ctry'                          ) = 1
DROP              TABLE         [SHI_Ctry]
/**************************************************************************************************************************************************/
/***  Government Restrictions table to ENTER data:  ***********************************************************************************************/
/**************************************************************************************************************************************************/
declare @CODESHI nvarchar(max)
set     @CODESHI = 
/**************************************************************************************************************************************************/
                                                                   /*** >>     ordered selection of GRI variables                               ***/
 N'
      SELECT
               [RowID]
             , [Nation_fk]
             , [Ctry_EditorialName]
             , [Question_Year]
             ' +
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
(    SELECT  ', ' + [QAS]
       FROM         [AT_Qs]
      WHERE         [QTable]  = 'SH'                                  /***        include GR coded questions                                       ***/
        AND         [QClass] != 'PERSI'                               /***        does not include persisted field                                 ***/
    for xml path('')  )                                            /*** <      End of the selection, nesting all cells into an XML string cell  ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
+N'
    INTO      [SHI_Ctry]
    FROM      [GRSH_C]
    WHERE     [Question_Year] = ( SELECT DISTINCT MAX([Question_Year]) FROM [GRSH_C] )  '
                                                                   /*** >>>    store ordered GRI variables in wide shape                        ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODESHI                                    /***        display the currently stored code (to be executed)               ***/
	EXEC              (@CODESHI)                                   /***        execute the code that has been stored as text                    ***/
/**************************************************************************************************************************************************/
GO
/**************************************************************************************************************************************************/
/***  IDs as PKs & Computed Fields ****************************************************************************************************************/
ALTER TABLE [SHI_Ctry]
ADD   CONSTRAINT SH_pk PRIMARY KEY(RowID)
GO
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
ALTER TABLE [SHI_Ctry]
ADD SHI_04_x         AS
                          SHI_04_b
                        + SHI_04_c
                        + SHI_04_d
                        + SHI_04_e
                        + SHI_04_f   PERSISTED
   ,SHI_05_x         AS
                          SHI_05_c                                              -- notice SHI_05_b_x has been dropped / never used for the index
                        + SHI_05_d
                        + SHI_05_e
                        + SHI_05_f   PERSISTED
   ,SHI_01_x         AS 
                          SHI_01_b
                        + SHI_01_c
                        + SHI_01_d
                        + SHI_01_e
                        + SHI_01_f   PERSISTED
GO
/***************************************************************************************************  Change ID field configuration as real pk  ***/
/**************************************************************************************************************************************************/
ALTER TABLE [SHI_Ctry]
ADD SHI_01_summary_b AS 
                          CASE WHEN SHI_01_a = '0.50   - Yes, in limited ways'              THEN 1 ELSE 0 END
                        + CASE WHEN SHI_01_a = '1.00   - Yes, widespread social harassment' THEN 1 ELSE 0 END
                        + CASE WHEN SHI_01_b > 0                                            THEN 1 ELSE 0 END
                        + CASE WHEN SHI_01_c > 0                                            THEN 1 ELSE 0 END
                        + CASE WHEN SHI_01_d > 0                                            THEN 1 ELSE 0 END
                        + CASE WHEN SHI_01_e > 0                                            THEN 1 ELSE 0 END
                        + CASE WHEN SHI_01_f > 0                                            THEN 1 ELSE 0 END   PERSISTED
GO



GO
/*************************************************************************************************************  Add Computed Columns PERSISTED  ***/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/


/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
IF (SELECT COUNT([TABLE_NAME]) FROM [INFORMATION_SCHEMA].[TABLES]
     WHERE       [TABLE_NAME] = 'Sources'                          ) = 1
DROP              TABLE         [Sources]
/**************************************************************************************************************************************************/
/***  Government Restrictions table to ENTER data:  ***********************************************************************************************/
/**************************************************************************************************************************************************/
declare @CODESou nvarchar(max)
set     @CODESou = 
/**************************************************************************************************************************************************/
                                                                   /*** >>     ordered selection of GRI variables                               ***/
 N'
      SELECT
               [RowID]
             , [Nation_fk]
             , [Ctry_EditorialName]
             , [Question_Year]
             ' +
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
(    SELECT  ', ' + [QAS]
       FROM         [AT_Qs]
      WHERE         [QTable]  = 'xs'          /***        include xs coded questions (no persisted fields)                 ***/
    for xml path('')  )                                            /*** <      End of the selection, nesting all cells into an XML string cell  ***/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
+N'
    INTO      [Sources]
    FROM      [GRSH_C]
    WHERE     [Question_Year] = ( SELECT DISTINCT MAX([Question_Year]) FROM [GRSH_C] )  '
                                                                   /*** >>>    store ordered GRI variables in wide shape                        ***/
/**************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @CODESou                                    /***        display the currently stored code (to be executed)               ***/
	EXEC              (@CODESou)                                   /***        execute the code that has been stored as text                    ***/
/**************************************************************************************************************************************************/
GO
/**************************************************************************************************************************************************/
/***  IDs as PKs & Computed Fields ****************************************************************************************************************/
ALTER TABLE [Sources]
ADD   CONSTRAINT SRC_pk PRIMARY KEY(RowID)
/**************************************************************************************************************************************************/
GO
/**************************************************************************************************************************************************/
/**************************************************************************************************************************************************/
/***************************************************************************************************************************************************************/
Print                    '------------------------------------------------------------------------------------------------------------------------------------- '
/***************************************************************************************************************************************************************/
GO