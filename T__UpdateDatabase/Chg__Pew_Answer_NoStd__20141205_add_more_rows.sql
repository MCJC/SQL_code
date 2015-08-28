-- script as part of mjr change in structure
-- check all as...
--   FIRST:
--   + Chg__Pew_Data_Source_20141205_add_fieldsandrows.sql
--   + Chg__Pew_Question_NoStd__20141205_drop_fields__add_rows.sql
--   + Chg__Pew_Question_Std__20141205_add_fieldandsrows.sql
--   + Chg__Pew_Answer_Std__20141205_add_fieldsandrows.sql
--   + Chg__Pew_Answer_NoStd__20141205_add_fieldsandrows.sql
--   THEN UPDATE:
--   + VIEW_Pew_Question.sql
--   + VIEW_Pew_Q&A.sql
--   + VIEW_Pew_Answer.sql
--   AND FINALLY:
--   + Chg__Pew_Answer_NoStd__20141205_add_more_rows.sql
/**************************************************************************************************************************/
/*****                                              BackUp current Table                                              *****/
/*****                                          BackUp updated >source Table                                          *****/
/**************************************************************************************************************************/
  DECLARE @CrDt    varchar( 8)
  SET     @CrDt = (CONVERT(VARCHAR(8),GETDATE(),112))
/*------------------------------------------------------------------------------------------------------------------------*/
EXEC ( ' SELECT *
                INTO  [_bk_forum].[dbo].[Pew_Answer_NoStd_' + @CrDt + ']
                FROM      [xRLS2].[dbo].[Pew_Answer_NoStd]'               )
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/*****                                                    STEP 001                                                    *****/
/**************************************************************************************************************************/
-- add RLSII - extra set
/*------------------------------------------------------------------------------------------------------------------------*/
INSERT INTO
           [forum].[dbo].[Pew_Answer_NoStd]
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT
----------------------------------------------------------------------------------------------------------------------------
       [Answer_pk]            =      ROW_NUMBER()
                                     OVER(ORDER BY [Answer_fk] )
                                  + (SELECT    MAX([Answer_pk])
                                     FROM [forum].[dbo].[Pew_Answer_NoStd])
----------------------------------------------------------------------------------------------------------------------------
      ,[Answer_value_NoStd]
      ,[Answer_Wording]
      ,[Answer_Std_fk]
----------------------------------------------------------------------------------------------------------------------------
      ,[Question_fk]          =   [Question_fk] + 131
-- select *  ---------------------------------------------------------------------------------------------------------------
  FROM
/*------------------------------------------------------------------------------------------------------------------------*/
           [forum].[dbo].[Pew_Q&A]
/*------------------------------------------------------------------------------------------------------------------------*/
WHERE
           [forum].[dbo].[Pew_Q&A].[Question_abbreviation] LIKE 'RLS07%'
/*------------------------------------------------------------------------------------------------------------------------*/
/**************************************************************************************************************************/

/**************************************************************************************************************************/
/*****                                                    STEP 002                                                    *****/
/**************************************************************************************************************************/
-- check results
SELECT * FROM [forum]..[Pew_Answer_NoStd]
/*------------------------------------------------------------------------------------------------------------------------*/
SELECT * FROM [forum]..[Pew_Q&A] WHERE [Question_abbreviation] LIKE 'RLS07%'
SELECT * FROM [forum]..[Pew_Q&A] WHERE [Question_abbreviation] LIKE 'RLS07cUS%'
SELECT * FROM [forum]..[Pew_Q&A] WHERE [Question_abbreviation] LIKE 'RLS07A&H%'
/**************************************************************************************************************************/
