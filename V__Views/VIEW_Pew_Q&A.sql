USE [forum]
GO
/*********************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*********************************************************************************************************/
ALTER VIEW    [dbo].[Pew_Q&A]
AS
/*********************************************************************************************************/
SELECT
       [QA_pk]                      = ROW_NUMBER()
                                            OVER(
                                        ORDER BY  
                                                [Q_pk]
                                              , [AnswerSet_number]
                                              , [Answer_value_Std]
                                              , [Answer_value_NoStd]
                                              , [Answer_Wording]     )
      ,[Question_Std_fk]
      ,[Question_fk]                = [Question_pk]
      ,[AnswerSet_num]
      ,[AnswerSet_number]
      ,[Answer_Std_fk]
      ,[Answer_fk]                  = [Answer_pk]
      ,[Data_source_fk]
      ,[Pew_Data_Collection]
      ,[Pew_Data_SubCollection]
      ,[Data_source_name]
      ,[Question_abbreviation_std]
      ,[Question_abbreviation]
      ,[Question_wording_std]
      ,[Question_short_wording_std]
      ,[Question_wording]
      ,[Question_Year]
      ,[Notes]
      ,[Answer_value]               = CASE 
                                          WHEN      [Answer_value_Std]          IS NULL
                                                 OR [Question_abbreviation_std] LIKE 'SHI_05_b'  -- not coded for VStd
                                          THEN -1
                                          WHEN      [Question_abbreviation_std] LIKE 'GRI_19_[b-f]%'
                                                 OR [Question_abbreviation_std] LIKE 'SHI_01_[b-f]%'
                                                 OR [Question_abbreviation_std] LIKE 'SHI_04_[b-f]%'
                                                 OR [Question_abbreviation_std] LIKE 'SHI_05_[c-f]%'
                                          THEN [Answer_value_NoStd]
                                          ELSE [Answer_value_Std]
                                       END
----  ,[Answer_value]               = CASE                                    /* 1ST VERSION OF CODE */
----                                      WHEN [Answer_value_Std] IS NOT NULL
----                                      THEN [Answer_value_Std]
----                                      WHEN [Answer_value_Std] IS     NULL
----                                       AND (    [Question_abbreviation_std] LIKE 'GRI_19_[b-f]%'
----                                             OR [Question_abbreviation_std] LIKE 'SHI_01_[b-f]%'
----                                             OR [Question_abbreviation_std] LIKE 'SHI_04_[b-f]%'
----                                             OR [Question_abbreviation_std] LIKE 'SHI_05_[c-f]%'  )
----                                      THEN [Answer_value_NoStd]
----                                      ELSE -1
----                                   END
      ,[Answer_value_Std]
      ,[Answer_value_NoStd]
      ,[Answer_Wording_std]
      ,[Answer_Wording]
      ,[Full_set_of_Answers]
      ,[NA_by_set_of_Answers]
      ,[Display]
      ,[Display_NoStd]
      ,[Editorially_Checked]
  FROM
/*********************************************************************************************************/
       [Pew_Question]                                                                      Q
/*********************************************************************************************************/
  FULL
  OUTER
   JOIN
/*********************************************************************************************************/
(
/*********************************************************************************************************/
SELECT
       [Answer_pk]
      ,[Answer_value_NoStd]
      ,[Answer_Wording]
      ,[Question_fk]
      ,[AnswerSet_number]
      ,[Answer_value_Std]
      ,[Answer_Wording_std]
      ,[Full_set_of_Answers]
      ,[NA_by_set_of_Answers]
      ,[Answer_Std_fk]              = CASE
                                           WHEN [Answer_Std_fk] IS NULL 
                                           THEN [Answer_Std_pk]
                                           ELSE [Answer_Std_fk]
                                       END
/*-------------------------------------------------------------------------------------------------------*/
  FROM
       [Pew_Answer_NoStd]
  FULL
  OUTER
   JOIN
       [Pew_Answer_Std]
/*-------------------------------------------------------------------------------------------------------*/
     ON
            Answer_Std_fk
         =  Answer_Std_pk
/*-------------------------------------------------------------------------------------------------------*/
)                                                                                                        A
/*********************************************************************************************************/
ON
       [Question_fk]
      =[Question_pk]
/*********************************************************************************************************/
  LEFT
   JOIN
/*********************************************************************************************************/
/*-------------------------------------------------------------------------------------------------------*/
       [Pew_Data_Source]                                                                   D
/*********************************************************************************************************/
ON
       [Data_Source_fk]
      =[Data_Source_pk]
/*********************************************************************************************************/
GO
/*********************************************************************************************************/
