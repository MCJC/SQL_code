/*********************************************************************************************************/
SELECT *
  INTO [_bk_forum].[dbo].[Pew_Survey_Answer_2013_03_07]
  FROM     [forum].[dbo].[Pew_Survey_Answer]
/*********************************************************************************************************/
-- drop answers as Michael indicated:

-- Have Western music, movies, and television hurt morality in the country?
-- (Lebanon, SVYc_0024 / 113)
-- answers:  14245
--           14246
--           14247
-- Do you believe humans and other living things have evolved or that they have existed in their present form since the beginning of time?
-- (Egypt, SVYu_0032 / 60)
-- answers:  15070
--           15071
--           15072
--Should sharia law be open to multiple interpretations or is there only one, true understanding of sharia?
-- (Egypt, SVYu_0185 / 60)	
-- answers:  15469
--           15470
--           15471
--           15472

-- Should sharia law be open to multiple interpretations or is there only one, true understanding of sharia?
-- (Jordan, SVYu_0185 / 104)
-- answers:  15469
--           15470
--           15471
--           15472


DELETE FROM [forum].[dbo].[Pew_Survey_Answer]
WHERE
            [forum].[dbo].[Pew_Survey_Answer].[Nation_fk] = 113
       AND  [forum].[dbo].[Pew_Survey_Answer].[Answer_fk] IN ( 14245, 14246, 14247 )


DELETE FROM [forum].[dbo].[Pew_Survey_Answer]
WHERE
            [forum].[dbo].[Pew_Survey_Answer].[Nation_fk] = 60
       AND  [forum].[dbo].[Pew_Survey_Answer].[Answer_fk] IN ( 15070, 15071, 15072,
                                                               15469, 15470, 15471, 15472 )


DELETE FROM [forum].[dbo].[Pew_Survey_Answer]
WHERE
            [forum].[dbo].[Pew_Survey_Answer].[Nation_fk] = 104
       AND  [forum].[dbo].[Pew_Survey_Answer].[Answer_fk] IN ( 15469, 15470, 15471, 15472 )



