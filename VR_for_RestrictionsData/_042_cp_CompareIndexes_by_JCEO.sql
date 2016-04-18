/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 006    ------------------------------------------------------------------------------------------ '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the lookup table [forum_ResAnal].[dbo].[vr_03w_W&Extras_by_Ctry&Year]                           <<<<<     ***/
/***             This table only includes numeric values aggregated by country/religion & year (does not include descriptive wordings).                      ***/
/***             The table adds calculated variables using the basic variables stored in the database.                                                       ***/
/***                                                                                                                                                         ***/
/***                                                      > > >     lookup tables work faster     < < <                                                      ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [GRSHR2015]
GO
/***************************************************************************************************************************************************************/
--ALTER VIEW     [v07_CompareIndexes]
--/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--AS
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
----SELECT






----FROM
----(
----/***************************************************************************************************************************************************************/

----SELECT
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
----/* NOTE: scaled GRI_19_ b to f requested by Peter Henne in 2015 */
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
----/* GRI_scaled index */
----      ,  GRI_scaled 
----         =        CAST ((
----                  CASE
----                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
----                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
----                                WHERE  [Field_fk]   = [Field_pk]
----                                  AND  [Level]      = 'low'
----                                  AND  [Point]      = 'highest'
----                                  AND  [Field_type] = 'GRI'
----                                  AND  [Field_year] = '2007'
----                              )
----                  THEN 1.00
----                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
----                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
----                                WHERE  [Field_fk]   = [Field_pk]
----                                  AND  [Level]      = 'moderate'
----                                  AND  [Point]      = 'highest'
----                                  AND  [Field_type] = 'GRI'
----                                  AND  [Field_year] = '2007'
----                              )
----                  THEN 2.00
----                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
----                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
----                                WHERE  [Field_fk]   = [Field_pk]
----                                  AND  [Level]      = 'high'
----                                  AND  [Point]      = 'highest'
----                                  AND  [Field_type] = 'GRI'
----                                  AND  [Field_year] = '2007'
----                              )
----                  THEN 3.00
----                  WHEN GRI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
----                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
----                                WHERE  [Field_fk]   = [Field_pk]
----                                  AND  [Level]      = 'very high'
----                                  AND  [Point]      = 'highest'
----                                  AND  [Field_type] = 'GRI'
----                                  AND  [Field_year] = '2007'
----                              )
----                  THEN 4.00
----                  END
----                                                               ) AS DECIMAL (38,2))
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
----/* SHI_scaled index */
----      ,  SHI_scaled 
----         =        CAST ((
----                  CASE
----                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
----                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
----                                WHERE  [Field_fk]   = [Field_pk]
----                                  AND  [Level]      = 'low'
----                                  AND  [Point]      = 'highest'
----                                  AND  [Field_type] = 'SHI'
----                                  AND  [Field_year] = '2007'
----                              )
----                  THEN 1.00
----                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
----                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
----                                WHERE  [Field_fk]   = [Field_pk]
----                                  AND  [Level]      = 'moderate'
----                                  AND  [Point]      = 'highest'
----                                  AND  [Field_type] = 'SHI'
----                                  AND  [Field_year] = '2007'
----                              )
----                  THEN 2.00
----                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
----                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
----                                WHERE  [Field_fk]   = [Field_pk]
----                                  AND  [Level]      = 'high'
----                                  AND  [Point]      = 'highest'
----                                  AND  [Field_type] = 'SHI'
----                                  AND  [Field_year] = '2007'
----                              )
----                  THEN 3.00
----                  WHEN SHI <= ( SELECT [CutPoint] FROM [forum].[dbo].[Pew_Field]
----                                                     , [forum].[dbo].[Pew_Index_Cut_Points]
----                                WHERE  [Field_fk]   = [Field_pk]
----                                  AND  [Level]      = 'very high'
----                                  AND  [Point]      = 'highest'
----                                  AND  [Field_type] = 'SHI'
----                                  AND  [Field_year] = '2007'
----                              )
----                  THEN 4.00
----                  END
----                                                               ) AS DECIMAL (38,2))
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
----       , *

