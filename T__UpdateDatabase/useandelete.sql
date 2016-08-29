---------------------------------------------------------------------------------------------------------------------------------------------------------
--+    '  [SVYc_0068] AS [RelAffili]'                                             /*** Most specific religious affiliation...    >> 'DENOM'          ***/
---------------------------------------------------------------------------------------------------------------------------------------------------------
--+    ', [SVYp_0255] AS [RelFamily]'                                             /*** Rel Fams (2nd level)...  'DENOM' gp into DenomFams (by RTrad) ***/
---------------------------------------------------------------------------------------------------------------------------------------------------------
--+    ', [SVYp_0354] AS [RelTradit]'                                             /*** Rel Trads (1st level)... FAMILY gp into R Trads               ***/
---------------------------------------------------------------------------------------------------------------------------------------------------------


last also add to microdata, then load



/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Question_Std_pk]
      ,[Question_abbreviation_std]
      ,[Question_wording_std]
      ,[Question_short_wording_std]
      ,[Display]
      ,[AnswerSet_num]
      ,[Editorially_Checked]
      ,[Question_Label_80Chars]
  FROM [x_LoadRLS1cUS].[dbo].[Pew_Question_Std]
WHERE 
       [Question_abbreviation_std] in ( 'SVYc_0068', 'SVYp_0255', 'SVYp_0354' )



/*****************************************************************************************************************************************************/
SELECT 
       [Question_Std_pk]            = CASE
                                           WHEN PQS.[Question_Std_pk] IS not NULL THEN PQS.[Question_Std_pk]
                                           ELSE (( ROW_NUMBER()
                                                         OVER( PARTITION BY MSQ.[StdVarName]
                                                                   ORDER BY MAn.[VarName])   )
                                                   + (SELECT MAX([Question_Std_pk]) FROM [stdaq].[dbo].[Pew_Question_Std])  )
                                       END
      ,[Question_pk]                = ROW_NUMBER()
                                            OVER( ORDER BY MAn.[VarName])
                                     + (SELECT MAX([Question_pk]) FROM [stdaq].[dbo].[Pew_Question_nOStd])
      ,[Question_abbreviation]      = 'RLS07_' + MAn.[VarName]
      ,[Question_wording]           = MAn.[VarLabel]
      ,[Data_source_fk]             = 0
      ,[Question_Year]              = 2007
      ,[Short_wording]              = ''
      ,[Notes]                      = ''
      ,[Default_response]           = ''
      ,[AnswerSet_number]           = MAn.[AnswerSet_number]
      ,[Full_set_of_Answers]        = MAn.[Full_set_of_Answers]

      ,[Question_abbreviation_std]  = CASE
                                           WHEN MSQ.[StdVarName] IS not NULL THEN MSQ.[StdVarName]
                                           ELSE
                                                       'SVYp_' 
                                               + RIGHT('00000'
                                               + CAST((
                                                     (   SELECT COUNT([Question_Std_pk])
                                                           FROM [Pew_Question_Std]
                                                          WHERE [Question_abbreviation_std] LIKE 'svy%' )
                                                      +  ROW_NUMBER()
                                                               OVER( PARTITION BY MSQ.[StdVarName]
                                                                         ORDER BY MAn.[VarName])          )
                                                                                                           AS varchar(4)),4)
                                       END
----                                               + CAST((
----                                                       (SELECT MAX(CAST(SUBSTRING([Question_abbreviation_std], 6, 4) AS INT))
----                                                          FROM [stdaq].[dbo].[Pew_Question_Std]
----                                                         WHERE [Question_abbreviation_std] like 'SVYu%'                      )
----                                                      +  ROW_NUMBER()
----                                                               OVER( PARTITION BY MSQ.[StdVarName]
----                                                                         ORDER BY MAn.[VarName])                              )
----                                                                                                                               AS varchar(4)),4)
      ,[Question_wording_std]       = CASE
                                           WHEN PQS.[Question_wording_std]       IS not NULL THEN PQS.[Question_wording_std]
                                       END
      ,[Question_short_wording_std] = CASE
                                           WHEN PQS.[Question_short_wording_std] IS not NULL THEN PQS.[Question_short_wording_std]
                                           ELSE  LTRIM(RIGHT([VarLabel],(LEN([VarLabel])-(CHARINDEX(' ',[VarLabel])-1))))
                                       END
      ,[Display]                    = CASE
                                           WHEN PQS.[Display] IS not NULL
                                           THEN PQS.[Display]
                                           ELSE 0
                                       END
      ,[Editorially_Checked]        = CASE
                                           WHEN PQS.[Question_short_wording_std] IS not NULL
                                           THEN 'Yes'
                                           ELSE 'NO!'
                                       END
     





SELECT 
       --DISTINCT
       [Answer_pk]
      ,[Answer_value_NoStd]
      ,[Answer_Wording]
      ,[Answer_Std_fk]
      ,[Question_fk]
      ,[Question_abbreviation]
      ,[Q] = SUBSTRING([Question_abbreviation], 10, 8)

  FROM [Pew_Answer_NoStd]
     , [Pew_Question_NoStd]
WHERE
       [Question_fk] IN (  SELECT [Question_pk]
                            FROM [Pew_Question_NoStd]
                           WHERE [Question_Std_fk] IN ( 344, 804, 903 )
                             AND [Question_abbreviation] LIKE 'RLS%'     )
  AND
       [Question_pk]
     = [Question_fk]

