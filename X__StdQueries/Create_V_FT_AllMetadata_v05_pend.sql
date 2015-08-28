/*****************************************************************************************************************************************************/
/*** >> Create complete view of metadata for all tables and fields ***********************************************************************************/
/*****************************************************************************************************************************************************/
--USE [_Admin]
--GO
/*****************************************************************************************************************************************************/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--/*****************************************************************************************************************************************************/
--ALTER VIEW    [dbo].[Metadata]
--AS
/*****************************************************************************************************************************************************/
---------------------------------------------------------------------------------------------------------------------------------------------------
USE [for_d]
GO
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
       sys.Tables
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
       INFORMATION_SCHEMA.COLUMNS
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
     sys.tables     t
INNER JOIN 
     sys.schemas    s ON t.schema_id = s.schema_id
INNER JOIN      
     sys.indexes    i ON t.OBJECT_ID = i.object_id
INNER JOIN 
     sys.partitions p ON i.object_id = p.OBJECT_ID
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
         information_schema.columns                  C
inner
JOIN
         information_schema.tables                   T
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
       sys.Tables                                 )  N
           ON     N.TN   = t.table_name
-------------------------------------------------------------------------------------------------------------------------------
                                                                                            ) as F1
,
(
-------------------------------------------------------------------------------------------------------------------------------
--DistinctRows  (counts rows of fields)
       SELECT COUNT (DISTINCT Age_pk) AS DistinctRows, Field = 'Pew_Age_Age_pk' FROM dbo.Pew_Age UNION SELECT COUNT (DISTINCT Age) AS DistinctRows, Field = 'Pew_Age_Age' FROM dbo.Pew_Age 
 UNION SELECT COUNT (DISTINCT Answer_pk) AS DistinctRows, Field = 'Pew_Answer_Answer_pk' FROM dbo.Pew_Answer UNION SELECT COUNT (DISTINCT Answer_value) AS DistinctRows, Field = 'Pew_Answer_Answer_value' FROM dbo.Pew_Answer UNION SELECT COUNT (DISTINCT Question_fk) AS DistinctRows, Field = 'Pew_Answer_Question_fk' FROM dbo.Pew_Answer UNION SELECT COUNT (DISTINCT Answer_wording) AS DistinctRows, Field = 'Pew_Answer_Answer_wording' FROM dbo.Pew_Answer UNION SELECT COUNT (DISTINCT answer_wording_std) AS DistinctRows, Field = 'Pew_Answer_answer_wording_std' FROM dbo.Pew_Answer 
 UNION SELECT COUNT (DISTINCT Data_source_pk) AS DistinctRows, Field = 'Pew_Data_Source_Data_source_pk' FROM dbo.Pew_Data_Source UNION SELECT COUNT (DISTINCT Data_source_name) AS DistinctRows, Field = 'Pew_Data_Source_Data_source_name' FROM dbo.Pew_Data_Source UNION SELECT COUNT (DISTINCT Data_source_description) AS DistinctRows, Field = 'Pew_Data_Source_Data_source_description' FROM dbo.Pew_Data_Source UNION SELECT COUNT (DISTINCT Data_source_url) AS DistinctRows, Field = 'Pew_Data_Source_Data_source_url' FROM dbo.Pew_Data_Source UNION SELECT COUNT (DISTINCT Source_Display_Name) AS DistinctRows, Field = 'Pew_Data_Source_Source_Display_Name' FROM dbo.Pew_Data_Source 
 UNION SELECT COUNT (DISTINCT Field_pk) AS DistinctRows, Field = 'Pew_Field_Field_pk' FROM dbo.Pew_Field UNION SELECT COUNT (DISTINCT Field_name) AS DistinctRows, Field = 'Pew_Field_Field_name' FROM dbo.Pew_Field UNION SELECT COUNT (DISTINCT Field_note) AS DistinctRows, Field = 'Pew_Field_Field_note' FROM dbo.Pew_Field UNION SELECT COUNT (DISTINCT Field_type) AS DistinctRows, Field = 'Pew_Field_Field_type' FROM dbo.Pew_Field UNION SELECT COUNT (DISTINCT Field_year) AS DistinctRows, Field = 'Pew_Field_Field_year' FROM dbo.Pew_Field UNION SELECT COUNT (DISTINCT Data_source_fk) AS DistinctRows, Field = 'Pew_Field_Data_source_fk' FROM dbo.Pew_Field 
 UNION SELECT COUNT (DISTINCT Locality_pk) AS DistinctRows, Field = 'Pew_Locality_Locality_pk' FROM dbo.Pew_Locality UNION SELECT COUNT (DISTINCT Province_fk) AS DistinctRows, Field = 'Pew_Locality_Province_fk' FROM dbo.Pew_Locality UNION SELECT COUNT (DISTINCT Locality) AS DistinctRows, Field = 'Pew_Locality_Locality' FROM dbo.Pew_Locality UNION SELECT COUNT (DISTINCT nation_fk) AS DistinctRows, Field = 'Pew_Locality_nation_fk' FROM dbo.Pew_Locality UNION SELECT COUNT (DISTINCT Weighting) AS DistinctRows, Field = 'Pew_Locality_Weighting' FROM dbo.Pew_Locality UNION SELECT COUNT (DISTINCT Locality_note) AS DistinctRows, Field = 'Pew_Locality_Locality_note' FROM dbo.Pew_Locality 
 UNION SELECT COUNT (DISTINCT Migration_data_source_pk) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Migration_data_source_pk' FROM dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Origin_nation_fk) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Origin_nation_fk' FROM dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Destination_nation_fk) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Destination_nation_fk' FROM dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Data_quality_level_fk) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Data_quality_level_fk' FROM dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Origin_data_source) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Origin_data_source' FROM dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Origin_data_year) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Origin_data_year' FROM dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Origin_data_type) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Origin_data_type' FROM dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Religion_data_source) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Religion_data_source' FROM dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Religion_data_year) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Religion_data_year' FROM dbo.Pew_Migration_Data_Source UNION SELECT COUNT (DISTINCT Religion_data_type) AS DistinctRows, Field = 'Pew_Migration_Data_Source_Religion_data_type' FROM dbo.Pew_Migration_Data_Source 
 UNION SELECT COUNT (DISTINCT Migration_Flow_pk) AS DistinctRows, Field = 'Pew_Migration_Flow_Migration_Flow_pk' FROM dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Migration_Flow_Field_fk' FROM dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Scenario_id) AS DistinctRows, Field = 'Pew_Migration_Flow_Scenario_id' FROM dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Origin_Nation_fk) AS DistinctRows, Field = 'Pew_Migration_Flow_Origin_Nation_fk' FROM dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Destination_Nation_fk) AS DistinctRows, Field = 'Pew_Migration_Flow_Destination_Nation_fk' FROM dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Religion_group_fk) AS DistinctRows, Field = 'Pew_Migration_Flow_Religion_group_fk' FROM dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Sex_fk) AS DistinctRows, Field = 'Pew_Migration_Flow_Sex_fk' FROM dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Age_fk) AS DistinctRows, Field = 'Pew_Migration_Flow_Age_fk' FROM dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Migrant_Count) AS DistinctRows, Field = 'Pew_Migration_Flow_Migrant_Count' FROM dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Display_by_Religion) AS DistinctRows, Field = 'Pew_Migration_Flow_Display_by_Religion' FROM dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Display_as_Destination_Ctry) AS DistinctRows, Field = 'Pew_Migration_Flow_Display_as_Destination_Ctry' FROM dbo.Pew_Migration_Flow UNION SELECT COUNT (DISTINCT Display_as_Origin_Ctry) AS DistinctRows, Field = 'Pew_Migration_Flow_Display_as_Origin_Ctry' FROM dbo.Pew_Migration_Flow 
 UNION SELECT COUNT (DISTINCT Nation_age_sex_value_pk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Nation_age_sex_value_pk' FROM dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Field_fk' FROM dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Scenario_id) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Scenario_id' FROM dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Nation_fk' FROM dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Sex_fk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Sex_fk' FROM dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Age_fk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Age_fk' FROM dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Cnt) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Cnt' FROM dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Data_source) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Data_source' FROM dbo.Pew_Nation_Age_Sex_Value UNION SELECT COUNT (DISTINCT Display) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_Display' FROM dbo.Pew_Nation_Age_Sex_Value 
 UNION SELECT COUNT (DISTINCT Nation_age_sex_value_pk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_psf_Nation_age_sex_value_pk' FROM dbo.Pew_Nation_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_psf_Field_fk' FROM dbo.Pew_Nation_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Scenario_id) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_psf_Scenario_id' FROM dbo.Pew_Nation_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_psf_Nation_fk' FROM dbo.Pew_Nation_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Sex_fk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_psf_Sex_fk' FROM dbo.Pew_Nation_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Age_fk) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_psf_Age_fk' FROM dbo.Pew_Nation_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Cnt) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_psf_Cnt' FROM dbo.Pew_Nation_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Data_source) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_psf_Data_source' FROM dbo.Pew_Nation_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Display) AS DistinctRows, Field = 'Pew_Nation_Age_Sex_Value_psf_Display' FROM dbo.Pew_Nation_Age_Sex_Value_psf 
 UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'countrycode_nation_pk_Nation_fk' FROM dbo.countrycode_nation_pk UNION SELECT COUNT (DISTINCT Num_UNStatDiv) AS DistinctRows, Field = 'countrycode_nation_pk_Num_UNStatDiv' FROM dbo.countrycode_nation_pk UNION SELECT COUNT (DISTINCT Num_IIASAALL) AS DistinctRows, Field = 'countrycode_nation_pk_Num_IIASAALL' FROM dbo.countrycode_nation_pk UNION SELECT COUNT (DISTINCT Ctry_EditorialName) AS DistinctRows, Field = 'countrycode_nation_pk_Ctry_EditorialName' FROM dbo.countrycode_nation_pk UNION SELECT COUNT (DISTINCT Nation) AS DistinctRows, Field = 'countrycode_nation_pk_Nation' FROM dbo.countrycode_nation_pk UNION SELECT COUNT (DISTINCT Region) AS DistinctRows, Field = 'countrycode_nation_pk_Region' FROM dbo.countrycode_nation_pk UNION SELECT COUNT (DISTINCT SubRegion6) AS DistinctRows, Field = 'countrycode_nation_pk_SubRegion6' FROM dbo.countrycode_nation_pk UNION SELECT COUNT (DISTINCT SubRegion) AS DistinctRows, Field = 'countrycode_nation_pk_SubRegion' FROM dbo.countrycode_nation_pk UNION SELECT COUNT (DISTINCT UN_Reg1) AS DistinctRows, Field = 'countrycode_nation_pk_UN_Reg1' FROM dbo.countrycode_nation_pk UNION SELECT COUNT (DISTINCT UN_Reg2) AS DistinctRows, Field = 'countrycode_nation_pk_UN_Reg2' FROM dbo.countrycode_nation_pk 
 UNION SELECT COUNT (DISTINCT Nation_language_pk) AS DistinctRows, Field = 'Pew_Nation_Language_Nation_language_pk' FROM dbo.Pew_Nation_Language UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Language_Nation_fk' FROM dbo.Pew_Nation_Language UNION SELECT COUNT (DISTINCT Language_fk) AS DistinctRows, Field = 'Pew_Nation_Language_Language_fk' FROM dbo.Pew_Nation_Language UNION SELECT COUNT (DISTINCT Pop) AS DistinctRows, Field = 'Pew_Nation_Language_Pop' FROM dbo.Pew_Nation_Language 
 UNION SELECT COUNT (DISTINCT Nation_pk) AS DistinctRows, Field = 'ISO_Nation_pk' FROM dbo.ISO UNION SELECT COUNT (DISTINCT ISO3166_1alpha2) AS DistinctRows, Field = 'ISO_ISO3166_1alpha2' FROM dbo.ISO 
 UNION SELECT COUNT (DISTINCT Nation_pk) AS DistinctRows, Field = 'Pew_Nation_Nation_pk' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Ctry_EditorialName) AS DistinctRows, Field = 'Pew_Nation_Ctry_EditorialName' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Num_UNStatDiv) AS DistinctRows, Field = 'Pew_Nation_Num_UNStatDiv' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Country_fk) AS DistinctRows, Field = 'Pew_Nation_Country_fk' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT ISO3166_1alpha2) AS DistinctRows, Field = 'Pew_Nation_ISO3166_1alpha2' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Nation_note) AS DistinctRows, Field = 'Pew_Nation_Nation_note' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT CtryCapital) AS DistinctRows, Field = 'Pew_Nation_CtryCapital' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Region) AS DistinctRows, Field = 'Pew_Nation_Region' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT SubRegion) AS DistinctRows, Field = 'Pew_Nation_SubRegion' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT SubRegion6) AS DistinctRows, Field = 'Pew_Nation_SubRegion6' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT UN_Reg1) AS DistinctRows, Field = 'Pew_Nation_UN_Reg1' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT UN_Reg2) AS DistinctRows, Field = 'Pew_Nation_UN_Reg2' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Current_pop) AS DistinctRows, Field = 'Pew_Nation_Current_pop' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Reference_pop) AS DistinctRows, Field = 'Pew_Nation_Reference_pop' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT TPop1910) AS DistinctRows, Field = 'Pew_Nation_TPop1910' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Christian_pct1910) AS DistinctRows, Field = 'Pew_Nation_Christian_pct1910' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Evangelical_pct2010) AS DistinctRows, Field = 'Pew_Nation_Evangelical_pct2010' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Pentecostal_pct2010) AS DistinctRows, Field = 'Pew_Nation_Pentecostal_pct2010' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Charismatic_pct2010) AS DistinctRows, Field = 'Pew_Nation_Charismatic_pct2010' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT GDP_per_capita) AS DistinctRows, Field = 'Pew_Nation_GDP_per_capita' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Life_Expectancy) AS DistinctRows, Field = 'Pew_Nation_Life_Expectancy' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Literacy_Rate) AS DistinctRows, Field = 'Pew_Nation_Literacy_Rate' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Internet_user_pct) AS DistinctRows, Field = 'Pew_Nation_Internet_user_pct' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT Global_NS) AS DistinctRows, Field = 'Pew_Nation_Global_NS' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT UN_Develop) AS DistinctRows, Field = 'Pew_Nation_UN_Develop' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT IMF_Advance) AS DistinctRows, Field = 'Pew_Nation_IMF_Advance' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT FOTM_Advance) AS DistinctRows, Field = 'Pew_Nation_FOTM_Advance' FROM dbo.Pew_Nation UNION SELECT COUNT (DISTINCT MainSources) AS DistinctRows, Field = 'Pew_Nation_MainSources' FROM dbo.Pew_Nation 
 UNION SELECT COUNT (DISTINCT Nation_pk) AS DistinctRows, Field = 'vi_Nation_Attributes_f_Nation_pk' FROM dbo.vi_Nation_Attributes_f UNION SELECT COUNT (DISTINCT Ctry_EditorialName) AS DistinctRows, Field = 'vi_Nation_Attributes_f_Ctry_EditorialName' FROM dbo.vi_Nation_Attributes_f UNION SELECT COUNT (DISTINCT Iso_3166_Code) AS DistinctRows, Field = 'vi_Nation_Attributes_f_Iso_3166_Code' FROM dbo.vi_Nation_Attributes_f UNION SELECT COUNT (DISTINCT CtryCapital) AS DistinctRows, Field = 'vi_Nation_Attributes_f_CtryCapital' FROM dbo.vi_Nation_Attributes_f UNION SELECT COUNT (DISTINCT SubRegion6) AS DistinctRows, Field = 'vi_Nation_Attributes_f_SubRegion6' FROM dbo.vi_Nation_Attributes_f UNION SELECT COUNT (DISTINCT Reference_pop) AS DistinctRows, Field = 'vi_Nation_Attributes_f_Reference_pop' FROM dbo.vi_Nation_Attributes_f UNION SELECT COUNT (DISTINCT Current_pop) AS DistinctRows, Field = 'vi_Nation_Attributes_f_Current_pop' FROM dbo.vi_Nation_Attributes_f UNION SELECT COUNT (DISTINCT GDP_per_capita) AS DistinctRows, Field = 'vi_Nation_Attributes_f_GDP_per_capita' FROM dbo.vi_Nation_Attributes_f UNION SELECT COUNT (DISTINCT Life_Expectancy) AS DistinctRows, Field = 'vi_Nation_Attributes_f_Life_Expectancy' FROM dbo.vi_Nation_Attributes_f UNION SELECT COUNT (DISTINCT Literacy_Rate) AS DistinctRows, Field = 'vi_Nation_Attributes_f_Literacy_Rate' FROM dbo.vi_Nation_Attributes_f UNION SELECT COUNT (DISTINCT Notes) AS DistinctRows, Field = 'vi_Nation_Attributes_f_Notes' FROM dbo.vi_Nation_Attributes_f UNION SELECT COUNT (DISTINCT Scenario_description) AS DistinctRows, Field = 'vi_Nation_Attributes_f_Scenario_description' FROM dbo.vi_Nation_Attributes_f 
 UNION SELECT COUNT (DISTINCT Nation_Religion_age_sex_value_pk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Nation_Religion_age_sex_value_pk' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Field_fk' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Scenario_id) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Scenario_id' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Nation_fk' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Religion_group_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Religion_group_fk' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Distribution_Wave_id) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Distribution_Wave_id' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Sex_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Sex_fk' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Age_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Age_fk' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Percentage) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Percentage' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Cases) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Cases' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Cases_Notes) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Cases_Notes' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Source) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Source' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Source_year) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Source_year' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Nation_Value_Source) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Nation_Value_Source' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Notes) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Notes' FROM dbo.Pew_Nation_Religion_Age_Sex_Value UNION SELECT COUNT (DISTINCT Display) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_Display' FROM dbo.Pew_Nation_Religion_Age_Sex_Value 
 UNION SELECT COUNT (DISTINCT Nation_Religion_age_sex_value_pk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Nation_Religion_age_sex_value_pk' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Field_fk' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Scenario_id) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Scenario_id' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Nation_fk' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Religion_group_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Religion_group_fk' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Distribution_Wave_id) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Distribution_Wave_id' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Sex_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Sex_fk' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Age_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Age_fk' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Percentage) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Percentage' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Cases) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Cases' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Cases_Notes) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Cases_Notes' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Source) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Source' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Source_year) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Source_year' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Nation_Value_Source) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Nation_Value_Source' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Notes) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Notes' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf UNION SELECT COUNT (DISTINCT Display) AS DistinctRows, Field = 'Pew_Nation_Religion_Age_Sex_Value_psf_Display' FROM dbo.Pew_Nation_Religion_Age_Sex_Value_psf 
 UNION SELECT COUNT (DISTINCT Nation_Religion_Fertility_Value_pk) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Nation_Religion_Fertility_Value_pk' FROM dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Field_fk' FROM dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Scenario_id) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Scenario_id' FROM dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Nation_fk' FROM dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Religion_Group_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Religion_Group_fk' FROM dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Age_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Age_fk' FROM dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Measurement) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Measurement' FROM dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Rate) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Rate' FROM dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Cases) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Cases' FROM dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Source) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Source' FROM dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Source_year) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Source_year' FROM dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Notes) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Notes' FROM dbo.Pew_Nation_Religion_Fertility_Value UNION SELECT COUNT (DISTINCT Display) AS DistinctRows, Field = 'Pew_Nation_Religion_Fertility_Value_Display' FROM dbo.Pew_Nation_Religion_Fertility_Value 
 UNION SELECT COUNT (DISTINCT Nation_Religion_Switching_Flow_pk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Nation_Religion_Switching_Flow_pk' FROM dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Field_fk' FROM dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Scenario_id) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Scenario_id' FROM dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Nation_fk' FROM dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Origin_Religion_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Origin_Religion_fk' FROM dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Destination_Religion_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Destination_Religion_fk' FROM dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Sex_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Sex_fk' FROM dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Age_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Age_fk' FROM dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Cnt) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Cnt' FROM dbo.Pew_Nation_Religion_Switching_Flow UNION SELECT COUNT (DISTINCT Display) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Flow_Display' FROM dbo.Pew_Nation_Religion_Switching_Flow 
 UNION SELECT COUNT (DISTINCT Nation_Religion_Switching_Rate_pk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Nation_Religion_Switching_Rate_pk' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Field_fk' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT SwitchingCluster) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_SwitchingCluster' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Nation_fk' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Origin_religion_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Origin_religion_fk' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Destination_religion_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Destination_religion_fk' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Sex_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Sex_fk' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Age_fk) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Age_fk' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Total_Cases) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Total_Cases' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Total_Switching_rate) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Total_Switching_rate' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Switch_Pct) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Switch_Pct' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Source) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Source' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Year) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Year' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Note) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Note' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Donor_Nations) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Donor_Nations' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate UNION SELECT COUNT (DISTINCT Number_of_Donors) AS DistinctRows, Field = 'Pew_Nation_Religion_Switching_Base_Rate_Number_of_Donors' FROM dbo.Pew_Nation_Religion_Switching_Base_Rate 
 UNION SELECT COUNT (DISTINCT Nation_Subreligion_Distribution_pk) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Nation_Subreligion_Distribution_pk' FROM dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Nation_fk' FROM dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Aggregated_Religion_fk) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Aggregated_Religion_fk' FROM dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Sub_Religion_fk) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Sub_Religion_fk' FROM dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Distribution_Wave_id) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Distribution_Wave_id' FROM dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT MinYear_link) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_MinYear_link' FROM dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Majority_SubReligion_Range) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Majority_SubReligion_Range' FROM dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Proportion) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Proportion' FROM dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Nation_Value_Source) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Nation_Value_Source' FROM dbo.Pew_Nation_Subreligion_Distribution UNION SELECT COUNT (DISTINCT Nation_Value_Note) AS DistinctRows, Field = 'Pew_Nation_Subreligion_Distribution_Nation_Value_Note' FROM dbo.Pew_Nation_Subreligion_Distribution 
 UNION SELECT COUNT (DISTINCT Pew_Migration_pk) AS DistinctRows, Field = 'Pew_Migration_Pew_Migration_pk' FROM dbo.Pew_Migration UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Migration_Field_fk' FROM dbo.Pew_Migration UNION SELECT COUNT (DISTINCT origin_nation_fk) AS DistinctRows, Field = 'Pew_Migration_origin_nation_fk' FROM dbo.Pew_Migration UNION SELECT COUNT (DISTINCT destination_nation_fk) AS DistinctRows, Field = 'Pew_Migration_destination_nation_fk' FROM dbo.Pew_Migration UNION SELECT COUNT (DISTINCT pew_religion_group_fk) AS DistinctRows, Field = 'Pew_Migration_pew_religion_group_fk' FROM dbo.Pew_Migration UNION SELECT COUNT (DISTINCT migrant_count) AS DistinctRows, Field = 'Pew_Migration_migrant_count' FROM dbo.Pew_Migration UNION SELECT COUNT (DISTINCT Display_by_Religion) AS DistinctRows, Field = 'Pew_Migration_Display_by_Religion' FROM dbo.Pew_Migration UNION SELECT COUNT (DISTINCT Display_as_Origin_Ctry) AS DistinctRows, Field = 'Pew_Migration_Display_as_Origin_Ctry' FROM dbo.Pew_Migration UNION SELECT COUNT (DISTINCT Display_as_Destination_Ctry) AS DistinctRows, Field = 'Pew_Migration_Display_as_Destination_Ctry' FROM dbo.Pew_Migration 
 UNION SELECT COUNT (DISTINCT Preferred_Scenario_pk) AS DistinctRows, Field = 'Pew_Preferred_Scenario_Preferred_Scenario_pk' FROM dbo.Pew_Preferred_Scenario UNION SELECT COUNT (DISTINCT Field_fk) AS DistinctRows, Field = 'Pew_Preferred_Scenario_Field_fk' FROM dbo.Pew_Preferred_Scenario UNION SELECT COUNT (DISTINCT Nation_fk) AS DistinctRows, Field = 'Pew_Preferred_Scenario_Nation_fk' FROM dbo.Pew_Preferred_Scenario UNION SELECT COUNT (DISTINCT Preferred_Scenario_id) AS DistinctRows, Field = 'Pew_Preferred_Scenario_Preferred_Scenario_id' FROM dbo.Pew_Preferred_Scenario 
 UNION SELECT COUNT (DISTINCT Question_pk) AS DistinctRows, Field = 'Pew_Question_NoStd_Question_pk' FROM dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Question_abbreviation) AS DistinctRows, Field = 'Pew_Question_NoStd_Question_abbreviation' FROM dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Question_wording) AS DistinctRows, Field = 'Pew_Question_NoStd_Question_wording' FROM dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Data_source_fk) AS DistinctRows, Field = 'Pew_Question_NoStd_Data_source_fk' FROM dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Question_Year) AS DistinctRows, Field = 'Pew_Question_NoStd_Question_Year' FROM dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Short_wording) AS DistinctRows, Field = 'Pew_Question_NoStd_Short_wording' FROM dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Notes) AS DistinctRows, Field = 'Pew_Question_NoStd_Notes' FROM dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Default_response) AS DistinctRows, Field = 'Pew_Question_NoStd_Default_response' FROM dbo.Pew_Question_NoStd UNION SELECT COUNT (DISTINCT Question_Std_fk) AS DistinctRows, Field = 'Pew_Question_NoStd_Question_Std_fk' FROM dbo.Pew_Question_NoStd 
 UNION SELECT COUNT (DISTINCT Question_Std_pk) AS DistinctRows, Field = 'Pew_Question_Std_Question_Std_pk' FROM dbo.Pew_Question_Std UNION SELECT COUNT (DISTINCT Question_abbreviation_std) AS DistinctRows, Field = 'Pew_Question_Std_Question_abbreviation_std' FROM dbo.Pew_Question_Std UNION SELECT COUNT (DISTINCT Question_wording_std) AS DistinctRows, Field = 'Pew_Question_Std_Question_wording_std' FROM dbo.Pew_Question_Std UNION SELECT COUNT (DISTINCT Question_short_wording_std) AS DistinctRows, Field = 'Pew_Question_Std_Question_short_wording_std' FROM dbo.Pew_Question_Std 
 UNION SELECT COUNT (DISTINCT Religion_group_pk) AS DistinctRows, Field = 'Pew_Religion_Group_Religion_group_pk' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Wrd_religion_code) AS DistinctRows, Field = 'Pew_Religion_Group_Wrd_religion_code' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev04) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev04' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev03) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev03' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev02) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev02' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev01) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev01' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev00) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev00' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT wrd_religion_1) AS DistinctRows, Field = 'Pew_Religion_Group_wrd_religion_1' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT wrd_religion_2) AS DistinctRows, Field = 'Pew_Religion_Group_wrd_religion_2' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT wrd_religion_3) AS DistinctRows, Field = 'Pew_Religion_Group_wrd_religion_3' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev01_5) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev01_5' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev02_5) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev02_5' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_religion_lev05) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_religion_lev05' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_RelL02_Display) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_RelL02_Display' FROM dbo.Pew_Religion_Group UNION SELECT COUNT (DISTINCT Pew_RelL02_5_display) AS DistinctRows, Field = 'Pew_Religion_Group_Pew_RelL02_5_display' FROM dbo.Pew_Religion_Group 
 UNION SELECT COUNT (DISTINCT Scenario_pk) AS DistinctRows, Field = 'Pew_Scenario_Scenario_pk' FROM dbo.Pew_Scenario UNION SELECT COUNT (DISTINCT Scenario_id) AS DistinctRows, Field = 'Pew_Scenario_Scenario_id' FROM dbo.Pew_Scenario UNION SELECT COUNT (DISTINCT Scenario_description) AS DistinctRows, Field = 'Pew_Scenario_Scenario_description' FROM dbo.Pew_Scenario UNION SELECT COUNT (DISTINCT Notes) AS DistinctRows, Field = 'Pew_Scenario_Notes' FROM dbo.Pew_Scenario 
 UNION SELECT COUNT (DISTINCT Sex) AS DistinctRows, Field = 'Pew_Sex_Sex' FROM dbo.Pew_Sex UNION SELECT COUNT (DISTINCT Sex_pk) AS DistinctRows, Field = 'Pew_Sex_Sex_pk' FROM dbo.Pew_Sex 


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
               FROM [sys].[tables]                           /*main*/
                  , [INFORMATION_SCHEMA].[COLUMNS]           /*main*/
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

use for_d
go 
/*********************************************************************************************************/
SELECT
       DISTINCT	
                ' ' + 
    			ColumnList
FROM 
( SELECT *                                        /*main*/
    FROM [sys].[tables]                           /*main*/
       , [INFORMATION_SCHEMA].[COLUMNS]           /*main*/
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
    	                                    + ''' FROM dbo.' 
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