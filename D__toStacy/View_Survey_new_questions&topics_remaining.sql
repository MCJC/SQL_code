USE [Stacy's]
GO

/****** Object:  View [dbo].[MissingSubTopics]    Script Date: 04/18/2013 14:24:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--CREATE VIEW
ALTER VIEW 
               [dbo].[MissingSubTopics]
AS
--/*****************************************************************************************************************************************************/
SELECT
       ROW_NUMBER() OVER(ORDER BY   
                                  Display
                                 ,Topic
                                 ,SubTopic_Sorting
                                 ,Priority_order
                                              ) AS RowID
      ,[Topic_fk]
      ,[Topic_pk]
      ,[Question_Std_fk]
      ,[Topic]
      ,[SubTopic]
      ,[Topic_sorting]
      ,[SubTopic_Sorting]
      ,[Priority_order]
      ,[Display]
      ,[Question_abbreviation_std]
      ,[Question_wording_std]
      ,[Question_short_wording_std]
FROM
(
SELECT
       DISTINCT 
       [Topic_fk]
      ,[Topic_pk]
      ,[Question_Std_fk]
      ,[Topic]
      ,[SubTopic]
      ,[Topic_sorting]
      ,[Priority_order]
      ,[SubTopic_Sorting]
      ,[Display]
      ,[Question_abbreviation_std]
      ,[Question_wording_std]
      ,[Question_short_wording_std]
FROM
(
SELECT *
  FROM
         [forum].[dbo].[Pew_Question_Std]             
       , [forum].[dbo].[Pew_Question_Topic]           
       , [forum].[dbo].[Pew_Survey_Tables_Displayable]

WHERE
         [Question_Std_fk]
       = [Question_Std_pk]
  AND
          [Question_abbreviation_std]
       =  [SbjctQ_ab]
)  q1         
FULL OUTER JOIN

         [forum].[dbo].[Pew_Topic]
   q2
    ON
         [Topic_fk]
       = [Topic_pk]
WHERE
         [Topic] != 'Restrictions on Religion'
  and
         [Topic] != 'Population Characteristics'
) T1

GO


