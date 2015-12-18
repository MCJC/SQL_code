SELECT 
       distinct
	   [Question_abbreviation_std]
      ,[Question_short_wording_std]
      ,[Question_Label_80Chars]
      ,[Full_set_of_Answers]
      ,[NA_by_set_of_Answers]
  FROM [forum].[dbo].[Pew_Q&A_Std]
  where    
           [Question_abbreviation_std] like 'G%'
        or 
		   [Question_abbreviation_std] like 'SH%'
        or 
		   [Question_abbreviation_std] like 'X%'
  order by [Question_abbreviation_std]
--
