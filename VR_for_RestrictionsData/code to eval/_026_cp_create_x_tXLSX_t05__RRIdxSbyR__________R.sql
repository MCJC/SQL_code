/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the lookup table [forum_ResAnal].[dbo].[vrx_w_05_proRRIdxSbyR_00]                           <<<<<     ***/
/***             This table only includes aggregated numeric values                                                                                          ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [forum_ResAnal]
GO
/***************************************************************************************************************************************************************/
IF OBJECT_ID (N'[forum_ResAnal].[dbo].[vrx_w_05_proRRIdxSbyR_00]', N'U') IS NOT NULL
DROP TABLE      [forum_ResAnal].[dbo].[vrx_w_05_proRRIdxSbyR_00]
SELECT * INTO   [forum_ResAnal].[dbo].[vrx_w_05_proRRIdxSbyR_00]
FROM
/***************************************************************************************************************************************************************/
(
/*** > pivoted data ********************************************************************************************************************************************/
SELECT 
        [IdxS_row] =
                      ROW_NUMBER()
                      OVER(ORDER BY
                                     [Region]
                                    ,[CEN]
                                              )
      , [Nation_fk]
      , [Ctry_EditorialName]
      , [GRI - baseline year]
      , [SHI - baseline year]
      , [GRI - previous year]
      , [SHI - previous year]
      , [GRI - latest year]
      , [SHI - latest year]
      , [Region]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
  FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
/*** > pivotable data ******************************************************************************************************************************************/
SELECT 
       [Nation_fk]
      ,[Ctry_EditorialName]    =  CASE
                                  WHEN [Nation_fk] > 999 THEN   [Region]
                                                              + '     '
                                                              + 
                                                                CONVERT(VARCHAR(29),
                                                                 CAST(
                                                                  (ROUND(
                                                                     SUM([w])
                                                                     OVER(PARTITION BY [Region]) 
                                                                  , 0))
                                                                 AS DECIMAL(24,0)) 
                                                                )
                                                              + ' countries'
                                  ELSE [Ctry_EditorialName]
                                  END
      ,[Region]
      ,[CEN]
      ,[HEAD]
      ,[IRV]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
  FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
       [Nation_fk]
      ,[Ctry_EditorialName]
      ,[Region]                =  [Region5]
      ,[CEN]                   =  CASE
                                  WHEN [Nation_fk] < 999
                                  THEN [Ctry_EditorialName]
                                  END
      ,[HEAD]                  =  CASE
                                  WHEN [Year] = ( SELECT ((MAX([Year]))    ) FROM [vr_04w_R&H_Index_by_CtryRegion&Yr] )
                                  THEN [Index_abbreviation] + ' - latest year'
                                  WHEN [Year] = ( SELECT ((MAX([Year])) - 1) FROM [vr_04w_R&H_Index_by_CtryRegion&Yr] )
                                  THEN [Index_abbreviation] + ' - previous year'
                                  WHEN [Year] = ( SELECT ((MIN([Year]))    ) FROM [vr_04w_R&H_Index_by_CtryRegion&Yr] )
                                  THEN [Index_abbreviation] + ' - baseline year'
                                  END
      ,[IRV]                   =  CASE
                                  WHEN [Nation_fk] < 999
                                  THEN CONVERT(VARCHAR(5),[I_Rounded_value])
                                  ELSE ''
                                  END
      ,[w]                     =  CASE
                                  WHEN [Nation_fk] < 999
                                  THEN (1/ (CAST
                                             (COUNT([Year]) 
                                              OVER
                                             (PARTITION BY [Nation_fk])
                                            AS DECIMAL(24,16)) ) )
                                  ELSE 0
                                  END
  FROM
       [forum_ResAnal].[dbo].[vr_04w_R&H_Index_by_CtryRegion&Yr]
WHERE
          [ByRegion5]  = 1
AND
          [Index_abbreviation] != 'GFI'
AND
      (   [Year] >= ( SELECT ((MAX([Year])) - 1) FROM [vr_04w_R&H_Index_by_CtryRegion&Yr] )
       OR [Year]  = ( SELECT ((MIN([Year]))    ) FROM [vr_04w_R&H_Index_by_CtryRegion&Yr] ) )
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
)                                                                                                                                                AS prePivtbDATA
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/*** < pivotable data ******************************************************************************************************************************************/
)                                                                                                                                                AS    PivtbDATA
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
PIVOT  ( MAX([IRV])    
         FOR [HEAD]
IN ( 
       [GRI - baseline year]
     , [SHI - baseline year]
     , [GRI - previous year]
     , [SHI - previous year]
     , [GRI - latest year]
     , [SHI - latest year]
                             )
                                ) AS pivt
/*** < pivoted data ********************************************************************************************************************************************/
)                                                                                                                                                AS      PvtDATA
/***************************************************************************************************************************************************************/
