/**************************************************************************************************************************************************/
/***                                                                                                                                            ***/
/***     >>>>>   This is the script used to create the view [_Admin].[dbo].[Metadata]                                                 <<<<<     ***/
/***             (Metadata for all tables and fields in [forum])                                                                                ***/
/***                                                                                                                                            ***/
/**************************************************************************************************************************************************/
USE [_Admin]
GO
/*****************************************************************************************************************************************************/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/**************************************************************************************************************************************************/
declare @CURR nvarchar(4)                                 /***        declare variable for storing current year (number as text)                ***/
set     @CURR = (SELECT (MAX([Q_Yr]) - 0)                 /***        set value to current year                                                 ***/
                 FROM [s11_AllCodedValues]  )             /***        from main view used as source                                             ***/
declare @PAST nvarchar(4)                                 /***        declare variable for storing former year (number as text)                 ***/
set     @PAST = (SELECT (MAX([Q_Yr]) - 1)                 /***        set value to former year = current year minus 1                           ***/
                 FROM [s11_AllCodedValues]  )             /***        from main view used as source                                             ***/
declare @CODEmain nvarchar(max)                           /***        declare variable for storing the main code to be executed                 ***/
set     @CODEmain =                                       /***        start storing text as part of the main code to be executed                ***/
/*********************************************************     >>>>>> this is the main code to be executed                                      ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the first part w/temp. set known as common table expression CTE   ***/
N'
ALTER VIEW     [dbo].[Metadata]       AS




