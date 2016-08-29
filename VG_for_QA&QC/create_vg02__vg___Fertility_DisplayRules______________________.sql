/********************************************************************************************************************************************************/
/********************************************************************************************************************************************************/
/***                                                                                                                                                  ***/
/***     >>>>>   This is the script used to create the view [forum_ResAnal].[dbo].[vg_01__Fertility_DisplayRules]                           <<<<<     ***/
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
               [dbo].[vg_02__Fertility_DisplayRules]
AS
/********************************************************************************************************************************************************/
SELECT
----------------------------------------------------------------------------------------------------------------------------------------------------------
          [fDR_row]                    = ROW_NUMBER()OVER(ORDER BY 
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
      ,   [Measurement]                = CASE
                                         WHEN D.[Measurement] IS NULL
                                         THEN 'Any Measurement'
                                         ELSE D.[Measurement]
                                         END
----------------------------------------------------------------------------------------------------------------------------------------------------------
      , D.[Display]
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
  FROM [forum].[dbo].[Pew_Nation_Religion_Fertility_Value] X
     , [forum].[dbo].[Pew_Field]                           F
     , [forum].[dbo].[Pew_Scenario]                        S
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
      ,[Display]
      , COUNT(*)     [NofRows_to_be_Hidden]
  FROM [forum].[dbo].[Pew_Nation_Religion_Fertility_Value]
WHERE  [Display]                = 0
GROUP
   BY
       [Field_fk]
      ,[Scenario_id]
      ,[Display]
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
      ,[Display]
      , COUNT(*)     [NofRows_to_Display]
      ,[IsDisplayed] = 1
  FROM [forum].[dbo].[Pew_Nation_Religion_Fertility_Value]
WHERE  [Display]               != 0
GROUP
   BY
       [Field_fk]
      ,[Scenario_id]
      ,[Display]
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
/* rows to be actually displayed by Field&Scenario&Ctry&Rel --------------------------------------------------------------------------------------------*/
SELECT 
      DISTINCT
       [Measurement]
      ,[Field_fk]
      ,[Scenario_id]
      ,[Nation_fk]
      ,[Ctry_EditorialName]
      ,[Religion_Group_fk]
      ,[Pew_RelL02_Display]
      ,[Display]
      ,[rows]                 = COUNT(*) OVER(PARTITION BY [Field_fk]                   --NofTOT_by_Ctry&Rel
                                                         , [Scenario_id]
                                                         , [Nation_fk]
                                                         , [Religion_Group_fk] 
                                                         , [Display]              )
  FROM [forum].[dbo].[Pew_Nation_Religion_Fertility_Value]
     , [forum].[dbo].[Pew_Nation]
     , [forum].[dbo].[Pew_Religion_Group]
WHERE  [Display]               != 0
AND    [Nation_fk]
     = [Nation_pk]
AND    [Religion_Group_fk]
     = [Religion_group_pk]
/* < rows to be actually displayed by Field&Scenario&Ctry&Rel ------------------------------------------------------------------------------------------*/
) D
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
ON      A.[Field_fk]
      = D.[Field_fk]
AND
        A.[Scenario_pk]
      = D.[Scenario_id]
/*------------------------------------------------------------------------------------------------------------------------------------------------------*/
/********************************************************************************************************************************************************/
