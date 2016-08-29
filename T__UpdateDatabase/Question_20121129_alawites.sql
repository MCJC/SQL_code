UPDATE   [forum].[dbo].[Pew_Question]
SET
         [forum].[dbo].[Pew_Question].[Question_wording]
=
'Next I am going to ask about groups that some people regard as Muslims. Do you personally consider Alawites to be Muslims, or not?'
,
         [forum].[dbo].[Pew_Question].[Question_wording_std]
=
'Next I am going to ask about groups that some people regard as Muslims. Do you personally consider (Alawites) to be Muslims, or not?'
,
         [forum].[dbo].[Pew_Question].[Question_short_wording_std]
=
'Do you consider Alawites to be Muslims?'

where    [forum].[dbo].[Pew_Question].[Question_pk] = 859


SELECT *
  from [forum].[dbo].[Pew_Question]
  where Question_wording_std like '%alawites%'
  





Next I am going to ask about groups that some people regard as Muslims. Do you personally consider (Alavites) to be Muslims, or not?	Do you consider Alavites to be Muslims?