WITH [CTE]
  AS
    (
      SELECT [Nation_fk]
            ,[Ctry_EditorialName]
            ,[Year]                = SUBSTRING([Question_Year], 6, 8)
           '








/*****************************************************************************************************************************************************/
/*** >>  ***********************************************************************************/
/*****************************************************************************************************************************************************/


/*****************************************************************************************************************************************************/
/*****************************************************************************************************************************************************/
---------------------------------------------------------------------------------------------------------------------------------------------------
/*****************************************************************************************************************************/
SELECT
          N                =   ROW_NUMBER()
                              OVER(ORDER BY   
                                              TableID
                                            , Field_Number
                                            , Linked_Table
                                            , Linked_FN     )
        , tN               =  RIGHT('0'+ CONVERT(VARCHAR,TableID),2)
                                       + '|  '
                                       + CONVERT(VARCHAR,Table_Number)
        , fN               =  Field_Number         -- 2
        , Table_Name                               -- 3
        , Field_Name                               -- 4
        , Referenciality                           -- 5
        , Description      =  CASE
                                   WHEN Description IS NULL THEN 'not pulled from WRD yet'
                                   ELSE Description
                               END
        , Comments          =  CASE
                                   WHEN Comments    IS NULL THEN 'not pulled from WRD yet'
                                   ELSE Comments
                               END
        --, tnd
        --, fnd
        , Type                                     -- 6
        , Nullable                                 -- 7
        , Size                                     -- 8
        , DistinctRows                             -- 9
        , CharSet                                  -- 10
                           =  CASE
                                   WHEN CharSet IS NULL
                                   THEN '--'
                                   ELSE CharSet
                               END
        , Linked_Table                             -- 11
                           =  CASE
                                   WHEN Linked_Table IS NULL
                                   THEN '--'
                                   ELSE Linked_Table
                               END
        , Linked_Field                             -- 12
                           =  CASE
                                   WHEN Linked_Field IS NULL
                                   THEN '--'
                                   ELSE Linked_Field
                               END
FROM
(
/*** >> MTB: Main Table ******************************************************************************************************/
SELECT *
FROM
(
/*****************************************************************************************************************************/
/*** Columns for TABLES ******************************************************************************************************/
SELECT
          TableID
        , Table_Number                             -- 1
        , Field_Number                             -- 2
        , Table_Name                               -- 3
        , Field_Name                               -- 4
        , Referenciality                           -- 5
        , Type                                     -- 6
        , Nullable                                 -- 7
        , Size                                     -- 8
        , DistinctRows                             -- 9
        , CharSet                                  -- 10
FROM
(
-------------------------------------------------------------------------------------------------------------------------------
-- Table_Number
 SELECT 
         TN             = name
       , ROW_NUMBER() OVER(ORDER BY name )
         AS TableID
       , Table_Number   = object_id
       , Field_Number   = 0
       , Table_Name     = name
       , Field_Name     =  'Table Name:   '
                          + name
       , Referenciality = 'H'
       , Type           = 'N.A.'
       , Nullable       = 'N.A.'
       , CharSet        = 'N.A.'
  FROM
       forum.sys.Tables
-------------------------------------------------------------------------------------------------------------------------------
                                                                                            ) as T1
,
(
-------------------------------------------------------------------------------------------------------------------------------
-- Size (n of columns; includes views)
 SELECT 
         DISTINCT
         TN             = TABLE_NAME
       , Size           = CAST((COUNT(COLUMN_NAME) OVER (PARTITION BY TABLE_NAME)) as varchar)
  FROM
       forum.INFORMATION_SCHEMA.COLUMNS
-------------------------------------------------------------------------------------------------------------------------------
                                                                                            ) as T7
,
(
-------------------------------------------------------------------------------------------------------------------------------
--DistinctRows  (counts rows of tables)
 SELECT 
         DISTINCT
         TN             = t.NAME
       , DistinctRows   = p.rows
FROM 
     forum.sys.tables     t
INNER JOIN 
     forum.sys.schemas    s ON t.schema_id = s.schema_id
INNER JOIN      
     forum.sys.indexes    i ON t.OBJECT_ID = i.object_id
INNER JOIN 
     forum.sys.partitions p ON i.object_id = p.OBJECT_ID
                           AND i.index_id  = p.index_id
-------------------------------------------------------------------------------------------------------------------------------
                                                                                            ) as T8
-------------------------------------------------------------------------------------------------------------------------------
WHERE 
         T1.TN
       = T7.TN
  AND
         T1.TN
       = T8.TN
/****************************************************************************************************** Columns for TABLES ***/
/*****************************************************************************************************************************/
) MTT
-------------------------------------------------------------------------------------------------------------------------------
UNION
-------------------------------------------------------------------------------------------------------------------------------
SELECT *
FROM
(
/*****************************************************************************************************************************/
/*** Columns for FIELDS ******************************************************************************************************/
SELECT
          TableID
        , Table_Number                             -- 1
        , Field_Number                             -- 2
        , Table_Name                               -- 3
        , Field_Name                               -- 4
        , Referenciality                           -- 5
        , Type                                     -- 6
        , Nullable                                 -- 7
        , Size                                     -- 8
        , DistinctRows                             -- 9
        , CharSet                                  -- 10
FROM
(
-------------------------------------------------------------------------------------------------------------------------------
-- All fields (except N of rows) in all fields of all tables
 SELECT 
         TableID        = N.TableID
       , Table_Number   = N.Table_Number
       , Field_Number   = C.ORDINAL_POSITION
       , Table_Name     = C.TABLE_NAME
       , Field_Name     = C.COLUMN_NAME
       , Referenciality = CASE
                               WHEN RIGHT(C.COLUMN_NAME, 3) = '_pk'                         THEN 'pk'
                               WHEN RIGHT(C.COLUMN_NAME, 3) = '_fk'                         THEN 'fk'
                               WHEN       C.COLUMN_NAME     = 'Country_ID'                  THEN 'pk'
                               WHEN       C.COLUMN_NAME     = 'Code_value'                  THEN 'pk'
                               WHEN       C.COLUMN_NAME     = 'Wrd_religion_code'           THEN 'fk'  /* unstd but USED */

                               WHEN       C.COLUMN_NAME     = 'Preferred_scenario_id'       THEN 'ul'  /* undefined link */
                               WHEN       C.COLUMN_NAME     = 'Question_abbreviation_std'   THEN 'ul'  /* undefined link */

                               ELSE                                      '-'
                           END
       , Type           = C.DATA_TYPE
       , Nullable       = C.IS_NULLABLE
       , Size           = CASE
                          WHEN            C.DATA_TYPE                 = 'bit'
                          THEN  'bit 1'
                          WHEN            C.CHARACTER_MAXIMUM_LENGTH IS NULL
                          THEN  'N' + STR(C.NUMERIC_PRECISION,        3) 
                              + '(' + STR(C.NUMERIC_PRECISION_RADIX,  2) + ')'
                          ELSE 'Ch' + STR(C.CHARACTER_MAXIMUM_LENGTH, 6)
                          END
       , CharSet        = C.CHARACTER_SET_NAME
-- select *
FROM
         forum.information_schema.columns                  C
inner
JOIN
         forum.information_schema.tables                   T
           ON     c.table_name   = t.table_name
           AND    c.table_schema = t.table_schema
inner
JOIN
(
 SELECT 
         TN             = name
       , ROW_NUMBER() OVER(ORDER BY name )
         AS TableID
       , Table_Number   = object_id
  FROM
       forum.sys.Tables                                 )  N
           ON     N.TN   = t.table_name
-------------------------------------------------------------------------------------------------------------------------------
                                                                                            ) as F1
,
(
-------------------------------------------------------------------------------------------------------------------------------
--DistinctRows  (counts rows of fields)
       SELECT COUNT (DISTINCT Age_pk) AS DistinctRows, Field = 'Pew_Age_Age_pk' FROM forum.dbo.Pew_Age UNION SELECT COUNT (DISTINCT Age) AS DistinctRows, Field = 'Pew_Age_Age' FROM forum.dbo.Pew_Age 
 UNION SELECT COUNT (DISTINCT Answer_pk) AS DistinctRows, Field = 'Pew_Answer_Answer_pk' FROM forum.dbo.Pew_Answer UNION SELECT COUNT (DISTINCT Answer_value) AS DistinctRows, Field = 'Pew_Answer_Answer_value' FROM forum.dbo.Pew_Answer UNION SELECT COUNT (DISTINCT Question_fk) AS DistinctRows, Field = 'Pew_Answer_Question_fk' FROM forum.dbo.Pew_Answer UNION SELECT COUNT (DISTINCT Answer_wording) AS DistinctRows, Field = 'Pew_Answer_Answer_wording' FROM forum.dbo.Pew_Answer UNION SELECT COUNT (DISTINCT answer_wording_std) AS DistinctRows, Field = 'Pew_Answer_answer_wording_std' FROM forum.dbo.Pew_Answer 
 UNION SELECT COUNT (DISTINCT Country_ID) AS DistinctRows, Field = 'Country_Country_ID' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Country_Name) AS DistinctRows, Field = 'Country_Country_Name' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Country_footnote) AS DistinctRows, Field = 'Country_Country_footnote' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Official_country_name) AS DistinctRows, Field = 'Country_Official_country_name' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT UN_region) AS DistinctRows, Field = 'Country_UN_region' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Province_count) AS DistinctRows, Field = 'Country_Province_count' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT N_Pop_1900) AS DistinctRows, Field = 'Country_N_Pop_1900' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT N_Pop_1950) AS DistinctRows, Field = 'Country_N_Pop_1950' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT N_Pop_1970) AS DistinctRows, Field = 'Country_N_Pop_1970' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT N_pop_2000) AS DistinctRows, Field = 'Country_N_pop_2000' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT N_pop_2005) AS DistinctRows, Field = 'Country_N_pop_2005' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT N_pop) AS DistinctRows, Field = 'Country_N_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT N_pop_2025) AS DistinctRows, Field = 'Country_N_pop_2025' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT N_pop_2050) AS DistinctRows, Field = 'Country_N_pop_2050' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Adult_pop) AS DistinctRows, Field = 'Country_Adult_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Adult_Pct) AS DistinctRows, Field = 'Country_Adult_Pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Birth_Pct) AS DistinctRows, Field = 'Country_Birth_Pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Death_Pct) AS DistinctRows, Field = 'Country_Death_Pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Pop_increase_pct) AS DistinctRows, Field = 'Country_Pop_increase_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Life_expectancy) AS DistinctRows, Field = 'Country_Life_expectancy' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Household_size) AS DistinctRows, Field = 'Country_Household_size' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Pop_density) AS DistinctRows, Field = 'Country_Pop_density' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT People_count) AS DistinctRows, Field = 'Country_People_count' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Dev_index) AS DistinctRows, Field = 'Country_Dev_index' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT HDI) AS DistinctRows, Field = 'Country_HDI' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Adult_literacy_pct) AS DistinctRows, Field = 'Country_Adult_literacy_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Adult_literate_pop) AS DistinctRows, Field = 'Country_Adult_literate_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Rural_pop) AS DistinctRows, Field = 'Country_Rural_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Rural_pct) AS DistinctRows, Field = 'Country_Rural_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Urban_pop) AS DistinctRows, Field = 'Country_Urban_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Urban_pct) AS DistinctRows, Field = 'Country_Urban_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Metro_pop) AS DistinctRows, Field = 'Country_Metro_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Metro_pct) AS DistinctRows, Field = 'Country_Metro_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Small_city_count) AS DistinctRows, Field = 'Country_Small_city_count' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Medium_city_count) AS DistinctRows, Field = 'Country_Medium_city_count' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Mega_city_count) AS DistinctRows, Field = 'Country_Mega_city_count' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Water_access_pct) AS DistinctRows, Field = 'Country_Water_access_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Infant_mortality) AS DistinctRows, Field = 'Country_Infant_mortality' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Education_pct) AS DistinctRows, Field = 'Country_Education_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Major_religion_count) AS DistinctRows, Field = 'Country_Major_religion_count' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Ethnoreligion_count) AS DistinctRows, Field = 'Country_Ethnoreligion_count' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Orthodox_pop) AS DistinctRows, Field = 'Country_Orthodox_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Catholic_pop) AS DistinctRows, Field = 'Country_Catholic_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Anglican_pop) AS DistinctRows, Field = 'Country_Anglican_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Protestant_pop) AS DistinctRows, Field = 'Country_Protestant_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Independent_pop) AS DistinctRows, Field = 'Country_Independent_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Marginal_pop) AS DistinctRows, Field = 'Country_Marginal_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Evangelical_pop) AS DistinctRows, Field = 'Country_Evangelical_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Pentecostal_pop) AS DistinctRows, Field = 'Country_Pentecostal_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Charismatic_pop) AS DistinctRows, Field = 'Country_Charismatic_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Neocharismatic_pop) AS DistinctRows, Field = 'Country_Neocharismatic_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Renewalist_pop) AS DistinctRows, Field = 'Country_Renewalist_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Crypto_Chr_pop) AS DistinctRows, Field = 'Country_Crypto_Chr_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Professing_Chr_pop) AS DistinctRows, Field = 'Country_Professing_Chr_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Secular_station_audience_pct) AS DistinctRows, Field = 'Country_Secular_station_audience_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Pop_growth_pct_2025) AS DistinctRows, Field = 'Country_Pop_growth_pct_2025' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Pop_growth_2025) AS DistinctRows, Field = 'Country_Pop_growth_2025' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Pop_growth_pct_2050) AS DistinctRows, Field = 'Country_Pop_growth_pct_2050' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Pop_growth_2050) AS DistinctRows, Field = 'Country_Pop_growth_2050' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Agnostic_pop) AS DistinctRows, Field = 'Country_Agnostic_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Atheist_pop) AS DistinctRows, Field = 'Country_Atheist_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Bahai_pop) AS DistinctRows, Field = 'Country_Bahai_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Buddhist_pop) AS DistinctRows, Field = 'Country_Buddhist_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Chinese_folk_pop) AS DistinctRows, Field = 'Country_Chinese_folk_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Christian_pop) AS DistinctRows, Field = 'Country_Christian_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Confucianist_pop) AS DistinctRows, Field = 'Country_Confucianist_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Daoist_pop) AS DistinctRows, Field = 'Country_Daoist_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Ethnoreligionist_pop) AS DistinctRows, Field = 'Country_Ethnoreligionist_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Hindu_pop) AS DistinctRows, Field = 'Country_Hindu_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Jain_pop) AS DistinctRows, Field = 'Country_Jain_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Jew_pop) AS DistinctRows, Field = 'Country_Jew_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Muslim_pop) AS DistinctRows, Field = 'Country_Muslim_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Neoreligionist_pop) AS DistinctRows, Field = 'Country_Neoreligionist_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Shintoist_pop) AS DistinctRows, Field = 'Country_Shintoist_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Sikh_pop) AS DistinctRows, Field = 'Country_Sikh_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Spiritist_pop) AS DistinctRows, Field = 'Country_Spiritist_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Zoroastrian_pop) AS DistinctRows, Field = 'Country_Zoroastrian_pop' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT ISO_A2) AS DistinctRows, Field = 'Country_ISO_A2' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT ROG_code) AS DistinctRows, Field = 'Country_ROG_code' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Corruption_index) AS DistinctRows, Field = 'Country_Corruption_index' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Religious_Freedom_Index) AS DistinctRows, Field = 'Country_Religious_Freedom_Index' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Governmental_Restrictions_Index) AS DistinctRows, Field = 'Country_Governmental_Restrictions_Index' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Social_Restrictions_Index) AS DistinctRows, Field = 'Country_Social_Restrictions_Index' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Governmental_Favoritism_Index) AS DistinctRows, Field = 'Country_Governmental_Favoritism_Index' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Religious_Conflict) AS DistinctRows, Field = 'Country_Religious_Conflict' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Religious_Violence) AS DistinctRows, Field = 'Country_Religious_Violence' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Major_religions) AS DistinctRows, Field = 'Country_Major_religions' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Physicians_per_k) AS DistinctRows, Field = 'Country_Physicians_per_k' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT HIV_Adult_per_k) AS DistinctRows, Field = 'Country_HIV_Adult_per_k' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Malaria_per_k) AS DistinctRows, Field = 'Country_Malaria_per_k' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT GDP_per_capita) AS DistinctRows, Field = 'Country_GDP_per_capita' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT GNI_per_capita) AS DistinctRows, Field = 'Country_GNI_per_capita' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Net_Worth_per_capita) AS DistinctRows, Field = 'Country_Net_Worth_per_capita' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Internet_user_pct) AS DistinctRows, Field = 'Country_Internet_user_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Agnostic_pct) AS DistinctRows, Field = 'Country_Agnostic_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Atheist_pct) AS DistinctRows, Field = 'Country_Atheist_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Bahai_pct) AS DistinctRows, Field = 'Country_Bahai_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Buddhist_pct) AS DistinctRows, Field = 'Country_Buddhist_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Chinese_folk_pct) AS DistinctRows, Field = 'Country_Chinese_folk_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Christian_pct) AS DistinctRows, Field = 'Country_Christian_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Confucianist_pct) AS DistinctRows, Field = 'Country_Confucianist_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Daoist_pct) AS DistinctRows, Field = 'Country_Daoist_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Ethnoreligionist_pct) AS DistinctRows, Field = 'Country_Ethnoreligionist_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Hindu_pct) AS DistinctRows, Field = 'Country_Hindu_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Jain_pct) AS DistinctRows, Field = 'Country_Jain_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Jew_pct) AS DistinctRows, Field = 'Country_Jew_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Muslim_pct) AS DistinctRows, Field = 'Country_Muslim_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Neoreligionist_pct) AS DistinctRows, Field = 'Country_Neoreligionist_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Shintoist_pct) AS DistinctRows, Field = 'Country_Shintoist_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Sikh_pct) AS DistinctRows, Field = 'Country_Sikh_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Spiritist_pct) AS DistinctRows, Field = 'Country_Spiritist_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT Zoroastrian_pct) AS DistinctRows, Field = 'Country_Zoroastrian_pct' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT N_pop_2010) AS DistinctRows, Field = 'Country_N_pop_2010' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT flag_filename) AS DistinctRows, Field = 'Country_flag_filename' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT map_filename) AS DistinctRows, Field = 'Country_map_filename' FROM forum.dbo.Country UNION SELECT COUNT (DISTINCT UN_Region_Value) AS DistinctRows, Field = 'Country_UN_Region_Value' FROM forum.dbo.Country 
 UNION SELECT COUNT (DISTINCT data_quality_level_pk) AS DistinctRows, Field = 'Pew_Migration_Data_Quality_Level_data_quality_level_pk' FROM forum.dbo.Pew_Migration_Data_Quality_Level UNION SELECT COUNT (DISTINCT national_origin) AS DistinctRows, Field = 'Pew_Migration_Data_Quality_Level_national_origin' FROM forum.dbo.Pew_Migration_Data_Quality_Level UNION SELECT COUNT (DISTINCT religious_distribution) AS DistinctRows, Field = 'Pew_Migration_Data_Quality_Level_religious_distribution' FROM forum.dbo.Pew_Migration_Data_Quality_Level UNION SELECT COUNT (DISTINCT data_quality_level) AS DistinctRows, Field = 'Pew_Migration_Data_Quality_Level_data_quality_level' FROM forum.dbo.Pew_Migration_Data_Quality_Level 
 UNION SELECT COUNT (DISTINCT Data_source_pk) AS DistinctRows, Field = 'Pew_Data_Source_Data_source_pk' FROM forum.dbo.Pew_Data_Source UNION SELECT COUNT (DISTINCT Data_source_name) AS DistinctRows, Field = 'Pew_Data_Source_Data_source_name' FROM forum.dbo.Pew_Data_Source UNION SELECT COUNT (DISTINCT Data_source_description) AS DistinctRows, Field = 'Pew_Data_Source_Data_source_description' FROM forum.dbo.Pew_Data_Source UNION SELECT COUNT (DISTINCT Data_source_url) AS DistinctRows, Field = 'Pew_Data_Source_Data_source_url' FROM forum.dbo.Pew_Data_Source UNION SELECT COUNT (DISTINCT Source_Display_Name) AS DistinctRows, Field = 'Pew_Data_Source_Source_Display_Name' FROM forum.dbo.Pew_Data_Source 
 UNION SELECT COUNT (DISTINCT Display_Footnotes_pk) AS DistinctRows, Field = 'Pew_Display_Footnotes_Display_Footnotes_pk' FROM forum.dbo.Pew_Display_Footnotes UNION SELECT COUNT (DISTINCT List_fk) AS DistinctRows, Field = 'Pew_Display_Footnotes_List_fk' FROM forum.dbo.Pew_Display_Footnotes UNION SELECT COUNT (DISTINCT item_fk) AS DistinctRows, Field = 'Pew_Display_Footnotes_item_fk' FROM forum.dbo.Pew_Display_Footnotes UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Display_Footnotes_Nation_fk' FROM forum.dbo.Pew_Display_Footnotes UNION SELECT COUNT (DISTINCT Locality_fk) AS DistinctRows, Field = 'Pew_Display_Footnotes_Locality_fk' FROM forum.dbo.Pew_Display_Footnotes UNION SELECT COUNT (DISTINCT Religion_fk) AS DistinctRows, Field = 'Pew_Display_Footnotes_Religion_fk' FROM forum.dbo.Pew_Display_Footnotes UNION SELECT COUNT (DISTINCT Topic_fk) AS DistinctRows, Field = 'Pew_Display_Footnotes_Topic_fk' FROM forum.dbo.Pew_Display_Footnotes UNION SELECT COUNT (DISTINCT Question_fk) AS DistinctRows, Field = 'Pew_Display_Footnotes_Question_fk' FROM forum.dbo.Pew_Display_Footnotes UNION SELECT COUNT (DISTINCT Note_fk) AS DistinctRows, Field = 'Pew_Display_Footnotes_Note_fk' FROM forum.dbo.Pew_Display_Footnotes UNION SELECT COUNT (DISTINCT Note_SortingNumber) AS DistinctRows, Field = 'Pew_Display_Footnotes_Note_SortingNumber' FROM forum.dbo.Pew_Display_Footnotes 
 UNION SELECT COUNT (DISTINCT Display_Question_pk) AS DistinctRows, Field = 'Pew_Display_Question_Display_Question_pk' FROM forum.dbo.Pew_Display_Question UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Display_Question_Nation_fk' FROM forum.dbo.Pew_Display_Question UNION SELECT COUNT (DISTINCT TabNumber) AS DistinctRows, Field = 'Pew_Display_Question_TabNumber' FROM forum.dbo.Pew_Display_Question UNION SELECT COUNT (DISTINCT ChartNumber) AS DistinctRows, Field = 'Pew_Display_Question_ChartNumber' FROM forum.dbo.Pew_Display_Question UNION SELECT COUNT (DISTINCT Question_fk) AS DistinctRows, Field = 'Pew_Display_Question_Question_fk' FROM forum.dbo.Pew_Display_Question 
 UNION SELECT COUNT (DISTINCT Display_Reports_pk) AS DistinctRows, Field = 'Pew_Display_Reports_Display_Reports_pk' FROM forum.dbo.Pew_Display_Reports UNION SELECT COUNT (DISTINCT List_fk) AS DistinctRows, Field = 'Pew_Display_Reports_List_fk' FROM forum.dbo.Pew_Display_Reports UNION SELECT COUNT (DISTINCT item_fk) AS DistinctRows, Field = 'Pew_Display_Reports_item_fk' FROM forum.dbo.Pew_Display_Reports UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Display_Reports_Nation_fk' FROM forum.dbo.Pew_Display_Reports UNION SELECT COUNT (DISTINCT Locality_fk) AS DistinctRows, Field = 'Pew_Display_Reports_Locality_fk' FROM forum.dbo.Pew_Display_Reports UNION SELECT COUNT (DISTINCT Religion_fk) AS DistinctRows, Field = 'Pew_Display_Reports_Religion_fk' FROM forum.dbo.Pew_Display_Reports UNION SELECT COUNT (DISTINCT Topic_fk) AS DistinctRows, Field = 'Pew_Display_Reports_Topic_fk' FROM forum.dbo.Pew_Display_Reports UNION SELECT COUNT (DISTINCT Question_fk) AS DistinctRows, Field = 'Pew_Display_Reports_Question_fk' FROM forum.dbo.Pew_Display_Reports UNION SELECT COUNT (DISTINCT Data_source_fk) AS DistinctRows, Field = 'Pew_Display_Reports_Data_source_fk' FROM forum.dbo.Pew_Display_Reports UNION SELECT COUNT (DISTINCT Report_SortingNumber) AS DistinctRows, Field = 'Pew_Display_Reports_Report_SortingNumber' FROM forum.dbo.Pew_Display_Reports UNION SELECT COUNT (DISTINCT GRF_Level) AS DistinctRows, Field = 'Pew_Display_Reports_GRF_Level' FROM forum.dbo.Pew_Display_Reports 
 UNION SELECT COUNT (DISTINCT Field_pk) AS DistinctRows, Field = 'Pew_Field_Field_pk' FROM forum.dbo.Pew_Field UNION SELECT COUNT (DISTINCT Field_name) AS DistinctRows, Field = 'Pew_Field_Field_name' FROM forum.dbo.Pew_Field UNION SELECT COUNT (DISTINCT Field_note) AS DistinctRows, Field = 'Pew_Field_Field_note' FROM forum.dbo.Pew_Field UNION SELECT COUNT (DISTINCT Field_type) AS DistinctRows, Field = 'Pew_Field_Field_type' FROM forum.dbo.Pew_Field UNION SELECT COUNT (DISTINCT Field_year) AS DistinctRows, Field = 'Pew_Field_Field_year' FROM forum.dbo.Pew_Field UNION SELECT COUNT (DISTINCT Data_source_fk) AS DistinctRows, Field = 'Pew_Field_Data_source_fk' FROM forum.dbo.Pew_Field 
 UNION SELECT COUNT (DISTINCT Flag_pk) AS DistinctRows, Field = 'Pew_Flag_Flag_pk' FROM forum.dbo.Pew_Flag UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Flag_Nation_fk' FROM forum.dbo.Pew_Flag UNION SELECT COUNT (DISTINCT Flag_name) AS DistinctRows, Field = 'Pew_Flag_Flag_name' FROM forum.dbo.Pew_Flag UNION SELECT COUNT (DISTINCT Flag_image) AS DistinctRows, Field = 'Pew_Flag_Flag_image' FROM forum.dbo.Pew_Flag 
 UNION SELECT COUNT (DISTINCT G_20_3_summary_pk) AS DistinctRows, Field = 'Pew_G_20_3_Summary_G_20_3_summary_pk' FROM forum.dbo.Pew_G_20_3_Summary UNION SELECT COUNT (DISTINCT Answer_value) AS DistinctRows, Field = 'Pew_G_20_3_Summary_Answer_value' FROM forum.dbo.Pew_G_20_3_Summary UNION SELECT COUNT (DISTINCT Answer_wording) AS DistinctRows, Field = 'Pew_G_20_3_Summary_Answer_wording' FROM forum.dbo.Pew_G_20_3_Summary UNION SELECT COUNT (DISTINCT Question_year) AS DistinctRows, Field = 'Pew_G_20_3_Summary_Question_year' FROM forum.dbo.Pew_G_20_3_Summary UNION SELECT COUNT (DISTINCT Notes) AS DistinctRows, Field = 'Pew_G_20_3_Summary_Notes' FROM forum.dbo.Pew_G_20_3_Summary UNION SELECT COUNT (DISTINCT Question_abbreviation) AS DistinctRows, Field = 'Pew_G_20_3_Summary_Question_abbreviation' FROM forum.dbo.Pew_G_20_3_Summary UNION SELECT COUNT (DISTINCT Question_wording) AS DistinctRows, Field = 'Pew_G_20_3_Summary_Question_wording' FROM forum.dbo.Pew_G_20_3_Summary UNION SELECT COUNT (DISTINCT Nation) AS DistinctRows, Field = 'Pew_G_20_3_Summary_Nation' FROM forum.dbo.Pew_G_20_3_Summary 
 UNION SELECT COUNT (DISTINCT GRFsite_URLs_Topic_pk) AS DistinctRows, Field = 'Pew_GRFsite_URLs_Topic_GRFsite_URLs_Topic_pk' FROM forum.dbo.Pew_GRFsite_URLs_Topic UNION SELECT COUNT (DISTINCT GRFsite_URL) AS DistinctRows, Field = 'Pew_GRFsite_URLs_Topic_GRFsite_URL' FROM forum.dbo.Pew_GRFsite_URLs_Topic UNION SELECT COUNT (DISTINCT Topic_fk) AS DistinctRows, Field = 'Pew_GRFsite_URLs_Topic_Topic_fk' FROM forum.dbo.Pew_GRFsite_URLs_Topic UNION SELECT COUNT (DISTINCT Display) AS DistinctRows, Field = 'Pew_GRFsite_URLs_Topic_Display' FROM forum.dbo.Pew_GRFsite_URLs_Topic UNION SELECT COUNT (DISTINCT Priority_order) AS DistinctRows, Field = 'Pew_GRFsite_URLs_Topic_Priority_order' FROM forum.dbo.Pew_GRFsite_URLs_Topic 
 UNION SELECT COUNT (DISTINCT ID) AS DistinctRows, Field = 'zg_WRD_Religion_ID' FROM forum.dbo.zg_WRD_Religion UNION SELECT COUNT (DISTINCT Code_value) AS DistinctRows, Field = 'zg_WRD_Religion_Code_value' FROM forum.dbo.zg_WRD_Religion UNION SELECT COUNT (DISTINCT Sort_key) AS DistinctRows, Field = 'zg_WRD_Religion_Sort_key' FROM forum.dbo.zg_WRD_Religion UNION SELECT COUNT (DISTINCT Description) AS DistinctRows, Field = 'zg_WRD_Religion_Description' FROM forum.dbo.zg_WRD_Religion UNION SELECT COUNT (DISTINCT WRD_Level) AS DistinctRows, Field = 'zg_WRD_Religion_WRD_Level' FROM forum.dbo.zg_WRD_Religion UNION SELECT COUNT (DISTINCT Supplementary_code_YesNo) AS DistinctRows, Field = 'zg_WRD_Religion_Supplementary_code_YesNo' FROM forum.dbo.zg_WRD_Religion UNION SELECT COUNT (DISTINCT WRD_Religion_1) AS DistinctRows, Field = 'zg_WRD_Religion_WRD_Religion_1' FROM forum.dbo.zg_WRD_Religion UNION SELECT COUNT (DISTINCT WRD_Religion_2) AS DistinctRows, Field = 'zg_WRD_Religion_WRD_Religion_2' FROM forum.dbo.zg_WRD_Religion UNION SELECT COUNT (DISTINCT WRD_Religion_3) AS DistinctRows, Field = 'zg_WRD_Religion_WRD_Religion_3' FROM forum.dbo.zg_WRD_Religion UNION SELECT COUNT (DISTINCT Indent_Description) AS DistinctRows, Field = 'zg_WRD_Religion_Indent_Description' FROM forum.dbo.zg_WRD_Religion UNION SELECT COUNT (DISTINCT WRD_Religion_1_ID) AS DistinctRows, Field = 'zg_WRD_Religion_WRD_Religion_1_ID' FROM forum.dbo.zg_WRD_Religion UNION SELECT COUNT (DISTINCT WRD_Religion_2_ID) AS DistinctRows, Field = 'zg_WRD_Religion_WRD_Religion_2_ID' FROM forum.dbo.zg_WRD_Religion 
 UNION SELECT COUNT (DISTINCT Language_pk) AS DistinctRows, Field = 'Pew_Language_Language_pk' FROM forum.dbo.Pew_Language UNION SELECT COUNT (DISTINCT language) AS DistinctRows, Field = 'Pew_Language_language' FROM forum.dbo.Pew_Language UNION SELECT COUNT (DISTINCT Iso_code) AS DistinctRows, Field = 'Pew_Language_Iso_code' FROM forum.dbo.Pew_Language 
 UNION SELECT COUNT (DISTINCT List_pk) AS DistinctRows, Field = 'Pew_Lists_List_pk' FROM forum.dbo.Pew_Lists UNION SELECT COUNT (DISTINCT List) AS DistinctRows, Field = 'Pew_Lists_List' FROM forum.dbo.Pew_Lists 
 UNION SELECT COUNT (DISTINCT Locality_answer_pk) AS DistinctRows, Field = 'Pew_Locality_Answer_Locality_answer_pk' FROM forum.dbo.Pew_Locality_Answer UNION SELECT COUNT (DISTINCT Locality_fk) AS DistinctRows, Field = 'Pew_Locality_Answer_Locality_fk' FROM forum.dbo.Pew_Locality_Answer UNION SELECT COUNT (DISTINCT Answer_fk) AS DistinctRows, Field = 'Pew_Locality_Answer_Answer_fk' FROM forum.dbo.Pew_Locality_Answer UNION SELECT COUNT (DISTINCT display) AS DistinctRows, Field = 'Pew_Locality_Answer_display' FROM forum.dbo.Pew_Locality_Answer 
 UNION SELECT COUNT (DISTINCT Locality_pk) AS DistinctRows, Field = 'Pew_Locality_Locality_pk' FROM forum.dbo.Pew_Locality UNION SELECT COUNT (DISTINCT Province_fk) AS DistinctRows, Field = 'Pew_Locality_Province_fk' FROM forum.dbo.Pew_Locality UNION SELECT COUNT (DISTINCT Locality) AS DistinctRows, Field = 'Pew_Locality_Locality' FROM forum.dbo.Pew_Locality UNION SELECT COUNT (DISTINCT nation_fk) AS DistinctRows, Field = 'Pew_Locality_nation_fk' FROM forum.dbo.Pew_Locality UNION SELECT COUNT (DISTINCT Weighting) AS DistinctRows, Field = 'Pew_Locality_Weighting' FROM forum.dbo.Pew_Locality UNION SELECT COUNT (DISTINCT Locality_note) AS DistinctRows, Field = 'Pew_Locality_Locality_note' FROM forum.dbo.Pew_Locality 
 UNION SELECT COUNT (DISTINCT Migration_Data_Source_pk) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Migration_Data_Source_pk' FROM forum.dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Origin_Nation_fk) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Origin_Nation_fk' FROM forum.dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Destination_Nation_fk) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Destination_Nation_fk' FROM forum.dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Data_quality_level_fk) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Data_quality_level_fk' FROM forum.dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Origin_data_source) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Origin_data_source' FROM forum.dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Origin_data_year) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Origin_data_year' FROM forum.dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Origin_data_type) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Origin_data_type' FROM forum.dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Religion_data_source) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Religion_data_source' FROM forum.dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Religion_data_year) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Religion_data_year' FROM forum.dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Religion_data_type) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Religion_data_type' FROM forum.dbo.Pew_Migration_Data_Source 
 UNION SELECT COUNT (DISTINCT Migration_Flow_pk) AS DistinctRows, Field = 'Pew_Migration_Flow_Migration_Flow_pk' FROM forum.dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Migration_Flow_Field_fk' FROM forum.dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Scenario_id) AS DistinctRows, Field = 'Pew_Migration_Flow_Scenario_id' FROM forum.dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Origin_Nation_fk) AS DistinctRows, Field = 'Pew_Migration_Flow_Origin_Nation_fk' FROM forum.dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Destination_Nation_fk) AS DistinctRows, Field = 'Pew_Migration_Flow_Destination_Nation_fk' FROM forum.dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Religion_group_fk) AS DistinctRows, Field = 'Pew_Migration_Flow_Religion_group_fk' FROM forum.dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Sex_fk) AS DistinctRows, Field = 'Pew_Migration_Flow_Sex_fk' FROM forum.dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Age_fk) AS DistinctRows, Field = 'Pew_Migration_Flow_Age_fk' FROM forum.dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Migrant_Count) AS DistinctRows, Field = 'Pew_Migration_Flow_Migrant_Count' FROM forum.dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Display_by_Religion) AS DistinctRows, Field = 'Pew_Migration_Flow_Display_by_Religion' FROM forum.dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Display_as_Destination_Ctry) AS DistinctRows, Field = 'Pew_Migration_Flow_Display_as_Destination_Ctry' FROM forum.dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Display_as_Origin_Ctry) AS DistinctRows, Field = 'Pew_Migration_Flow_Display_as_Origin_Ctry' FROM forum.dbo.Pew_Migration_Flow 
 UNION SELECT COUNT (DISTINCT Nation_Age_Sex_Value_pk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Nation_Age_Sex_Value_pk' FROM forum.dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Field_fk' FROM forum.dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Scenario_id) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Scenario_id' FROM forum.dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Nation_fk' FROM forum.dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Sex_fk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Sex_fk' FROM forum.dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Age_fk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Age_fk' FROM forum.dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Cnt) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Cnt' FROM forum.dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Data_Source) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Data_Source' FROM forum.dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Display_AgeSex_Str) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Display_AgeSex_Str' FROM forum.dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Display_AgeStr_15Yrs) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Display_AgeStr_15Yrs' FROM forum.dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Display_MedianAge) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Display_MedianAge' FROM forum.dbo.Pew_Nation_Age_Sex_Value 
 UNION SELECT COUNT (DISTINCT Nation_answer_pk) AS DistinctRows, Field = 'Pew_Nation_Answer_Nation_answer_pk' FROM forum.dbo.Pew_Nation_Answer UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Answer_Nation_fk' FROM forum.dbo.Pew_Nation_Answer UNION SELECT COUNT (DISTINCT Answer_fk) AS DistinctRows, Field = 'Pew_Nation_Answer_Answer_fk' FROM forum.dbo.Pew_Nation_Answer UNION SELECT COUNT (DISTINCT display) AS DistinctRows, Field = 'Pew_Nation_Answer_display' FROM forum.dbo.Pew_Nation_Answer 
 UNION SELECT COUNT (DISTINCT Nation_language_pk) AS DistinctRows, Field = 'Pew_Nation_Language_Nation_language_pk' FROM forum.dbo.Pew_Nation_Language UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Language_Nation_fk' FROM forum.dbo.Pew_Nation_Language UNION SELECT COUNT (DISTINCT Language_fk) AS DistinctRows, Field = 'Pew_Nation_Language_Language_fk' FROM forum.dbo.Pew_Nation_Language UNION SELECT COUNT (DISTINCT Pop) AS DistinctRows, Field = 'Pew_Nation_Language_Pop' FROM forum.dbo.Pew_Nation_Language 
 UNION SELECT COUNT (DISTINCT Nation_pk) AS DistinctRows, Field = 'Pew_Nation_Nation_pk' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Ctry_EditorialName) AS DistinctRows, Field = 'Pew_Nation_Ctry_EditorialName' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Num_UNStatDiv) AS DistinctRows, Field = 'Pew_Nation_Num_UNStatDiv' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Country_fk) AS DistinctRows, Field = 'Pew_Nation_Country_fk' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT ISO3166_1alpha2) AS DistinctRows, Field = 'Pew_Nation_ISO3166_1alpha2' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Nation_note) AS DistinctRows, Field = 'Pew_Nation_Nation_note' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT CtryCapital) AS DistinctRows, Field = 'Pew_Nation_CtryCapital' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Region) AS DistinctRows, Field = 'Pew_Nation_Region' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT SubRegion) AS DistinctRows, Field = 'Pew_Nation_SubRegion' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT SubRegion6) AS DistinctRows, Field = 'Pew_Nation_SubRegion6' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT UN_Reg1) AS DistinctRows, Field = 'Pew_Nation_UN_Reg1' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT UN_Reg2) AS DistinctRows, Field = 'Pew_Nation_UN_Reg2' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT TPop1910) AS DistinctRows, Field = 'Pew_Nation_TPop1910' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Christian_pct1910) AS DistinctRows, Field = 'Pew_Nation_Christian_pct1910' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Evangelical_pct2010) AS DistinctRows, Field = 'Pew_Nation_Evangelical_pct2010' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Pentecostal_pct2010) AS DistinctRows, Field = 'Pew_Nation_Pentecostal_pct2010' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Charismatic_pct2010) AS DistinctRows, Field = 'Pew_Nation_Charismatic_pct2010' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT GDP_per_capita) AS DistinctRows, Field = 'Pew_Nation_GDP_per_capita' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Life_Expectancy) AS DistinctRows, Field = 'Pew_Nation_Life_Expectancy' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Literacy_Rate) AS DistinctRows, Field = 'Pew_Nation_Literacy_Rate' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Internet_user_pct) AS DistinctRows, Field = 'Pew_Nation_Internet_user_pct' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Global_NS) AS DistinctRows, Field = 'Pew_Nation_Global_NS' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT UN_Develop) AS DistinctRows, Field = 'Pew_Nation_UN_Develop' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT IMF_Advance) AS DistinctRows, Field = 'Pew_Nation_IMF_Advance' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT FOTM_Advance) AS DistinctRows, Field = 'Pew_Nation_FOTM_Advance' FROM forum.dbo.Pew_Nation UNION SELECT COUNT (DISTINCT MainSources) AS DistinctRows, Field = 'Pew_Nation_MainSources' FROM forum.dbo.Pew_Nation 
 UNION SELECT COUNT (DISTINCT Nation_Religion_Age_Sex_Value_pk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Nation_Religion_Age_Sex_Value_pk' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Field_fk' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Scenario_id) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Scenario_id' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Nation_fk' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Religion_Group_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Religion_Group_fk' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Distribution_Wave_id) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Distribution_Wave_id' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Sex_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Sex_fk' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Age_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Age_fk' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Percentage) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Percentage' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Cases) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Cases' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Cases_Notes) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Cases_Notes' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Source) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Source' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Source_Year) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Source_Year' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Nation_Value_Source) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Nation_Value_Source' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Notes) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Notes' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Display_AgeSex_Str) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Display_AgeSex_Str' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Display_AgeStr_15Yrs) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Display_AgeStr_15Yrs' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Display_MedianAge) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Display_MedianAge' FROM forum.dbo.Pew_Nation_Religion_Age_Sex_Value 
 UNION SELECT COUNT (DISTINCT Nation_religion_answer_pk) AS DistinctRows, Field = 'Pew_Nation_Religion_Answer_Nation_religion_answer_pk' FROM forum.dbo.Pew_Nation_Religion_Answer UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Answer_Nation_fk' FROM forum.dbo.Pew_Nation_Religion_Answer UNION SELECT COUNT (DISTINCT Religion_group_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Answer_Religion_group_fk' FROM forum.dbo.Pew_Nation_Religion_Answer UNION SELECT COUNT (DISTINCT Answer_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Answer_Answer_fk' FROM forum.dbo.Pew_Nation_Religion_Answer UNION SELECT COUNT (DISTINCT Adh_Pct) AS DistinctRows, Field = 'Pew_Nation_Religion_Answer_Adh_Pct' FROM forum.dbo.Pew_Nation_Religion_Answer UNION SELECT COUNT (DISTINCT display) AS DistinctRows, Field = 'Pew_Nation_Religion_Answer_display' FROM forum.dbo.Pew_Nation_Religion_Answer 
 UNION SELECT COUNT (DISTINCT Nation_Religion_Fertility_Value_pk) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Nation_Religion_Fertility_Value_pk' FROM forum.dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Field_fk' FROM forum.dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Scenario_id) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Scenario_id' FROM forum.dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Nation_fk' FROM forum.dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Religion_Group_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Religion_Group_fk' FROM forum.dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Age_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Age_fk' FROM forum.dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Measurement) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Measurement' FROM forum.dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Rate) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Rate' FROM forum.dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Cases) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Cases' FROM forum.dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Source) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Source' FROM forum.dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Source_year) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Source_year' FROM forum.dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Notes) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Notes' FROM forum.dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Display) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Display' FROM forum.dbo.Pew_Nation_Religion_Fertility_Value 
 UNION SELECT COUNT (DISTINCT Nation_Religion_Switching_Flow_pk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Nation_Religion_Switching_Flow_pk' FROM forum.dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Field_fk' FROM forum.dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Scenario_id) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Scenario_id' FROM forum.dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Nation_fk' FROM forum.dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Origin_Religion_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Origin_Religion_fk' FROM forum.dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Destination_Religion_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Destination_Religion_fk' FROM forum.dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Sex_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Sex_fk' FROM forum.dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Age_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Age_fk' FROM forum.dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Cnt) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Cnt' FROM forum.dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Display) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Display' FROM forum.dbo.Pew_Nation_Religion_Switching_Flow 
 UNION SELECT COUNT (DISTINCT Nation_Religion_Switching_Rate_pk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Nation_Religion_Switching_Rate_pk' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Field_fk' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT SwitchingCluster) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_SwitchingCluster' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Nation_fk' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Origin_religion_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Origin_religion_fk' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Destination_religion_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Destination_religion_fk' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Sex_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Sex_fk' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Age_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Age_fk' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Total_Cases) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Total_Cases' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Total_Switching_rate) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Total_Switching_rate' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Switch_Pct) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Switch_Pct' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Source) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Source' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Year) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Year' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Note) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Note' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Donor_Nations) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Donor_Nations' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Number_of_Donors) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Number_of_Donors' FROM forum.dbo.Pew_Nation_Religion_Switching_Base_Rate 
 UNION SELECT COUNT (DISTINCT Nation_restriction_avg_pk) AS DistinctRows, Field = 'Pew_Nation_Restriction_AVG_Nation_restriction_avg_pk' FROM forum.dbo.Pew_Nation_Restriction_AVG UNION SELECT COUNT (DISTINCT Avg_answer_value) AS DistinctRows, Field = 'Pew_Nation_Restriction_AVG_Avg_answer_value' FROM forum.dbo.Pew_Nation_Restriction_AVG UNION SELECT COUNT (DISTINCT Ending_year) AS DistinctRows, Field = 'Pew_Nation_Restriction_AVG_Ending_year' FROM forum.dbo.Pew_Nation_Restriction_AVG UNION SELECT COUNT (DISTINCT Study_period) AS DistinctRows, Field = 'Pew_Nation_Restriction_AVG_Study_period' FROM forum.dbo.Pew_Nation_Restriction_AVG UNION SELECT COUNT (DISTINCT Question_abbreviation) AS DistinctRows, Field = 'Pew_Nation_Restriction_AVG_Question_abbreviation' FROM forum.dbo.Pew_Nation_Restriction_AVG UNION SELECT COUNT (DISTINCT Question_abbreviation_order) AS DistinctRows, Field = 'Pew_Nation_Restriction_AVG_Question_abbreviation_order' FROM forum.dbo.Pew_Nation_Restriction_AVG UNION SELECT COUNT (DISTINCT Question_wording) AS DistinctRows, Field = 'Pew_Nation_Restriction_AVG_Question_wording' FROM forum.dbo.Pew_Nation_Restriction_AVG UNION SELECT COUNT (DISTINCT Nation) AS DistinctRows, Field = 'Pew_Nation_Restriction_AVG_Nation' FROM forum.dbo.Pew_Nation_Restriction_AVG 
 UNION SELECT COUNT (DISTINCT Nation_Subreligion_Distribution_pk) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Nation_Subreligion_Distribution_pk' FROM forum.dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Nation_fk' FROM forum.dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Aggregated_Religion_fk) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Aggregated_Religion_fk' FROM forum.dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Sub_Religion_fk) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Sub_Religion_fk' FROM forum.dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Distribution_Wave_id) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Distribution_Wave_id' FROM forum.dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT MinYear_link) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_MinYear_link' FROM forum.dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Majority_SubReligion_Range) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Majority_SubReligion_Range' FROM forum.dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Proportion) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Proportion' FROM forum.dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Nation_Value_Source) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Nation_Value_Source' FROM forum.dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Nation_Value_Note) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Nation_Value_Note' FROM forum.dbo.Pew_Nation_Subreligion_Distribution 
 UNION SELECT COUNT (DISTINCT Nation_Value_pk) AS DistinctRows, Field = 'Pew_Nation_Value_Nation_Value_pk' FROM forum.dbo.Pew_Nation_Value UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Value_Nation_fk' FROM forum.dbo.Pew_Nation_Value UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Nation_Value_Field_fk' FROM forum.dbo.Pew_Nation_Value UNION SELECT COUNT (DISTINCT Nation_Value) AS DistinctRows, Field = 'Pew_Nation_Value_Nation_Value' FROM forum.dbo.Pew_Nation_Value 
 UNION SELECT COUNT (DISTINCT Note_pk) AS DistinctRows, Field = 'Pew_Footnote_Note_pk' FROM forum.dbo.Pew_Footnote UNION SELECT COUNT (DISTINCT Footnote_Display) AS DistinctRows, Field = 'Pew_Footnote_Footnote_Display' FROM forum.dbo.Pew_Footnote UNION SELECT COUNT (DISTINCT About_the_Data_link) AS DistinctRows, Field = 'Pew_Footnote_About_the_Data_link' FROM forum.dbo.Pew_Footnote 
 UNION SELECT COUNT (DISTINCT origin) AS DistinctRows, Field = 'Pew_Migration_Data_origin' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT destination) AS DistinctRows, Field = 'Pew_Migration_Data_destination' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT religion) AS DistinctRows, Field = 'Pew_Migration_Data_religion' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT migrant_count) AS DistinctRows, Field = 'Pew_Migration_Data_migrant_count' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT data_quality_level) AS DistinctRows, Field = 'Pew_Migration_Data_data_quality_level' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT origin_data_source) AS DistinctRows, Field = 'Pew_Migration_Data_origin_data_source' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT origin_data_year) AS DistinctRows, Field = 'Pew_Migration_Data_origin_data_year' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT religion_data_source) AS DistinctRows, Field = 'Pew_Migration_Data_religion_data_source' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT religion_data_year) AS DistinctRows, Field = 'Pew_Migration_Data_religion_data_year' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT origin_Data_type) AS DistinctRows, Field = 'Pew_Migration_Data_origin_Data_type' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT religion_data_type) AS DistinctRows, Field = 'Pew_Migration_Data_religion_data_type' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT Migration_data_pk) AS DistinctRows, Field = 'Pew_Migration_Data_Migration_data_pk' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT origin_region) AS DistinctRows, Field = 'Pew_Migration_Data_origin_region' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT origin_pop) AS DistinctRows, Field = 'Pew_Migration_Data_origin_pop' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT destination_region) AS DistinctRows, Field = 'Pew_Migration_Data_destination_region' FROM forum.dbo.Pew_Migration_Data UNION SELECT COUNT (DISTINCT destination_pop) AS DistinctRows, Field = 'Pew_Migration_Data_destination_pop' FROM forum.dbo.Pew_Migration_Data 
 UNION SELECT COUNT (DISTINCT Pew_Index_CutPoints_pk) AS DistinctRows, Field = 'Pew_Index_Cut_Points_Pew_Index_CutPoints_pk' FROM forum.dbo.Pew_Index_Cut_Points UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Index_Cut_Points_Field_fk' FROM forum.dbo.Pew_Index_Cut_Points UNION SELECT COUNT (DISTINCT Level) AS DistinctRows, Field = 'Pew_Index_Cut_Points_Level' FROM forum.dbo.Pew_Index_Cut_Points UNION SELECT COUNT (DISTINCT Point) AS DistinctRows, Field = 'Pew_Index_Cut_Points_Point' FROM forum.dbo.Pew_Index_Cut_Points UNION SELECT COUNT (DISTINCT CutPoint) AS DistinctRows, Field = 'Pew_Index_Cut_Points_CutPoint' FROM forum.dbo.Pew_Index_Cut_Points 
 UNION SELECT COUNT (DISTINCT Pew_Migration_pk) AS DistinctRows, Field = 'Pew_Migration_Pew_Migration_pk' FROM forum.dbo.Pew_Migration UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Migration_Field_fk' FROM forum.dbo.Pew_Migration UNION SELECT COUNT (DISTINCT origin_nation_fk) AS DistinctRows, Field = 'Pew_Migration_origin_nation_fk' FROM forum.dbo.Pew_Migration UNION SELECT COUNT (DISTINCT destination_nation_fk) AS DistinctRows, Field = 'Pew_Migration_destination_nation_fk' FROM forum.dbo.Pew_Migration UNION SELECT COUNT (DISTINCT pew_religion_group_fk) AS DistinctRows, Field = 'Pew_Migration_pew_religion_group_fk' FROM forum.dbo.Pew_Migration UNION SELECT COUNT (DISTINCT migrant_count) AS DistinctRows, Field = 'Pew_Migration_migrant_count' FROM forum.dbo.Pew_Migration UNION SELECT COUNT (DISTINCT Display_by_Religion) AS DistinctRows, Field = 'Pew_Migration_Display_by_Religion' FROM forum.dbo.Pew_Migration UNION SELECT COUNT (DISTINCT Display_as_Origin_Ctry) AS DistinctRows, Field = 'Pew_Migration_Display_as_Origin_Ctry' FROM forum.dbo.Pew_Migration UNION SELECT COUNT (DISTINCT Display_as_Destination_Ctry) AS DistinctRows, Field = 'Pew_Migration_Display_as_Destination_Ctry' FROM forum.dbo.Pew_Migration 
 UNION SELECT COUNT (DISTINCT Pew_Survey_Answer_pk) AS DistinctRows, Field = 'Pew_Survey_Answer_Pew_Survey_Answer_pk' FROM forum.dbo.Pew_Survey_Answer UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Survey_Answer_Nation_fk' FROM forum.dbo.Pew_Survey_Answer UNION SELECT COUNT (DISTINCT Cross_Answer_fk) AS DistinctRows, Field = 'Pew_Survey_Answer_Cross_Answer_fk' FROM forum.dbo.Pew_Survey_Answer UNION SELECT COUNT (DISTINCT Answer_fk) AS DistinctRows, Field = 'Pew_Survey_Answer_Answer_fk' FROM forum.dbo.Pew_Survey_Answer UNION SELECT COUNT (DISTINCT PewRel_lev02_fk) AS DistinctRows, Field = 'Pew_Survey_Answer_PewRel_lev02_fk' FROM forum.dbo.Pew_Survey_Answer UNION SELECT COUNT (DISTINCT PewRel_lev02_5_fk) AS DistinctRows, Field = 'Pew_Survey_Answer_PewRel_lev02_5_fk' FROM forum.dbo.Pew_Survey_Answer UNION SELECT COUNT (DISTINCT WRel_lev02_Pct) AS DistinctRows, Field = 'Pew_Survey_Answer_WRel_lev02_Pct' FROM forum.dbo.Pew_Survey_Answer UNION SELECT COUNT (DISTINCT WRel_lev02_5_Pct) AS DistinctRows, Field = 'Pew_Survey_Answer_WRel_lev02_5_Pct' FROM forum.dbo.Pew_Survey_Answer UNION SELECT COUNT (DISTINCT Ctry_Pct) AS DistinctRows, Field = 'Pew_Survey_Answer_Ctry_Pct' FROM forum.dbo.Pew_Survey_Answer UNION SELECT COUNT (DISTINCT L02_Display) AS DistinctRows, Field = 'Pew_Survey_Answer_L02_Display' FROM forum.dbo.Pew_Survey_Answer UNION SELECT COUNT (DISTINCT L02_5_Display) AS DistinctRows, Field = 'Pew_Survey_Answer_L02_5_Display' FROM forum.dbo.Pew_Survey_Answer UNION SELECT COUNT (DISTINCT unW_cases) AS DistinctRows, Field = 'Pew_Survey_Answer_unW_cases' FROM forum.dbo.Pew_Survey_Answer 
 UNION SELECT COUNT (DISTINCT Preferred_Scenario_pk) AS DistinctRows, Field = 'Pew_Preferred_Scenario_Preferred_Scenario_pk' FROM forum.dbo.Pew_Preferred_Scenario UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Preferred_Scenario_Field_fk' FROM forum.dbo.Pew_Preferred_Scenario UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Preferred_Scenario_Nation_fk' FROM forum.dbo.Pew_Preferred_Scenario UNION SELECT COUNT (DISTINCT Preferred_Scenario_id) AS DistinctRows, Field = 'Pew_Preferred_Scenario_Preferred_Scenario_id' FROM forum.dbo.Pew_Preferred_Scenario 
 UNION SELECT COUNT (DISTINCT Province_pk) AS DistinctRows, Field = 'Province_Province_pk' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Country_fk) AS DistinctRows, Field = 'Province_Country_fk' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Province_Name) AS DistinctRows, Field = 'Province_Province_Name' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Province_Capital) AS DistinctRows, Field = 'Province_Province_Capital' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Province_Area_Square_Mile) AS DistinctRows, Field = 'Province_Province_Area_Square_Mile' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Province_Area_Square_km) AS DistinctRows, Field = 'Province_Province_Area_Square_km' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Province_Pop_pct) AS DistinctRows, Field = 'Province_Province_Pop_pct' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Province_pop) AS DistinctRows, Field = 'Province_Province_pop' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Province_AC_Pct) AS DistinctRows, Field = 'Province_Province_AC_Pct' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Province_AC_pop) AS DistinctRows, Field = 'Province_Province_AC_pop' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Note_1) AS DistinctRows, Field = 'Province_Note_1' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT WCD_Religion_string) AS DistinctRows, Field = 'Province_WCD_Religion_string' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Religions_over_1_percent) AS DistinctRows, Field = 'Province_Religions_over_1_percent' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Religious_Freedom_Index) AS DistinctRows, Field = 'Province_Religious_Freedom_Index' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Governmental_Restrictions_Index) AS DistinctRows, Field = 'Province_Governmental_Restrictions_Index' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Social_Restrictions_Index) AS DistinctRows, Field = 'Province_Social_Restrictions_Index' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Governmental_Favoritism_Index) AS DistinctRows, Field = 'Province_Governmental_Favoritism_Index' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Religious_Conflict) AS DistinctRows, Field = 'Province_Religious_Conflict' FROM forum.dbo.Province UNION SELECT COUNT (DISTINCT Religious_Violence) AS DistinctRows, Field = 'Province_Religious_Violence' FROM forum.dbo.Province 
 UNION SELECT COUNT (DISTINCT Question_pk) AS DistinctRows, Field = 'Pew_Question_NoStd_Question_pk' FROM forum.dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Question_abbreviation) AS DistinctRows, Field = 'Pew_Question_NoStd_Question_abbreviation' FROM forum.dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Question_wording) AS DistinctRows, Field = 'Pew_Question_NoStd_Question_wording' FROM forum.dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Data_source_fk) AS DistinctRows, Field = 'Pew_Question_NoStd_Data_source_fk' FROM forum.dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Question_Year) AS DistinctRows, Field = 'Pew_Question_NoStd_Question_Year' FROM forum.dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Short_wording) AS DistinctRows, Field = 'Pew_Question_NoStd_Short_wording' FROM forum.dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Notes) AS DistinctRows, Field = 'Pew_Question_NoStd_Notes' FROM forum.dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Default_response) AS DistinctRows, Field = 'Pew_Question_NoStd_Default_response' FROM forum.dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Question_Std_fk) AS DistinctRows, Field = 'Pew_Question_NoStd_Question_Std_fk' FROM forum.dbo.Pew_Question_NoStd 
 UNION SELECT COUNT (DISTINCT Question_Std_pk) AS DistinctRows, Field = 'Pew_Question_Std_Question_Std_pk' FROM forum.dbo.Pew_Question_Std UNION SELECT COUNT (DISTINCT Question_abbreviation_std) AS DistinctRows, Field = 'Pew_Question_Std_Question_abbreviation_std' FROM forum.dbo.Pew_Question_Std UNION SELECT COUNT (DISTINCT Question_wording_std) AS DistinctRows, Field = 'Pew_Question_Std_Question_wording_std' FROM forum.dbo.Pew_Question_Std UNION SELECT COUNT (DISTINCT Question_short_wording_std) AS DistinctRows, Field = 'Pew_Question_Std_Question_short_wording_std' FROM forum.dbo.Pew_Question_Std UNION SELECT COUNT (DISTINCT Display) AS DistinctRows, Field = 'Pew_Question_Std_Display' FROM forum.dbo.Pew_Question_Std 
 UNION SELECT COUNT (DISTINCT Question_topic_pk) AS DistinctRows, Field = 'Pew_Question_Topic_Question_topic_pk' FROM forum.dbo.Pew_Question_Topic UNION SELECT COUNT (DISTINCT Question_Std_fk) AS DistinctRows, Field = 'Pew_Question_Topic_Question_Std_fk' FROM forum.dbo.Pew_Question_Topic UNION SELECT COUNT (DISTINCT Topic_fk) AS DistinctRows, Field = 'Pew_Question_Topic_Topic_fk' FROM forum.dbo.Pew_Question_Topic UNION SELECT COUNT (DISTINCT Topic_Priority_order) AS DistinctRows, Field = 'Pew_Question_Topic_Topic_Priority_order' FROM forum.dbo.Pew_Question_Topic UNION SELECT COUNT (DISTINCT SubTopic_Priority_order) AS DistinctRows, Field = 'Pew_Question_Topic_SubTopic_Priority_order' FROM forum.dbo.Pew_Question_Topic 
 UNION SELECT COUNT (DISTINCT Religion_group_pk) AS DistinctRows, Field = 'Pew_Religion_Group_Religion_group_pk' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev00) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev00' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev01) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev01' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev01_5) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev01_5' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_RelL02_Display) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_RelL02_Display' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev02) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev02' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_RelL02_5_Display) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_RelL02_5_Display' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev02_5) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev02_5' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev03) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev03' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev04) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev04' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev05) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev05' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_rel_forGRandSH) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_rel_forGRandSH' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_rel_forGvFavor) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_rel_forGvFavor' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Wrd_religion_code) AS DistinctRows, Field = 'Pew_Religion_Group_Wrd_religion_code' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT wrd_religion_1) AS DistinctRows, Field = 'Pew_Religion_Group_wrd_religion_1' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT wrd_religion_2) AS DistinctRows, Field = 'Pew_Religion_Group_wrd_religion_2' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT wrd_religion_3) AS DistinctRows, Field = 'Pew_Religion_Group_wrd_religion_3' FROM forum.dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT R_sorter) AS DistinctRows, Field = 'Pew_Religion_Group_R_sorter' FROM forum.dbo.Pew_Religion_Group 
 UNION SELECT COUNT (DISTINCT Scenario_pk) AS DistinctRows, Field = 'Pew_Scenario_Scenario_pk' FROM forum.dbo.Pew_Scenario UNION SELECT COUNT (DISTINCT Scenario_id) AS DistinctRows, Field = 'Pew_Scenario_Scenario_id' FROM forum.dbo.Pew_Scenario UNION SELECT COUNT (DISTINCT Scenario_description) AS DistinctRows, Field = 'Pew_Scenario_Scenario_description' FROM forum.dbo.Pew_Scenario UNION SELECT COUNT (DISTINCT Notes) AS DistinctRows, Field = 'Pew_Scenario_Notes' FROM forum.dbo.Pew_Scenario 
 UNION SELECT COUNT (DISTINCT Sex) AS DistinctRows, Field = 'Pew_Sex_Sex' FROM forum.dbo.Pew_Sex UNION SELECT COUNT (DISTINCT Sex_pk) AS DistinctRows, Field = 'Pew_Sex_Sex_pk' FROM forum.dbo.Pew_Sex 
 UNION SELECT COUNT (DISTINCT Survey_fk) AS DistinctRows, Field = 'Survey_data_Survey_fk' FROM forum.dbo.Survey_data UNION SELECT COUNT (DISTINCT Survey_locality_fk) AS DistinctRows, Field = 'Survey_data_Survey_locality_fk' FROM forum.dbo.Survey_data UNION SELECT COUNT (DISTINCT Adherents_Pct_of_Province) AS DistinctRows, Field = 'Survey_data_Adherents_Pct_of_Province' FROM forum.dbo.Survey_data UNION SELECT COUNT (DISTINCT Survey_Religion_fk) AS DistinctRows, Field = 'Survey_data_Survey_Religion_fk' FROM forum.dbo.Survey_data UNION SELECT COUNT (DISTINCT Adherents_note) AS DistinctRows, Field = 'Survey_data_Adherents_note' FROM forum.dbo.Survey_data UNION SELECT COUNT (DISTINCT Survey_data_pk) AS DistinctRows, Field = 'Survey_data_Survey_data_pk' FROM forum.dbo.Survey_data 
 UNION SELECT COUNT (DISTINCT Survey_locality_pk) AS DistinctRows, Field = 'Survey_locality_Survey_locality_pk' FROM forum.dbo.Survey_locality UNION SELECT COUNT (DISTINCT Survey_fk) AS DistinctRows, Field = 'Survey_locality_Survey_fk' FROM forum.dbo.Survey_locality UNION SELECT COUNT (DISTINCT Survey_locality_name) AS DistinctRows, Field = 'Survey_locality_Survey_locality_name' FROM forum.dbo.Survey_locality UNION SELECT COUNT (DISTINCT Province_fk) AS DistinctRows, Field = 'Survey_locality_Province_fk' FROM forum.dbo.Survey_locality UNION SELECT COUNT (DISTINCT Survey_locality_note) AS DistinctRows, Field = 'Survey_locality_Survey_locality_note' FROM forum.dbo.Survey_locality UNION SELECT COUNT (DISTINCT Cases) AS DistinctRows, Field = 'Survey_locality_Cases' FROM forum.dbo.Survey_locality UNION SELECT COUNT (DISTINCT Religion_string) AS DistinctRows, Field = 'Survey_locality_Religion_string' FROM forum.dbo.Survey_locality UNION SELECT COUNT (DISTINCT Pct_of_Country) AS DistinctRows, Field = 'Survey_locality_Pct_of_Country' FROM forum.dbo.Survey_locality 
 UNION SELECT COUNT (DISTINCT Survey_pk) AS DistinctRows, Field = 'Survey_Survey_pk' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Survey_field_name) AS DistinctRows, Field = 'Survey_Survey_field_name' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Survey_Country) AS DistinctRows, Field = 'Survey_Survey_Country' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Main_country_fk) AS DistinctRows, Field = 'Survey_Main_country_fk' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Survey_name) AS DistinctRows, Field = 'Survey_Survey_name' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Survey_short_name) AS DistinctRows, Field = 'Survey_Survey_short_name' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Source_type) AS DistinctRows, Field = 'Survey_Source_type' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Survey_year) AS DistinctRows, Field = 'Survey_Survey_year' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Provinces_Covered_Pct) AS DistinctRows, Field = 'Survey_Provinces_Covered_Pct' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Provinces_100Cases_Pct) AS DistinctRows, Field = 'Survey_Provinces_100Cases_Pct' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Response_rate) AS DistinctRows, Field = 'Survey_Response_rate' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Valid_sample_size) AS DistinctRows, Field = 'Survey_Valid_sample_size' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Male_and_female) AS DistinctRows, Field = 'Survey_Male_and_female' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Religious_categories) AS DistinctRows, Field = 'Survey_Religious_categories' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Multiple_languages) AS DistinctRows, Field = 'Survey_Multiple_languages' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Sample_design) AS DistinctRows, Field = 'Survey_Sample_design' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Mode) AS DistinctRows, Field = 'Survey_Mode' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Languages) AS DistinctRows, Field = 'Survey_Languages' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Fieldwork_dates) AS DistinctRows, Field = 'Survey_Fieldwork_dates' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Representative_coverage) AS DistinctRows, Field = 'Survey_Representative_coverage' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Portion_Not_Covered) AS DistinctRows, Field = 'Survey_Portion_Not_Covered' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Survey_note) AS DistinctRows, Field = 'Survey_Survey_note' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Population_Covered_Pct) AS DistinctRows, Field = 'Survey_Population_Covered_Pct' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Languages_Offered) AS DistinctRows, Field = 'Survey_Languages_Offered' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Available_Translations) AS DistinctRows, Field = 'Survey_Available_Translations' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Question_Type) AS DistinctRows, Field = 'Survey_Question_Type' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Question_Wording) AS DistinctRows, Field = 'Survey_Question_Wording' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Answer_Choices) AS DistinctRows, Field = 'Survey_Answer_Choices' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Sample_universe) AS DistinctRows, Field = 'Survey_Sample_universe' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Weighting) AS DistinctRows, Field = 'Survey_Weighting' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Cases) AS DistinctRows, Field = 'Survey_Cases' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Data_release_note) AS DistinctRows, Field = 'Survey_Data_release_note' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Exclude_Data_From_Online) AS DistinctRows, Field = 'Survey_Exclude_Data_From_Online' FROM forum.dbo.Survey UNION SELECT COUNT (DISTINCT Source_Reference) AS DistinctRows, Field = 'Survey_Source_Reference' FROM forum.dbo.Survey 
 UNION SELECT COUNT (DISTINCT Survey_Religion_pk) AS DistinctRows, Field = 'Survey_religion_code_Survey_Religion_pk' FROM forum.dbo.Survey_religion_code UNION SELECT COUNT (DISTINCT Survey_fk) AS DistinctRows, Field = 'Survey_religion_code_Survey_fk' FROM forum.dbo.Survey_religion_code UNION SELECT COUNT (DISTINCT Survey_religion_name) AS DistinctRows, Field = 'Survey_religion_code_Survey_religion_name' FROM forum.dbo.Survey_religion_code UNION SELECT COUNT (DISTINCT WRD_religion_code_fk) AS DistinctRows, Field = 'Survey_religion_code_WRD_religion_code_fk' FROM forum.dbo.Survey_religion_code UNION SELECT COUNT (DISTINCT Survey_religion_note) AS DistinctRows, Field = 'Survey_religion_code_Survey_religion_note' FROM forum.dbo.Survey_religion_code UNION SELECT COUNT (DISTINCT Adherents_Pct_of_Country) AS DistinctRows, Field = 'Survey_religion_code_Adherents_Pct_of_Country' FROM forum.dbo.Survey_religion_code 
 UNION SELECT COUNT (DISTINCT Top_line_id) AS DistinctRows, Field = 'Pew_Religion_Restriction_Top_Line_Top_line_id' FROM forum.dbo.Pew_Religion_Restriction_Top_Line UNION SELECT COUNT (DISTINCT Answer_value) AS DistinctRows, Field = 'Pew_Religion_Restriction_Top_Line_Answer_value' FROM forum.dbo.Pew_Religion_Restriction_Top_Line UNION SELECT COUNT (DISTINCT Answer_wording) AS DistinctRows, Field = 'Pew_Religion_Restriction_Top_Line_Answer_wording' FROM forum.dbo.Pew_Religion_Restriction_Top_Line UNION SELECT COUNT (DISTINCT Ending_year) AS DistinctRows, Field = 'Pew_Religion_Restriction_Top_Line_Ending_year' FROM forum.dbo.Pew_Religion_Restriction_Top_Line UNION SELECT COUNT (DISTINCT Study_period) AS DistinctRows, Field = 'Pew_Religion_Restriction_Top_Line_Study_period' FROM forum.dbo.Pew_Religion_Restriction_Top_Line UNION SELECT COUNT (DISTINCT Question_abbreviation) AS DistinctRows, Field = 'Pew_Religion_Restriction_Top_Line_Question_abbreviation' FROM forum.dbo.Pew_Religion_Restriction_Top_Line UNION SELECT COUNT (DISTINCT Question_wording) AS DistinctRows, Field = 'Pew_Religion_Restriction_Top_Line_Question_wording' FROM forum.dbo.Pew_Religion_Restriction_Top_Line UNION SELECT COUNT (DISTINCT Nation) AS DistinctRows, Field = 'Pew_Religion_Restriction_Top_Line_Nation' FROM forum.dbo.Pew_Religion_Restriction_Top_Line UNION SELECT COUNT (DISTINCT Pew_religion) AS DistinctRows, Field = 'Pew_Religion_Restriction_Top_Line_Pew_religion' FROM forum.dbo.Pew_Religion_Restriction_Top_Line UNION SELECT COUNT (DISTINCT question_abbreviation_order) AS DistinctRows, Field = 'Pew_Religion_Restriction_Top_Line_question_abbreviation_order' FROM forum.dbo.Pew_Religion_Restriction_Top_Line 
 UNION SELECT COUNT (DISTINCT Topic_pk) AS DistinctRows, Field = 'Pew_Topic_Topic_pk' FROM forum.dbo.Pew_Topic UNION SELECT COUNT (DISTINCT Topic_sorting) AS DistinctRows, Field = 'Pew_Topic_Topic_sorting' FROM forum.dbo.Pew_Topic UNION SELECT COUNT (DISTINCT SubTopic_Sorting) AS DistinctRows, Field = 'Pew_Topic_SubTopic_Sorting' FROM forum.dbo.Pew_Topic UNION SELECT COUNT (DISTINCT Topic) AS DistinctRows, Field = 'Pew_Topic_Topic' FROM forum.dbo.Pew_Topic UNION SELECT COUNT (DISTINCT SubTopic) AS DistinctRows, Field = 'Pew_Topic_SubTopic' FROM forum.dbo.Pew_Topic UNION SELECT COUNT (DISTINCT Display) AS DistinctRows, Field = 'Pew_Topic_Display' FROM forum.dbo.Pew_Topic 
