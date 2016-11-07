/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the view [for_x].[dbo].[V4short_LRestr_by_CYV]                                                  <<<<<     ***/
/***             This view only includes numeric values aggregated by country/religion & year & variable (long format).                                      ***/
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
ALTER  VIEW
               [dbo].[V4_L_by_CYV_extended]
AS
/***************************************************************************************************************************************************************/
SELECT
       *
  FROM
/***************************************************************************************************************************************************************/
(  
/***************************************************************************************************************************************************************/
SELECT   
       [Basic_updatable_data_pk] = ROW_NUMBER()OVER(ORDER BY Nation_fk, Question_Year, QA_std)
--      ,[entity]
--      ,[note]
      ,[link_fk]
      ,[Nation_fk]
      ,[Locality_fk]
      ,[Religion_fk]
      ,[Ctry_EditorialName]
      ,[Locality]
      ,[Religion]
      ,[Question_Year]
      ,[QA_std]
      ,[QW_std]
      ,[Answer_value]
      ,[answer_wording]
      ,[answer_wording_std]
      ,[Question_fk]
      ,[Answer_fk]
      ,[Notes]


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
       distinct
       [entity]
      --,[link_fk]
      --,[Nation_fk]
      --,[Locality_fk]
      --,[Religion_fk]
      --,[Region5]
      --,[Region6]
      --,[Ctry_EditorialName]
      --,[Locality]
      --,[Religion]
      --,[Question_Year]
      --,[QA_std]
      --,[QW_std]
      --,[Answer_value]
      --,[answer_wording]
      --,[answer_wording_std]
      --,[Question_fk]
      --,[Answer_fk]
      --,[Notes]
  FROM [forum_ResAnal].[dbo].[V1_DB_Long]
  
  


        [row_key]            = ROW_NUMBER()
                               OVER(ORDER BY   
                                                  V.[Nation_fk]
                                                , Q.[Q_Number]
                                                , V.[Question_Year]
                                                , V.[Variable]
                                                , V.[Value]                      ) 
      ,  [Nation_fk]
      ,  [Ctry_EditorialName]
      ,  [YEAR]
      ,  [Question_Year]
      ,  [GRI]
      ,  [SHI]
      ,  [GFI]
      ,V.[Variable]
      ,  [Value]
      ,  [PctWg]
      ,  [PctWgR5]
      ,  [PctWgR6]
      ,  [CntWg]
      ,Q.[Q_Number]
  FROM [V4_L_by_CYV]       V
     , [AllQuestions]      Q
WHERE  
       V.[Variable]
     = Q.[Variable]
/***************************************************************************************************************************************************************/
)   AS  V4s
/***************************************************************************************************************************************************************/
    WHERE                                                                       /*** begining of filters to be applied...                                    ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'CSR%'                                           /*** filter to exclude CSR questions                                         ***/
    AND                                                                         /*** second filter to be applied...                                          ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'ERI%'                                           /*** filter to exclude ERI questions                                         ***/
    AND                                                                         /*** third filter to be applied...                                           ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'IEI%'                                           /*** filter to exclude IEI questions                                         ***/
    AND                                                                         /*** fourth filter to be applied...                                          ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'PPR%'                                           /*** filter to exclude PPR questions                                         ***/
    AND                                                                         /*** ficth filter to be applied...                                           ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE 'RIR%'                                           /*** filter to exclude RIR questions                                         ***/
    AND                                                                         /*** ficth filter to be applied...                                           ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE '%_ny'                                           /*** filter to exclude y/n (repeated) questions                              ***/
    AND                                                                         /*** ficth filter to be applied...                                           ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT LIKE '%_dummy'                                        /*** filter to exclude dummy questions                                       ***/
    AND                                                                         /*** ficth filter to be applied...                                           ***/
          [Variable]                                                            /*** field in view including varnames (also those to be excluded)            ***/
                      NOT IN (                                                  /*** filter to exclude unuseful Restrictions/Hostilities questions           ***/
                                  'GRI_01_x2'
                                , 'XSG_S_99_01'
                                , 'XSG_S_99_02'
                                , 'XSG_S_99_03'
                                , 'XSG_S_99_04'
                                , 'XSG_S_99_05'
                                , 'XSG_S_99_06'
                                , 'GRI_20_05_x1'
                                , 'GRX_21_01'
                                , 'GRX_21_02'
                                , 'GRX_21_03'
                                                            )


--      ,[entity]
--      ,[note]
      ,[link_fk]
      ,[Nation_fk]
      ,[Locality_fk]
      ,[Religion_fk]
      ,[Ctry_EditorialName]
      ,[Locality]
      ,[Religion]
      ,[Question_Year]
      ,[QA_std]
      ,[QW_std]
      ,[Answer_value]
      ,[answer_wording]
      ,[answer_wording_std]
      ,[Question_fk]
      ,[Answer_fk]
      ,[Notes]


SELECT [Nation_fk]
      ,[Ctry_EditorialName]
      ,[Region5Yr]
      ,[Region6Yr]
      ,[Region5]
      ,[Region6]
      ,[YEAR]
      ,[Question_Year]
      ,[GRI]
      ,[SHI]
      ,[GFI]
      ,[Variable]
      ,[Value]
      ,[PctWg]
      ,[PctWgR5]
      ,[PctWgR6]
      ,[CntWg]
  FROM [forum_ResAnal].[dbo].[V4_L_by_CYV]