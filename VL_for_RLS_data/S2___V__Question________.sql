USE [RLS]
GO
/*********************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*********************************************************************************************************/
ALTER VIEW    [dbo].[Pew_Question]
AS
/*********************************************************************************************************/
SELECT
       [Q_pk]                       = ROW_NUMBER()
                                            OVER(
                                        ORDER BY  
                                               [Question_abbreviation_std]
                                             , [Question_Year]
                                             , [Question_abbreviation]      )
      ,[Question_pk]
      ,[Question_Std_fk]            =          [Question_Std_fk]
      ,[Question_abbreviation_std]
      ,[Question_abbreviation]
      ,[Question_wording_std]
      ,[Question_short_wording_std]
      ,[Question_wording]
      ,[Question_Year]
      ,[Notes]
      ,[AnswerSet_num]
      ,[Data_source_fk]
      ,[Editorially_Checked]
      ,[Display]
  FROM 
           [Pew_Question_NoStd]  QU
  FULL
  OUTER
   JOIN
           [Pew_Question_Std]    QS
     ON
           QU.Question_Std_fk
         = QS.Question_Std_pk
/*********************************************************************************************************/
GO
/*********************************************************************************************************/