-------------------------------------------------------------------------------------------------------------------------------
                                                                                            ) as F9
-------------------------------------------------------------------------------------------------------------------------------
WHERE 
         F1.Table_Name
       + '_'
       + F1.Field_Name
       = F9.Field
/****************************************************************************************************** Columns for FIELDS ***/
/*****************************************************************************************************************************/
) MFT
/*****************************************************************************************************************************/
/*** << MTB: Main Table ******************************************************************************************************/
                                                                                                                          ) MTB
/*****************************************************************************************************************************/
FULL OUTER JOIN
/*****************************************************************************************************************************/
(
/*** >> TLK: Table of Links for fk-pk ****************************************************************************************/
 SELECT 
          Linked_Field  = CASE
                               WHEN COLUMN_NAME LIKE '%pk'
                               THEN '--'
                               ELSE COLUMN_NAME
                           END
        , Linked_Table  = CASE
                               WHEN COLUMN_NAME LIKE '%pk'
                               THEN 'NOT CURRENTLY LINKED'
                               ELSE TABLE_NAME
                           END
        , Linked_FN     = ORDINAL_POSITION
        , Field_Name_x  = CASE
                               WHEN COLUMN_NAME LIKE '%[C,c]ountry_fk'
                               THEN                  'Country_ID'

                               WHEN COLUMN_NAME LIKE '%[N,n]ation_fk'
                               THEN                  'Nation_pk'

                               WHEN COLUMN_NAME IN (
                                                     'PewRel_lev02_fk'
                                                   , 'PewRel_lev02_5_fk'
                                                   , 'Aggregated_Religion_fk'
                                                   , 'Sub_Religion_fk'
                                                   , 'pew_religion_group_fk'
                                                                                )
                               THEN                  'Religion_group_pk'
 
                               WHEN COLUMN_NAME LIKE 'Cross_Answer_fk'
                               THEN                  'Answer_pk'

                               WHEN COLUMN_NAME LIKE 'W[R,r][D,d]_religion_code%' /* unstd fk in Pew t USED in queries/procedures */
                               THEN                  'Code_value'

                               WHEN COLUMN_NAME LIKE 'Scenario_id'
                               THEN                  'Preferred_scenario_id'  /* while scenario has no pk */

                               WHEN COLUMN_NAME LIKE '[Q,q]uestion_abbreviation_order'
                               THEN                  'Question_abbreviation_std'  /* while current tables' design */

                               WHEN COLUMN_NAME LIKE '%pk'                        /* not currently linked */
                               THEN COLUMN_NAME

                               ELSE STUFF(
                                    COLUMN_NAME,
                                      CHARINDEX('_fk',
                                      COLUMN_NAME), 3, '_pk' )
                           END
   FROM  
          (
             SELECT *                                        /*main*/
               FROM [forum].[sys].[tables]                   /*main*/
                  , [forum].[INFORMATION_SCHEMA].[COLUMNS]   /*main*/
               WHERE    TABLE_NAME                           /*main*/
                      = name                                 /*main*/
                 AND    TABLE_NAME                           /*main*/
                     != 'sysdiagrams'                        /*main*/
                 AND    COLUMN_NAME                          /*main*/
                     != 'item_fk'                            /*main*/
                                                                      ) MBTfSV
   WHERE    
            COLUMN_NAME LIKE '%_fk'
         OR COLUMN_NAME IN (                                    /* list of not currently linked pks */
                             'Display_Footnotes_pk'
                           , 'Display_Reports_pk'
                           , 'G_20_3_summary_pk'
                           , 'GRFsite_URLs_Topic_pk'
                           , 'Pew_Index_CutPoints_pk'
                           , 'Locality_answer_pk'
                           , 'Locality_value_pk'
                           , 'pew_migration_pk'
                           , 'Migration_data_pk'
                           , 'Migration_data_source_pk'
                           , 'Nation_age_sex_value_pk'
                           , 'Nation_answer_pk'
                           , 'Nation_language_pk'
                           , 'Nation_religion_age_sex_value_pk'
                           , 'Nation_religion_answer_pk'
                           , 'Nation_religion_fertility_value_pk'
                           , 'Nation_restriction_avg_pk'
                           , 'Nation_subreligion_distribution_pk'
                           , 'Nation_Value_pk'
                           , 'Preferred_scenario_pk'
                           , 'Question_topic_pk'
                           , 'Pew_Survey_Answer_pk'
                           , 'Survey_data_pk'
                                                                     )
         OR COLUMN_NAME LIKE 'Scenario_id'                      /* will dissapear later when scenario table get the proper pk */
         OR COLUMN_NAME LIKE '[Q,q]uestion_abbreviation_order'  /* will dissapear later when some tables get re-designed */
         OR COLUMN_NAME LIKE 'Wrd_religion_code'                /* will remain: unstd name used in other queries/procedures */
         
/*** << TLK: Table of Links for fk-pk ****************************************************************************************/
                                                                                                                          ) TLK
