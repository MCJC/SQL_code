
SELECT 
        Display_Reports_pk
      , List_fk
      , ItemTopic__fk = item_fk
      , TABLE_Data_source_fk = TL.Data_source_fk
      , QUEST_Data_source_fk = QL.Data_source_fk
      , Display
      , TABLE_Source_Display_Name = TL.Source_Display_Name
      , QUEST_Source_Display_Name = QL.Source_Display_Name
      , List
      , Topic
      , SubTopic
      , Report_SortingNumber
      , Question_abbreviation_std
      , Question_abbreviation
      , Question_short_wording_std
--select *
  FROM
(
SELECT [Display_Reports_pk]
      ,[List_fk]
      ,[List]
      ,[item_fk]
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
full
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
      TL.Item_fk
    = QL.Topic_fk
ORDER BY 
             item_fk
        ,    Report_SortingNumber
        , TL.Data_source_fk
        , QL.Data_source_fk