ORDER BY
       SUBSTRING([Question_abbreviation], 10, 8)
      ,[Question_abbreviation]
      ,[Answer_Wording]

 




SELECT [A_pk]
      ,[Answer_pk]
      ,[Answer_Std_fk]
      ,[AnswerSet_num]
      ,[Answer_value]
      ,[Answer_value_Std]
      ,[Answer_value_NoStd]
      ,[Answer_Wording_std]
      ,[Answer_Wording]
      ,[Full_set_of_Answers]
      ,[NA_by_set_of_Answers]
      ,[Question_fk]
  FROM [x_LoadRLS1cUS].[dbo].[Pew_Answer]




/*------------------------------------------------------------------------------------------------------------------------*/
SELECT
----------------------------------------------------------------------------------------------------------------------------
--     [Question_abbreviation],
----------------------------------------------------------------------------------------------------------------------------
       [Question_pk]                =   ROW_NUMBER()
                                        OVER( ORDER BY [Question_abbreviation])
                                     + (SELECT MAX([Question_pk]) FROM [Pew_Question_NoStd])
------------------------------------------------------------------------------------------------------------------------------
      ,[Question_abbreviation]      =  [Question_abbreviation] + '_Std'
------------------------------------------------------------------------------------------------------------------------------
      ,[Question_wording]           =  'Standardized: ' + [Question_wording]
------------------------------------------------------------------------------------------------------------------------------
      ,[Question_Year]
      ,[Notes]
      ,[Data_source_fk]
------------------------------------------------------------------------------------------------------------------------------
      ,[Question_Std_fk]            = CASE
                                      WHEN [Question_abbreviation] LIKE '%denom'
                                      THEN (SELECT [Question_Std_pk]
                                              FROM [Pew_Question_Std]
                                             WHERE [Question_wording_std] LIKE 'Standard RLS denominations%' )
                                      WHEN [Question_abbreviation] LIKE '%family'
                                      THEN (SELECT [Question_Std_pk]
                                              FROM [Pew_Question_Std]
                                             WHERE [Question_wording_std] LIKE 'Standard RLS denominational families%' )
                                      WHEN [Question_abbreviation] LIKE '%reltrad'
                                      THEN (SELECT [Question_Std_pk]
                                              FROM [Pew_Question_Std]
                                             WHERE [Question_wording_std] LIKE 'Standard RLS religious traditions%' )
                                       END
------------------------------------------------------------------------------------------------------------------------------
  FROM [Pew_Question_NoStd]
----------------------------------------------------------------------------------------------------------------------------
WHERE 
       [Question_Std_fk] IN ( 344, 804, 903 )
  AND
       [Question_abbreviation] LIKE 'RLS%'
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************/


/****** Script for SelectTopNRows command from SSMS  ******/





       [Question_Std_pk]            =    ROW_NUMBER()
                                         OVER(ORDER BY [Question_abbreviation_std])
                                      + (SELECT MAX([Question_Std_pk]) FROM [Pew_Question_Std])
      ,[Question_abbreviation_std]  =          'SVYp_' 
                                      +  RIGHT('00000'
                                      +  CAST((
                                               (   SELECT COUNT([Question_Std_pk])
                                                     FROM [Pew_Question_Std]
                                                    WHERE [Question_abbreviation_std] LIKE 'svy%' )
                                                +  ROW_NUMBER()
                                                   OVER(ORDER BY [Question_abbreviation_std])     )
                                                                                                    AS varchar(4)),4)
      ,[Question_wording_std]       = CASE
                                      WHEN [Question_abbreviation_std] = 'SVYc_0068'
                                      THEN 'Standard RLS denominations - most specific religious affiliation'
                                      WHEN [Question_abbreviation_std] = 'SVYp_0255'
                                      THEN 'Standard RLS denominational families by religious tradition (grouping Std denomination)'
                                      WHEN [Question_abbreviation_std] = 'SVYp_0354'
                                      THEN 'Standard RLS religious traditions (grouping Std denominational families)'
                                       END
      ,[Question_short_wording_std] = CASE
                                      WHEN [Question_abbreviation_std] = 'SVYc_0068'
                                      THEN 'RLS denominations'
                                      WHEN [Question_abbreviation_std] = 'SVYp_0255'
                                      THEN 'RLS denominational families'
                                      WHEN [Question_abbreviation_std] = 'SVYp_0354'
                                      THEN 'RLS religious traditions'
                                       END
      ,[Display]
      ,[AnswerSet_num]
      ,[Editorially_Checked]        = 'NO!'
      ,[Question_Label_80Chars]
  FROM [x_LoadRLS1cUS].[dbo].[Pew_Question_Std]
WHERE 
       [Question_abbreviation_std] in ( 'SVYc_0068', 'SVYp_0255', 'SVYp_0354' )




  FROM 
       (  SELECT
                distinct
                [VarName]
               ,[VarLabel]
               ,[AnswerSet_number]
               ,[Full_set_of_Answers]
           FROM [stdaq].[dbo].[MatchEDAnswers]  )        MAn
left
join
       [stdaq].[dbo].[Matched_StdQs]                     MSQ
on
       MAn.[VarName]
      =MSQ.[CunStdName]

left
join
       [stdaq].[dbo].[Source_for_NEW__Pew_Question_Std]  PQS
on
       MSQ.[StdVarName]
      =PQS.[Question_abbreviation_std]
/*****************************************************************************************************************************************************/
                                                                                                                                   ) all_new_questions
