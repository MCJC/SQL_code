SELECT *
FROM
/*** View including values for current and former year *********************************************************************************************************/
               [dbo].[v05_ReportData]
WHERE  [Variable]       IN (
                                'SHI_11_a_n'
                         ,      'SHI_11_b_n'
                         ,      'SHI_11_a'
                         ,      'SHI_11_b'
                           )
                                                        
SELECT distinct [Question_Year]
      ,[SHI_11_b]
      ,[SHI_11_a]
--      ,[SHI_11_b_DES]
  --    ,[SHI_11_a_DES]
  FROM [GRSHR2015].[dbo].[v02_AllCodedValues]
--

SELECT   -- distinct
          [Question_Year]
      ,   [QA_std]              /* [QA_std] is provisionally recoded here...       */
      ,   [QW_std]              /* [QA_std] is provisionally recoded here...       */
      ,   [Answer_value]        /* [Answer_value] is provisionally recoded here, 
                                   before we actually recode it in the database
                                   inorder to have just a consistent distridution
                                   Other variable will be added, if needed, for
                                   catching nuances.                               */
    --,   [answer_wording]
      ,   [answer_wording_std]
	  , [Nation_fk]
	  , [Ctry_EditorialName]
FROM      [forum_ResAnal].[dbo].[vr_06w_LongData_ALL]  
WHERE
          [QA_std] like  'SHI_11%'
		  --[QA_std] in    ( 'SHI_11', 'SHI_11_x')
--and       [Answer_value] = '0.50'
and        [Question_Year] = 2013
and [Nation_fk] in
(
--13,
--20,
--36,
--43,
--53,
--54,
--70,
--76,
--98,
--127,
--149,
--156,
--165,
--190,
--195,
--200,
--205,
--79,
--117,
--131,
--146,
--206,
--220,
55
 )

order by        [QA_std],[Answer_value], [Question_Year]

--
select distinct [Question_Year], [QA_std], [QW_std], [Answer_value], [answer_wording_std] -- select *
FROM      [forum_ResAnal].[dbo].[vr_06w_LongData_ALL]                        /* NOTICE THIS IS 2014 WORKING DATA => DATA FROM DB AFTER RLS REMOVED*/ 
/*------------------------------------------------------------------------------------------------------------------------------------------------*/
WHERE
          [QA_std] like  'SHI_11%'
order by        [QA_std], [QW_std], [Answer_value], [Question_Year]




/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Nation_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Question_Year]
      ,[SHI_11]
      ,[SHI_11_a]
      ,[SHI_11_x]
  FROM [forum_ResAnal].[dbo].[vr___02_cDB_Wide__by_Ctry&Year]
where

[Nation_fk] = 55
and
[Question_Year] = 2013


USE [forum_ResAnal]
GO
SELECT
        [QA_fk]                  =   Q.[QA_pk]
      , [link_fk]                =   K.[Nation_answer_pk]
      , [Nation_fk]              =   N.[Nation_pk]
      , [Ctry_EditorialName]     =   N.[Ctry_EditorialName]
      , [Question_Year]          =   Q.[Question_Year]
      , [QA_std]                 =   Q.[Question_abbreviation_std]
      , [QW_std]                 =   Q.[Question_short_wording_std]
      , [Answer_value]           =   Q.[Answer_value]
      , [Answer_value_Std]       =   Q.[Answer_value_Std]
      , [Answer_value_NoStd]     =   Q.[Answer_value_NoStd]
      , [answer_wording]         =   Q.[answer_wording]
      , [answer_wording_std]     =   Q.[answer_wording_std]
      , [Data_source_name]       =   Q.[Data_source_name]
      , [Question_Std_fk]        =   Q.[Question_Std_fk]
      , [Question_fk]            =   Q.[Question_fk]
      , [Answer_Std_fk]          =   Q.[Answer_Std_fk]
      , [Answer_fk]              =   Q.[Answer_fk]
      , [AnswerSet_number]       =   Q.[AnswerSet_number]
      , [Question_wording_std]   =   Q.[Question_wording_std]
      , [Question_wording]       =   Q.[Question_wording]
      , [Question_abbreviation]  =   Q.[Question_abbreviation]
      , [NA_by_set_of_Answers]   =   Q.[NA_by_set_of_Answers]
      , [Full_set_of_Answers]    =   Q.[Full_set_of_Answers]
      , [Display_by_StdQ]        =   Q.[Display]
      , [Display_by_NoSQ]        =   Q.[Display_NoStd]
      , [Display_by_Ans]         =   K.[Display]
      , [Editorially_Checked]    =   Q.[Editorially_Checked]
      , [Notes]                  =   Q.[Notes]

  FROM [forum]..[Pew_Q&A]                      Q
      ,[forum]..[Pew_Nation]                   N
      ,[FORUM]..[Pew_Nation_Answer]            K

    WHERE Q.[Answer_fk]           = K.[Answer_fk]
      AND Q.[Pew_Data_Collection] = 'Global Restriction on Religion Study'
      AND K.[Nation_fk]           =  N.[Nation_pk]
      AND N.[Nation_pk]           = 55
      AND Q.[Question_Year]       = 2013
	  AND Q.[Question_abbreviation_std] LIKE 'SHI_11%' 

/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 003    ------------------------------------------------------------------------------------------ '
/***************************************************************************************************************************************************************/
/***                                                                                                                                            ***/
/***     >>>>>         This script creates long set of data from the 'Global Restriction on Religion Study'                           <<<<<     ***/
/***                   The long set of data includes numeric values and descriptive wordings for GR&SH R                                        ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
USE [forum_ResAnal]
GO
/**************************************************************************************************************************************************/
IF OBJECT_ID  (N'[forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]', N'U') IS NOT NULL
DROP TABLE       [forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]
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
 INTO                   [vr___01_cDB_Long__NoAggregated]
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
AND
QA_std                                 NOT LIKE       '%_d'+ '[a,b]'       /* exclude all da/db counts from 2010                                  */
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
