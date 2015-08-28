/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the lookup table [forum_ResAnal].[dbo].[vr_05w_SemiWide_by_Ctry&Year]                           <<<<<     ***/
/***             This table only includes numeric values aggregated by country/religion & year (does not include descriptive wordings).                      ***/
/***                                                                                                                                                         ***/
/***                                                      > > >     lookup tables work faster     < < <                                                      ***/
/***                                                                                                                                                         ***/
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
/***************************************************************************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/
N'
/***************************************************************************************************************************************************************/
IF OBJECT_ID (N''[forum_ResAnal].[dbo].[vr_05w_SemiWide_by_Ctry&Year]'', N''U'') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr_05w_SemiWide_by_Ctry&Year]
SELECT * INTO    [forum_ResAnal].[dbo].[vr_05w_SemiWide_by_Ctry&Year]
FROM
/***************************************************************************************************************************************************************/
'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
N'
(
SELECT 
           [byCY_row]           =  ROW_NUMBER()
                                   OVER(ORDER BY
                                                   [Nation_fk]
                                                 , [Question_Year] )
'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
N'
      ,    [Nation_fk]
      ,    [Ctry_EditorialName]
      ,    [UN_TotalPopulation]
      ,    [Region5]
      ,    [Region6]
      ,    [Question_Year]
      , IV.[GRI]
      , RV.[GRI_rd_1d]
      , SV.[GRI_scaled]
      , IV.[SHI]
      , RV.[SHI_rd_1d]
      , SV.[SHI_scaled]
'
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/*** Begin selection (into text, in a cell) of a comma delimited list of fields from a system view *************************************************************/
/***************************************************************************************************************************************************************/
(                                                                               /*** parenthesis to include query for the cell to be stuffed                ***/
    SELECT                                                                      /*** SELECT statement                                                        ***/
          ', '                                                                  /*** comma delimiter                                                         ***/
        +                                                                       /*** concatenated to...                                                      ***/
          [COLUMN_NAME]                                                         /*** Fiels including all Q Abb Std (StdVarName)                              ***/
    FROM                                                                        /*** from...                                                                 ***/
          [INFORMATION_SCHEMA].[COLUMNS]                                        /*** name of the sys view which includes all field (var) names as rows       ***/
WHERE                                                                           /*** FILTER:                                                                 ***/
          [TABLE_NAME] = 'vr_03w_W&Extras_by_Ctry&Year'                         /*** only the view vr_03                                                     ***/
  AND                                                                           /*** FILTER:                                                                 ***/
          [COLUMN_NAME] NOT IN (  'Nation_fk'                                   /*** exclude fileds initialy listed                                          ***/
                                 ,'Region5'                                     /***                                                                         ***/
                                 ,'Region6'                                     /***                                                                         ***/
                                 ,'Ctry_EditorialName'                          /***                                                                         ***/
                                 ,'Question_Year'                               /***                                                                         ***/
                                 ,'GRI'                                         /***                                                                         ***/
                                 ,'GRI_rd_1d'                                   /***                                                                         ***/
                                 ,'GRI_scaled'                                  /***                                                                         ***/
                                 ,'SHI'                                         /***                                                                         ***/
                                 ,'SHI_rd_1d'                                   /***                                                                         ***/
                                 ,'SHI_scaled'            )                     /***                                                                         ***/
         ORDER BY                                                               /*** sorting order usesd to order stored & extra variables alphabetically    ***/
          ', '                                                                  /*** including comma delimiter                        -> as part of sorting  ***/
        +                                                                       /*** concatenated to...                               -> as part of sorting  ***/
          [COLUMN_NAME]                                                         /*** Fiels including all Q Abb Std (StdVarName)       -> as part of sorting  ***/
         for xml path('')                                                       /*** Modifies the selected rowset nesting all cells into an XML string cell  ***/
/***************************************************************************************************************************************************************/
/*** End of the selection (into text, in a cell) of a comma delimited list of fields ***************************************************************************/
/***************************************************************************************************************************************************************/
)                                                                                /*** parenthesis to include query for the cell to be stuffed                ***/
/****************************************************************************************************************************** stuffing function ends here! ***/
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*--- > main dataset ------------------------------------------------------------------------------------------------------------------------------------------*/
N'
  FROM [vr_03w_W&Extras_by_Ctry&Year]
'
/*--- < main dataset ------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*--- > population --------------------------------------------------------------------------------------------------------------------------------------------*/
N'
     , (  SELECT 
                  [FYr]                 = [Field_year]
                , [Nfk]                 = [Nation_fk]
                , [UN_TotalPopulation]  =  CAST([Cnt] AS BIGINT)
             FROM [forum].[dbo].[Pew_Nation_Age_Sex_Value]
                , [forum].[dbo].[Pew_Field]
           WHERE  [Sex_fk]       = 0
             AND  [Age_fk]       = 0
             AND  [Scenario_id]  = 3
             AND  [Field_fk]
                = [Field_pk]                                ) POP
'
/*--- < population --------------------------------------------------------------------------------------------------------------------------------------------*/
+
/*--- > adjusted rounding of indexes --------------------------------------------------------------------------------------------------------------------------*/
N'
     , (  SELECT 
                  [Niv]        = [Nation_fk]
                , [Yiv]        = [YEAR]
                , [GRI]
                , [SHI]
            FROM  (  SELECT [level]
                           ,[Nation_fk]
                           ,[Year]
                           ,[Ctry_EditorialName]
                           ,[Index_abbreviation]
                           ,[Index_value]
                       FROM [vr_04w_R&H_Index_by_CtryRegion&Yr]
                      WHERE [level] = 1                                    ) rI
            PIVOT (AVG( [Index_value] )
                   FOR  [Index_abbreviation]
                    IN( [GRI]
                       ,[SHI] )) AS pvt                                         ) IV
     , (  SELECT 
                  [Nrv]        = [Nation_fk]
                , [Yrv]        = [YEAR]
                , [GRI_rd_1d]  = [GRI]
                , [SHI_rd_1d]  = [SHI]
            FROM  (  SELECT [level]
                           ,[Nation_fk]
                           ,[Year]
                           ,[Ctry_EditorialName]
                           ,[Index_abbreviation]
                           ,[I_Rounded_value]
                       FROM [vr_04w_R&H_Index_by_CtryRegion&Yr]
                      WHERE [level] = 1                                    ) rI
            PIVOT (AVG( [I_Rounded_value] )
                   FOR  [Index_abbreviation]
                    IN( [GRI]
                       ,[SHI] )) AS pvt                                         ) RV
     , (  SELECT 
                  [Nsv]        = [Nation_fk]
                , [Ysv]        = [YEAR]
                , [GRI_scaled] = CAST([GRI] AS DECIMAL(38,2))
                , [SHI_scaled] = CAST([SHI] AS DECIMAL(38,2))
            FROM  (  SELECT [level]
                           ,[Nation_fk]
                           ,[Year]
                           ,[Ctry_EditorialName]
                           ,[Index_abbreviation]
                           ,[I_Scaled_value]
                       FROM [vr_04w_R&H_Index_by_CtryRegion&Yr]
                      WHERE [level] = 1                                    ) rI
            PIVOT (AVG( [I_Scaled_value] )
                   FOR  [Index_abbreviation]
                    IN( [GRI]
                       ,[SHI] )) AS pvt                                         ) SV
'
/*--- < adjusted rounding of indexes --------------------------------------------------------------------------------------------------------------------------*/
+
/*--- > join onditions ----------------------------------------------------------------------------------------------------------------------------------------*/
N'
WHERE         [Nfk]        = [Nation_fk]
  AND         [Niv]        = [Nation_fk]
  AND         [Nrv]        = [Nation_fk]
  AND         [Nsv]        = [Nation_fk]
  AND         [FYr]        = [Question_Year]
  AND         [Yiv]        = [Question_Year]
  AND         [Yrv]        = [Question_Year]
  AND         [Ysv]        = [Question_Year]
) formerview
'
/*--- < join onditions ----------------------------------------------------------------------------------------------------------------------------------------*/
/***************************************************************************************************************************************************************/
/*** This is a way for checking the SQL statement that has been stored as a string variable ********************************************************************/
/***************************************************************************************************************************************************************/
--	EXEC dbo.LongPrint @ALLCODE                                     /***        display the currently stored code (to be executed)                           ***/
/*** The complete SQL statement stored as a string variable is executed as a character string ******************************************************************/
	EXEC              (@ALLCODE)                                    /***        execute the code that has been stored as text                                ***/
/***************************************************************************************************************************************************************/
