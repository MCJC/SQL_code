---------------------------------------------------------------------------------------------------------------------------------------------------------------
USE [_Admin]
GO
---------------------------------------------------------------------------------------------------------------------------------------------------------------
/*************************************************************************************************************************************************************/
/*** >> Create reference metadata table [Describe_Table_and_Fields] storing descriptions of both tables and fields *******************************************/
/*************************************************************************************************************************************************************/
--IF OBJECT_ID  (N'[_Admin].[dbo].[Describe_Table_and_Fields]', N'U') IS NOT NULL
--DROP   TABLE     [_Admin].[dbo].[Describe_Table_and_Fields]
--GO
--/*************************************************************************************************************************************************************/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--SET ANSI_PADDING ON
--GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--CREATE TABLE
--             [_Admin].[dbo].[Describe_Table_and_Fields]
--                                        (
--                                            [Description_pk]           [int]           NOT NULL
--                                          , [Table_name]               [nvarchar](max)     NULL
--                                          , [Field_name]               [nvarchar](max)     NULL
--                                          , [Description]              [nvarchar] (50)     NULL
--                                          , [Comments]                 [nvarchar](750)     NULL
--                                          ,
--                                            CONSTRAINT
--                                            [Description_pk]           PRIMARY KEY CLUSTERED 
--                                          ( [Description_pk] ASC )
--                                                      WITH (
--                                                              PAD_INDEX               = OFF
--                                                            , STATISTICS_NORECOMPUTE  = OFF
--                                                            , IGNORE_DUP_KEY          = OFF
--                                                            , ALLOW_ROW_LOCKS         = ON
--                                                            , ALLOW_PAGE_LOCKS        = ON
--                                                                                              ) ON [PRIMARY]
--                                                                                                            ) ON [PRIMARY]
--GO
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--SET ANSI_PADDING OFF
--GO
/*************************************************************************************************************************************************************/
/*** << Create reference metadata table [Describe_Table_and_Fields] storing descriptions of both tables and fields *******************************************/
/*************************************************************************************************************************************************************/



/*************************************************************************************************************************************************************/
/*** >> Insert descriptions for all tables in [forumdb] belonging to Pew and all their corresponding fields **************************************************/
/*************************************************************************************************************************************************************/
TRUNCATE
TABLE
             [_Admin].[dbo].[Describe_Table_and_Fields]
---------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO 
             [_Admin].[dbo].[Describe_Table_and_Fields]
                                        (
                                            [Description_pk]
                                          , [Table_name]
                                          , [Field_name]
                                          , [Description]
                                          , [Comments]
                                                              )
SELECT
         ROW_NUMBER() OVER(ORDER BY   
                                            [Table_name]
                                          , [Field_name]
                                                              ) AS Description_pk
        , [Table_name]
        , [Field_name]
        , [Description]
        , [Comments]
