/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [TABLE_CATALOG]
      ,[TABLE_SCHEMA]
      ,[TABLE_NAME]
      ,[COLUMN_NAME]
      ,[ORDINAL_POSITION]
      ,[COLUMN_DEFAULT]
      ,[IS_NULLABLE]
      ,[DATA_TYPE]
      ,[CHARACTER_MAXIMUM_LENGTH]
      ,[CHARACTER_OCTET_LENGTH]
      ,[NUMERIC_PRECISION]
      ,[NUMERIC_PRECISION_RADIX]
      ,[NUMERIC_SCALE]
      ,[DATETIME_PRECISION]
      ,[CHARACTER_SET_CATALOG]
      ,[CHARACTER_SET_SCHEMA]
      ,[CHARACTER_SET_NAME]
      ,[COLLATION_CATALOG]
      ,[COLLATION_SCHEMA]
      ,[COLLATION_NAME]
      ,[DOMAIN_CATALOG]
      ,[DOMAIN_SCHEMA]
      ,[DOMAIN_NAME]
  FROM [INFORMATION_SCHEMA].[COLUMNS]
------------------------------------------------------------------
WHERE [TABLE_NAME] in(
                       'vi_AgeSexValue',
                       'vi_AgeSexValue_Pct_of_W',
                       'vi_FertilityRate',
                       'vi_Field',
                       'vi_ForMoreInformationLinks_by_Region_or_Ctry',
                       'vi_ForMoreInformationLinks_by_Religion',
                       'vi_Locations_by_Question',
                       'vi_MedianAge',
                       'vi_Migrants',
                       'vi_Migrants_by_Ctry',
                       'vi_Nation_Attributes',
                       'vi_Nation_Flags',
                       'vi_QuestionMetadata_Svy&Restr',
                       'vi_Religion_Attributes',
                       'vi_ReportLinks_by_Region_or_Ctry',
                       'vi_ReportLinks_by_Religion',
                       'vi_Restrictions_Index_by_CtryRegion&Yr',
                       'vi_Restrictions_Tables_by_region&world',
                       'vi_Sources_by_Tabs&Charts',
                       'vi_Survey_Tables_Displayable',
                       'vi_Thresholds',
                       'vi_Topic&Question_Displayable',
                       'vi_Topic&Question_link_RelatedPewResearchReports'
                      )
AND [COLUMN_NAME] like '%sex%'





--select top 1 * from 	[forum].[dbo].[vi_AgeSexValue]
--select top 1 * from 	[forum].[dbo].[vi_AgeSexValue_Pct_of_W]
--select top 1 * from 	[forum].[dbo].[vi_FertilityRate]
--select top 1 * from 	[forum].[dbo].[vi_Field]
--select top 1 * from 	[forum].[dbo].[vi_ForMoreInformationLinks_by_Region_or_Ctry]
--select top 1 * from 	[forum].[dbo].[vi_ForMoreInformationLinks_by_Religion]
--select top 1 * from 	[forum].[dbo].[vi_Locations_by_Question]
--select top 1 * from 	[forum].[dbo].[vi_MedianAge]
--select top 1 * from 	[forum].[dbo].[vi_Migrants]
--select top 1 * from 	[forum].[dbo].[vi_Migrants_by_Ctry]
--select top 1 * from 	[forum].[dbo].[vi_Nation_Attributes]
--select top 1 * from 	[forum].[dbo].[vi_Nation_Flags]
--select top 1 * from 	[forum].[dbo].[vi_QuestionMetadata_Svy&Restr]
--select top 1 * from 	[forum].[dbo].[vi_Religion_Attributes]
--select top 1 * from 	[forum].[dbo].[vi_ReportLinks_by_Region_or_Ctry]
--select top 1 * from 	[forum].[dbo].[vi_ReportLinks_by_Religion]
--select top 1 * from 	[forum].[dbo].[vi_Restrictions_Index_by_CtryRegion&Yr]
--select top 1 * from 	[forum].[dbo].[vi_Restrictions_Tables_by_region&world]
--select top 1 * from 	[forum].[dbo].[vi_Sources_by_Tabs&Charts]
select top 1 * from 	[forum].[dbo].[vi_Survey_Tables_Displayable]
--select top 1 * from 	[forum].[dbo].[vi_Thresholds]
--select top 1 * from 	[forum].[dbo].[vi_Topic&Question_Displayable]
--select top 1 * from 	[forum].[dbo].[vi_Topic&Question_link_RelatedPewResearchReports]

select distinct [Sex]    from	[forum].[dbo].[vi_Survey_Tables_Displayable]

select distinct [Sex]    from	[forum].[dbo].[vi_MedianAge]
select distinct [Sex]    from	[forum].[dbo].[vi_AgeSexValue]
select distinct [Sex_fk] from	[forum].[dbo].[vi_AgeSexValue]
select distinct [Sex]    from	[forum].[dbo].[vi_AgeSexValue_Pct_of_W]
select distinct [Sex_fk] from	[forum].[dbo].[vi_AgeSexValue_Pct_of_W]

 
