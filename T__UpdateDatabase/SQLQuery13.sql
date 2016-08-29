SELECT 

       [Topic_fk]
      ,[Question_Std_fk]
      ,[Topic_sorting]
      ,[SubTopic_Sorting]
      ,[Display]
      ,[Question_abbreviation_std]
      ,[Priority_order]
      ,[SubTopic]
      ,[Question_wording_std]
      ,[Question_short_wording_std]
      ,[Question_topic_pk]

  FROM [forum].[dbo].[Pew_Question_Topic]  L
     , [forum].[dbo].[Pew_Topic]           T
   , [forum].[dbo].[Pew_Question_Std]      Q

WHERE 
       T.Topic_pk       = L.Topic_fk
  AND  Q.Question_Std_pk = L.Question_Std_fk

ORDER BY
         [Topic_fk]
       , [Question_Std_fk]
--		   [Topic_sorting]
--		  ,[SubTopic_Sorting]
--		  ,[Question_abbreviation_std]