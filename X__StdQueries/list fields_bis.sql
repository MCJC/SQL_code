-- n of cpolumns (includes views)
use forum
go 

SELECT distinct
n= COUNT(COLUMN_NAME) OVER (PARTITION BY TABLE_NAME)
, TABLE_NAME


-- AS EmployeesPerDept

--COUNT(COLUMN_NAME)

--select *
 FROM INFORMATION_SCHEMA.COLUMNS


 WHERE 
TABLE_CATALOG = 'forum' AND TABLE_SCHEMA = 'dbo'
--AND TABLE_NAME = 'table'


--counts rows of tables

SELECT 
       --*
    --   ,
    TableName = t.NAME,
    TableSchema = s.Name,
    RowCounts = p.rows
FROM 
    sys.tables t
INNER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
    
    
    
WHERE 
    t.is_ms_shipped = 0
GROUP BY
    t.NAME, s.Name, p.Rows
ORDER BY 
    s.Name, t.Name











/*** all tables & fields **************************************************************/
SELECT
          * --,
        --  DBName      = c.table_schema
        --, TableName   = c.table_name
        --, ColumnName  = c.column_name
        --, DataType    = c.data_type
        --, TableType   = t.table_type
        --, InTabPosit  = c.ordinal_position
        --, Nullable    = c.is_nullable
        --, Size        = CASE
        --                WHEN            c.character_maximum_length IS NULL
        --                THEN  'N' + STR(c.numeric_precision,        3) 
        --                    + '(' + STR(c.numeric_precision_radix,  2) + ')'
        --                ELSE 'Ch' + STR(c.character_maximum_length, 6)
        --                END
        --, CharSet     = C.character_set_name

FROM
         --forum.information_schema.columns c
--inner
--JOIN
           forum.information_schema.tables t

           ON     c.table_name   = t.table_name
           AND    c.table_schema = t.table_schema

WHERE             t.table_type   = 'BASE TABLE'
ORDER BY 
           DBName
         , TableName
         , ordinal_position
         , TableType
/*** all tables ***********************************************************************/
SELECT *
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
         