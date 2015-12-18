USE [forum]
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
                                                CASE 
                                                WHEN [Question_abbreviation_std] IS NULL        THEN 0
                                                WHEN [Question_abbreviation_std] IN ( 'GRI'
                                                                                     ,'SHI'
                                                                                     ,'GFI' )   THEN 0.50
                                                WHEN [Question_abbreviation_std] LIKE '%scaled' THEN 0.75
                                                WHEN [Question_abbreviation_std] LIKE     'GR%' THEN 1
                                                WHEN [Question_abbreviation_std] LIKE     'SH%' THEN 1
                                                WHEN [Question_abbreviation_std] LIKE     'XS%' THEN 1
                                                WHEN [Question_abbreviation_std] LIKE     'GF%' THEN 1
                                                WHEN [Question_abbreviation_std] LIKE     'SV%' THEN 2
                                                WHEN [Question_abbreviation_std] LIKE     'CS%' THEN 3
                                                WHEN [Question_abbreviation_std] LIKE     'ER%' THEN 3
                                                WHEN [Question_abbreviation_std] LIKE     'IE%' THEN 3
                                                WHEN [Question_abbreviation_std] LIKE     'PP%' THEN 3
                                                WHEN [Question_abbreviation_std] LIKE     'RI%' THEN 3
                                                END
                                             , [Question_abbreviation_std]
                                             , [Question_Year]
                                             , [Question_abbreviation]                                    )
      ,[Question_pk]
      ,[Question_Std_fk]            = CASE
                                           WHEN [Question_Std_fk] IS NULL 
                                           THEN [Question_Std_pk]
                                           ELSE [Question_Std_fk]
                                       END
      ,[Question_abbreviation_std]
      ,[Question_abbreviation]
      ,[Question_wording_std]
      ,[Question_short_wording_std]
      ,[Question_Label_80Chars]          --  added Dec2015
      ,[Question_wording]
      ,[Question_Year]
      ,[Notes]
      ,[AnswerSet_num]
      ,[Data_source_fk]
      ,[Editorially_Checked]
      ,[Display]                             = QS.[Display]
      ,[Display_NoStd]                       = QU.[Display]

  FROM 
           [forum].[dbo].[Pew_Question_NoStd]  QU
  FULL
  OUTER
   JOIN
           [forum].[dbo].[Pew_Question_Std]    QS
     ON
           QU.Question_Std_fk
         = QS.Question_Std_pk
/*********************************************************************************************************/
GO
/*********************************************************************************************************/
