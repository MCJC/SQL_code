USE [RLS]
GO
/*********************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*********************************************************************************************************/
ALTER VIEW    [dbo].[Pew_Q&A_Std]
AS
/*********************************************************************************************************/
SELECT
       [QAStd_pk]                      = ROW_NUMBER()
                                            OVER(
                                            ORDER BY  
                                                      [Question_abbreviation_std]
                                                    , [Answer_value_Std]            )
      ,[Question_Std_fk]               = [Question_Std_pk]
      ,[Answer_Std_fk]                 = [Answer_Std_pk]
      ,[Question_abbreviation_std]
      ,[Question_wording_std]
      ,[Question_short_wording_std]
      ,[Question_Label_80Chars]
      ,[Answer_value_std]
      ,[Answer_Wording_std]
      ,[Display]
      ,[AnswerSet_num]
      ,[Editorially_Checked]
      ,[Full_set_of_Answers]
      ,[NA_by_set_of_Answers]
  FROM
/*********************************************************************************************************/
       [Pew_Question_Std]
     , [Pew_Answer_Std]
/*********************************************************************************************************/
WHERE
       [AnswerSet_num]
      =[AnswerSet_number]
/*********************************************************************************************************/
GO
/*********************************************************************************************************/
