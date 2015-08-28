UPDATE   [forum].[dbo].[Pew_Question]
SET
         [forum].[dbo].[Pew_Question].[Question_abbreviation]
= RTRIM( [forum].[dbo].[Pew_Question].[Question_abbreviation] )
,
         [forum].[dbo].[Pew_Question].[Question_abbreviation_std]
= RTRIM( [forum].[dbo].[Pew_Question].[Question_abbreviation_std] )

where    [forum].[dbo].[Pew_Question].[Question_pk] IN (1138, 1141)
