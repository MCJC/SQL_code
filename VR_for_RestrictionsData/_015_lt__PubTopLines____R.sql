/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 015    ------------------------------------------------------------------------------------------ '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the lookup table [forum_ResAnal].[dbo].[vr___10_cDB_Published_TopLines]                         <<<<<     ***/
/***             This table only includes aggregated numeric values                                                                                          ***/
/***                                                                                                                                                         ***/
/***                                                                                                                                                         ***/
/***                                                      > > >     lookup tables work faster     < < <                                                      ***/
/***************************************************************************************************************************************************************/
USE [forum_ResAnal]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
declare @ALLCODE nvarchar(max)
/***************************************************************************************************************************************************************/
set     @ALLCODE =
/*** > ALLCODE *************************************************************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
N'
ALTER  VIEW                      [dbo].[vr___10_]        AS
SELECT * FROM
(
  SELECT
'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
N'
          [vx2Row]
          =  ROW_NUMBER()
             OVER(ORDER BY [vx1Row] )
        , [Variable]
        , [Value]
        , [Wording]
        , [N2007]
        , [P2007]
        , [N' + (SELECT CAST((SELECT MAX([Question_Year]) FROM [vr___06_cDB_LongData_ALL_byCYQ]) -1 AS VARCHAR)) + N']
        , [P' + (SELECT CAST((SELECT MAX([Question_Year]) FROM [vr___06_cDB_LongData_ALL_byCYQ]) -1 AS VARCHAR)) + N']
        , [N' + (SELECT CAST((SELECT MAX([Question_Year]) FROM [vr___06_cDB_LongData_ALL_byCYQ])    AS VARCHAR)) + N']
        , [P' + (SELECT CAST((SELECT MAX([Question_Year]) FROM [vr___06_cDB_LongData_ALL_byCYQ])    AS VARCHAR)) + N']
        , [vx1Row]
'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
N'
  FROM 
          [forum_ResAnal].[dbo].[vr___09_cDB_Basic_TopLines_All]        T
   JOIN
      (
        SELECT
                  [V] = [Question_abbreviation_std]
          FROM
                  [forum]..[Pew_Question_Std]
        LEFT JOIN [forum]..[Pew_Question_Attributes]
               ON [Question_Std_pk]
                 =[Question_Std_fk]
            WHERE [attk]
                 = ''Itl''
              AND [attr]
                 = 1
                                                        )               F
     ON      [Variable]  =  [V]                                                       ) MYMAIND
'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*** < ALLCODE *************************************************************************************************************************************************/

/***************************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @ALLCODE                                     /***        display the currently stored code (to be executed)                           ***/
/***************************************************************************************************************************************************************/
	EXEC  (@ALLCODE)
/***************************************************************************************************************************************************************/
GO
/***************************************************************************************************************************************************************/








/***************************************************************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___10_cDB_Published_TopLines]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr___10_cDB_Published_TopLines]
SELECT * INTO    [forum_ResAnal].[dbo].[vr___10_cDB_Published_TopLines]
            FROM                 [dbo].[vr___10_]
/***************************************************************************************************************************************************************/
GO
/***************************************************************************************************************************************************************/
--	SELECT* FROM [forum_ResAnal].[dbo].[vr___10_cDB_Published_TopLines] WHERE [Variable] IS NULL
/***************************************************************************************************************************************************************/


