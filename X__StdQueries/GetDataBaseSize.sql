--SELECT 
--    t.NAME AS TableName
--FROM 
--    sys.tables t
--ORDER BY 
--    t.Name
/*****************************************************************************************************************************************************/
/*** >> Create complete view of metadata for all tables and fields ***********************************************************************************/
/*****************************************************************************************************************************************************/
USE [forum]
GO
/*****************************************************************************************************************************/
select
          DataBaseN     = DB_NAME()
        , CELLS         = SUM(Size * DistinctRows)
        , TotalSpaceGB  = CAST((ROUND((((SUM(CAST((TotalSpaceKB)AS decimal (12,4))))/1024)/ 1024),18,4))AS decimal (6,3))
        , UsedSpaceGB   = CAST((ROUND((((SUM(CAST((UsedSpaceKB )AS decimal (12,4))))/1024)/ 1024),18,4))AS decimal (6,3))
        , UnusedSpaceKB = SUM(UnusedSpaceKB)
from
(
/*** Columns for TABLES ******************************************************************************************************/
SELECT
          DataBaseID                = 1 
        , TableID
        , Table_Number                             -- 1
        , Table_Name                               -- 3
        , Size                                     -- 8
        , DistinctRows                             -- 9
FROM
(
-------------------------------------------------------------------------------------------------------------------------------
-- Table_Number
 SELECT 
         TN             = name
       , ROW_NUMBER() OVER(ORDER BY name )
         AS TableID
       , Table_Number   = object_id
       , Table_Name     = name
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
)  CT
join
(
SELECT 
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
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
WHERE 
    t.NAME NOT LIKE 'dt%' 
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, p.Rows
) as USp
ON Table_Name = Name

GROUP BY 
          DataBaseID

    