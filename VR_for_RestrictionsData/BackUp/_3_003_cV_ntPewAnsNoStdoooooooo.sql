/***************************************************************************************************************************************************************/
Print 
'--- ' + CONVERT (VARCHAR(19), SYSDATETIME()) + ' ==>  script 3.002    ---------------------------------------------------------------------------------------- '
/***************************************************************************************************************************************************************/
/***                                                                                                                                                         ***/
/***     >>>>>   This is the script used to create the VIEW vr___01_cDB_Long__NoAggregated




                                                       lookup table [forum_ResAnal].[dbo].[vr_05w_SemiWide_by_Ctry&Year]                           <<<<<     ***/
/***             This table only includes numeric values aggregated by country/religion & year (does not include descriptive wordings).                      ***/
/***                                                                                                                                                         ***/
/***                                                      > > >     lookup tables work faster     < < <                                                      ***/
/***                                                                                                                                                         ***/
/***************************************************************************************************************************************************************/
USE [GRSHRcode]
GO
/***************************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/***************************************************************************************************************************************************************/
ALTER VIEW     [vr___01_wDB_Long__NoAggregated]
AS

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
       [entity]                     =  [CRL]
      ,[QA_fk]                      =   0
      ,[link_fk]                    =  CASE
	                             WHEN  [na_Nation_answer_pk]            IS NOT NULL
								 THEN  [na_Nation_answer_pk]
								 WHEN  [la_Locality_answer_pk]          IS NOT NULL
								 THEN  [la_Locality_answer_pk]
								 WHEN  [ra_Nation_religion_answer_pk]   IS NOT NULL
								 THEN  [ra_Nation_religion_answer_pk]
								        END
      ,[Nation_fk]                  =  [Nfk]
      ,[Locality_fk]                =  [Lfk]
      ,[Religion_fk]                =  [Rfk]
      ,[Region5]                    =  [R_5]
      ,[Region6]                    =  [R_6]
      ,[Ctry_EditorialName]         =  [CEN]
      ,[Locality]                   =  [loc]
      ,[Religion]                   =  [rel]
      ,[Question_Year]              =  [qr_Question_Year]
      ,[QA_std]                     =  [QAs]
      ,[QW_std]                     =  [qs_Question_short_wording_std]
      ,[Answer_value]               =  [AVn]
      ,[Answer_value_Std]           =  [AVs]
      ,[Answer_value_NoStd]         =  [AVn]
      ,[answer_wording]             =  [AWn]
      ,[answer_wording_std]         =  [AWs]
      ,[Data_source_name]           =  [dsn]
      ,[Question_Std_fk]            =  [QSk]
      ,[Question_fk]                =  [QRk]
      ,[Answer_Std_fk]              =  [ASk]
      ,[Answer_fk]                  =  [ARp]
      ,[AnswerSet_number]           =  [qs_AnswerSet_num]
      ,[Question_wording_std]       =  [qs_Question_wording_std]
      ,[Question_wording]           =  [qr_Question_wording]
      ,[Question_abbreviation]      =  [qr_Question_abbreviation]
      ,[NA_by_set_of_Answers]       =  [as_NA_by_set_of_Answers]
      ,[Full_set_of_Answers]        =  [as_Full_set_of_Answers]
      ,[Display_by_StdQ]            =  [qs_Display]
      ,[Display_by_NoSQ]            =  [qr_Display]
      ,[Display_by_Ans]
      ,[link_fk]                    =  CASE
	                             WHEN  [na_display]                     IS NOT NULL
								 THEN  [na_display]
								 WHEN  [la_display]                     IS NOT NULL
								 THEN  [la_display]
								 WHEN  [ra_display]                     IS NOT NULL
								 THEN  [ra_display]
								        END
      ,[Editorially_Checked]        =  [qs_Editorially_Checked]
      ,[Notes]                      =  [qr_Notes]




 [entity][CRL]
      ,[QA_fk]                         = 0
      ,[link_fk]      =  [na_Nation_answer_pk]      =  [la_Locality_answer_pk]      =  [ra_Nation_religion_answer_pk]
      ,[Nation_fk]      =  [Nfk]
      ,[Locality_fk]      =  [Lfk]
      ,[Religion_fk]      =  [Rfk]
      ,[Region5]      =  [R_5]
      ,[Region6]      =  [R_6]
      ,[Ctry_EditorialName]      =  [CEN]
      ,[Locality]      =  [loc]
      ,[Religion]      =  [rel]
      ,[Question_Year]      =  [qr_Question_Year]
      ,[QA_std]      =  [QAs]
      ,[QW_std]      =  [qs_Question_short_wording_std]
      ,[Answer_value]
      ,[Answer_value_Std]      =  [AVs]
      ,[Answer_value_NoStd]      =  [AVn]
      ,[answer_wording]      =  [AWn]
      ,[answer_wording_std]      =  [AWs]
      ,[Data_source_name]      =  [dsn]
      ,[Question_Std_fk]      =  [QSk]
      ,[Question_fk]      =  [QRk]
      ,[Answer_Std_fk]      =  [ASk]
      ,[Answer_fk]      =  [ARp]
      ,[AnswerSet_number]      =  [qs_AnswerSet_num]
      ,[Question_wording_std]      =  [qs_Question_wording_std]
      ,[Question_wording]      =  [qr_Question_wording]
      ,[Question_abbreviation]      =  [qr_Question_abbreviation]
      ,[NA_by_set_of_Answers]      =  [as_NA_by_set_of_Answers]
      ,[Full_set_of_Answers]      =  [as_Full_set_of_Answers]
      ,[Display_by_StdQ]      =  [qs_Display]
      ,[Display_by_NoSQ]      =  [qr_Display]
      ,[Display_by_Ans]      =  [na_display]      =  [la_display]      =  [ra_display]
      ,[Editorially_Checked]      =  [qs_Editorially_Checked]
      ,[Notes]      =  [qr_Notes]


 TOP 1000 [entity]
      ,[QA_fk]
      ,[link_fk]
      ,[Nation_fk]
      ,[Locality_fk]
      ,[Religion_fk]
      ,[Region5]
      ,[Region6]
      ,[Ctry_EditorialName]
      ,[Locality]
      ,[Religion]
      ,[Question_Year]
      ,[QA_std]
      ,[QW_std]
      ,[Answer_value]
      ,[Answer_value_Std]
      ,[Answer_value_NoStd]
      ,[answer_wording]
      ,[answer_wording_std]
      ,[Data_source_name]
      ,[Question_Std_fk]
      ,[Question_fk]
      ,[Answer_Std_fk]
      ,[Answer_fk]
      ,[AnswerSet_number]
      ,[Question_wording_std]
      ,[Question_wording]
      ,[Question_abbreviation]
      ,[NA_by_set_of_Answers]
      ,[Full_set_of_Answers]
      ,[Display_by_StdQ]
      ,[Display_by_NoSQ]
      ,[Display_by_Ans]
      ,[Editorially_Checked]
      ,[Notes]
  FROM [forum_ResAnal].[dbo].[vr___01_cDB_Long__NoAggregated]