/*****************************************************************************************************************************/
ON 
          Field_Name
        = Field_Name_x
/*****************************************************************************************************************************/
FULL OUTER JOIN
/*****************************************************************************************************************************/
(
/*** >> TLK: Table of Links for fk-pk ****************************************************************************************/
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
          tnd = Table_name
        , fnd = Field_name
        ,      Description
        ,      Comments
   FROM  
          [_Admin].[dbo].[Descriptions]
/*** << TLK: Table of Links for fk-pk ****************************************************************************************/
                                                                                                                          ) DES
/*****************************************************************************************************************************/
ON 
          Table_Name
        = tnd
AND 
          Field_Name
        = fnd
/*****************************************************************************************************************************/
-------------------------------------------------------------------------------------------------------------------------------
WHERE
         Table_Name       != 'sysdiagrams'  /* table heading not removed before in query */
-------------------------------------------------------------------------------------------------------------------------------
--AND
--         TableID          IS NOT NULL       /* fields from WRD not included in current Pew cloned tables filtred when sorting? */
-------------------------------------------------------------------------------------------------------------------------------
--- >> test statements --------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--AND
--         TableID          IS NULL
--OR
--AND
--         Description      IS NULL
-------------------------------------------------------------------------------------------------------------------------------
--- << test statements --------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------
--/*****************************************************************************************************************************/