----FROM
----/***************************************************************************************************************************************************************/
----(
----/*** table including numeric values + Step-2 calculated variables **********************************************************************************************/
----SELECT
----/* Indexes wiolll NOT fit previously published data  ----------------------------------------------------------------------------------------------------------*/
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
----/* GRI index */
----         GRI 
----         =
----                  CAST ((((
----                                [GRI_01]
----                         +      [GRI_02]
----                         +      [GRI_03]
----                         +      [GRI_04]
----                         +      [GRI_05]
----                         +      [GRI_06]
----                         +      [GRI_07]
----                         +      [GRI_08_for_index]
----                         +      [GRI_09]
----                         +      [GRI_10]
----                         +      [GRI_11]
----                         +      [GRI_12]
----                         +      [GRI_13]
----                         +      [GRI_14]
----                         +      [GRI_15]
----                         +      [GRI_16]
----                         +      [GRI_17]
----                         +      [GRI_18]
----                         +      [GRI_19]
----                         +      [GRI_20]
----                                                       ) / 2    )
----                                                                  ) AS DECIMAL (38,32))
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
----/* SHI index */
----       , SHI 
----         =        CAST ((((
----                                [SHI_01]
----                         +      [SHI_02]
----                         +      [SHI_03]
----                         +      [SHI_04]
----                         +      [SHI_05]
----                         +      [SHI_06]
----                         +      [SHI_07]
----                         +      [SHI_08]
----                         +      [SHI_09]
----                         +      [SHI_10]
----                         +      [SHI_11_for_index]
----                         +      [SHI_12]
----                         +      [SHI_13]
----                                                       ) / 1.3  )
----                                                                  ) AS DECIMAL (38,32))
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
----       , *
----FROM
----/***************************************************************************************************************************************************************/
----(
SELECT
       [v_CI_row]          = ROW_NUMBER()
                             OVER
                            (ORDER BY
                                      [Nation_fk]
                                     ,[Index_abbreviation]
                                                            )
      ,*
      ,[DIFF] = ROUND([Value_Year_2013],1,1) - [Index_value]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
FROM
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
(
/*--- query including INDEX values for current and former year -------------------------------------------------------------------------------------------------*/
SELECT
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
       [Nation_fk]
      ,[Ctry_EditorialName]
      ,[Index_abbreviation]
      --,[Variable]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,[NIncrease]         = SUM([I])
      ,[NDecrease]         = SUM([I])
      ,[Value_Year_2014]   = CASE
                                  WHEN [Index_abbreviation] = 'GRI'
                                  THEN  SUM([Value_Year_2014]) / 2
                                  WHEN [Index_abbreviation] = 'SHI'
                                  THEN  SUM([Value_Year_2014]) / 1.3
                                  ELSE  NULL
                             END
      ,[Value_Year_2013]   = CASE
                                  WHEN [Index_abbreviation] = 'GRI'
                                  THEN  SUM([Value_Year_2013]) / 2
                                  WHEN [Index_abbreviation] = 'SHI'
                                  THEN  SUM([Value_Year_2013]) / 1.3
                                  ELSE  NULL
                             END
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
FROM
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
(
/*--- query including recoded values for current and former year (not aggregated) -----------------------------------------------------------------------------*/
SELECT
       [Nation_fk]
      ,[Ctry_EditorialName]
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,[Variable]          = CASE
                                  WHEN [Variable]        = 'GRI_08'
                                  THEN                     'GRI_08_for_index'
                                  WHEN [Variable]        = 'SHI_11'
                                  THEN                     'SHI_11_for_index'
                                  WHEN [Variable]     LIKE 'GRI_20_0%'
                                  THEN                     'GRI_20'
                                  WHEN [Variable]     LIKE 'SHI_01_%'
                                  THEN                     'SHI_01'
                                  ELSE [Variable]
                             END
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,[Index_abbreviation]= SUBSTRING([Variable], 1,3)
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
      ,[I]                 = CASE WHEN [Change] > 0 THEN 1 ELSE 0 END
      ,[D]                 = CASE WHEN [Change] < 0 THEN 1 ELSE 0 END
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
 --   ,[v2014]= [Value_Year_2014]
      ,[Value_Year_2014]   = CASE
                                  WHEN [Variable]        = 'GRI_08'
                                   AND [Value_Year_2014] = 0.5
                                  THEN                     1
                                  WHEN [Variable]        = 'SHI_11'
                                   AND [Value_Year_2014] = 0.5
                                  THEN                     1
                                  WHEN [Variable]     LIKE 'GRI_20_0[1245]'
                                  THEN [Value_Year_2014] / 5
                                  WHEN [Variable]     LIKE 'GRI_20_03_[abc]'
                                  THEN [Value_Year_2014] / 15
                                  WHEN [Variable]     LIKE 'SHI_01_%'
                                   AND [Value_Year_2014] > 0
                                  THEN                     0.1666
                                  ELSE [Value_Year_2014]
                             END
      ,[Value_Year_2013]   = CASE
                                  WHEN [Variable]        = 'GRI_08'
                                   AND [Value_Year_2013] = 0.5
                                  THEN                     1
                                  WHEN [Variable]        = 'SHI_11'
                                   AND [Value_Year_2013] = 0.5
                                  THEN                     1
                                  WHEN [Variable]     LIKE 'GRI_20_0[1245]'
                                  THEN [Value_Year_2013] / 5
                                  WHEN [Variable]     LIKE 'GRI_20_03_[abc]'
                                  THEN [Value_Year_2013] / 15
                                  WHEN [Variable]     LIKE 'SHI_01_%'
                                   AND [Value_Year_2013] > 0
                                  THEN                     0.166666
                                  ELSE [Value_Year_2013]
                             END
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
--SELECT *
FROM
/*** View including values for current and former year *********************************************************************************************************/
               [dbo].[v05_ReportData]
/********************************************************************************************************* View including values for current and former year ***/
WHERE
       [Variable]       IN (
                                'GRI_01'  
                         ,      'GRI_02'  
                         ,      'GRI_03'  
                         ,      'GRI_04'  
                         ,      'GRI_05'  
                         ,      'GRI_06'  
                         ,      'GRI_07'  
                         ,      'GRI_08'  
                         ,      'GRI_09'  
                         ,      'GRI_10'  
                         ,      'GRI_11'  
                         ,      'GRI_12'  
                         ,      'GRI_13'  
                         ,      'GRI_14'  
                         ,      'GRI_15'  
                         ,      'GRI_16'  
                         ,      'GRI_17'  
                         ,      'GRI_18'  
                         ,      'GRI_19'  
                         ,      'GRI_20_01'  
                         ,      'GRI_20_02'  
                         ,      'GRI_20_03_a'  
                         ,      'GRI_20_03_b'  
                         ,      'GRI_20_03_c'  
                         ,      'GRI_20_04'  
                         ,      'GRI_20_05'  
                         ,      'SHI_01_a'  
                         ,      'SHI_01_b'  
                         ,      'SHI_01_c'  
                         ,      'SHI_01_d'  
                         ,      'SHI_01_e'  
                         ,      'SHI_01_f'  
                         ,      'SHI_02'  
                         ,      'SHI_03'  
                         ,      'SHI_04'  
                         ,      'SHI_05'  
                         ,      'SHI_06'  
                         ,      'SHI_07'  
                         ,      'SHI_08'  
                         ,      'SHI_09'  
                         ,      'SHI_10'  
                         ,      'SHI_11'  
                         ,      'SHI_12'  
                         ,      'SHI_13'  
                                                                  )
/*----------------------------------------------------------------------------- query including recoded values for current and former year (not aggregated) ---*/
)   BASREC
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/
 GROUP
    BY
       [Nation_fk]
      ,[Ctry_EditorialName]
      ,[Index_abbreviation]
      --,[Variable]
/*------------------------------------------------------------------------------------------------ query including INDEX values for current and former year ---*/
)   INDVALS
/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/


       LEFT JOIN 
     /*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
      (
     /*--- INDEX values for former year -----------------------------------------------------------------------------------------------------------------------*/
          SELECT 
                 [n] = [Nation_fk]
                ,[i] = [Index_abbreviation]
                ,[Index_value]
            FROM [forum].[dbo].[vi_Restrictions_Index_by_CtryRegion&Yr]
           WHERE [Year] = 2013
     /*--------------------------------------------------------------------------------------------------------------------------- INDEX values former year ---*/
      )   OLDVALS
     /*--------------------------------------------------------------------------------------------------------------------------------------------------------*/
        ON
                 [n] = [Nation_fk]
       AND
                 [i] = [Index_abbreviation]

/*-------------------------------------------------------------------------------------------------------------------------------------------------------------*/




/*


/********************************************************************************************** table including numeric values + Step-1 calculated variables ***/
)                                                                                                                                                       AS NV_S1
/***************************************************************************************************************************************************************/
)                                                                                                                                                       AS NV_S2
/********************************************************************************************** table including numeric values + Step-2 calculated variables ***/
/********************************************************************************************** table including numeric values + Step-3 calculated variables ***/
/************************************************************************************************************************************* main select statement ***/
/***************************************************************************************************************************************************************/
) formerview
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
*/