FROM
---------------------------------------------------------------------------------------------------------------------------------------------------------------
(
      SELECT 
Table_name  = 'Pew_Age',
Field_name  = 'Table Name:   Pew_Age',
Description = 'Collection of age cohorts (not mutually exclusive)',
Comments    = 'Lookup. A collection of age cohorts used by different sources. The first set correpond to the 5-year age cohorts  (mutually exclusive in each sub-set, but not mutually exclusive in the whole set).'
UNION SELECT 
Table_name  = 'Pew_Age',
Field_name  = 'Age_pk',
Description = 'Coded value (scaled or count) for each answer',
Comments    = 'Field used as primary key of the table Pew_Age.'
UNION SELECT 
Table_name  = 'Pew_Age',
Field_name  = 'Age',
Description = 'Primary key of Pew_Data_Source.',
Comments    = 'Age cohorts used by different sources four grouping characteristics of the population  (they are mutually exclusive in each sub-set, but not mutually exclusive in the whole set).'
UNION SELECT 
Table_name  = 'Pew_Answer',
Field_name  = 'Table Name:   Pew_Answer',
Description = 'Relationship. Select appropria',
Comments    = 'Core data. Set of all answers corresponding to each question. The combination of value and wordings make the set of answers corresponding to the questions of each wave of data (as defined in Pew_Question_NoStd). The wording can be detailed descriptions of the meaning of the score. The values and standard wordings make the set of answers corresponding to the standard questions across time (as defined in Pew_Question_Std).'
UNION SELECT 
Table_name  = 'Pew_Answer',
Field_name  = 'Answer_pk',
Description = 'Field used to sort the differe',
Comments    = 'Field used as primary key of the table Pew_Answer.'
UNION SELECT 
Table_name  = 'Pew_Answer',
Field_name  = 'Answer_value',
Description = 'Field used as foreign key, ref',
Comments    = 'The coded value (scaled or count) assigned to each possible answer to the corresponding question.'
UNION SELECT 
Table_name  = 'Pew_Answer',
Field_name  = 'Question_fk',
Description = 'Note about the field. May be u',
Comments    = 'Field used as foreign key, referring to the corresponding unstandardized question (as defined by Pew_Question_NoStd). Link to the standard question is through the unstandardized question.'
UNION SELECT 
Table_name  = 'Pew_Answer',
Field_name  = 'Answer_wording',
Description = 'Primary key of Pew_Footnote',
Comments    = 'The wording of possible answers to the corresponding question or the detailed description of the meaning of the coded value.'
UNION SELECT 
Table_name  = 'Pew_Answer',
Field_name  = 'answer_wording_std',
Description = 'from Pew_Answer',
Comments    = 'The standard wording of possible answers to the corresponding standard question giving meaning to the coded value.'
UNION SELECT 
Table_name  = 'Pew_Data_Source',
Field_name  = 'Table Name:   Pew_Data_Source',
Description = 'from Pew_Question_NoStd',
Comments    = 'Core data. Names of the reports or studies for which data is stored.'
UNION SELECT 
Table_name  = 'Pew_Data_Source',
Field_name  = 'Data_source_pk',
Description = 'Field used as foreign key, ref',
Comments    = 'Field used as primary key of the table Pew_Data_Source.'
UNION SELECT 
Table_name  = 'Pew_Data_Source',
Field_name  = 'Data_source_name',
Description = 'Field used as foreign key, ref',
Comments    = 'Name of study or research project, such as Global Restriction on Religion Study; fertility; Global Christianity, etc.'
UNION SELECT 
Table_name  = 'Pew_Data_Source',
Field_name  = 'Data_source_description',
Description = 'Primary key of Pew_Language',
Comments    = 'Descriptions of the whole study or subsections of study.'
UNION SELECT 
Table_name  = 'Pew_Data_Source',
Field_name  = 'Data_source_url',
Description = 'List of major categories curre',
Comments    = 'URL (also known as web address) of the  whole study or subsections of study.'
UNION SELECT 
Table_name  = 'Pew_Data_Source',
Field_name  = 'Source_Display_Name',
Description = 'Where more than one Locality c',
Comments    = 'Name of the  whole study or subsections of study as should be displayed in the GRF website.'
UNION SELECT 
Table_name  = 'Pew_Display_Footnotes',
Field_name  = 'Table Name:   Pew_Display_Footnotes',
Description = 'Field used as foreign key, ref',
Comments    = 'Relationship. Select appropriate footnote to be displayed on the GRF website for nations, religions, questions, etc.'
UNION SELECT 
Table_name  = 'Pew_Display_Footnotes',
Field_name  = 'Display_Footnotes_pk',
Description = 'Field used as foreign key, ref',
Comments    = 'Field used as primary key of the table Pew_Display_Footnotes.'
UNION SELECT 
Table_name  = 'Pew_Display_Footnotes',
Field_name  = 'List_fk',
Description = 'Field used as foreign key, ref',
Comments    = 'Field used as foreign key, referring to the table listed as an entity of the Pew_Lists table, which should be used to link the field item_fk.'
UNION SELECT 
Table_name  = 'Pew_Display_Footnotes',
Field_name  = 'item_fk',
Description = 'Indicator for whether to displ',
Comments    = 'Field used as foreign key, referring to entities in different tables (Pew_Nation; Pew_Locality; Pew_Religion_Group; Pew_Topic; Pew_Question), listed in the Pew_Lists table.'
UNION SELECT 
Table_name  = 'Pew_Display_Footnotes',
Field_name  = 'Note_fk',
Description = 'static lookup of Destination n',
Comments    = 'Field used as foreign key, referring to the corresponding note (as defined by Pew_Footnote).'
UNION SELECT 
Table_name  = 'Pew_Display_Footnotes',
Field_name  = 'Note_SortingNumber',
Description = 'static lookup from Pew_Migration_Data_Source',
Comments    = 'Field used to sort the different notes corresponding to the same entity or set of entities (such as nation and religion) when displaying them in the GRF website.'
UNION SELECT 
Table_name  = 'Pew_Display_Reports',
Field_name  = 'Table Name:   Pew_Display_Reports',
Description = 'Primary key of Pew_Migration_Data',
Comments    = 'Relationship. Select appropriate report to be displayed on the GRF website for topic, questions, etc.'
UNION SELECT 
Table_name  = 'Pew_Display_Reports',
Field_name  = 'Display_Reports_pk',
Description = 'Lookup. Migration data quality',
Comments    = 'Field used as primary key of the table Pew_Display_Reports'
UNION SELECT 
Table_name  = 'Pew_Display_Reports',
Field_name  = 'List_fk',
Description = 'Lookup. For each origin/destin',
Comments    = 'Field used as foreign key, referring to the table listed as an entity of the Pew_Lists table, which should be used to link the field item_fk'
UNION SELECT 
Table_name  = 'Pew_Display_Reports',
Field_name  = 'item_fk',
Description = 'Origin data type',
Comments    = 'Field used as foreign key, referring to entities in different tables (Pew_Nation; Pew_Locality; Pew_Religion_Group; Pew_Topic; Pew_Question), listed in the Pew_Lists table'
UNION SELECT 
Table_name  = 'Pew_Display_Reports',
Field_name  = 'Data_source_fk',
Description = 'Religion data type',
Comments    = 'Field used as foreign key, referring to the reports listed as URLs in displaying names (as defined by Pew_Data_Source)'
UNION SELECT 
Table_name  = 'Pew_Display_Reports',
Field_name  = 'Report_SortingNumber',
Description = 'Where more than one Nation com',
Comments    = 'Field used to sort the different reports corresponding to the same entity or set of entities (such as topic and question) when displaying them in the GRF website.'
UNION SELECT 
Table_name  = 'Pew_Field',
Field_name  = 'Table Name:   Pew_Field',
Description = 'Capital city',
Comments    = 'Lookup of field names for use in both Nation_Value and Locality_Value tables. The role of Pew_Field is similar to the Pew_Question table, allowing for field name metadata.'
UNION SELECT 
Table_name  = 'Pew_Field',
Field_name  = 'Field_pk',
Description = 'Gross domestic product (GDP) a',
Comments    = 'Field used as primary key of the table Pew_Field'
UNION SELECT 
Table_name  = 'Pew_Field',
Field_name  = 'Field_name',
Description = 'Total population 2020',
Comments    = 'Name of the field for use when data is cross-tabulated.'
UNION SELECT 
Table_name  = 'Pew_Field',
Field_name  = 'Field_note',
Description = 'Defines Global North and Global South',
Comments    = 'Note about the field. May be used to explain abbreviations used in the field name'
UNION SELECT 
Table_name  = 'Pew_Field',
Field_name  = 'Field_type',
Description = 'Total population 1910',
Comments    = 'Type of field: allowing (for example) the selection of the same data from different years'
UNION SELECT 
Table_name  = 'Pew_Field',
Field_name  = 'Field_year',
Description = '3 digit numerical code (includ',
Comments    = 'The year of the data listed in the corresponding row (if the field data pertains to a particular time).'
UNION SELECT 
Table_name  = 'Pew_Field',
Field_name  = 'Data_source_fk',
Description = 'Sources for major indicators',
Comments    = 'Field used as foreign key, referring to the corresponding data source (as defined by Pew_Data_Source)'
UNION SELECT 
Table_name  = 'Pew_Footnote',
Field_name  = 'Table Name:   Pew_Footnote',
Description = 'Field used as foreign key, ref',
Comments    = 'Core Data. Footnotes used by reports in the GRF website'
UNION SELECT 
Table_name  = 'Pew_Footnote',
Field_name  = 'Note_pk',
Description = 'Indicator for whether to displ',
Comments    = 'Field used as primary key of the table Pew_Footnote'
UNION SELECT 
Table_name  = 'Pew_Footnote',
Field_name  = 'Footnote_Display',
Description = 'Indicator for whether to displ',
Comments    = 'Footnotes as should be displayed in the GRF website.'
UNION SELECT 
Table_name  = 'Pew_Footnote',
Field_name  = 'About_the_Data_link',
Description = 'Field used as foreign key, ref',
Comments    = 'Link for the corresponding “About the data” page in the GRF website  (currently just one page)'
UNION SELECT 
Table_name  = 'Pew_G_20_3_Summary',
Field_name  = 'Table Name:   Pew_G_20_3_Summary',
Description = 'Percentage value of this field',
Comments    = 'Static table (a view that has been saved as a table)'
UNION SELECT 
Table_name  = 'Pew_G_20_3_Summary',
Field_name  = 'G_20_3_summary_pk',
Description = 'Notes on the Percentage value ',
Comments    = 'Field used as primary key of the table Pew_G_20_3_Summary'
UNION SELECT 
Table_name  = 'Pew_G_20_3_Summary',
Field_name  = 'Answer_value',
Description = 'Notes on the number of cases o',
Comments    = 'from Pew_Answer'
UNION SELECT 
Table_name  = 'Pew_G_20_3_Summary',
Field_name  = 'Answer_wording',
Description = 'Field used as foreign key, ref',
Comments    = 'from Pew_Answer'
UNION SELECT 
Table_name  = 'Pew_G_20_3_Summary',
Field_name  = 'Question_year',
Description = 'Core data. Fertility values (o',
Comments    = 'from Pew_Question_NoStd'
UNION SELECT 
Table_name  = 'Pew_G_20_3_Summary',
Field_name  = 'Notes',
Description = 'Number of cases of this field ',
Comments    = 'from Pew_Question_NoStd'
UNION SELECT 
Table_name  = 'Pew_G_20_3_Summary',
Field_name  = 'Question_abbreviation',
Description = 'Field used as foreign key, ref',
Comments    = 'from Pew_Question_NoStd'
UNION SELECT 
Table_name  = 'Pew_G_20_3_Summary',
Field_name  = 'Question_wording',
Description = 'Primary key of Pew_Nation_Restriction_AVG',
Comments    = 'from Pew_Question_NoStd'
UNION SELECT 
Table_name  = 'Pew_G_20_3_Summary',
Field_name  = 'Nation',
Description = 'Question abbreviation_order',
Comments    = 'from Pew_Nation'
UNION SELECT 
Table_name  = 'Pew_GRFsite_URLs_Topic',
Field_name  = 'Table Name:   Pew_GRFsite_URLs_Topic',
Description = 'Field used as foreign key, ref',
Comments    = 'Core Data. Topics and subtopics of postings in the GRF website.'
UNION SELECT 
Table_name  = 'Pew_GRFsite_URLs_Topic',
Field_name  = 'GRFsite_URLs_Topic_pk',
Description = 'Notes specific to this nation/religion/field',
Comments    = 'Field used as primary key of the table Pew_GRFsite_URLs_Topic'
UNION SELECT 
Table_name  = 'Pew_GRFsite_URLs_Topic',
Field_name  = 'GRFsite_URL',
Description = 'Primary key of Pew_Nation_Value',
Comments    = 'URL (also known as web address) for the topics and questions in the GRF website.'
UNION SELECT 
Table_name  = 'Pew_GRFsite_URLs_Topic',
Field_name  = 'Topic_fk',
Description = 'Primary key of Pew_Preferred_Scenario',
Comments    = 'Field used as foreign key, referring to the corresponding  topic/subtopic (as defined by Pew_Topic)'
UNION SELECT 
Table_name  = 'Pew_GRFsite_URLs_Topic',
Field_name  = 'Display',
Description = 'Primary key of Pew_Question_NoStd',
Comments    = 'Indicator for whether to display with value 1 denotes "yes" and value 0 denotes "no".'
UNION SELECT 
Table_name  = 'Pew_GRFsite_URLs_Topic',
Field_name  = 'Priority_order',
Description = 'Shortened question wording',
Comments    = 'Sorting order for displaying topics/questions in the GRF website'
UNION SELECT 
Table_name  = 'Pew_Index_Cut_Points',
Field_name  = 'Table Name:   Pew_Index_Cut_Points',
Description = 'Primary key of Pew_Question_Std',
Comments    = 'Core Data. Cutting points for distributing continuous measurements (as indexes) into discrete categories.'
UNION SELECT 
Table_name  = 'Pew_Index_Cut_Points',
Field_name  = 'Pew_Index_CutPoints_pk',
Description = 'Primary key of Pew_Question_Topic',
Comments    = 'Field used as primary key of the table Pew_Index_Cut_Points'
UNION SELECT 
Table_name  = 'Pew_Index_Cut_Points',
Field_name  = 'Field_fk',
Description = 'Primary key of Pew_Religion_Group',
Comments    = 'Field used as foreign key, referring to the corresponding field (as defined by Pew_Field).'
UNION SELECT 
Table_name  = 'Pew_Index_Cut_Points',
Field_name  = 'Level',
Description = 'Pew religion level 02 (top level religions)',
Comments    = 'Discrete categories in which continuous measurement is distributes (for example: low, moderate, high and very high).'
UNION SELECT 
Table_name  = 'Pew_Index_Cut_Points',
Field_name  = 'Point',
Description = 'WRD religion group level 3',
Comments    = 'Indicators denoting whether the CutPoint is the upper or lower limit of the of the discrete category.'
UNION SELECT 
Table_name  = 'Pew_Index_Cut_Points',
Field_name  = 'CutPoint',
Description = '??//. Top lines in the publica',
Comments    = 'Numeric cutoffs used for defining the categorical levels.'
UNION SELECT 
Table_name  = 'Pew_Language',
Field_name  = 'Table Name:   Pew_Language',
Description = 'Study period',
Comments    = 'Main languages. (See also Ethnologue_Language table with 7,365 languages)'
UNION SELECT 
Table_name  = 'Pew_Language',
Field_name  = 'Language_pk',
Description = 'Question abbreviation order.',
Comments    = 'Field used as primary key of the table Pew_Language'
UNION SELECT 
Table_name  = 'Pew_Language',
Field_name  = 'language',
Description = 'Primary key of Pew_Survey_Answer',
Comments    = 'Language name'
UNION SELECT 
Table_name  = 'Pew_Language',
Field_name  = 'Iso_code',
Description = 'Field used as foreign key, ref',
Comments    = 'ISO alpha code -- PENDING FOR COMPLETION'
UNION SELECT 
Table_name  = 'Pew_Lists',
Field_name  = 'Table Name:   Pew_Lists',
Description = 'Indicator for whether to displ',
Comments    = '?? . List of major categories currently including Pew_Nation, Pew_Locality, Pew_Religion_Group, Pew_Topic, and Pew_Question.'
UNION SELECT 
Table_name  = 'Pew_Lists',
Field_name  = 'List_pk',
Description = 'Sorting number for subtopics',
Comments    = 'Field used as primary key of the table Pew_Lists'
UNION SELECT 
Table_name  = 'Pew_Lists',
Field_name  = 'List',
Description = 'Core WRD data. Provinces or ot',
Comments    = 'List of major categories currently including Pew_Nation, Pew_Locality, Pew_Religion_Group, Pew_Topic, and Pew_Question.'
UNION SELECT 
Table_name  = 'Pew_Locality',
Field_name  = 'Table Name:   Pew_Locality',
Description = 'Core WRD data. Religions or re',
Comments    = 'Core Data. The term "Locality" distinguishes these Pew entities from WRD standard "Province". Pew locaities may be WRD provinces, or they may be WRD sub-provinces which can be combined into WRD provinces based on the sub-province weightings defined in this table.  Lists all localities used by Pew at different times and hence not mutually exclusive.'
UNION SELECT 
Table_name  = 'Pew_Locality',
Field_name  = 'Locality_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Locality'
UNION SELECT 
Table_name  = 'Pew_Locality',
Field_name  = 'Locality',
Description = '',
Comments    = 'Locality name'
UNION SELECT 
Table_name  = 'Pew_Locality',
Field_name  = 'Province_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding province (as defined by Pew_Province).'
UNION SELECT 
Table_name  = 'Pew_Locality',
Field_name  = 'Weighting',
Description = '',
Comments    = 'Where more than one Locality combines into a Province, the weighting given to each part is defined here.'
UNION SELECT 
Table_name  = 'Pew_Locality',
Field_name  = 'Locality_note',
Description = '',
Comments    = 'Notes about the locality.'
UNION SELECT 
Table_name  = 'Pew_Locality',
Field_name  = 'nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation).'
UNION SELECT 
Table_name  = 'Pew_Locality_Answer',
Field_name  = 'Table Name:   Pew_Locality_Answer',
Description = '',
Comments    = 'Relationship. Answers (as defined in Pew_Answer) correspondign to provices (as defined in Pew_Locality)'
UNION SELECT 
Table_name  = 'Pew_Locality_Answer',
Field_name  = 'Locality_answer_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Locality_Answer'
UNION SELECT 
Table_name  = 'Pew_Locality_Answer',
Field_name  = 'Locality_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding locality (as defined by Pew_Locality).'
UNION SELECT 
Table_name  = 'Pew_Locality_Answer',
Field_name  = 'Answer_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding answer (as defined in Pew_Answer).'
UNION SELECT 
Table_name  = 'Pew_Locality_Answer',
Field_name  = 'display',
Description = '',
Comments    = 'Indicator for whether to display with value 1 denotes "yes" and value 0 denotes "no".'
UNION SELECT 
Table_name  = 'Pew_Locality_Value',
Field_name  = 'Table Name:   Pew_Locality_Value',
Description = '',
Comments    = 'Core data (no data added yet). The value of this Field (as defined in Pew_Field) in this Locality. // THIS IS AN EMPTY TABLE'
UNION SELECT 
Table_name  = 'Pew_Locality_Value',
Field_name  = 'Locality_value_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Locality_Value.'
UNION SELECT 
Table_name  = 'Pew_Locality_Value',
Field_name  = 'Locality_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding locality (as defined by Pew_Locality).'
UNION SELECT 
Table_name  = 'Pew_Locality_Value',
Field_name  = 'Field_fk',
Description = '',
Comments    = 'NOT CURRENTLY USED: SHOULD PROBABLY BE DELETED.'
UNION SELECT 
Table_name  = 'Pew_Locality_Value',
Field_name  = 'Locality_Value',
Description = '',
Comments    = 'The value of this Field (as defined in Pew_Field) in this Locality.'
UNION SELECT 
Table_name  = 'Pew_Migration',
Field_name  = 'Table Name:   Pew_Migration',
Description = '',
Comments    = 'Core data: Migrants of each religion from each nation to each nation'
UNION SELECT 
Table_name  = 'Pew_Migration',
Field_name  = 'pew_migration_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Migration.'
UNION SELECT 
Table_name  = 'Pew_Migration',
Field_name  = 'pew_religion_group_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding religion group (as defined by Pew_Religion_Group).'
UNION SELECT 
Table_name  = 'Pew_Migration',
Field_name  = 'destination_nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation) that is the destination of migration.'
UNION SELECT 
Table_name  = 'Pew_Migration',
Field_name  = 'migrant_count',
Description = '',
Comments    = 'Migrant count of this religion from this origin country to this destination country'
UNION SELECT 
Table_name  = 'Pew_Migration',
Field_name  = 'origin_nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation) that is the nation of origin.'
UNION SELECT 
Table_name  = 'Pew_Migration',
Field_name  = 'field_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding field name (which includes type, year, and link to the data source, as defined by Pew_Field)'
UNION SELECT 
Table_name  = 'Pew_Migration',
Field_name  = 'Display_by_Religion',
Description = '',
Comments    = 'Indicator for whether to display by religion in the GRF website with value 1 denotes "yes" and value 0 denotes "no".'
UNION SELECT 
Table_name  = 'Pew_Migration',
Field_name  = 'Display_as_Destination_Ctry',
Description = '',
Comments    = 'Indicator for whether to display disaggregated data by the destination country in the GRF website (value 1 denotes "yes" and value 0 denotes "no").'
UNION SELECT 
Table_name  = 'Pew_Migration',
Field_name  = 'Display_as_Origin_Ctry',
Description = '',
Comments    = 'Indicator for whether to display the origin country in the GRF website with value 1 denotes "yes" and value 0 denotes "no".'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'Table Name:   Pew_Migration_Data',
Description = '',
Comments    = 'A view that has been saved as a table. Migrants of each religion from each nation to each nation with static fields describing the data and the nations.'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'origin',
Description = '',
Comments    = 'static lookup of Origin nation name (from Pew_Nation)'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'destination',
Description = '',
Comments    = 'static lookup of Destination nation name (from Pew_Nation)'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'religion',
Description = '',
Comments    = 'static lookup of religious group name (from Pew_Religious_Group)'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'migrant_count',
Description = '',
Comments    = 'Migrant count of this religion from this origin country to this destination country'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'data_quality_level',
Description = '',
Comments    = 'static lookup from Pew_Migration_Data_Source with quality levels from 1 to 9'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'origin_data_source',
Description = '',
Comments    = 'static lookup from Pew_Migration_Data_Source'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'origin_data_year',
Description = '',
Comments    = 'static lookup from Pew_Migration_Data_Source'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'religion_data_source',
Description = '',
Comments    = 'static lookup from Pew_Migration_Data_Source'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'religion_data_year',
Description = '',
Comments    = 'static lookup from Pew_Migration_Data_Source'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'origin_Data_type',
Description = '',
Comments    = 'static lookup from Pew_Migration_Data_Source'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'religion_data_type',
Description = '',
Comments    = 'static lookup from Pew_Migration_Data_Source'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'Migration_data_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Migration_Data'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'origin_region',
Description = '',
Comments    = 'static lookup of the region name (5 Pew regions) corresponding to the origin country (from Pew_Nation)'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'origin_pop',
Description = '',
Comments    = 'static lookup of the population of the origin country, listed as current in Pew_Nation'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'destination_region',
Description = '',
Comments    = 'static lookup of the region name (5 Pew regions) corresponding to the destination country (from Pew_Nation)'
UNION SELECT 
Table_name  = 'Pew_Migration_Data',
Field_name  = 'destination_pop',
Description = '',
Comments    = 'static lookup of the population of the destination country, listed as current in Pew_Nation'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Quality_Level',
Field_name  = 'Table Name:   Pew_Migration_Data_Quality_Level',
Description = '',
Comments    = 'Lookup. Migration data quality level (a 3 x 3 grid depending on 3 levels of origin data and 3 levels of religion data).'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Quality_Level',
Field_name  = 'data_quality_level_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Migration_Data_Quality_Level'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Quality_Level',
Field_name  = 'national_origin',
Description = '',
Comments    = '3 types of origin data'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Quality_Level',
Field_name  = 'religious_distribution',
Description = '',
Comments    = '3 types of religion data'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Quality_Level',
Field_name  = 'data_quality_level',
Description = '',
Comments    = '9 levels of data quality'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Source',
Field_name  = 'Table Name:   Pew_Migration_Data_Source',
Description = '',
Comments    = 'Lookup. For each origin/destination combination (almost 232 x 231), the migration data source, year and type of data.'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Source',
Field_name  = 'Migration_data_source_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Migration_Data_Source'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Source',
Field_name  = 'Data_quality_level_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding data quality level (as defined by Pew_Migration_Data_Quality_Level)'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Source',
Field_name  = 'Origin_data_source',
Description = '',
Comments    = 'Origin data source'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Source',
Field_name  = 'Origin_data_year',
Description = '',
Comments    = 'Origin data year'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Source',
Field_name  = 'Origin_data_type',
Description = '',
Comments    = 'Origin data type'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Source',
Field_name  = 'Destination_nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation) that is the destination of migration.'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Source',
Field_name  = 'Origin_nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation) that is the nation of origin.'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Source',
Field_name  = 'Religion_data_source',
Description = '',
Comments    = 'Religion data source'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Source',
Field_name  = 'Religion_data_year',
Description = '',
Comments    = 'Religion data year'
UNION SELECT 
Table_name  = 'Pew_Migration_Data_Source',
Field_name  = 'Religion_data_type',
Description = '',
Comments    = 'Religion data type'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Table Name:   Pew_Nation',
Description = '',
Comments    = 'Core data. The term "Nation" distinguishes these Pew entities from WRD standard "Country". Pew nations may be WRD countries, or they may be WRD sub-countries which can be combined into WRD countries based on the sub-country weightings defined in this table.  Since both levels may be included in the table, the nations are not mutually exclusive.'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Nation_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Nation'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Nation',
Description = '',
Comments    = 'Nation name or description of sub-nation'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Country_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding country (used in table [Country])'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Weighting',
Description = '',
Comments    = 'Where more than one Nation combines into a WRD County, the weighting given to each part is defined here. Weighting = 1 where Nation = Country.'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Nation_note',
Description = '',
Comments    = 'Notes about the definition of the nation'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Iso_3166_Code',
Description = '',
Comments    = 'Usually 2-character ISO country code; sometimes 3 or 4 characters.'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Nicknames',
Description = '',
Comments    = 'Alternative names for the nation.'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Pfcountry',
Description = '',
Comments    = 'Prefered nation name'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'CtryCapital',
Description = '',
Comments    = 'Capital city'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Current_pop',
Description = '',
Comments    = 'Current population -- presently, population in 2012 (as defined in Pew_Field)'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Reference_pop',
Description = '',
Comments    = 'Reference population -- presently, population in 2000 (as defined in Pew_Field)'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Life_Expectancy',
Description = '',
Comments    = 'Life Expectancy'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Literacy_Rate',
Description = '',
Comments    = 'Adult literacy Rate'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'GDP_per_capita',
Description = '',
Comments    = 'Gross domestic product (GDP) at purchasing power parity (PPP) per capita'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Ctry_EditorialName',
Description = '',
Comments    = 'Editiorial name for the nation (used by Pew)'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'TPop1990',
Description = '',
Comments    = 'Total population 1990'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'TPop2000',
Description = '',
Comments    = 'Total population 2000'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'TPop2010',
Description = '',
Comments    = 'Total population 2010'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'TPop2020',
Description = '',
Comments    = 'Total population 2020'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'TPop2030',
Description = '',
Comments    = 'Total population 2030'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Region',
Description = '',
Comments    = 'Defines the Pew region'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'SubRegion',
Description = '',
Comments    = 'Defines the Pew sub-regions'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'IMF_Advance',
Description = '',
Comments    = 'International Monetary Fund (IMF) development status'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Global_NS',
Description = '',
Comments    = 'Defines Global North and Global South'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'UN_Reg1',
Description = '',
Comments    = 'UN major region / continent'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'UN_Reg2',
Description = '',
Comments    = 'UN region'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'UN_Develop',
Description = '',
Comments    = 'UN Development status (More Developed vs. Less Developed)'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'FOTM_Advance',
Description = '',
Comments    = 'Development status of the country in the Faith On The Move (FOTM) study (for the study period)'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'TPop1910',
Description = '',
Comments    = 'Total population 1910'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Christian_pct1910',
Description = '',
Comments    = 'Christian percent 1910'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Evangelical_pct2010',
Description = '',
Comments    = 'Evangelical percent 2010'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Pentecostal_pct2010',
Description = '',
Comments    = 'Pentecostal percent 2010'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Charismatic_pct2010',
Description = '',
Comments    = 'Charismatic percent 2010'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Num_UNStatDiv',
Description = '',
Comments    = '3 digit numerical code (including leading zeros) for countries or areas used by the United Nations Statistics Division'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'SubRegion6',
Description = '',
Comments    = 'Six regions in the world (Asia-Pacific, Europe, Latin America-Caribbean, Middle East-North Africa, North America and Sub-Saharan Africa)'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Internet_user_pct',
Description = '',
Comments    = 'Internet users as percent of population. Primary source: United Nation 2006. (WRD data)'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Source_GDP_per_capita',
Description = '',
Comments    = 'Source for GDP_per_capita'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'Source_Adult_Literacy_Pct',
Description = '',
Comments    = 'Source for Literacy_Rate'
UNION SELECT 
Table_name  = 'Pew_Nation',
Field_name  = 'MainSources',
Description = '',
Comments    = 'Sources for major indicators'
UNION SELECT 
Table_name  = 'Pew_Nation_Age_Sex_Value',
Field_name  = 'Table Name:   Pew_Nation_Age_Sex_Value',
Description = '',
Comments    = 'Core data: Population by gender and age group in each Nation.'
UNION SELECT 
Table_name  = 'Pew_Nation_Age_Sex_Value',
Field_name  = 'Nation_age_sex_value_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Nation_Age_Sex_Value'
UNION SELECT 
Table_name  = 'Pew_Nation_Age_Sex_Value',
Field_name  = 'Field_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding field name (which included type, year, and link to the data source, as defined by Pew_Field)'
UNION SELECT 
Table_name  = 'Pew_Nation_Age_Sex_Value',
Field_name  = 'Nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation)'
UNION SELECT 
Table_name  = 'Pew_Nation_Age_Sex_Value',
Field_name  = 'Age_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding age (as defined by Pew_Age)'
UNION SELECT 
Table_name  = 'Pew_Nation_Age_Sex_Value',
Field_name  = 'Sex_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding sex (as defined by Pew_Sex)'
UNION SELECT 
Table_name  = 'Pew_Nation_Age_Sex_Value',
Field_name  = 'Cnt',
Description = '',
Comments    = 'Population of this gender in this age group in this nation'
UNION SELECT 
Table_name  = 'Pew_Nation_Age_Sex_Value',
Field_name  = 'Data_source',
Description = '',
Comments    = 'Source of the population data (if not given by field_fk)'
UNION SELECT 
Table_name  = 'Pew_Nation_Age_Sex_Value',
Field_name  = 'Year',
Description = '',
Comments    = 'Year of the population data (if not given by field_fk)'
UNION SELECT 
Table_name  = 'Pew_Nation_Age_Sex_Value',
Field_name  = 'display',
Description = '',
Comments    = 'Indicator for whether to display with value 1 denotes "yes" and value 0 denotes "no".'
UNION SELECT 
Table_name  = 'Pew_Nation_Answer',
Field_name  = 'Table Name:   Pew_Nation_Answer',
Description = '',
Comments    = 'Core data. Answers (as defined in Pew_Answer) applicable to each Nation.'
UNION SELECT 
Table_name  = 'Pew_Nation_Answer',
Field_name  = 'Nation_answer_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Nation_Answer'
UNION SELECT 
Table_name  = 'Pew_Nation_Answer',
Field_name  = 'Nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation)'
UNION SELECT 
Table_name  = 'Pew_Nation_Answer',
Field_name  = 'Answer_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the answer (as defined in Pew_Answer) applicable to this Nation.'
UNION SELECT 
Table_name  = 'Pew_Nation_Answer',
Field_name  = 'display',
Description = '',
Comments    = 'Indicator for whether to display with value 1 denotes "yes" and value 0 denotes "no".'
UNION SELECT 
Table_name  = 'Pew_Nation_Language',
Field_name  = 'Table Name:   Pew_Nation_Language',
Description = '',
Comments    = 'Core Data. Population by Pew language by nation'
UNION SELECT 
Table_name  = 'Pew_Nation_Language',
Field_name  = 'Nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation)'
UNION SELECT 
Table_name  = 'Pew_Nation_Language',
Field_name  = 'Pop',
Description = '',
Comments    = 'Population of this Pew language in this nation'
UNION SELECT 
Table_name  = 'Pew_Nation_Language',
Field_name  = 'Nation_language_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Nation_Language'
UNION SELECT 
Table_name  = 'Pew_Nation_Language',
Field_name  = 'Language_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the language (as defined in Pew_Language).'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Table Name:   Pew_Nation_Religion_Age_Sex_Value',
Description = '',
Comments    = 'Core data. The value of this Field (as defined in Pew_Field) for this Religion, by age group and gender, in this Nation.'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation)'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Source_year',
Description = '',
Comments    = 'Year of the data (if not given by field_fk, that is sex/age/religion/nation-specific information)'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Source',
Description = '',
Comments    = 'Source of the data (if not given by field_fk, that is sex/age/religion/nation-specific information)'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Percentage',
Description = '',
Comments    = 'Percentage value of this field for this sex,age & religion in this nation'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Field_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding field name (which included type, year, and link to the data source, as defined by Pew_Field)'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Sex_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding sex (as defined by Pew_Sex)'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Age_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding age (as defined by Pew_Age)'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Religion_group_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding religion group (as defined by Pew_Religion_Group).'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Notes',
Description = '',
Comments    = 'Notes on the Percentage value of this field for this sex,age & religion in this nation'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Scenario_id',
Description = '',
Comments    = 'Scenario'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Nation_religion_age_sex_value_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Nation_Religion_Age_Sex_Value'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Display',
Description = '',
Comments    = 'Indicator for whether to display with value 1 denotes "yes" and value 0 denotes "no".'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Cases',
Description = '',
Comments    = 'Number of cases in the original data source (survey, census, etc.) of this field for this sex, age & religion.'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Cases_Notes',
Description = '',
Comments    = 'Notes on the number of cases of this field for this sex, age & religion.'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Nation_Value_Source',
Description = '',
Comments    = 'Source for the national level data'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Age_Sex_Value',
Field_name  = 'Distribution_Wave_id',
Description = '',
Comments    = 'PRESENTLY THEY ALL HAVE VALUE 1'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Answer',
Field_name  = 'Table Name:   Pew_Nation_Religion_Answer',
Description = '',
Comments    = 'Core data. Answers (as defined in Pew_Answer) for this Religion, applicable to this Nation.'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Answer',
Field_name  = 'Nation_religion_answer_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Nation_Religion_Answer'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Answer',
Field_name  = 'Nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation)'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Answer',
Field_name  = 'Religion_group_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding religion group (as defined by Pew_Religion_Group).'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Answer',
Field_name  = 'Answer_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the answer (as defined in Pew_Answer) applicable to this Nation.'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Answer',
Field_name  = 'Adh_Pct',
Description = '',
Comments    = 'The percentage of people of this Religion in this Nation who answered in this way'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Answer',
Field_name  = 'display',
Description = '',
Comments    = 'Indicator for whether to display with value 1 denotes "yes" and value 0 denotes "no".'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Fertility_Value',
Field_name  = 'Table Name:   Pew_Nation_Religion_Fertility_Value',
Description = '',
Comments    = 'Core data. Fertility values (of females) by country, religion, and age cohort.'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Fertility_Value',
Field_name  = 'Nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation)'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Fertility_Value',
Field_name  = 'Source_year',
Description = '',
Comments    = 'Source year specific to this nation/religion/age/field'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Fertility_Value',
Field_name  = 'Source',
Description = '',
Comments    = 'The source (specific to this nation/religion/age/field)'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Fertility_Value',
Field_name  = 'Rate',
Description = '',
Comments    = 'Value of this field for this religion & age in this nation'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Fertility_Value',
Field_name  = 'Cases',
Description = '',
Comments    = 'Number of cases of this field for this religion & age in this nation'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Fertility_Value',
Field_name  = 'Field_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding field name (which included type, year, and link to the data source, as defined by Pew_Field)'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Fertility_Value',
Field_name  = 'Religion_group_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding religion group (as defined by Pew_Religion_Group).'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Fertility_Value',
Field_name  = 'measurement',
Description = '',
Comments    = 'Measurement method specific to this nation/religion/age/field'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Fertility_Value',
Field_name  = 'notes',
Description = '',
Comments    = 'Notes specific to this nation/religion/age/field'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Fertility_Value',
Field_name  = 'age_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding age (as defined by Pew_Age)'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Fertility_Value',
Field_name  = 'Scenario_id',
Description = '',
Comments    = 'Scenario'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Fertility_Value',
Field_name  = 'Nation_religion_fertility_value_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Nation_Religion_Fertility_Value'
UNION SELECT 
Table_name  = 'Pew_Nation_Religion_Fertility_Value',
Field_name  = 'Display',
Description = '',
Comments    = 'Indicator for whether to display with value 1 denotes "yes" and value 0 denotes "no".'
UNION SELECT 
Table_name  = 'Pew_Nation_Restriction_AVG',
Field_name  = 'Table Name:   Pew_Nation_Restriction_AVG',
Description = '',
Comments    = 'Core data. Cross-year average for restriction on religion variables (presently 3-year average)'
UNION SELECT 
Table_name  = 'Pew_Nation_Restriction_AVG',
Field_name  = 'Nation_restriction_avg_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Nation_Restriction_AVG'
UNION SELECT 
Table_name  = 'Pew_Nation_Restriction_AVG',
Field_name  = 'Avg_answer_value',
Description = '',
Comments    = 'Cross-year average'
UNION SELECT 
Table_name  = 'Pew_Nation_Restriction_AVG',
Field_name  = 'Ending_year',
Description = '',
Comments    = 'The lastest year for the cross-year period'
UNION SELECT 
Table_name  = 'Pew_Nation_Restriction_AVG',
Field_name  = 'Study_period',
Description = '',
Comments    = 'Cross-year period for the study'
UNION SELECT 
Table_name  = 'Pew_Nation_Restriction_AVG',
Field_name  = 'Question_abbreviation',
Description = '',
Comments    = 'Question abbreviation, also used as variable name'
UNION SELECT 
Table_name  = 'Pew_Nation_Restriction_AVG',
Field_name  = 'Question_abbreviation_order',
Description = '',
Comments    = 'Question abbreviation_order'
UNION SELECT 
Table_name  = 'Pew_Nation_Restriction_AVG',
Field_name  = 'Question_wording',
Description = '',
Comments    = 'Question wording'
UNION SELECT 
Table_name  = 'Pew_Nation_Restriction_AVG',
Field_name  = 'Nation',
Description = '',
Comments    = 'Nation'
UNION SELECT 
Table_name  = 'Pew_Nation_Subreligion_Distribution',
Field_name  = 'Table Name:   Pew_Nation_Subreligion_Distribution',
Description = '',
Comments    = 'Core data. Distribution of sub-religions within the main religion. A specific type of Nation_Religion_Value table where all values are relgion percentages'
UNION SELECT 
Table_name  = 'Pew_Nation_Subreligion_Distribution',
Field_name  = 'Nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation)'
UNION SELECT 
Table_name  = 'Pew_Nation_Subreligion_Distribution',
Field_name  = 'Sub_Religion_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding religious group (as defined by Pew_Religion_Group)'
UNION SELECT 
Table_name  = 'Pew_Nation_Subreligion_Distribution',
Field_name  = 'Aggregated_Religion_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding religious group (as defined by Pew_Religion_Group)'
UNION SELECT 
Table_name  = 'Pew_Nation_Subreligion_Distribution',
Field_name  = 'Proportion',
Description = '',
Comments    = 'Proportion of this sub-religion in this religion'
UNION SELECT 
Table_name  = 'Pew_Nation_Subreligion_Distribution',
Field_name  = 'Majority_SubReligion_Range',
Description = '',
Comments    = 'Estimate range: high, low or mid'
UNION SELECT 
Table_name  = 'Pew_Nation_Subreligion_Distribution',
Field_name  = 'nation_value_Source',
Description = '',
Comments    = 'The source (specific to this nation/religion/field)'
UNION SELECT 
Table_name  = 'Pew_Nation_Subreligion_Distribution',
Field_name  = 'nation_value_Note',
Description = '',
Comments    = 'Notes specific to this nation/religion/field'
UNION SELECT 
Table_name  = 'Pew_Nation_Subreligion_Distribution',
Field_name  = 'Nation_subreligion_distribution_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Nation_Subreligion_Distribution'
UNION SELECT 
Table_name  = 'Pew_Nation_Subreligion_Distribution',
Field_name  = 'MinYear_link',
Description = '',
Comments    = 'Minimum year to link to (all 1990)'
UNION SELECT 
Table_name  = 'Pew_Nation_Subreligion_Distribution',
Field_name  = 'Distribution_wave_id',
Description = '',
Comments    = 'Distribution wave (presently only value 1)'
UNION SELECT 
Table_name  = 'Pew_Nation_Value',
Field_name  = 'Table Name:   Pew_Nation_Value',
Description = '',
Comments    = 'Core data. The value of this Field (as defined in Pew_Field) in this Nation. (presently THEY ARE SCORES OF RESTRICTION ON RELIGION BY NATION FOR 2007 TO 2010 )'
UNION SELECT 
Table_name  = 'Pew_Nation_Value',
Field_name  = 'Nation_Value_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Nation_Value'
UNION SELECT 
Table_name  = 'Pew_Nation_Value',
Field_name  = 'Nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation)'
UNION SELECT 
Table_name  = 'Pew_Nation_Value',
Field_name  = 'Field_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding field name (which included type, year, and link to the data source, as defined by Pew_Field)'
UNION SELECT 
Table_name  = 'Pew_Nation_Value',
Field_name  = 'Nation_Value',
Description = '',
Comments    = 'The value of this Field (such as scores of restriction on religion) for this nation.'
UNION SELECT 
Table_name  = 'Pew_Preferred_Scenario',
Field_name  = 'Table Name:   Pew_Preferred_Scenario',
Description = '',
Comments    = 'Core data. Preferred scenarios for particular fields in a nation'
UNION SELECT 
Table_name  = 'Pew_Preferred_Scenario',
Field_name  = 'Preferred_scenario_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Preferred_Scenario'
UNION SELECT 
Table_name  = 'Pew_Preferred_Scenario',
Field_name  = 'Nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation)'
UNION SELECT 
Table_name  = 'Pew_Preferred_Scenario',
Field_name  = 'Field_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding field name (which included type, year, and link to the data source, as defined by Pew_Field)'
UNION SELECT 
Table_name  = 'Pew_Preferred_Scenario',
Field_name  = 'Preferred_scenario_id',
Description = '',
Comments    = 'The preferred scenario for this field in this nation (presently there are 3 values: 0, 1, and 2).'
UNION SELECT 
Table_name  = 'Pew_Question_NoStd',
Field_name  = 'Table Name:   Pew_Question_NoStd',
Description = '',
Comments    = 'Core data. Unstandarized questions'
UNION SELECT 
Table_name  = 'Pew_Question_NoStd',
Field_name  = 'Question_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Question_NoStd'
UNION SELECT 
Table_name  = 'Pew_Question_NoStd',
Field_name  = 'Question_abbreviation',
Description = '',
Comments    = 'Question abbreviation, also used as variable name'
UNION SELECT 
Table_name  = 'Pew_Question_NoStd',
Field_name  = 'Question_wording',
Description = '',
Comments    = 'Question wording'
UNION SELECT 
Table_name  = 'Pew_Question_NoStd',
Field_name  = 'Data_source_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding data source (as defined by Pew_Data_Source)'
UNION SELECT 
Table_name  = 'Pew_Question_NoStd',
Field_name  = 'Question_Year',
Description = '',
Comments    = 'Question year'
UNION SELECT 
Table_name  = 'Pew_Question_NoStd',
Field_name  = 'Short_wording',
Description = '',
Comments    = 'Shortened question wording'
UNION SELECT 
Table_name  = 'Pew_Question_NoStd',
Field_name  = 'Notes',
Description = '',
Comments    = 'Notes'
UNION SELECT 
Table_name  = 'Pew_Question_NoStd',
Field_name  = 'Default_response',
Description = '',
Comments    = 'Default response to questions'
UNION SELECT 
Table_name  = 'Pew_Question_NoStd',
Field_name  = 'Question_Std_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding standardized question abbreviation (as defined by Pew_Question_Std)'
UNION SELECT 
Table_name  = 'Pew_Question_Std',
Field_name  = 'Table Name:   Pew_Question_Std',
Description = '',
Comments    = 'Core data. Standardized questions'
UNION SELECT 
Table_name  = 'Pew_Question_Std',
Field_name  = 'Question_Std_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Question_Std'
UNION SELECT 
Table_name  = 'Pew_Question_Std',
Field_name  = 'Question_abbreviation_std',
Description = '',
Comments    = 'Standardized question abbreviation, also used as variable name.'
UNION SELECT 
Table_name  = 'Pew_Question_Std',
Field_name  = 'Question_wording_std',
Description = '',
Comments    = 'Standardized question wording.'
UNION SELECT 
Table_name  = 'Pew_Question_Std',
Field_name  = 'Question_short_wording_std',
Description = '',
Comments    = 'Standardized and shortened question wording.'
UNION SELECT 
Table_name  = 'Pew_Question_Topic',
Field_name  = 'Table Name:   Pew_Question_Topic',
Description = '',
Comments    = 'Core Data. Topics of questions'
UNION SELECT 
Table_name  = 'Pew_Question_Topic',
Field_name  = 'Question_topic_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Question_Topic'
UNION SELECT 
Table_name  = 'Pew_Question_Topic',
Field_name  = 'Question_Std_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the standard question (as defined by Pew_Question_std)'
UNION SELECT 
Table_name  = 'Pew_Question_Topic',
Field_name  = 'Topic_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding topic (as defined by Pew_Topic)'
UNION SELECT 
Table_name  = 'Pew_Question_Topic',
Field_name  = 'Priority_order',
Description = '',
Comments    = 'Priority order'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'Table Name:   Pew_Religion_Group',
Description = '',
Comments    = 'Core data. Religions or religious groups used in the sources or results of any study of the Forum (census, surveys, coded data, etc).'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'Religion_group_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Religion_Group'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'Pew_religion',
Description = '',
Comments    = 'The name of this religion or religious group used in any survey or census or Pew publication.'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'Wrd_religion_code',
Description = '',
Comments    = 'The lowest level WRD religion that covers this religious group'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'Pew_religion_lev04',
Description = '',
Comments    = 'Pew religion level 04'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'Pew_religion_lev03',
Description = '',
Comments    = 'Pew religion level 03'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'Pew_religion_lev02',
Description = '',
Comments    = 'Pew religion level 02 (top level religions)'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'Pew_religion_lev01',
Description = '',
Comments    = 'Pew religion level 01 (affiliated, unaffiliated, not defined)'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'Pew_religion_lev00',
Description = '',
Comments    = 'Pew religion level 00 (all)'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'wrd_religion_1',
Description = '',
Comments    = 'WRD religion group level 1'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'wrd_religion_2',
Description = '',
Comments    = 'WRD religion group level 2'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'wrd_religion_3',
Description = '',
Comments    = 'WRD religion group level 3'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'Pew_religion_lev01_5',
Description = '',
Comments    = '??//Pew religion level 1.5'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'Pew_religion_lev02_5',
Description = '',
Comments    = '??//Pew religion level 2.5'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'Pew_religion_lev05',
Description = '',
Comments    = 'Pew religion level 05'
UNION SELECT 
Table_name  = 'Pew_Religion_Group',
Field_name  = 'Pew_RelL02_Display',
Description = '',
Comments    = 'Pew religion level 02 as displayed in the GRF website'
UNION SELECT 
Table_name  = 'Pew_Religion_Restriction_Top_Line',
Field_name  = 'Table Name:   Pew_Religion_Restriction_Top_Line',
Description = '',
Comments    = '??//. Top lines in the publications on Restriction on Religion'
UNION SELECT 
Table_name  = 'Pew_Religion_Restriction_Top_Line',
Field_name  = 'Top_line_id',
Description = '',
Comments    = 'Numeric ID of top line tables'
UNION SELECT 
Table_name  = 'Pew_Religion_Restriction_Top_Line',
Field_name  = 'Answer_value',
Description = '',
Comments    = 'The coded value (scaled or count) assigned to each possible answer to the corresponding question.'
UNION SELECT 
Table_name  = 'Pew_Religion_Restriction_Top_Line',
Field_name  = 'Answer_wording',
Description = '',
Comments    = 'The wording of possible answers to the corresponding question or the detailed description of the meaning of the coded value.'
UNION SELECT 
Table_name  = 'Pew_Religion_Restriction_Top_Line',
Field_name  = 'Ending_year',
Description = '',
Comments    = 'The lastest year for the study'
UNION SELECT 
Table_name  = 'Pew_Religion_Restriction_Top_Line',
Field_name  = 'Study_period',
Description = '',
Comments    = 'Study period'
UNION SELECT 
Table_name  = 'Pew_Religion_Restriction_Top_Line',
Field_name  = 'Question_abbreviation',
Description = '',
Comments    = 'Question abbreviation, also used as variable name'
UNION SELECT 
Table_name  = 'Pew_Religion_Restriction_Top_Line',
Field_name  = 'Question_wording',
Description = '',
Comments    = 'Question wording'
UNION SELECT 
Table_name  = 'Pew_Religion_Restriction_Top_Line',
Field_name  = 'Nation',
Description = '',
Comments    = 'Nation'
UNION SELECT 
Table_name  = 'Pew_Religion_Restriction_Top_Line',
Field_name  = 'Pew_religion',
Description = '',
Comments    = 'Pew relgion'
UNION SELECT 
Table_name  = 'Pew_Religion_Restriction_Top_Line',
Field_name  = 'question_abbreviation_order',
Description = '',
Comments    = 'Question abbreviation order.'
UNION SELECT 
Table_name  = 'Pew_Sex',
Field_name  = 'Table Name:   Pew_Sex',
Description = '',
Comments    = 'Lookup table for gender (3 records: male, female, or all)'
UNION SELECT 
Table_name  = 'Pew_Sex',
Field_name  = 'Sex',
Description = '',
Comments    = 'all, male or female'
UNION SELECT 
Table_name  = 'Pew_Sex',
Field_name  = 'Sex_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Sex'
UNION SELECT 
Table_name  = 'Pew_Survey_Answer',
Field_name  = 'Table Name:   Pew_Survey_Answer',
Description = '',
Comments    = 'Core data. Answers in Pew surveys'
UNION SELECT 
Table_name  = 'Pew_Survey_Answer',
Field_name  = 'Pew_Survey_Answer_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Survey_Answer'
UNION SELECT 
Table_name  = 'Pew_Survey_Answer',
Field_name  = 'Nation_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the corresponding nation (as defined by Pew_Nation)'
UNION SELECT 
Table_name  = 'Pew_Survey_Answer',
Field_name  = 'Cross_Answer_fk',
Description = '',
Comments    = '??// Field used as foreign key, referring to answer  (as defined in Pew_Answer) applicable to this Nation.'
UNION SELECT 
Table_name  = 'Pew_Survey_Answer',
Field_name  = 'Answer_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the answer (as defined in Pew_Answer) applicable to this Nation.'
UNION SELECT 
Table_name  = 'Pew_Survey_Answer',
Field_name  = 'PewRel_lev02_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the religion level 2  (as defined in Pew_Religion_Group) applicable to this Nation.'
UNION SELECT 
Table_name  = 'Pew_Survey_Answer',
Field_name  = 'PewRel_lev02_5_fk',
Description = '',
Comments    = 'Field used as foreign key, referring to the religion level 2.5  (as defined in Pew_Religion_Group) applicable to this Nation.'
UNION SELECT 
Table_name  = 'Pew_Survey_Answer',
Field_name  = 'WRel_lev02_Pct',
Description = '',
Comments    = 'Percent of individuals by religion group level 2 '
UNION SELECT 
Table_name  = 'Pew_Survey_Answer',
Field_name  = 'WRel_lev02_5_Pct',
Description = '',
Comments    = 'Percent of individuals by religion group level 2.5'
UNION SELECT 
Table_name  = 'Pew_Survey_Answer',
Field_name  = 'Ctry_Pct',
Description = '',
Comments    = 'Percent of individuals '
UNION SELECT 
Table_name  = 'Pew_Survey_Answer',
Field_name  = 'L02_Display',
Description = '',
Comments    = 'Indicator for whether to display for religion group level 2'
UNION SELECT 
Table_name  = 'Pew_Survey_Answer',
Field_name  = 'L02_5_Display',
Description = '',
Comments    = 'Indicator for whether to display for religion group level 2.5'
UNION SELECT 
Table_name  = 'Pew_Survey_Answer',
Field_name  = 'unW_cases',
Description = '',
Comments    = 'Unweighted number of cases in the survey'
UNION SELECT 
Table_name  = 'Pew_Topic',
Field_name  = 'Table Name:   Pew_Topic',
Description = '',
Comments    = 'Core data. Topics and subtopics of Pew studies and research projects'
UNION SELECT 
Table_name  = 'Pew_Topic',
Field_name  = 'Topic_pk',
Description = '',
Comments    = 'Field used as primary key of the table Pew_Topic'
UNION SELECT 
Table_name  = 'Pew_Topic',
Field_name  = 'Topic_sorting',
Description = '',
Comments    = 'Sorting number for  topics'
UNION SELECT 
Table_name  = 'Pew_Topic',
Field_name  = 'SubTopic_Sorting',
Description = '',
Comments    = 'Sorting number for subtopics'
UNION SELECT 
Table_name  = 'Pew_Topic',
Field_name  = 'Topic',
Description = '',
Comments    = 'Main topics'
UNION SELECT 
Table_name  = 'Pew_Topic',
Field_name  = 'SubTopic',
Description = '',
Comments    = 'Subtopics'
UNION SELECT 
Table_name  = 'Pew_Topic',
Field_name  = 'Display',
Description = '',
Comments    = 'Indicator for whether to display with value 1 denotes "yes" and value 0 denotes "no".'
UNION SELECT 
Table_name  = 'Country',
Field_name  = 'Table Name:   Country',
Description = '',
Comments    = 'Core WRD data. Countries and terrirtories used as units of analysis to aggregate data.'
UNION SELECT 
Table_name  = 'Province',
Field_name  = 'Table Name:   Province',
Description = '',
Comments    = 'Core WRD data. Provinces or other territorial sub-divisions of the countries used as units of analysis to aggregate data.'
UNION SELECT 
Table_name  = 'Survey',
Field_name  = 'Table Name:   Survey',
Description = '',
Comments    = 'List of all consulted surveys including main characteristics'
UNION SELECT 
Table_name  = 'Survey_data',
Field_name  = 'Table Name:   Survey_data',
Description = '',
Comments    = 'Percentage of adherents by locality and religious group (as they are named in the survey), acoording to the different surveys.'
UNION SELECT 
Table_name  = 'Survey_locality',
Field_name  = 'Table Name:   Survey_locality',
Description = '',
Comments    = 'Religious composition and number of cases for the  top 5 religions over 1% in each locality-province acoording to the different surveys (% not by province not by locality, a province could have more than one locality as they are named in the survey, and a locality can also correspond to more than one province).'
UNION SELECT 
Table_name  = 'Survey_religion_code',
Field_name  = 'Table Name:   Survey_religion_code',
Description = '',
Comments    = 'Religious groups as they are named in the survey (including pct of adherents by the corresponding country). * 3 rows are duplicated.'
UNION SELECT 
Table_name  = 'zg_WRD_Religion',
Field_name  = 'Table Name:   zg_WRD_Religion',
Description = '',
Comments    = 'Core WRD data. Religions or religious groups which are referred by the diferent statistics (demography, restrictions, etc.).'
---------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                                                                                        ) data
/*************************************************************************************************************************************************************/
/*************************************************************************************************************************************************************/
---------------------------------------------------------------------------------------------------------------------------------------------------------------