/*****************************************************************************************************************************/
/*********************************************************************************************************/
/** Query for distinct values per row is created by this query,  *****************************************/
/** after copy/paste/delete the first word "UNION"               *****************************************/
/*********************************************************************************************************/

/*

use forum
go 
/*********************************************************************************************************/
SELECT
       DISTINCT	
                ' ' + 
    			ColumnList
FROM 
( SELECT *                                        /*main*/
    FROM [forum].[sys].[tables]                   /*main*/
       , [forum].[INFORMATION_SCHEMA].[COLUMNS]   /*main*/
    WHERE    TABLE_NAME                           /*main*/
           = name                                 /*main*/
      AND    TABLE_NAME                           /*main*/
          != 'sysdiagrams'                                 )           COL1
    CROSS AppLy 
                                    (
    	                              SELECT
    	                                      'UNION'
    	                                    + ' SELECT COUNT (DISTINCT ' 
    	                                    + COLUMN_NAME 
    	                                    + ') AS DistinctRows, Field = '''
    	                                    + COL1.TABLE_NAME 
    	                                    + '_' 
    	                                    + COLUMN_NAME
    	                                    + ''' FROM forum.dbo.' 
    	                                    + COL1.TABLE_NAME 
    	                                    + ' '
                                      FROM INFORMATION_SCHEMA.COLUMNS COL2
                                      WHERE COL1.TABLE_NAME = COL2.TABLE_NAME
                                        AND COL2.TABLE_NAME != 'sysdiagrams'
                                      FOR XML PATH ('')
                                    ) TableColumns (ColumnList)
WHERE 1=1
/*********************************************************************************************************/

                                                                                                         */































/*********************************************************     <<<<<  this has been the first part of the code                                  ***/
/**************************************************************************************************************************************************/
/*-------------------------------------------------------*     >>>>>  this is the second part of the code to be executed                        ***/
+   (     SELECT                                          /*** >      Begin selection (into text, in a cell, comma delimited list)              ***/
                    ', ' + [WQA_std]                      /***        distinct comma delimiter concatenated to field QA modified (as varname)   ***/
          FROM      [WT_VNs]                              /***        from table including var names & classifications as rows                  ***/
          WHERE     [QClass]     IN (   'DESCR'  )        /***        include Q with descriptions                                               ***/
            AND     [QTable] NOT IN (    'xs'    )        /***        vars to be excluded: sources (and former year's ???)                      ***/
             FOR XML PATH('')                       )     /*** <      End of selection, nesting all cells into an XML string cell               ***/
/*-------------------------------------------------------*     <<<<<  this has been the second part of the code                                 ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the third part of the code to be executed                         ***/
+ N'
FROM  [s11_AllCodedValues]
WHERE [Q_Yr] > ( SELECT (MAX([Q_Yr]) - 2) FROM [s11_AllCodedValues] )     )
          '
/*********************************************************     <<<<<  this has been the third part of the code (end of  CTA)                    ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the fourth part of the code to be executed                        ***/
+ N'
SELECT CURR.[Nation_fk]
      ,CURR.[Ctry_EditorialName]
          '
/*********************************************************     <<<<<  this has been the fourth part of the code                                 ***/
/**************************************************************************************************************************************************/
/*-------------------------------------------------------*     >>>>>  this is the fifth part of the code to be executed                         ***/
+   (     SELECT                                          /*** >      Begin selection (into text, in a cell, comma delimited list)              ***/
                    ', ' + [WQA_std]                      /***        distinct comma delimiter concatenated to field QA modified (as varname)   ***/
         + '_' + @PAST                                    /***        adding numeric-code identifier for former year                            ***/
         +    ' = PAST.' + [WQA_std]                      /***        set equal to former year description                                      ***/
          FROM      [WT_VNs]                              /***        from table including var names & classifications as rows                  ***/
          WHERE     [QClass]     IN (   'DESCR'  )        /***        include Q with descriptions                                               ***/
            AND     [QTable] NOT IN (    'xs'    )        /***        vars to be excluded: sources (and former year's ???)                      ***/
             FOR XML PATH('')                       )     /*** <      End of selection, nesting all cells into an XML string cell               ***/
/*-------------------------------------------------------*     <<<<<  this has been the fifth part of the code                                  ***/
/**************************************************************************************************************************************************/
/*-------------------------------------------------------*     >>>>>  this is the sixth part of the code to be executed                         ***/
+   (     SELECT                                          /*** >      Begin selection (into text, in a cell, comma delimited list)              ***/
                    ', ' + [WQA_std]                      /***        distinct comma delimiter concatenated to field QA modified (as varname)   ***/
         + '_' + @CURR                                    /***        adding numeric-code identifier for former year                            ***/
         +    ' = CURR.' + [WQA_std]                      /***        set equal to former year description                                      ***/
          FROM      [WT_VNs]                              /***        from table including var names & classifications as rows                  ***/
          WHERE     [QClass]     IN (   'DESCR'  )        /***        include Q with descriptions                                               ***/
            AND     [QTable] NOT IN (    'xs'    )        /***        vars to be excluded: sources (and former year's ???)                      ***/
             FOR XML PATH('')                       )     /*** <      End of selection, nesting all cells into an XML string cell               ***/
/*-------------------------------------------------------*     <<<<<  this has been the sixth part of the code                                  ***/
/**************************************************************************************************************************************************/
/*********************************************************     >>>>>  this is the seventh part of the code to be executed                       ***/
+ N'
FROM  [CTE]  CURR
JOIN  [CTE]  PAST
ON    CURR.Nation_fk
    = PAST.Nation_fk
WHERE CURR.[Year] = ( SELECT (MAX([Q_Yr]) - 0) FROM [s11_AllCodedValues] )
  AND PAST.[Year] = ( SELECT (MAX([Q_Yr]) - 1) FROM [s11_AllCodedValues] )
          '
/*********************************************************     <<<<<  this has been the seventh and final part of the code                      ***/
/**************************************************************************************************************************************************/
EXEC dbo.LongPrint @CODEmain                              /***        display the currently stored code (to be executed)                        ***/
EXEC              (@CODEmain)                             /***        execute the code that has been stored as text                             ***/
/**************************************************************************************************************************************************/
