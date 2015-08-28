/********************************************************************************************************************************/
/*** >> Create clone of reference metadata table [Describe_Table_and_Fields_WRD] storing descriptions of tables and fields ******/
/********************************************************************************************************************************/
/*** Copy main data using TASKS -> IMPORT DATA -> ... ***************************************************************************/
/*** Use the following query to select the data: ********************************************************************************/
/********************************************************************************************************************************/
------SELECT
------       [table_info_pk]                                -- int 
------     , [field_info_pk]                                -- int 
------     , [table_name]                                   -- nvarchar, 128
------     , [field_name]                                   -- nvarchar, 128
------     , [table_description] = T.[description]          -- nvarchar,  50
------     , [field_description] = F.[description]          -- nvarchar,  50
------     , [field_comments]    = F.[comments]             -- nvarchar, 750

------  FROM [wcd_metabase].[dbo].[Table_Info] T
------     , [wcd_metabase].[dbo].[Field_Info] F
------WHERE
------        [table_fk]
------      = [table_info_pk]
/********************************************************************************************************************************/
/********************************************************************************************************************************/
----------------------------------------------------------------------------------------------------------------------------------
IF OBJECT_ID  (N'[_Admin].[dbo].[Describe_Table_and_Fields_WRD]', N'U') IS NOT NULL
DROP   TABLE     [_Admin].[dbo].[Describe_Table_and_Fields_WRD]
----------------------------------------------------------------------------------------------------------------------------------
SELECT
                                             [Description_pk] = [field_info_pk] + 9000000 
                                            ,[Table_name]     = [table_name]
                                          --,[table_description]
                                            ,[Field_name]     = [field_name]
                                            ,[Description]    = [field_description]
----------------------------------------------------------------------------------------------------------------------------------
 INTO 
                 [_Admin].[dbo].[Describe_Table_and_Fields_WRD]
----------------------------------------------------------------------------------------------------------------------------------
 FROM
                 [_Admin].[dbo].[Descriptions_WRD]
----------------------------------------------------------------------------------------------------------------------------------
WHERE
        [table_name]
     IN (
           'Country'
         , 'Province'
         , 'Survey'
         , 'Survey_data'
         , 'Survey_locality'
         , 'Survey_religion_code'
         , 'zg_WRD_Religion'
                                   )      
----------------------------------------------------------------------------------------------------------------------------------
/********************************************************************************************************************************/
/*** << Create clone of reference metadata table [Describe_Table_and_Fields_WRD] storing descriptions of tables and fields ******/
/********************************************************************************************************************************/
