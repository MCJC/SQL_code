
  instead of 
   [_Admin].[dbo].[Descriptions_WRD]
   
   create [Describe_Table_and_Fields_WRD_all]
   
   
   from there pull
   
   [Describe_Table_and_Fields_WRD_all]
   
   Both can be views
   
   



SELECT
       [table_info_pk]                                -- int 
     , [field_info_pk]                                -- int 
     , [table_name]                                   -- nvarchar, 128
     , [field_name]                                   -- nvarchar, 128
     , [table_description] = T.[description]          -- nvarchar,  50
     , [field_description] = F.[description]          -- nvarchar,  50
     , [field_comments]    = F.[comments]             -- nvarchar, 750

  FROM [wcd_metabase].[dbo].[Table_Info] T
     , [wcd_metabase].[dbo].[Field_Info] F
WHERE
        [table_fk]
      = [table_info_pk]
AND
       [table_name]          LIKE '%Pew_%'

order by
       [table_name]
     , [field_name]

      