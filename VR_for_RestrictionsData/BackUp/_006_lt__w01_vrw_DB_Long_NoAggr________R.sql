USE [forum_ResAnal]
GO
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***      The long set of data includes numeric values and descriptive wordings for GR&SH R                                                                  ***/
/***                                                                                                                                                         ***/
/***                                                      > > >     lookup tables work faster     < < <                                                      ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr_01w_DB_Long_NoAggregated]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr_01w_DB_Long_NoAggregated]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * INTO    [forum_ResAnal].[dbo].[vr_01w_DB_Long_NoAggregated]
FROM
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
(
/*** Set of data coded in the working summer-period *****************************************************************/
SELECT
           entity              = 'CR&P'
      ,    link_fk             = 0
      ,   [Nation_fk]
      ,    Locality_fk         = NULL
      ,    Religion_fk         = NULL
      ,   [Region5]
      ,   [Region6]
      ,   [Ctry_EditorialName]
      ,    Locality            = ''
      ,    Religion            = ''
      ,   [Question_Year]      = SUBSTRING([Question_Year], 6, 4)
      ,   [QA_std]
      ,   [QW_std]
      ,   [Answer_value]       =      CAST([Answer_value]   AS DECIMAL(38,2))
      ,   [answer_wording]
      ,   [answer_wording_std]
      ,    Question_fk         = 0
      ,    Answer_fk           = 0
      ,   [Notes]              = ''
  FROM [GRSHR2014].[dbo].[s13_AllLongVals&Desc]
WHERE
          [QA_std]  NOT IN (    'SHI_01_summary_b'
                              , 'GRI_19_x'
                              , 'SHI_01_x'
                              , 'SHI_04_x'
                              , 'SHI_05_x'
                              , 'SHI_05_filter'
                              , 'GRI_02_filter'
                              , 'XSG_S_99_filter'
                              , 'SHI_04_filter'
                              , 'GRI_01_filter'
                              , 'GRI_19_filter'
                              , 'GRI_02_yBe'
                              , 'GRI_01_yBe'          )
  AND     [Question_Year] =     'Year_2013'                     ---- only 2013, other data added to include variables not used in 2013
--and QA_std like 'GRI_19%' ---- not sure why this ended here!
/***************************************************************  Set of data coded in the working summer-period  ***/
) AS NPR_and_current
/***************************************************************************************************************************************************************/
-- WHERE SUBSTRING(QA_std, 1, 2) IN ( 'GR', 'SH', 'XS')   ---- filter not needed this year
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/
UNION ALL
/***************************************************************************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT *
  FROM [forum_ResAnal].[dbo].[vrc_01_DB_Long_NoAggregated]
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
/***************************************************************************************************************************************************************/