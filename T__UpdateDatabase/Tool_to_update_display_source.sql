SELECT *
  FROM
(
SELECT [Display_Reports_pk]
      ,[List_fk]
      ,[List]
      ,Topic_pk
      ,[Topic]
      ,[SubTopic]
      ,[Display]
      ,[Data_source_fk]
      ,[Report_SortingNumber]
      ,[Source_Display_Name]
      --,[Data_source_url]
  FROM [forum].[dbo].[Pew_Display_Reports]  d
     , [forum].[dbo].[Pew_Lists]            l
     , [forum].[dbo].[Pew_Topic]            t
     , [forum].[dbo].[Pew_Data_Source]      s
WHERE 
        d.List_fk
      = l.List_pk
and

        l.List
      = 'Pew_Topic'
AND
      d.[item_fk]
    = t.[Topic_pk]      
AND
      d.[Data_source_fk]
    = s.[Data_source_pk]
                                                                 )  AS TL   --  TOPIC LINK
LEFT
JOIN
(
SELECT 
       DISTINCT
       S.Source_Display_Name
      ,T.[Question_abbreviation_std]
      ,T.[Question_abbreviation]
      ,T.[Question_short_wording_std]
      ,T.[Data_source_fk]
      ,L.[Topic_fk]
  FROM [forum].[dbo].[Pew_Survey_Tables_Displayable]     T
     , [forum].[dbo].[Pew_Question_Std]                  Q
     , [forum].[dbo].[Pew_Question_Topic]                L
     , [forum].[dbo].[Pew_Data_Source]                   S
Where    T.Question_abbreviation_std
       = Q.Question_abbreviation_std    
and      Q.Question_Std_pk
       = L.Question_Std_fk
and      T.Data_source_fk
       = S.Data_source_pk
                                                                 )  AS QL   --  QUESTION LINK
ON
      TL.Topic_pk
    = QL.Topic_fk
ORDER BY 
             Topic_pk
        ,    Report_SortingNumber
        , TL.Data_source_fk
        , QL.Data_source_fk


