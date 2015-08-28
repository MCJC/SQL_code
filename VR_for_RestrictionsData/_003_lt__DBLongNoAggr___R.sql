/**************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 003    ----------------------------------------------------------------------------- '
/**************************************************************************************************************************************************/
/***                                                                                                                                            ***/
/***     >>>>>         This script creates long set of data from the 'Global Restriction on Religion Study'                           <<<<<     ***/
/***                   The long set of data includes numeric values and descriptive wordings for GR&SH R                                        ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
USE [forum_ResAnal]
GO
/**************************************************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vrc_01_DB_Long_NoAggregated]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vrc_01_DB_Long_NoAggregated]
GO
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[NewTempTab1]'                , N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[NewTempTab1]
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[NewTempTab2]'                , N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[NewTempTab2]
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[NewTempTab3]'                , N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[NewTempTab3]
GO
/**************************************************************************************************************************************************/
ExtractGRSH 'Ctry', '[FORUM]..[Pew_Nation_Answer]'         , '[NewTempTab1]'
GO 
ExtractGRSH 'Prov', '[FORUM]..[Pew_Locality_Answer]'       , '[NewTempTab2]'
GO 
ExtractGRSH 'RGrp', '[FORUM]..[Pew_Nation_Religion_Answer]', '[NewTempTab3]'
GO 
/**************************************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT *
 INTO                   [vrc_01_DB_Long_NoAggregated]
 FROM
       (
          SELECT * FROM [NewTempTab1]
          UNION ALL 
          SELECT * FROM [NewTempTab2]
          UNION ALL
          SELECT * FROM [NewTempTab3]
                                       ) TempTabs
/*  >   filters  ---------------------------------------------------------------------------------------------------------------------------------*/
WHERE
Ctry_EditorialName                                 != 'North Korea'        /* Excluded from the analysis                                          */
AND
Ctry_EditorialName +'_/_'+ STR(Question_Year, 4,0) != 'South Sudan_/_2010' /* although data are not aggregated for the other part of former Sudan */
/*  <   filters  ---------------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************************************/
GO
/**************************************************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[NewTempTab1]'                , N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[NewTempTab1]
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[NewTempTab2]'                , N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[NewTempTab2]
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[NewTempTab3]'                , N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[NewTempTab3]
/**************************************************************************************************************************************************/
GO
/**************************************************************************************************************************************************/
