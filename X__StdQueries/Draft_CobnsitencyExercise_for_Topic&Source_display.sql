/******************************************************************************************************************************/
/* MAIN TABLE TO CHECK MATCHING */

SELECT 
        DISTINCT
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
      --, Question_abbreviation_std
      --, Question_abbreviation
      --, Question_short_wording_std
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

/*
Displa	List	Item
y_Repo	_fk		Topic
rts_pk			__fk	TABLE_Data_source_fk	QUEST_Data_source_fk	Display
8		4		31		33		5		1
8		4		31		33		7		1
8		4		31		33		33		1
8		4		31		33		56		1
9		4		31		36		5		1
9		4		31		36		7		1
9		4		31		36		33		1
9		4		31		36		56		1

MEANS

Topic 31 has two links ( 8 & 9 )
to two corresponding reports ( 33 & 36 )
whereas questions in such item have 4 links
to four corresponding reports ( 5, 7, 33, & 56 )


*/



/******************************************************************************************************************************/
/* DIAGNOSIS SET */
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
      --, Question_abbreviation_std
      --, Question_abbreviation
      --, Question_short_wording_std
INTO #DIAG
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
      --,T.[Question_abbreviation_std]
      --,T.[Question_abbreviation]
      --,T.[Question_short_wording_std]
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
AND
      TL.Source_Display_Name
    = QL.Source_Display_Name
ORDER BY 
          ItemTopic__fk
        , Report_SortingNumber
        , TABLE_Data_source_fk
        , QUEST_Data_source_fk
/******************************************************************************************************************************/



SELECT *
FROM
        #DIAG

-- TO BE ADDED (SHOULD NOT VE ANY)
SELECT *
FROM
        #DIAG
WHERE
        Display_Reports_pk IS NULL
-- TO BE DELETED
SELECT *
FROM
        #DIAG
WHERE
        QUEST_Source_Display_Name IS NULL
-- CORRECT ALTHOGH COULD BE DIVERGENT CODE
SELECT *
FROM
        #DIAG
WHERE
        Display_Reports_pk        IS NOT NULL
AND
        QUEST_Source_Display_Name IS NOT NULL


SELECT *
FROM
        #DIAG
WHERE
        Display_Reports_pk IS NULL










        
        
        
                        