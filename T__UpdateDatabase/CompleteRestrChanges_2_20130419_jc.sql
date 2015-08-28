/*********************************************************************************************************/
-- April 19 2013
/*********************************************************************************************************/
SELECT *
  INTO [_bk_forum].[dbo].[Pew_Answer_2013_04_19]
  FROM     [forum].[dbo].[Pew_Answer]
/*********************************************************************************************************/
UPDATE    
           [forum].[dbo].[Pew_Answer]

SET      answer_wording_std
       = 'Yes, with fewer than 10,000 casualties or people displaced'
WHERE    Answer_pk
       = 14083
AND
         answer_wording_std
       = 'Yes, with fewer than 10,000 casualties or people displaced from their homes'  --unstdzd wording in 2011
/*********************************************************************************************************/
-- check results
SELECT distinct
       [Q_Level]
      --,[Question_Year]
      ,[Question_abbreviation_std]
      ,[Question_short_wording_std]
      ,[Answer_value]
      ,[answer_wording_std]
      --,[Question_fk]
      --,[Answer_fk]
  FROM [forum].[dbo].[Restrictions_byCtry]
  where Question_short_wording_std like 'Was there a re%'
  --and Answer_value = 0.25











