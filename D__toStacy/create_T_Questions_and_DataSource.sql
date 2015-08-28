SELECT 
       DISTINCT
        ROW_NUMBER() OVER(ORDER BY   
                                    Data_source_pk
                                  , Question_abbreviation_std
                                  , Question_abbreviation
                                                               ) AS RowID
      ,*
--INTO 
--     [Stacy's].[dbo].[T_Questions_and_DataSource]
FROM
(
SELECT 
       DISTINCT
       [Question_pk]
      ,[Question_abbreviation_std]
      ,[Question_abbreviation]
      ,[Question_short_wording_std]
      ,[Question_Year]
      ,[Notes]
      ,[Data_source_pk]
      ,[Data_source_name]
      ,[Data_source_description]
      ,[Data_source_url]
      ,[Source_Display_Name]
  FROM [forum].[dbo].[Pew_Question]
     , [forum].[dbo].[Pew_Survey_Tables_Displayable]
     , [forum].[dbo].[Pew_Data_Source]
WHERE  [Question_abbreviation_std]
     = [SbjctQ_ab]
  AND  [Data_source_fk]
     = [Data_source_pk]
  AND  [Question_abbreviation] not like 'CSP%'
) AS MYT
