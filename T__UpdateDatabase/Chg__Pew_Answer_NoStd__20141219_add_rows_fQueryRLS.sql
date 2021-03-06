/**************************************************************************************************************************/
/*****                                              BackUp current Table                                              *****/
/**************************************************************************************************************************/
USE [forum]
GO
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT *
                INTO  [_bk_forum].[dbo].[Pew_Answer_NoStd_' + @CrDt + ']
                FROM      [forum].[dbo].[Pew_Answer_NoStd]'               )
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
/*------------------------------------------------------------------------------------------------------------------------*/
INSERT INTO
           [forum].[dbo].[Pew_Answer_NoStd]
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT
----------------------------------------------------------------------------------------------------------------------------
       [Answer_pk]           = ROW_NUMBER()
                                     OVER(
                                 ORDER BY  [AnsS], [Answer_pk] )
                               +   (SELECT MAX([Answer_pk])
                                      FROM     [Pew_Answer_NoStd] )
      ,[Answer_value_NoStd]
      ,[Answer_Wording]
      ,[Answer_Std_fk]
      ,[Question_fk]
----------------------------------------------------------------------------------------------------------------------------
  FROM
----------------------------------------------------------------------------------------------------------------------------
(
----------------------------------------------------------------------------------------------------------------------------
SELECT
       [Answer_pk]           = ROW_NUMBER()
                                     OVER(
                                 ORDER BY  [Answer_Std_pk]     )
      ,[Answer_value_NoStd]  = [Answer_value_std]
      ,[Answer_Wording]      = [Answer_Wording_std]
      ,[Answer_Std_fk]       = [Answer_Std_pk]
      ,[Question_fk]         = CASE
                               WHEN [Full_set_of_Answers] = '149 RLS  denominations for website'
                               THEN ( SELECT [Question_pk]
                                        FROM [Pew_Question_NoStd]
                                       WHERE [Question_abbreviation] = 'RLS07cUS_denom_Std' )
                               WHEN [Full_set_of_Answers] = '52 RLS  religious families for website'
                               THEN ( SELECT [Question_pk]
                                        FROM [Pew_Question_NoStd]
                                       WHERE [Question_abbreviation] = 'RLS07cUS_family_Std' )
                               WHEN [Full_set_of_Answers] = '16 RLS  religious traditions for website'
                               THEN ( SELECT [Question_pk]
                                        FROM [Pew_Question_NoStd]
                                       WHERE [Question_abbreviation] = 'RLS07cUS_reltrad_Std' )
                                END
      ,[AnsS]                = 'A'
  FROM [Pew_Answer_Std]
 WHERE [Full_set_of_Answers]
        IN (   '149 RLS  denominations for website'
             , '52 RLS  religious families for website'
             , '16 RLS  religious traditions for website' )

UNION
ALL

SELECT
       [Answer_pk]           = ROW_NUMBER()
                                     OVER(
                                 ORDER BY  [Answer_Std_pk]     )
      ,[Answer_value_NoStd]  = [Answer_value_std]
      ,[Answer_Wording]      = [Answer_Wording_std]
      ,[Answer_Std_fk]       = [Answer_Std_pk]
      ,[Question_fk]         = CASE
                               WHEN [Full_set_of_Answers] = '149 RLS  denominations for website'
                               THEN ( SELECT [Question_pk]
                                        FROM [Pew_Question_NoStd]
                                       WHERE [Question_abbreviation] = 'RLS07A&H_denom_Std' )
                               WHEN [Full_set_of_Answers] = '52 RLS  religious families for website'
                               THEN ( SELECT [Question_pk]
                                        FROM [Pew_Question_NoStd]
                                       WHERE [Question_abbreviation] = 'RLS07A&H_family_Std' )
                               WHEN [Full_set_of_Answers] = '16 RLS  religious traditions for website'
                               THEN ( SELECT [Question_pk]
                                        FROM [Pew_Question_NoStd]
                                       WHERE [Question_abbreviation] = 'RLS07A&H_reltrad_Std' )
                                END
      ,[AnsS]                = 'B'
  FROM [Pew_Answer_Std]
 WHERE [Full_set_of_Answers]
        IN (   '149 RLS  denominations for website'
             , '52 RLS  religious families for website'
             , '16 RLS  religious traditions for website' )
----------------------------------------------------------------------------------------------------------------------------
) DOUBSET
----------------------------------------------------------------------------------------------------------------------------
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/*****                                                    STEP 002                                                    *****/
/**************************************************************************************************************************/
-- check results
SELECT * FROM [forum].[dbo].[Pew_Answer_NoStd]
/**************************************************************************************************************************/
