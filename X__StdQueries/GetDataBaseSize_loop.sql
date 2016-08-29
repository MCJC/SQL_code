USE master
--drop table #SizeTempTable
CREATE TABLE #SizeTempTable
              (  DataBaseN      VARCHAR(20)
               , CELLS	      BIGINT
               , TotalSpaceGB   DECIMAL(5,3)
               , UsedSpaceGB    DECIMAL(5,3)
               , UnusedSpaceKB  BIGINT       )
/*****************************************************************************************************************************************************/
/*** >> Create complete list of database size in ForumDb *********************************************************************************************/
/*****************************************************************************************************************************************************/
-- Declare the variables needed for cursor to store data

  DECLARE                          --  declare variable
          db_names                 --  cursor name
                    CURSOR FOR     -- as a cursor to take values from
/*-----------------------------------------------------------------------------------------------------------*/
-- SELECT the data that will be represented by cursor
--    (i.e. "select query" to produce the table)
         SELECT   
                 name
         FROM
                 sysdatabases
-- Where Clause, Enable if you want to filter out some databases.
--        where name like 'forum'
/*-----------------------------------------------------------------------------------------------------------*/
  DECLARE                          --  declare variable
          @db_name                 --  variable name
                    varchar(100)   --  data type of the variable
DECLARE @QueryString NVARCHAR(max)
                    
/*************************************************************************************************************/
-- OPEN the cursor 
    OPEN                           -- open
           db_names                -- cursor name
/*-----------------------------------------------------------------------------------------------------------*/
-- RETRIEVE the FIRST row from cursor & STORE it into the variable(s): 
           FETCH NEXT              -- retrieve the next row
                 FROM              -- from cursor
                      db_names     -- cursor name
                 INTO              -- store it into the variable(s)
                      @db_name     --  variable name
-- @@FETCH_STATUS returns the status of the last cursor FETCH statement issued against  
-- any cursor currently opened by the connection. 
	--     @@FETCH_STATUS =  0 means The FETCH statement was successful. 
	--     @@FETCH_STATUS = -1 means The FETCH statement failed or the row was beyond the result set. 
	--     @@FETCH_STATUS = -2 means The row fetched is missing. 
			 WHILE  @@FETCH_STATUS = 0
/*************************************************************************************************************/
/*************************************************************************************************************/
-- BEGIN the procedures to be done using the values of each row of the cursor
					BEGIN
-- Procedures to be done
/*****************************************************************************************************************************************************/
/*** >> Calculate database size for each database (from tables and fields) ***************************************************************************/
/*****************************************************************************************************************************************************/
--PRINT @db_name
/*****************************************************************************************************************************/
SET @QueryString =
N' 
INSERT INTO
            #SizeTempTable
'
+
N' 
select
          DataBaseN     =  '''
 + 
       @db_name
+
N'''
        , CELLS         = SUM(Size * DistinctRows)
        , TotalSpaceGB  = CAST((ROUND((((SUM(CAST((TotalSpaceKB)AS decimal (12,4))))/1024)/ 1024),18,4))AS decimal (6,3))
        , UsedSpaceGB   = CAST((ROUND((((SUM(CAST((UsedSpaceKB )AS decimal (12,4))))/1024)/ 1024),18,4))AS decimal (6,3))
        , UnusedSpaceKB = SUM(UnusedSpaceKB)
from
(
'
+
N' SELECT
          DataBaseID                = 1 
        , TableID
        , Table_Number                             -- 1
        , Table_Name                               -- 3
        , Size                                     -- 8
        , DistinctRows                             -- 9
FROM 
( 
'
+

N' SELECT 
         TN             = name
       , ROW_NUMBER() OVER(ORDER BY name )
         AS TableID
       , Table_Number   = object_id
       , Table_Name     = name
  FROM '
 + 
       @db_name
+
N'.sys.Tables'
+
N'
) as T1
,
(
'
+
N' SELECT 
         DISTINCT
         TN             = TABLE_NAME
       , Size           = CAST((COUNT(COLUMN_NAME) OVER (PARTITION BY TABLE_NAME)) as varchar)
  FROM '
 + 
       @db_name
+
N'.[INFORMATION_SCHEMA].[COLUMNS]'
+
N'
) as T7
,
(
'
+
N' SELECT 
         DISTINCT
         TN             = t.NAME
       , DistinctRows   = p.rows
FROM  '
 + 
       @db_name
+
N'.sys.tables     t 
INNER JOIN 
'
+
       @db_name
+
N'.sys.schemas    s ON t.schema_id = s.schema_id 
INNER JOIN      
'
+
       @db_name
+
N'.sys.indexes    i ON t.OBJECT_ID = i.object_id
INNER JOIN 
'
+
       @db_name
+
N'.sys.partitions p ON i.object_id = p.OBJECT_ID
                           AND i.index_id  = p.index_id
'
+
N'
) as T8
'


+
N'
WHERE 
         T1.TN
       = T7.TN
  AND
         T1.TN
       = T8.TN
'
+
N'
)  CT
join
(
'
+
N' SELECT 
    t.NAME,
    p.rows AS RowCounts
    ,
    SUM
    (a.total_pages) * 8 AS TotalSpaceKB, 
    SUM
    (a.used_pages) * 8 AS UsedSpaceKB
    , 
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB
FROM 
'
+
       @db_name
+
N'.sys.tables t
INNER JOIN      
'
+
       @db_name
+
N'.sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
'
+
       @db_name
+
N'.sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
'
+
       @db_name
+
N'.sys.allocation_units a ON p.partition_id = a.container_id
WHERE 
    t.NAME NOT LIKE ''dt%'' 
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, p.Rows
) as USp
ON Table_Name = Name

GROUP BY 
          DataBaseID
'



--print @QueryString
EXEC sp_executesql @QueryString
/*****************************************************************************************************************************************************/
/*** << Calculate database size for each database (from tables and fields) ***************************************************************************/
/*****************************************************************************************************************************************************/
-- RETRIEVE the NEXT row from cursor & STORE it into the variable(s): 
           FETCH NEXT              -- retrieve the next row
                 FROM              -- from cursor
                      db_names     -- cursor name
                 INTO              -- store it into the variable(s)
                      @db_name     --  variable name
-- END the procedures to be done using the values of each row of the cursor
                 END
/***********************************************************************************************************/
-- CLOSE the cursor 
   CLOSE                            -- close
              db_names              -- cursor name
/*************************************************************************************************************/
-- REMOVE the cursor reference and relase cursor from memory
-- (very Important )
DEALLOCATE                          -- remove reference and relase from memory
              db_names              -- cursor name
/*************************************************************************************************************/
/*************************************************************************************************************/

select * 
from
       #SizeTempTable
