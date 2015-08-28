/*********************************************************************************************************/
-- Query for distinct values per row is created by this query,
-- after copy/paste/delete the first "UNION"
SELECT
       DISTINCT	
                ' ' + 
    			ColumnList
FROM 
    INFORMATION_SCHEMA.COLUMNS COL1
    CROSS AppLy 
                                    (
    	                              SELECT
    	                                      'UNION'
    	                                    + ' SELECT COUNT (DISTINCT ' 
    	                                    + COLUMN_NAME 
    	                                    + ') AS Distinct_Rows, Field = '''
    	                                    + COL1.TABLE_NAME 
    	                                    + '_' 
    	                                    + COLUMN_NAME
    	                                    + ''' FROM ' 
    	                                    + COL1.TABLE_NAME 
    	                                    + ' '
                                      FROM INFORMATION_SCHEMA.COLUMNS COL2
                                      WHERE COL1.TABLE_NAME = COL2.TABLE_NAME
                                      FOR XML PATH ('')
                                    ) TableColumns (ColumnList)
WHERE 1=1
/*********************************************************************************************************/

use forum
go 



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
        , Distinct_Rows                            -- 9
        , CharSet                                  -- 10
FROM
(
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
       , Type           = ''
       , Nullable       = 'N.A.'
       , CharSet        = 'N.A.'
  FROM
       forum.sys.Tables
                                                                                            ) as T1
,
(
-- Size (n of columns; includes views)
 SELECT 
         DISTINCT
         TN             = TABLE_NAME
       , Size           = COUNT(COLUMN_NAME) OVER (PARTITION BY TABLE_NAME)
  FROM
       INFORMATION_SCHEMA.COLUMNS
                                                                                            ) as T7
,
(
--Distinct_Rows (counts rows of tables)
 SELECT 
         DISTINCT
         TN             = t.NAME
       , Distinct_Rows  = p.rows
--select *
FROM 
     sys.tables t
INNER JOIN 
     sys.schemas s ON t.schema_id = s.schema_id
INNER JOIN      
     sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
     sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
                                                                                            ) as T8



WHERE 
         T1.TN
       = T7.TN
  AND
         T1.TN
       = T8.TN
ORDER BY 
         T1.Table_Number






/*********************************************************************************************************/

select *
FROM 
     sys.tables t
INNER JOIN 
     sys.schemas s ON t.schema_id = s.schema_id
INNER JOIN      
     sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
     sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
order by i.object_id

select * from  sys.indexes 


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
        , Distinct_Rows                            -- 9
        , CharSet                                  -- 10
FROM
(
-- all fields in all tables
 SELECT 
         TableID        = N.TableID
       , Table_Number   = N.Table_Number
       , Field_Number   = C.ORDINAL_POSITION
       , Table_Name     = C.TABLE_NAME
       , Field_Name     = C.COLUMN_NAME
       , Referenciality = ''
       , Type           = C.DATA_TYPE
       , Size           = CASE
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


WHERE             t.table_type   = 'BASE TABLE'
ORDER BY 
           DBName
         , TableName
         , ordinal_position
         , TableType
/*** all tables ***********************************************************************/
SELECT
name	object_id	principal_id	schema_id	parent_object_id	type	type_desc	create_date	modify_date	is_ms_shipped	is_published	is_schema_published	lob_data_space_id	filestream_data_space_id	max_column_id_used	lock_on_bulk_load	uses_ansi_nulls	is_replicated	has_replication_filter	is_merge_published	is_sync_tran_subscribed	has_unchecked_assembly_data	text_in_row_limit	large_value_types_out_of_row	is_tracked_by_cdc	lock_escalation	lock_escalation_desc
Pew_Nation	5575058	NULL	1	0	U 	USER_TABLE	2011-03-20 13:32:29.477	2013-04-26 12:52:37.697	0	0	0	0	NULL	46	0	1	0	0	0	0	0	0	0	0	0	TABLE


 *
FROM forum.sys.Tables
ORDER BY object_id


/*** all tables ***********************************************************************/




--SELECT
-- OBJECT_NAME(OBJECT_ID)
-- , OBJECT_ID, OBJECT_NAME(database_id), database_id, index_id
--  AS DatabaseName, last_user_update,*

SELECT 
 OBJECT_NAME(OBJECT_ID)
--, OBJECT_ID
, OBJECT_NAME(database_id), database_id, index_id, *
FROM sys.dm_db_index_usage_stats
ORDER BY object_id


WHERE database_id = DB_ID( 'dbname')
AND OBJECT_ID=OBJECT_ID('tablename')








SELECT OBJECT_NAME(OBJECT_ID) AS FORUM, last_user_update,*
FROM sys.dm_db_index_usage_stats
WHERE database_id = DB_ID( 'FORUM')
AND OBJECT_ID=OBJECT_ID('COUNTRY')


select
t.name
,user_seeks
,user_scans
,user_lookups
,user_updates
,last_user_seek
,last_user_scan
,last_user_lookup
,last_user_update
from
sys.dm_db_index_usage_stats i JOIN
sys.tables t ON (t.object_id = i.object_id)
where
database_id = db_id()

/**** LIST TABLES AND COLUMNS ************************************************************************/

sp_tables

SELECT OBJECT_NAME(OBJECT_ID) AS DatabaseName, max(last_user_update)
 FROM sys.dm_db_index_usage_stats
 group by OBJECT_ID

sp_columns @table_name = Country
sp_columns @table_name = Pew_Answer
sp_columns @table_name = Pew_Data_Source
sp_columns @table_name = Pew_Field
sp_columns @table_name = Pew_Locality
sp_columns @table_name = Pew_Locality_Answer
sp_columns @table_name = Pew_Locality_Value
sp_columns @table_name = Pew_Migration
sp_columns @table_name = Pew_Nation
sp_columns @table_name = Pew_Nation_Answer
sp_columns @table_name = Pew_Nation_Religion_Answer
sp_columns @table_name = Pew_Nation_Religion_Value
sp_columns @table_name = Pew_Nation_Value
sp_columns @table_name = Pew_Question
sp_columns @table_name = Pew_Religion_Group 
sp_columns @table_name = Province
sp_columns @table_name = Survey
sp_columns @table_name = Survey_data
sp_columns @table_name = Survey_locality
sp_columns @table_name = Survey_religion_code
sp_columns @table_name = sysdiagrams
sp_columns @table_name = zg_Pew_Data_Quality_Level
sp_columns @table_name = zg_WRD_Religion
sp_columns @table_name = migrant_origin
sp_columns @table_name = v_african_survey


out S:\Forum\EsparzaOchoa\myfile.csv -c -t

select * from sysdiagrams

SELECT *
FROM
information_schema.columns where table_name ='GRSH_C'




sp_columns @table_name = GRSH_C



sp_tables
--- save it somehow....
 into mytables
 
 sys.assembly_types
         