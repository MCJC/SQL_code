/********************************************************************************************************************************************************/
/********************************************************************************************************************************************************/
/***                                                                                                                                                  ***/
/***     >>>>>   This is the script used to create the view [forum_ResAnal].[dbo].[vg_03__AgeSex&Fertility_DisplayRules]                    <<<<<     ***/
/***                                                                                                                                                  ***/
/********************************************************************************************************************************************************/
-- complete (unfiltered) view could be stored in 
USE [forum_ResAnal]
GO
/********************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/********************************************************************************************************************************************************/
ALTER  VIEW
               [dbo].[vg_03__AgeSex&Fertility_DisplayRules]
AS
/********************************************************************************************************************************************************/
SELECT
----------------------------------------------------------------------------------------------------------------------------------------------------------
          [asfDR_row]                  = ROW_NUMBER()OVER(ORDER BY 
                                                        [IsDisplayed] DESC 
                                                    , A.[Field_year]
                                                    , A.[Scenario_pk]
                                                    , D.[Nation_fk]
                                                    , D.[Religion_Group_fk]
                                                    , D.[rows]               )
----------------------------------------------------------------------------------------------------------------------------------------------------------
      ,   [Ctry_EditorialName]         = CASE
                                         WHEN D.[Ctry_EditorialName] IS NULL
                                         THEN '>> ALL COUNTRIES <<'
                                         ELSE D.[Ctry_EditorialName]
                                         END
      ,   [Religion]                   = CASE
                                         WHEN D.[Pew_RelL02_Display] IS NULL
                                         THEN '>> ALL RELIGIONS <<'
                                         ELSE D.[Pew_RelL02_Display]
                                         END
      ,   [level]                      = CASE
                                         WHEN D.[level] IS NULL
                                         THEN 'Both Total & by cohorts'
                                         ELSE D.[level]
                                         END
----------------------------------------------------------------------------------------------------------------------------------------------------------
      , D.[Display_AgeSex_Str]
      , D.[Display_AgeStr_15Yrs]
      , D.[Display_MedianAge]
      , A.[Field_fk]
      , A.[Scenario_pk]
      , D.[Nation_fk]                  
      , D.[Religion_Group_fk]
      , A.[Field_year]
      , A.[Scenario_description]
      , A.[NofRows_by_Field&Scenario]
      , B.[NofRows_to_be_Hidden]
      ,   [NofRows_to_Display]         = ISNULL(C.[NofRows_to_Display], 0)
      , D.[rows]
  FROM
(
/* rows per Field&Scenario -----------------------------------------------------------------------------------------------------------------------------*/
SELECT 
       [Field_fk]
      ,[Scenario_pk]
      ,[Field_year]
      ,[Scenario_description]
      , COUNT(*)     [NofRows_by_Field&Scenario]
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]  X
     , [forum].[dbo].[Pew_Field]                          F
     , [forum].[dbo].[Pew_Scenario]                       S
WHERE 
       [Field_pk]
     = [Field_fk]
and
       X.[Scenario_id]
     = S.[Scenario_id]

GROUP
   BY
       [Field_fk]
      ,[Scenario_pk]
      ,[Field_year]
      ,[Scenario_description]
/* < rows per Field&Scenario ---------------------------------------------------------------------------------------------------------------------------*/
) A
LEFT OUTER JOIN 
(
/* rows per Field&Scenario&Display NOT DISPLAYED  ------------------------------------------------------------------------------------------------------*/
SELECT 
       [Field_fk]
      ,[Scenario_id]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
      , COUNT(*)     [NofRows_to_be_Hidden]
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
WHERE  [Display_AgeSex_Str]     = 0
AND    [Display_AgeStr_15Yrs]   = 0
AND    [Display_MedianAge]      = 0
GROUP
   BY
       [Field_fk]
      ,[Scenario_id]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
/* < rows per Field&Scenario&Display NOT DISPLAYED  ----------------------------------------------------------------------------------------------------*/
) B
ON      A.[Field_fk]
      = B.[Field_fk]
