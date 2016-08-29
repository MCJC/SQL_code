 SELECT 
         TableSort      =   ROW_NUMBER() OVER(ORDER BY name )
       , Table_Name     =  'Table Name:   '
                          + name
       , Table_Number   = object_id
  FROM
    -- sys.Tables
       sys.views
