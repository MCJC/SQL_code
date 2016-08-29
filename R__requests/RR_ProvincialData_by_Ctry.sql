USE [for_x]
GO

/****** Object:  View [dbo].[V9X_INDIA]    Script Date: 08/27/2013 11:10:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/***************************************************************************************************************************************************************/
--create VIEW
CREATE  VIEW
               [dbo].[V9X_INDIA]
AS
/***************************************************************************************************************************************************************/
SELECT 
       [V9xRow]
      ,[Ctry_EditorialName]
      ,[Locality]
                = case
                  when [entity]  = 'Prov'
                  then [Locality] + ': Description of events' 
                  else ''
                  end
      ,[Question_Year]
      ,[QA_std]
                = case 
                  when [QA_std]  = 'GRI_08_index'
                  then             'GRI_08'
                  when [QA_std]  = 'SHI_11_index'
                  then             'SHI_11'
                  else [QA_std]
                  end
      ,[QW_std]
      --,[Answer_value]
      --                 = case 
      --            when [entity]  = 'Prov'
      --            then null
      --            else [Answer_value]
      --            end
      ,[AW_std]
                       = case 
                  when [entity] != 'Prov'
                  then [AW_std]
                  when [entity]  = 'Prov'
                  then [AW_det]
                  end
  FROM [for_x].[dbo].[T9x_LongData]
WHERE 
       [Ctry_EditorialName] = 'India'
AND
       [entity] = 'Prov'
AND
       [AW_det] IS NOT NULL
AND
       [AW_det] != ''


AND
       [Question_Year]  != 2012

AND
       [QA_std]  IN (
                       'GRI_01'
                     , 'GRI_02'
                     , 'GRI_03'
                     , 'GRI_04'
                     , 'GRI_05'
                     , 'GRI_06'
                     , 'GRI_07'
--                     , 'GRI_08'
                     , 'GRI_08_index'
                     , 'GRI_09'
                     , 'GRI_10'
                     , 'GRI_11'
                     , 'GRI_12'
                     , 'GRI_13'
                     , 'GRI_14'
                     , 'GRI_15'
                     , 'GRI_16'
                     , 'GRI_17'
                     , 'GRI_18'
                     , 'GRI_19'
                     , 'GRI_19_b'
                     , 'GRI_19_c'
                     , 'GRI_19_d'
                     , 'GRI_19_e'
                     , 'GRI_19_f'
                     , 'GRI_20'
                     , 'GRI_20_01'
                     , 'GRI_20_02'
                     , 'GRI_20_03_a'
                     , 'GRI_20_03_b'
                     , 'GRI_20_03_c'
                     , 'GRI_20_03_top'
                     , 'GRI_20_04'
                     , 'GRI_20_05'
                     , 'GRI_20_top'
                     , 'SHI_01'
                     , 'SHI_01_a'
                     , 'SHI_01_b'
                     , 'SHI_01_c'
                     , 'SHI_01_d'
                     , 'SHI_01_e'
                     , 'SHI_01_f'
                     , 'SHI_02'
                     , 'SHI_03'
                     , 'SHI_04'
                     , 'SHI_04_b'
                     , 'SHI_04_c'
                     , 'SHI_04_d'
                     , 'SHI_04_e'
                     , 'SHI_04_f'
                     , 'SHI_05'
                     , 'SHI_05_b'
                     , 'SHI_05_c'
                     , 'SHI_05_d'
                     , 'SHI_05_e'
                     , 'SHI_05_f'
                     , 'SHI_06'
                     , 'SHI_07'
                     , 'SHI_08'
                     , 'SHI_09'
                     , 'SHI_10'
                     , 'SHI_11_index'
                     , 'SHI_12'
                     , 'SHI_13'
                                       )       


  
GO