AND
        A.[Scenario_pk]
      = B.[Scenario_id]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
LEFT OUTER JOIN 
(
/* rows per Field&Scenario&Display DISPLAYED  ----------------------------------------------------------------------------------------------------------*/
SELECT 
       [Field_fk]
      ,[Scenario_id]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
      , COUNT(*)     [NofRows_to_Display]
      ,[IsDisplayed] = 1
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
WHERE  [Display_AgeSex_Str]    != 0
   OR  [Display_AgeStr_15Yrs]  != 0
   OR  [Display_MedianAge]     != 0
GROUP
   BY
       [Field_fk]
      ,[Scenario_id]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
/* < rows per Field&Scenario&Display DISPLAYED  --------------------------------------------------------------------------------------------------------*/
) C
ON      A.[Field_fk]
      = C.[Field_fk]
AND
        A.[Scenario_pk]
      = C.[Scenario_id]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
LEFT OUTER JOIN 
(
/* rows to be actually displaye by Field&Scenario&Ctry&Rel ---------------------------------------------------------------------------------------------*/
SELECT 
       [level]                = 'Total by Ctry&Rel'
      ,[Field_fk]
      ,[Scenario_id]
      ,[Nation_fk]
      ,[Ctry_EditorialName]
      ,[Religion_Group_fk]
      ,[Pew_RelL02_Display]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
      ,[rows]                 = COUNT(*) OVER(PARTITION BY [Field_fk]                   --NofTOT_by_Ctry&Rel
                                                         , [Scenario_id]
                                                         , [Nation_fk]
                                                         , [Religion_Group_fk] 
                                                         , [Display_AgeSex_Str]
                                                         , [Display_AgeStr_15Yrs]
                                                         , [Display_MedianAge]    )
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
     , [forum].[dbo].[Pew_Nation]
     , [forum].[dbo].[Pew_Religion_Group]
WHERE  [Sex_fk]                 = 0
AND    [Age_fk]                 = 0
AND(   [Display_AgeSex_Str]    != 0
    OR [Display_AgeStr_15Yrs]  != 0
    OR [Display_MedianAge]     != 0  )
AND    [Nation_fk]
     = [Nation_pk]
AND    [Religion_Group_fk]
     = [Religion_group_pk]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
UNION ALL
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT 
      DISTINCT
       [level]                = 'By Age&Sex cohorts'
      ,[Field_fk]
      ,[Scenario_id]
      ,[Nation_fk]
      ,[Ctry_EditorialName]
      ,[Religion_Group_fk]
      ,[Pew_RelL02_Display]
      ,[Display_AgeSex_Str]
      ,[Display_AgeStr_15Yrs]
      ,[Display_MedianAge]
      ,[rows]                 = COUNT(*) OVER(PARTITION BY [Field_fk]                   --NofTOT_by_Ctry&Rel
                                                         , [Scenario_id]
                                                         , [Nation_fk]
                                                         , [Religion_Group_fk] 
                                                         , [Display_AgeSex_Str]
                                                         , [Display_AgeStr_15Yrs]
                                                         , [Display_MedianAge]    )
  FROM [forum].[dbo].[Pew_Nation_Religion_Age_Sex_Value]
     , [forum].[dbo].[Pew_Nation]
     , [forum].[dbo].[Pew_Religion_Group]
WHERE  [Sex_fk]                != 0
AND    [Age_fk]                != 0
AND(   [Display_AgeSex_Str]    != 0
    OR [Display_AgeStr_15Yrs]  != 0
    OR [Display_MedianAge]     != 0  )
AND    [Nation_fk]
     = [Nation_pk]
AND    [Religion_Group_fk]
     = [Religion_group_pk]
/* < rows to be actually displaye by Field&Scenario&Ctry&Rel -------------------------------------------------------------------------------------------*/
) D
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
ON      A.[Field_fk]
      = D.[Field_fk]
AND
        A.[Scenario_pk]
      = D.[Scenario_id]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
/********************************************************************************************************************************************************/
